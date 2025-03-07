import 'package:flutter/material.dart';

import '../../../domain/result_match_entity.dart';

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

final class ConsultaNotFoundState extends ConsultaState {
  final ImageProvider petImage;

  const ConsultaNotFoundState(this.petImage);
}

final class ConsultaResultState extends ConsultaState {
  final List<ResultMatchesEntity> matches;
  final ImageProvider petImage;

  const ConsultaResultState({required this.matches, required this.petImage});
}
