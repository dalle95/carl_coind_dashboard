import 'dart:convert';

import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/common/helper/mapper/macchina.dart';

import '/data/macchine/models/macchina.dart';
import '/data/macchine/sources/macchina.dart';

import '/domain/macchine/repositories/macchina.dart';

class MacchinaRepositoryImpl extends MacchinaRepository {
  @override
  Future<Either> getMacchine() async {
    var returnedData = await sl<MacchinaService>().getMacchine();

    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      var macchine = List.from(data['data']).map(
        (item) {
          return MacchinaMapper.toEntity(
            MacchinaModel.fromJson(jsonEncode(item)),
          );
        },
      ).toList();
      return Right(macchine);
    });
  }
}
