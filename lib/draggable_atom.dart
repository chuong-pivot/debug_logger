import 'package:flutter/material.dart';

class DraggableAtom extends StatefulWidget {
  const DraggableAtom({
    super.key,
    required this.child,
    this.top,
    this.left,
    this.hasTrail = false,
  });

  final Widget child;
  final double? top;
  final double? left;
  final bool hasTrail;

  @override
  State<DraggableAtom> createState() => _DraggableAtomState();
}

class _DraggableAtomState extends State<DraggableAtom> {
  void updatePosition(Offset newPosition) {
    final childSize = childKey.currentContext?.size;

    setState(() {
      if (childSize != null) {
        position = Offset(
          newPosition.dx,
          newPosition.dy,
        );
      } else {
        position = newPosition;
      }
    });
  }

  final childKey = GlobalKey();

  Offset? position;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          key: childKey,
          top: position?.dy ?? widget.top,
          left: position?.dx ?? widget.left,
          child: Draggable(
            maxSimultaneousDrags: 1,
            feedback: widget.child,
            onDragEnd: (details) => updatePosition(details.offset),
            childWhenDragging: Opacity(
              opacity: widget.hasTrail ? .3 : 0,
              child: widget.child,
            ),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
