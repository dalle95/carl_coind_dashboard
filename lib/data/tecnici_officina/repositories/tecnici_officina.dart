import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '../sources/tecnici_officina.dart';

import '/domain/tecnici_officina/repositories/tecnici_officina.dart';

class TecniciOfficinaRepositoryImpl extends TecniciOfficinaRepository {
  @override
  Future<Either> getDati() async {
    var returnedData = await sl<TecniciOfficinaService>().getDati();

    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data);
    });
  }
}
