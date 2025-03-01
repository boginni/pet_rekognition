import 'package:flutter/material.dart';

class LoadingStepComponent extends StatelessWidget {
  const LoadingStepComponent({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16 * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 32,
          children: [
            Text('Enviando Fotos', textAlign: TextAlign.center),
            Expanded(
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Center(child: CircularProgressIndicator()),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 16,
                        child: LinearProgressIndicator(value: progress),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [Text('')],
            ),
          ],
        ),
      ),
    );
  }
}
