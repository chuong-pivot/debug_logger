import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class DebugLoggerState with _$DebugLoggerState {
  factory DebugLoggerState({
    @Default(true) bool isButtonCollapsed,
    @Default(false) bool isTakingScreenshot,
    @Default(false) bool isHandling,
    @Default(false) bool isEditingImage,
    String? imagePath,
  }) = _DebugLoggerState;
}
