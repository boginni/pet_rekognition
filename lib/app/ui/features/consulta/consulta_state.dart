import 'package:camera/camera.dart';

sealed class ConsultaState {
  const ConsultaState();
}

final class ConsultaCapturaState extends ConsultaState {
  const ConsultaCapturaState();
}

final class ConsultaLoadingState extends ConsultaState {
  const ConsultaLoadingState();
}

final class ConsultaErrorState extends ConsultaState {
  const ConsultaErrorState();
}

final class ConsultaResultCrocodiloState extends ConsultaState {
  final XFile capturedImage;

  const ConsultaResultCrocodiloState(this.capturedImage);
}

final class ConsultaResultLoboState extends ConsultaState {
  final double accuracy;
  final XFile capturedImage;
  final XFile bestMatch;

  const ConsultaResultLoboState(
    this.accuracy,
    this.capturedImage,
    this.bestMatch,
  );
}

final class ConsultaResultAguiaState extends ConsultaState {
  final XFile capturedImage;
  final XFile bestMatch;
  final double accuracy;

  const ConsultaResultAguiaState(
    this.accuracy,
    this.capturedImage,
    this.bestMatch,
  );
}
