import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_painter/image_painter.dart';

import 'debug_logger/debug_logger.dart';
import 'draggable_atom.dart';

class DebugLoggerWrapper extends StatelessWidget {
  const DebugLoggerWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!DebugLogger.isDebugLoggerEnabled) {
      return child;
    }

    return ProviderScope(
      key: GlobalKey(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            child,
            Positioned.fill(
              child: Overlay(
                initialEntries: [
                  OverlayEntry(
                    maintainState: true,
                    builder: (context) {
                      return DraggableAtom(
                        top: 50,
                        left: 100,
                        child: Opacity(
                          opacity: .3,
                          child: OrientationBuilder(
                            builder: (context, orientation) {
                              return Consumer(
                                builder: (context, ref, child) {
                                  final debugLoggerState =
                                      ref.watch(debugLoggerProvider);

                                  final debugLoggerNotifier =
                                      ref.read(debugLoggerProvider.notifier);

                                  return !debugLoggerState.isTakingScreenshot
                                      ? Flex(
                                          direction: orientation ==
                                                  Orientation.portrait
                                              ? Axis.vertical
                                              : Axis.horizontal,
                                          children: [
                                            GestureDetector(
                                              onTap: () => debugLoggerNotifier
                                                  .toogleCollapse(
                                                      !debugLoggerState
                                                          .isButtonCollapsed),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.orange,
                                                ),
                                                child: Icon(
                                                  debugLoggerState
                                                          .isButtonCollapsed
                                                      ? Icons.menu
                                                      : Icons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            if (!debugLoggerState
                                                .isButtonCollapsed) ...[
                                              const SizedBox(
                                                width: 10,
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: debugLoggerNotifier
                                                    .handleDebugData,
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.orange,
                                                  ),
                                                  child: const Icon(
                                                    Icons.outgoing_mail,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: debugLoggerNotifier
                                                    .takeScreenshot,
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.orange,
                                                  ),
                                                  child: const Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              if (debugLoggerState.imagePath !=
                                                  null) ...[
                                                const SizedBox(
                                                  width: 10,
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    debugLoggerNotifier
                                                        .setisEditingImage(
                                                            true);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.orange,
                                                    ),
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ]
                                            ],
                                          ],
                                        )
                                      : Container();
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final isHandling = ref.watch(
                    debugLoggerProvider.select((value) => value.isHandling));

                return isHandling
                    ? Positioned.fill(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromRGBO(0, 0, 0, 1)
                                    .withOpacity(.5),
                              ),
                              alignment: Alignment.topCenter,
                              child: const Text(
                                'Sending log...',
                                style: TextStyle(height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container();
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final isEditing = ref.watch(debugLoggerProvider
                    .select((value) => value.isEditingImage));

                return isEditing
                    ? const Positioned.fill(child: EditDebugScreenshot())
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditDebugScreenshot extends ConsumerStatefulWidget {
  const EditDebugScreenshot({super.key});

  @override
  ConsumerState<EditDebugScreenshot> createState() =>
      _EditDebugScreenshotState();
}

class _EditDebugScreenshotState extends ConsumerState<EditDebugScreenshot> {
  GlobalKey<ImagePainterState> _imageKey = GlobalKey<ImagePainterState>();
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    final debugLoggerState = ref.watch(debugLoggerProvider);
    final debugLoggerNofitier = ref.watch(debugLoggerProvider.notifier);

    try {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                debugLoggerNofitier.setisEditingImage(false);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  if (isSaving || debugLoggerState.imagePath == null) {
                    return;
                  }

                  setState(() {
                    isSaving = true;
                  });

                  final newImageBytes =
                      await _imageKey.currentState?.exportImage();

                  if (newImageBytes != null) {
                    final file = File(debugLoggerState.imagePath!);

                    await file.writeAsBytes(newImageBytes);

                    debugLogger.d('Save success');
                  } else {
                    debugLogger.e('Save failed');
                  }

                  setState(() {
                    isSaving = false;
                  });
                },
                icon: const Icon(Icons.save),
              ),
            ],
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              if (debugLoggerState.imagePath != null) ...[
                Positioned.fill(
                  child: ImagePainter.memory(
                    File(debugLoggerState.imagePath!).readAsBytesSync(),
                    key: _imageKey,
                  ),
                ),
              ],
              if (isSaving) ...[
                Positioned.fill(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              const Color.fromRGBO(0, 0, 0, 1).withOpacity(.5),
                        ),
                      ),
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    } catch (err) {
      debugLogger.e(err);
    }

    return Container();
  }
}
