import 'package:flutter/material.dart';

class UpSideStepComponent extends StatelessWidget {
  const UpSideStepComponent({
    super.key,
    required this.child,
  });

  final Widget child;

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
                Text('FACE PARA CIMA'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
