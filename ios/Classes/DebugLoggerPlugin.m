#import "DebugLoggerPlugin.h"
#if __has_include(<debug_logger/debug_logger-Swift.h>)
#import <debug_logger/debug_logger-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "debug_logger-Swift.h"
#endif

@implementation DebugLoggerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDebugLoggerPlugin registerWithRegistrar:registrar];
}
@end
