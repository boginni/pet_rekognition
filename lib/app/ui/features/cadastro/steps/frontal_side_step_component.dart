import 'package:flutter/material.dart';

class FrontalSideStepComponent extends StatelessWidget {
  const FrontalSideStepComponent({
    super.key,
    required this.index,
    required this.child,
    required this.onNext,
  });
  final int index;
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
            Text('', textAlign: TextAlign.center),
            Expanded(child: child),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text('FRONTAL $index'),
                FilledButton(onPressed: onNext, child: Text('Avançar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
