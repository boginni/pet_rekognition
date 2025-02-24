import 'package:flutter/material.dart';

import '../../../widgets/pet_comparison_component.dart';

class ResultAguiaComponent extends StatelessWidget {
  const ResultAguiaComponent({
    super.key,

    required this.onFinish,
    required this.leftImage,
    required this.rightImage,
    required this.accuracy,
  });

  final double accuracy;
  final VoidCallback onFinish;
  final ImageProvider leftImage;
  final ImageProvider rightImage;

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
            Text('RESULTADO', textAlign: TextAlign.center),
            PetComparisonComponent(
              leftImage: leftImage,
              rightImage: rightImage,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text('${accuracy.toStringAsFixed(1)}%'),
                Icon(
                  Icons.check_circle_sharp,
                  color: Theme.of(context).colorScheme.primary,
                  size: 16 * 8,
                ),
                Text('Trilha Águia'),
                FilledButton(onPressed: onFinish, child: Text('FINALIZAR')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
