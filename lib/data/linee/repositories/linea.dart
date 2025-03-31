import 'dart:convert';

import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/common/helper/mapper/linea.dart';

import '/data/linee/models/linea.dart';
import '/data/linee/sources/linea.dart';

import '/domain/linee/repositories/linea.dart';

class LineaRepositoryImpl extends LineaRepository {
  @override
  Future<Either> getLinee() async {
    var returnedData = await sl<LineaService>().getLinee();

    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      var linee = List.from(data['data']).map(
        (item) {
          return LineaMapper.toEntity(LineaModel.fromJson(jsonEncode(item)));
        },
      ).toList();
      return Right(linee);
    });
  }
}
