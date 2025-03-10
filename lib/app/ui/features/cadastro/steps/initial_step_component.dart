import 'package:flutter/material.dart';

class InitialStepComponent extends StatelessWidget {
  const InitialStepComponent({
    super.key,
    required this.child,
    required this.onNext,
  });

  final Widget child;
  final VoidCallback onNext;

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
            Text('Prepare-se para o pet faceID', textAlign: TextAlign.center),
            Expanded(child: child),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text('Frontal 1'),
                FilledButton(onPressed: onNext, child: Text('INICIAR')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
