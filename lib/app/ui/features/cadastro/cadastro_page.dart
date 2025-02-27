import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/down_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/finalize_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/frontal_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/initial_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/left_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/right_side_step_component.dart';
import 'package:pet_recognition/app/ui/features/cadastro/steps/up_side_step_component.dart';
import 'package:pet_recognition/app/ui/widgets/pet_face_component.dart';

import '../../widgets/oval_progress_border/oval_progress_border.dart';
import 'cadastro_controller.dart';
import 'cadastro_state.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage>
    with TickerProviderStateMixin {
  final state = ValueNotifier<CadastroState>(CadastroStartState());
  final controller = CadastroController();
  late final animationController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );

  bool isTakingPicture = false;

  CameraController? cameraController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    cameraController = await controller.getCameraController();
    setState(() {});
  }

  Future<XFile?> _takePicture() async {
    final CameraController? cameraController = this.cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      final file = await cameraController.takePicture();
      return file;
    } on CameraException catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erro ao tirar foto')));
      }

      return null;
    }
  }

  Future<XFile?> takePicture() async {
    if (isTakingPicture) {
      throw Exception('Already taking picture');
    }

    try {
      isTakingPicture = true;

      final image = await _takePicture();

      if (image != null) {
        return image;
      }
    } finally {
      isTakingPicture = false;
    }

    return null;
  }

  void finalize() {
    Navigator.of(context).pop();
  }

  void nextStep() async {
    final action = switch (state.value) {
      CadastroStartState() => () {
        state.value = LeftSideState();
      },
      LeftSideState() => () {
        state.value = FrontalSideState(2);
      },
      RightSideState() => () {
        state.value = FrontalSideState(3);
      },
      UpSideState() => () {
        state.value = FrontalSideState(4);
      },
      DownSideState() => () {
        state.value = FrontalSideState(5);
      },
      CadastroFinalizeState() => () {
        state.value = CadastroStartState();
      },
      FrontalSideState(index: final index) => () {
        switch (index) {
          case 1:
            state.value = LeftSideState();
            break;
          case 2:
            state.value = RightSideState();
            break;
          case 3:
            state.value = UpSideState();
            break;
          case 4:
            state.value = DownSideState();
            break;
          case 5:
            state.value = CadastroFinalizeState();
            break;
          default:
            state.value = CadastroStartState();
        }
      },
    };

    final image = await takePicture();

    if (image == null) {
      return;
    }

    try {
      await controller.register(image);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao registrar imagem')),
        );
      }

      return;
    }

    action();
    animationController.reset();
    animationController.forward().then((value) {
      if (state.value is! CadastroFinalizeState) {
        nextStep();
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    cameraBuilder(BuildContext context) {
      if (cameraController != null) {
        return ValueListenableBuilder(
          valueListenable: animationController,
          builder: (context, value, _) {
            final counter = (3 - (value * 3)).ceil();

            return Center(
              child: CustomPaint(
                painter: ProgressPainter(color: colors.primary, value: value),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  shape: const OvalBorder(),
                  child: ColoredBox(
                    color: colors.surfaceContainerHighest,
                    child: CustomPaint(
                      painter: ProgressPainter(
                        color: colors.primary,
                        value: value,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          shape: const OvalBorder(),
                          child: Stack(
                            children: [
                              CameraPreview(cameraController!),
                              if (animationController.isAnimating)
                                Positioned(
                                  bottom: 32,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colors.primaryContainer,
                                      ),
                                      child: Text(
                                        counter.toString(),
                                        textAlign: TextAlign.center,
                                        style: textTheme.displayLarge?.copyWith(
                                          color: colors.onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }

      return const CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: ValueListenableBuilder(
        valueListenable: state,
        builder: (context, currentState, child) {
          return switch (currentState) {
            CadastroStartState() => InitialStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                animationController.reset();
                animationController.forward().then((value) {
                  nextStep();
                });
              },
            ),
            LeftSideState() => LeftSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                await takePicture();
                state.value = FrontalSideState(2);
              },
            ),
            RightSideState() => RightSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                await takePicture();
                state.value = FrontalSideState(3);
              },
            ),
            UpSideState() => UpSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () {
                takePicture();
                state.value = FrontalSideState(4);
              },
            ),
            DownSideState() => DownSideStepComponent(
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                await takePicture();
                state.value = FrontalSideState(5);
              },
            ),
            CadastroFinalizeState() => FinalizeComponent(
              finalize: () {
                finalize();
              },
            ),
            FrontalSideState(index: final index) => FrontalSideStepComponent(
              index: index,
              child: PetFaceComponent(cameraBuilder: cameraBuilder),
              onNext: () async {
                await takePicture();

                switch (index) {
                  case 1:
                    state.value = LeftSideState();
                    break;
                  case 2:
                    state.value = RightSideState();
                    break;
                  case 3:
                    state.value = UpSideState();
                    break;
                  case 4:
                    state.value = DownSideState();
                    break;
                  case 5:
                    state.value = CadastroFinalizeState();
                    break;
                  default:
                    state.value = CadastroStartState();
                }
              },
            ),
          };
        },
      ),
    );
  }
}
