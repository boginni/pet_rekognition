import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../custom_painters/progress_painter.dart';

class CameraViewComponent extends StatelessWidget {
  const CameraViewComponent({
    super.key,
    required this.progressValue,
    required this.cameraController,
    required this.showCounter,
    required this.counter,
  });

  final double progressValue;
  final CameraController cameraController;
  final bool showCounter;
  final int counter;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return CustomPaint(
      painter: ProgressPainter(color: colors.primary, value: progressValue),
      child: Material(
        clipBehavior: Clip.antiAlias,
        shape: const OvalBorder(),
        child: ColoredBox(
          color: colors.surfaceContainerHighest,
          child: CustomPaint(
            painter: ProgressPainter(
              color: colors.primary,
              value: progressValue,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Material(
                clipBehavior: Clip.antiAlias,
                shape: const OvalBorder(),
                child: Stack(
                  children: [
                    CameraPreview(cameraController),
                    if (showCounter)
                      Positioned(
                        bottom: 32,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.primaryContainer,
                            ),
                            child: Text(
                              counter.toString(),
                              textAlign: TextAlign.center,
                              style: textTheme.displayLarge?.copyWith(
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
