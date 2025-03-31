import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/api_url.dart';
import '/core/network/dio_client.dart';
import '/service_locator.dart';

abstract class LegameService {
  Future<Either> getLegami();
}

class LegameApiServiceImpl extends LegameService {
  @override
  Future<Either> getLegami() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.legami,
      );
      if (response.statusCode == 401) {
        return const Left('Sessione scaduta');
      }
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['errors']);
    }
  }
}
