import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class LineaService {
  Future<Either> getLinee();
}

class LineaApiServiceImpl extends LineaService {
  @override
  Future<Either> getLinee() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.linee,
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
