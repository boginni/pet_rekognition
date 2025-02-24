import 'package:flutter/material.dart';

class PetComparisonComponent extends StatelessWidget {
  const PetComparisonComponent({
    super.key,
    required this.leftImage,
    required this.rightImage,
    this.borderColor,
  });

  final ImageProvider leftImage;
  final ImageProvider rightImage;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              clipBehavior: Clip.antiAlias,
              shape: OvalBorder(
                side: BorderSide(
                  color: borderColor ?? Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Image(
                image: leftImage,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              clipBehavior: Clip.antiAlias,
              shape: OvalBorder(
                side: BorderSide(
                  color: borderColor ?? Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Image(
                image: rightImage,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
