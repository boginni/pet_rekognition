import 'package:camera/camera.dart';
import 'package:pet_recognition/app/domain/search_result_entity.dart';

abstract interface class PetRepository {
  const PetRepository();

  Future<void> register(XFile image);

  Future<SearchResultEntity> search(XFile photo);

  Future<String> authenticate();
}
