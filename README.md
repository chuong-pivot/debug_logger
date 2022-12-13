This plug-in using logger and riverpod

Just wrap your app with DebugLoggerWrapper() and you are good to go 👍

IMPORTANT: Add --dart-define DEBUG_LOGGER_ENABLED=true behind your run cmd
Example: flutter run --dart-define DEBUG_LOGGER_ENABLED=true

Please look at main.dart in /example for more detail.

Initial DebugLogger.onDoneHandling for interacting with the debuglog file and screenshot file.
**Note: DebugLogger.onDoneHandling Can be set at any time in the code**

Use debugLogger instead of Logger
