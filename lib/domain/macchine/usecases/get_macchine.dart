import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/usecase/usecase.dart';

import '/domain/macchine/repositories/macchina.dart';

class GetMacchineUseCase extends UseCase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    return await sl<MacchinaRepository>().getMacchine();
  }
}
