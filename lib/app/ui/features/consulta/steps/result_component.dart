import 'package:flutter/material.dart';
import 'package:pet_recognition/app/ui/widgets/pet_comparison_component.dart';

import '../../../../domain/result_match_entity.dart';

class ResultComponent extends StatelessWidget {
  final List<ResultMatchesEntity> matches;
  final ImageProvider petImage;
  final VoidCallback onFinish;
  final int maxSize;

  const ResultComponent({
    super.key,
    required this.matches,
    required this.petImage,
    required this.onFinish,
    this.maxSize = 2,
  });

  @override
  Widget build(BuildContext context) {
    final listSize = matches.length;

    return Column(
      spacing: 16,
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: listSize > maxSize ? maxSize : listSize,
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemBuilder: (context, index) {
              final match = matches[index];

              final matchImage = match.rawImage;

              final ImageProvider rightImage =
                  matchImage != null
                      ? NetworkImage(matchImage)
                      : AssetImage('assets/placeholder-image.png');

              final score = match.score ?? 0;

              final goodScore = score >= 0.8;

              return Column(
                spacing: 16,
                children: [
                  PetComparisonComponent(
                    leftImage: petImage,
                    rightImage: rightImage,
                    borderColor:
                        goodScore
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.error,
                  ),
                  Builder(
                    builder: (context) {
                      if (score >= 0.9) {
                        return Row(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16 * 2,
                              height: 16 * 2,
                              child: Image.asset('assets/aguia.png'),
                            ),

                            Text('${(score * 100.0).toStringAsFixed(1)}%'),
                          ],
                        );
                      }

                      if (score >= 0.8) {
                        return Row(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16 * 2,
                              height: 16 * 2,
                              child: Image.asset('assets/lobo.png'),
                            ),
                            Text('${(score * 100.0).toStringAsFixed(1)}%'),
                          ],
                        );
                      }

                      return SizedBox(
                        width: 16 * 2,
                        height: 16 * 2,
                        child: Image.asset('assets/crocodilo.png'),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
        FilledButton(onPressed: onFinish, child: Text('FINALIZAR')),
        SizedBox(height: 16,),
      ],
    );
  }
}
