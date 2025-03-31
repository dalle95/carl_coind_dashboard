import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/common/helper/mapper/wo.dart';

import '/data/wo/sources/wo.dart';

import '/domain/wo/repositories/wo.dart';

class WORepositoryImpl extends WORepository {
  @override
  Future<Either> getInterventi() async {
    var returnedData = await sl<WOService>().getInterventi();

    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      var wo = List.from(data).map(
        (item) {
          return WOMapper.toEntity(item);
        },
      ).toList();
      return Right(wo);
    });
  }
}
