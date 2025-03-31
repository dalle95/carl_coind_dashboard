import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/usecase/usecase.dart';

import '/domain/linee/repositories/linea.dart';

class GetLineeUseCase extends UseCase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    return await sl<LineaRepository>().getLinee();
  }
}
