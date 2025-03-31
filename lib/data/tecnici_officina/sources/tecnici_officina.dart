import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/service_locator.dart';

import '/domain/macchine/entities/macchina.dart';
import '/domain/macchine/usecases/get_macchine.dart';
import '/domain/tecnici/entities/tecnico.dart';
import '/domain/tecnici/usecases/get_tecnici.dart';
import '/domain/wo/entities/wo.dart';
import '/domain/wo/usecases/get_wo.dart';

abstract class TecniciOfficinaService {
  Future<Either> getDati();
}

class TecniciOfficinaServiceImpl extends TecniciOfficinaService {
  @override
  Future<Either> getDati() async {
    try {
      Either returnedData;

      List<TecnicoEntity> tecnici = [];
      returnedData = await sl<GetTecniciUseCase>().call(params: null);
      returnedData.fold((error) {}, (data) {
        tecnici = data;
      });

      List<MacchinaEntity> macchine = [];
      returnedData = await sl<GetMacchineUseCase>().call(params: null);
      returnedData.fold((error) {}, (data) {
        macchine = data;
      });

      List<WOEntity> wo = [];
      returnedData = await sl<GetInterventiUseCase>().call(params: null);
      returnedData.fold((error) {}, (data) {
        wo = data;
      });

      List<TecnicoEntity> tecniciOfficina = [];

      for (var macchina in macchine) {
        if (macchina.codice == r'MAC-VARIE') {
          var interventi = wo
              .where(
                (wo) => wo.impiantoId == macchina.id,
              )
              .toList();

          tecniciOfficina = tecnici
              .where(
                (tecnico) => interventi
                    .any((intervento) => intervento.assegnatoAId == tecnico.id),
              )
              .toList();
        }
      }

      return Right(tecniciOfficina);
    } on DioException catch (e) {
      return Left(e.response!.data['error']);
    }
  }
}
