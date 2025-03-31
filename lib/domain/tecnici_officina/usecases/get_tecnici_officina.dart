import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/usecase/usecase.dart';

import '/domain/tecnici_officina/repositories/tecnici_officina.dart';

class GetTecniciOfficinaUseCase extends UseCase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    return await sl<TecniciOfficinaRepository>().getDati();
  }
}
