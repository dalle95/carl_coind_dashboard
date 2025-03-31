import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/common/helper/errors/carl_gestione_errori.dart';

import '/data/linea_dashboard/models/dati_dashboard.dart';

import '/domain/legami/entities/legame.dart';
import '/domain/legami/usecases/get_legami.dart';
import '/domain/linee/entities/linea.dart';
import '/domain/linee/usecases/get_linee.dart';
import '/domain/macchine/entities/macchina.dart';
import '/domain/macchine/usecases/get_macchine.dart';
import '/domain/wo/entities/wo.dart';
import '/domain/wo/usecases/get_wo.dart';

abstract class LineaDashboardService {
  Future<Either> getDati();
}

class LineaDashboardServiceImpl extends LineaDashboardService {
  // @override
  // Future<Either> getDati() async {
  //   try {
  //     Either returnedData;

  //     // List<TecnicoEntity> tecnici = [];
  //     // returnedData = await sl<GetTecniciUseCase>().call(params: null);
  //     // returnedData.fold((error) {
  //     //   throw CARLException(error.toString());
  //     // }, (data) {
  //     //   tecnici = data;
  //     // });

  //     List<LineaEntity> linee = [];
  //     returnedData = await sl<GetLineeUseCase>().call(params: null);
  //     returnedData.fold((error) {
  //       throw CARLException(error.toString());
  //     }, (data) {
  //       linee = data;
  //     });

  //     List<MacchinaEntity> macchine = [];
  //     returnedData = await sl<GetMacchineUseCase>().call(params: null);
  //     returnedData.fold((error) {
  //       throw CARLException(error.toString());
  //     }, (data) {
  //       macchine = data;
  //     });

  //     List<LegameEntity> legami = [];
  //     returnedData = await sl<GetLegamiUseCase>().call(params: null);
  //     returnedData.fold((error) {
  //       throw CARLException(error.toString());
  //     }, (data) {
  //       legami = data;
  //     });

  //     List<WOEntity> wo = [];
  //     returnedData = await sl<GetInterventiUseCase>().call(params: null);
  //     returnedData.fold((error) {
  //       throw CARLException(error.toString());
  //     }, (data) {
  //       wo = data;
  //     });

  //     List<LineaDashboardEntity> lineeDashboard = [];

  //     for (var linea in linee) {
  //       List<DettaglioMacchina> dettagliMacchina = [];

  //       var legamiLinea = legami.where((legame) => legame.lineaId == linea.id);

  //       for (var legame in legamiLinea) {
  //         var macchina = macchine.firstWhere(
  //           (macchina) => macchina.id == legame.macchinaId,
  //         );

  //         var interventi = wo
  //             .where(
  //               (wo) =>
  //                   wo.impiantoId == macchina.id &&
  //                   wo.puntoDiStrutturaId == linea.id,
  //             )
  //             .toList();

  //         final tecniciAssegnati = interventi
  //             .where((intervento) => intervento.assegnatoA != null)
  //             .map((intervento) => intervento.assegnatoA!)
  //             .toSet()
  //             .toList();
  //         interventi = raggruppaWOEntity(interventi);

  //         var dettaglio = DettaglioMacchina(
  //           macchina: macchina,
  //           ordine: legame.ordine,
  //           interventi: interventi,
  //           tecnici: tecniciAssegnati,
  //         );

  //         dettagliMacchina.add(dettaglio);
  //       }
  //       dettagliMacchina.sort((a, b) => a.ordine.compareTo(b.ordine));

  //       lineeDashboard.add(
  //         LineaDashboardEntity(
  //           linea: linea,
  //           listaMacchine: dettagliMacchina,
  //         ),
  //       );
  //     }

  //     return Right(lineeDashboard);
  //   } on CARLException catch (e) {
  //     return Left(e.message);
  //   }
  // }

  @override
  Future<Either> getDati() async {
    try {
      Either returnedData;

      List<LineaEntity> linee = [];
      returnedData = await sl<GetLineeUseCase>().call(params: null);
      returnedData.fold((error) {
        throw CARLException(error.toString());
      }, (data) {
        linee = data;
      });

      List<MacchinaEntity> macchine = [];
      returnedData = await sl<GetMacchineUseCase>().call(params: null);
      returnedData.fold((error) {
        throw CARLException(error.toString());
      }, (data) {
        macchine = data;
      });

      List<LegameEntity> legami = [];
      returnedData = await sl<GetLegamiUseCase>().call(params: null);
      returnedData.fold((error) {
        throw CARLException(error.toString());
      }, (data) {
        legami = data;
      });

      List<WOEntity> wo = [];
      returnedData = await sl<GetInterventiUseCase>().call(params: null);
      returnedData.fold((error) {
        throw CARLException(error.toString());
      }, (data) {
        wo = data;
      });

      final datiDashboard = DatiDashboardModel(
        linee: linee,
        legami: legami,
        macchine: macchine,
        wo: wo,
      );

      return Right(datiDashboard);
    } on CARLException catch (e) {
      return Left(e.message);
    }
  }
}
