import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

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
            Text('CONSULTANDO', textAlign: TextAlign.center),
            Expanded(
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: 3,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [Text('AGUARDE ALGUNS INSTANTES')],
            ),
          ],
        ),
      ),
    );
  }
}
