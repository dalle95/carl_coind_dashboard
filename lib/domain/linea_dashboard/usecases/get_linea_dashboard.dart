import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/usecase/usecase.dart';

import '/domain/linea_dashboard/repositories/linea_dashboard.dart';

class GetLineeDashboardUseCase extends UseCase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    return await sl<LineaDashboardRepository>().getDati();
  }
}
