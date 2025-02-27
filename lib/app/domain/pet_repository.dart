import 'package:camera/camera.dart';

abstract interface class PetRepository {
  const PetRepository();

  Future<void> register(XFile image);

  Future<void> search(XFile photo);

  Future<String> authenticate();
}
