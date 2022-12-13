import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../enviroment_variables.dart';
import '../folders_path.dart';
import '../state/debug_logger_result.dart';
import '../state/state.dart';

part 'debug_logger.g.dart';

final debugLogger = DebugLogger.log;

@riverpod
class DebugLogger extends _$DebugLogger {
  @override
  DebugLoggerState build() {
    return DebugLoggerState();
  }

  static void logPrint(Object? obj) {
    // for PrettyDiaLogger
    if (kDebugMode) {
      print(obj);
    }

    DebugLogger.appendDebugLogs(obj.toString());
  }

  static void appendDebugLogs(String logs) {
    logData += '$logs\n';
  }

  static const isDebugLoggerEnabled = EnviromentVariables.debugLoggerEnabled;
  static Function(DebugLoggerResult result)? onDoneUpload;

  static String logData = '';

  static final log = Logger(
    printer: PrettyPrinter(
      noBoxingByDefault: true,
      printEmojis: false,
      colors: false,
      printTime: true,
    ),
    filter: CustomLogFilter(),
    output: CustomLogOutput(),
  );

  final storageRef = FirebaseStorage.instance.ref();
  final _auth = FirebaseAuth.instance;

  void toogleCollapse(bool isCollapse) {
    state = state.copyWith(
      isButtonCollapsed: isCollapse,
    );
  }

  void setIsSending(bool isSending) {
    state = state.copyWith(
      isSending: isSending,
    );
  }

  void setIsTakingScrenshot(bool isTakingScreenshot) {
    state = state.copyWith(
      isTakingScreenshot: isTakingScreenshot,
    );
  }

  void setImagePath(String path) {
    state = state.copyWith(
      imagePath: path,
    );
  }

  Future<void> takeScreenshot() async {
    setIsTakingScrenshot(true);

    debugLogger.d('Taking screenshot...');

    try {
      final dir = await getApplicationDocumentsDirectory();

      const fileName = 'debug_screenshot.png';

      final savedPath = join(dir.path, FolderPaths.images, fileName);

      await File(savedPath).create(recursive: true);

      final screenshotFilePath = await NativeScreenshot.takeScreenshot(
        saveScreenshotPath: savedPath,
      );

      if (screenshotFilePath == null) {
        debugLogger.d('Take screenshot error: filePath = null');
        return;
      }

      debugLogger.d('screenshotFilePath = $screenshotFilePath');

      setImagePath(screenshotFilePath);
    } catch (err) {
      debugLogger.e('Take screenshot error: $err');
    }

    setIsTakingScrenshot(false);
  }

  Future<void> uploadDebugLogsDataToServer() async {
    if (state.isSending || state.isTakingScreenshot) {
      return;
    }

    if (state.imagePath.isNotEmpty) {
      await takeScreenshot();
    }

    setIsSending(true);

    try {
      debugLogger.d('Adding user info...');

      // NOTE: Change base on app state management package
      final email = _auth.currentUser?.email;
      logData = 'User Info:\nUser email: ${email ?? 'Guest mode'}\n\n$logData';
      // END-NOTE

      debugLogger.d('Adding device info...');

      final androidInfo = await DeviceInfoPlugin().androidInfo;

      logData =
          'Device Info:\nDevice: ${androidInfo.device}\nModel: ${androidInfo.model}\nVersion: ${androidInfo.version.sdkInt}\n\n$logData';

      debugLogger.d('Write log data to file....');

      final directory = await getApplicationDocumentsDirectory();
      final logFileName =
          'travelo_debug_log_${DateTime.now().toIso8601String()}.log';
      final logFile = File(join(directory.path, logFileName));

      await logFile.writeAsString(logData, flush: true);

      debugLogger.d('Log file path = ${logFile.path}');

      String? logFileDownloadURL;

      try {
        final debugLogsRef = await uploadFileToServer(
          file: logFile,
          path: 'debug_logs/$logFileName',
        );

        if (debugLogsRef == null) {
          debugLogger.d("Can't upload file to server.");
        }

        await debugLogsRef?.putFile(logFile);

        logFileDownloadURL = await debugLogsRef?.getDownloadURL();
      } catch (err) {
        debugLogger.e(err);
      }

      debugLogger.d('Log file download URL: $logFileDownloadURL');

      String? screenshotDownloadUrl;

      if (state.imagePath.isNotEmpty) {
        final fileName =
            'travelo_debug_screenshot_${DateTime.now().toIso8601String()}.png';

        final screenshotFile = File(state.imagePath);

        debugLogger.d('Upload image file name: $fileName');

        final debugScreenshotRef = await uploadFileToServer(
          file: screenshotFile,
          path: 'debug_screenshots/$fileName',
        );

        try {
          await debugScreenshotRef?.putFile(screenshotFile);
        } catch (err) {
          debugLogger.d(err);
        }

        screenshotDownloadUrl = await debugScreenshotRef?.getDownloadURL();

        debugLogger.d('Screenshot download URL:  $screenshotDownloadUrl');
      }

      onDoneUpload?.call(DebugLoggerResult(
        logFileDownloadURL: logFileDownloadURL,
        screenshotDownloadUrl: screenshotDownloadUrl,
      ));
    } catch (err) {
      debugLogger.e(err);
    }

    setIsSending(false);
  }

  Future<Reference?> uploadFileToServer({
    required File file,
    required String path,
  }) async {
    try {
      debugLogger.d('Uploading $path');

      final strgRef = storageRef.child(path);

      await strgRef.putFile(file);

      return strgRef;
    } catch (err) {
      debugLogger.e(err);
    }

    return null;
  }
}

class CustomLogFilter extends LogFilter {
  /* to enable outputting debug log in release build
   (when testHelperEnabled=true only) */
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode || EnviromentVariables.debugLoggerEnabled;
  }
}

class CustomLogOutput extends LogOutput {
  static final consoleOutput = ConsoleOutput();

  @override
  void output(OutputEvent event) {
    consoleOutput.output(event); // output to terminal

    // save logs for sending later
    event.lines.forEach(DebugLogger.appendDebugLogs);
  }
}
