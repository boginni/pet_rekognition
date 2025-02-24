import 'package:flutter/material.dart';

class PetFaceComponent extends StatelessWidget {
  const PetFaceComponent({super.key, required this.cameraBuilder});

  final WidgetBuilder cameraBuilder;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16 * 2),
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: OvalBorder(side: BorderSide(color: colors.primary, width: 2)),
          child: cameraBuilder(context),
        ),
      ),
    );
  }
}
