import 'package:debug_logger/debug_logger/debug_logger.dart';
import 'package:debug_logger/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    debugLogger.wtf(
      details.exceptionAsString(),
      [
        details,
        details.stack,
      ],
    );
  };

  DebugLogger.onDoneUpload = (result) {
    print(result.debugLogFilePath);
    print(result.imageFilePath);
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DebugLoggerWrapper(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          backgroundColor: Colors.white,
          body: const Center(
            child: Text('Running on: \n'),
          ),
        ),
      ),
    );
  }
}
