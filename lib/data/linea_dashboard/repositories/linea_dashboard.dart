import 'package:dartz/dartz.dart';

import '/data/linea_dashboard/sources/linea_dashboard.dart';

import '/domain/linea_dashboard/repositories/linea_dashboard.dart';

import '/service_locator.dart';

class LineaDashboardRepositoryImpl extends LineaDashboardRepository {
  @override
  Future<Either> getDati() async {
    var returnedData = await sl<LineaDashboardService>().getDati();

    return returnedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }
}
