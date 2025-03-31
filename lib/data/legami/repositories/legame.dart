import 'dart:convert';

import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/common/helper/mapper/legame.dart';

import '/data/legami/models/legame.dart';
import '/data/legami/sources/legame.dart';

import '/domain/legami/repositories/legame.dart';

class LegameRepositoryImpl extends LegamiRepository {
  @override
  Future<Either> getLegami() async {
    var returnedData = await sl<LegameService>().getLegami();

    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      var legami = List.from(data['data']).map(
        (item) {
          return LegameMapper.toEntity(
            LegameModel.fromJson(jsonEncode(item)),
          );
        },
      ).toList();
      return Right(legami);
    });
  }
}
