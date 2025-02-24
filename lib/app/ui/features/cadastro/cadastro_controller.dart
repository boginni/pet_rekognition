import 'package:camera/camera.dart';

import 'cadastro_state.dart';

class CadastroController {
  Future<CameraController> getCameraController() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      throw Exception('No cameras available');
    }

    final cameraController = CameraController(cameras[0], ResolutionPreset.max);

    await cameraController.initialize();

    return cameraController;
  }

}
