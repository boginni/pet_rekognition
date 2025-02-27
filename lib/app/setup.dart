import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_recognition/app/externall/pet_repository_impl.dart';

import 'domain/pet_repository.dart';

void setup() {
  final i = GetIt.instance;

  final dio = Dio();

  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ),
  );

  dio.options.baseUrl = 'https://petlove.pupzdobrasil.com.br';

  i.registerSingleton(dio);

  i.registerLazySingleton<PetRepository>(() => PetRepositoryImpl(dio));
}
