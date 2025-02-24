sealed class CadastroState {
  const CadastroState();
}

final class CadastroStartState extends CadastroState {
  const CadastroStartState();
}

final class FrontalSideState extends CadastroState {
  final int index;

  const FrontalSideState(this.index);
}

final class LeftSideState extends CadastroState {
  const LeftSideState();
}

final class RightSideState extends CadastroState {
  const RightSideState();
}

final class UpSideState extends CadastroState {
  const UpSideState();
}

final class DownSideState extends CadastroState {
  const DownSideState();
}

final class CadastroFinalizeState extends CadastroState {
  const CadastroFinalizeState();
}
