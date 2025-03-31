import 'package:carl_coind_dashboard/core/usecase/usecase.dart';
import 'package:carl_coind_dashboard/domain/tecnici/repositories/tecnico.dart';
import 'package:carl_coind_dashboard/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetTecniciUseCase extends UseCase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    return await sl<TecnicoRepository>().getTecnici();
  }
}
