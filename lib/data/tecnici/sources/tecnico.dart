import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../core/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class TecnicoService {
  Future<Either> getTecnici();
}

class TecnicoApiServiceImpl extends TecnicoService {
  @override
  Future<Either> getTecnici() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.tecnici,
      );

      if (response.statusCode == 401) {
        return const Left('Sessione scaduta');
      }
      return Right(response.data);
    } on DioException catch (e) {
      Logger().e(e);
      return Left(e.response!.data['errors']);
    }
  }
}
