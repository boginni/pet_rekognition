import 'package:flutter/material.dart';
import 'package:pet_recognition/app/ui/widgets/pet_comparison_component.dart';

class ResultCrocodiloComponent extends StatelessWidget {
  const ResultCrocodiloComponent({
    super.key,
    required this.onFinish,
    required this.image,
  });

  final VoidCallback onFinish;
  final ImageProvider image;

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
              leftImage: image,
              rightImage: image,
              borderColor: Theme.of(context).colorScheme.error,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text(
                  'NÃO IDENTIFICADO',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.error,
                  size: 16 * 8,
                ),
                Text('TRILHA CROCODILO'),
                FilledButton(onPressed: onFinish, child: Text('FINALIZAR')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
