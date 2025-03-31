import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '/common/helper/mapper/tecnico.dart';

import '/data/tecnici/models/tecnico.dart';
import '/data/tecnici/sources/tecnico.dart';

import '../../../domain/tecnici/repositories/tecnico.dart';

import '/service_locator.dart';

class TecnicoRepositoryImpl extends TecnicoRepository {
  @override
  Future<Either> getTecnici() async {
    var returnedData = await sl<TecnicoService>().getTecnici();

    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      var tecnici = List.from(data['data']).map(
        (item) {
          return TecnicoMapper.toEntity(
              TecnicoModel.fromJson(jsonEncode(item)));
        },
      ).toList();
      return Right(tecnici);
    });
  }
}
