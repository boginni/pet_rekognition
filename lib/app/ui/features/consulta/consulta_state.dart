import 'package:camera/camera.dart';
import 'package:pet_recognition/app/domain/either.dart';

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
  final Either<XFile, String> bestMatch;

  const ConsultaResultCrocodiloState(this.capturedImage, this.bestMatch);
}

final class ConsultaResultLoboState extends ConsultaState {
  final double accuracy;
  final XFile capturedImage;
  final String? bestMatch;

  const ConsultaResultLoboState(
    this.accuracy,
    this.capturedImage,
    this.bestMatch,
  );
}

final class ConsultaResultAguiaState extends ConsultaState {
  final double accuracy;
  final XFile capturedImage;
  final String? bestMatch;

  const ConsultaResultAguiaState(
    this.accuracy,
    this.capturedImage,
    this.bestMatch,
  );
}
