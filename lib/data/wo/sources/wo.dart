import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/service_locator.dart';

import '/core/constants/api_url.dart';
import '/core/network/dio_client.dart';

import '/data/wo/models/wo.dart';

import '/domain/linee/entities/linea.dart';
import '/domain/macchine/entities/macchina.dart';
import '/domain/tecnici/entities/tecnico.dart';

import '/common/helper/errors/carl_gestione_errori.dart';
import '/common/helper/utils/date_utils.dart';

abstract class WOService {
  Future<Either> getInterventi();
}

class WOApiServiceImpl extends WOService {
  @override
  Future<Either> getInterventi() async {
    // List<WOModel> lista = [];
    // Response<dynamic> response;
    // Map<String, dynamic> responseMap;
    // dynamic responseIncluded;
    // dynamic responseData;

    // try {
    //   response = await sl<DioClient>().get(
    //     ApiUrl.interventiEImpianti,
    //   );

    //   // Gestione errore di autenticazione
    //   if (response.statusCode == 401) {
    //     return const Left('Sessione scaduta');
    //   }

    //   // Gestione errore generico
    //   //TODO: lable
    //   if (response.statusCode! >= 400) {
    //     throw CARLException('Errore generico');
    //   }

    //   responseMap = response.data;
    //   responseIncluded = responseMap['included'];
    //   responseData = responseMap['data'];

    //   // Se non sono presenti dati esco dalla funzione
    //   if (responseIncluded == null || responseData == null) {
    //     return const Right([]);
    //   }

    //   // Itero per i risultati presenti nella path "included" e definisco i WO trovati
    //   for (var record in responseIncluded) {
    //     if (record['type'] == 'wo') {
    //       // Trova la natura, il creatoDa e l'assegnatoA dal JSON included
    //       var natura = responseIncluded.firstWhere(
    //         (item) =>
    //             item['id'] ==
    //             record['relationships']?['actionType']?['data']?['id'],
    //         orElse: () => null,
    //       );
    //       var assegnatoAId =
    //           record['relationships']?['assignedTo']?['data']?['id'];

    //       var assegnatoA = responseIncluded.firstWhere(
    //         (item) => item['id'] == assegnatoAId,
    //         orElse: () => null,
    //       );

    //       var note = responseIncluded.firstWhere(
    //         (item) =>
    //             item['id'] ==
    //             record['relationships']?['longDesc']?['data']?['id'],
    //         orElse: () => null,
    //       );

    //       // Trova impianto e puntoDiStruttura dal JSON data
    //       String? impiantoId;
    //       String? puntoDiStrutturaId;
    //       MacchinaEntity? impianto;
    //       LineaEntity? puntoDiStruttura;

    //       for (var dataRecord in responseData) {
    //         if (dataRecord['type'] == 'woeqpt' &&
    //             dataRecord['relationships']?['WO']?['data']?['id'] ==
    //                 record['id']) {
    //           // Trova impianto (eqpt.type == "material")
    //           var id = dataRecord['relationships']?['eqpt']?['data']?['id'];
    //           var impiantoRecord = responseIncluded.firstWhere(
    //             (item) => item['id'] == id && item['type'] == 'material',
    //             orElse: () => null,
    //           );
    //           if (impiantoRecord != null) {
    //             impiantoId = impiantoRecord['id'];
    //             impianto = MacchinaEntity(
    //               id: impiantoRecord['id'],
    //               codice: impiantoRecord['attributes']?['code'],
    //               descrizione: impiantoRecord['attributes']?['description'],
    //               stato: impiantoRecord['attributes']?['statusCode'],
    //             );
    //           }

    //           // Trova puntoDiStruttura (eqpt.type == "box")
    //           id = dataRecord['relationships']?['eqpt']?['data']?['id'];
    //           var puntoDiStrutturaRecord = responseIncluded.firstWhere(
    //             (item) => item['id'] == id && item['type'] == 'box',
    //             orElse: () => null,
    //           );
    //           if (puntoDiStrutturaRecord != null) {
    //             puntoDiStrutturaId = puntoDiStrutturaRecord['id'];
    //             puntoDiStruttura = LineaEntity(
    //               id: puntoDiStrutturaRecord['id'],
    //               codice: puntoDiStrutturaRecord['attributes']?['code'],
    //               descrizione: puntoDiStrutturaRecord['attributes']
    //                   ?['description'],
    //               stato: puntoDiStrutturaRecord['attributes']?['statusCode'],
    //             );
    //           }
    //         }
    //       }

    //       // Codifica stato
    //       String descrizioneStato;
    //       switch (record['attributes']?['statusCode']) {
    //         case 'AWAITINGREAL':
    //           descrizioneStato = 'In attesa di realizzazione';
    //           break;
    //         case 'INPROGRESS':
    //           descrizioneStato = 'In corso';
    //           break;
    //         case 'PAUSE':
    //           descrizioneStato = 'In pausa';
    //           break;
    //         default:
    //           descrizioneStato = 'In attesa di realizzazione';
    //       }

    //       // Per definire se l'intervento è un intervento padre o figlio
    //       final codice = record['attributes']?['code'] as String?;

    //       final tipoIntervento = (codice != null &&
    //               codice.contains('.') &&
    //               codice.split('.').length > 1)
    //           ? codice.split('.')[1]
    //           : 'Principale';

    //       lista.add(
    //         WOModel(
    //           id: record['id'],
    //           codice: codice ?? 'Nessuno',
    //           descrizione: record['attributes']?['description'] ?? 'Nessuno',
    //           stato: descrizioneStato,
    //           natura: natura != null
    //               ? natura['attributes']['description']
    //               : 'Nessuna',
    //           dataCreazione: record['attributes']?['createDate'] != null
    //               ? DateUtils.conversioneDataCarlFormatDateTime(
    //                   record['attributes']['createDate'])
    //               : null,
    //           dataInizio: record['attributes']?['WOBegin'] != null
    //               ? DateUtils.conversioneDataCarlFormatDateTime(
    //                   record['attributes']['WOBegin'])
    //               : null,
    //           dataFine: record['attributes']?['WOEnd'] != null
    //               ? DateUtils.conversioneDataCarlFormatDateTime(
    //                   record['attributes']['WOEnd'])
    //               : null,
    //           operatoreLinea: record['attributes']?['xtraTxt01'] ?? 'Nessuna',
    //           statoMacchina:
    //               record['attributes']?['xtraTxt15'] ?? 'Non definito',
    //           assegnatoAId: assegnatoAId ?? 'Nessuno',
    //           assegnatoA: assegnatoA != null
    //               ? TecnicoEntity(
    //                   id: assegnatoAId ?? 'Nessuno',
    //                   codice: assegnatoA?['attributes']['code'],
    //                   nome: assegnatoA?['attributes']['fullName'],
    //                   stato: assegnatoA?['attributes']['statusCode'],
    //                 )
    //               : null,
    //           puntoDiStrutturaId: puntoDiStrutturaId,
    //           puntoDiStruttura: puntoDiStruttura,
    //           impiantoId: impiantoId,
    //           impianto: impianto,
    //           tipoIntervento: tipoIntervento,
    //           note: note?['attributes']['rawDescription'],
    //         ),
    //       );
    //     }
    //   }

    Response response;
    List<WOModel> lista = [];
    try {
      response = await sl<DioClient>().get(ApiUrl.interventiEImpianti);

      lista = await parseWOListFromResponse(response);

      response = await sl<DioClient>()
          .get(ApiUrl.interventiEImpiantiPrincipaliCompletati);

      final secondList = await parseWOListFromResponse(response);

      for (final wo in secondList) {
        if (!lista.any((e) => e.id == wo.id) &&
            lista.any((e) => e.codice?.startsWith(wo.codice ?? '') == true)) {
          lista.add(wo);
        }
      }

      return Right(lista);
    } on CARLException catch (e) {
      return Left(e.message);
    } on DioException catch (e) {
      return Left(e.response!.data['errors']);
    }
  }
}

Future<List<WOModel>> parseWOListFromResponse(
    Response<dynamic> response) async {
  if (response.statusCode == 401) {
    throw CARLException('Sessione scaduta');
  }

  if (response.statusCode! >= 400) {
    throw CARLException('Errore generico');
  }

  final Map<String, dynamic> responseMap = response.data;
  final List<dynamic>? responseIncluded = responseMap['included'];
  final List<dynamic>? responseData = responseMap['data'];

  if (responseIncluded == null || responseData == null) return [];

  final List<WOModel> lista = [];

  for (var record in responseIncluded) {
    if (record['type'] != 'wo') continue;

    final natura = responseIncluded.firstWhere(
      (item) =>
          item['id'] == record['relationships']?['actionType']?['data']?['id'],
      orElse: () => null,
    );

    final assegnatoAId = record['relationships']?['assignedTo']?['data']?['id'];

    final assegnatoA = responseIncluded.firstWhere(
      (item) => item['id'] == assegnatoAId,
      orElse: () => null,
    );

    final note = responseIncluded.firstWhere(
      (item) =>
          item['id'] == record['relationships']?['longDesc']?['data']?['id'],
      orElse: () => null,
    );

    String? impiantoId;
    String? puntoDiStrutturaId;
    MacchinaEntity? impianto;
    LineaEntity? puntoDiStruttura;

    for (var dataRecord in responseData) {
      if (dataRecord['type'] != 'woeqpt' ||
          dataRecord['relationships']?['WO']?['data']?['id'] != record['id']) {
        continue;
      }

      var id = dataRecord['relationships']?['eqpt']?['data']?['id'];

      var impiantoRecord = responseIncluded.firstWhere(
        (item) => item['id'] == id && item['type'] == 'material',
        orElse: () => null,
      );
      if (impiantoRecord != null) {
        impiantoId = impiantoRecord['id'];
        impianto = MacchinaEntity(
          id: impiantoRecord['id'],
          codice: impiantoRecord['attributes']?['code'],
          descrizione: impiantoRecord['attributes']?['description'],
          stato: impiantoRecord['attributes']?['statusCode'],
        );
      }

      var puntoDiStrutturaRecord = responseIncluded.firstWhere(
        (item) => item['id'] == id && item['type'] == 'box',
        orElse: () => null,
      );
      if (puntoDiStrutturaRecord != null) {
        puntoDiStrutturaId = puntoDiStrutturaRecord['id'];
        puntoDiStruttura = LineaEntity(
          id: puntoDiStrutturaRecord['id'],
          codice: puntoDiStrutturaRecord['attributes']?['code'],
          descrizione: puntoDiStrutturaRecord['attributes']?['description'],
          stato: puntoDiStrutturaRecord['attributes']?['statusCode'],
        );
      }
    }

    String descrizioneStato;
    switch (record['attributes']?['statusCode']) {
      case 'AWAITINGREAL':
        descrizioneStato = 'In attesa di realizzazione';
        break;
      case 'INPROGRESS':
        descrizioneStato = 'In corso';
        break;
      case 'PAUSE':
        descrizioneStato = 'In pausa';
        break;
      default:
        descrizioneStato = 'In attesa di realizzazione';
    }

    final codice = record['attributes']?['code'] as String?;

    final tipoIntervento =
        (codice != null && codice.contains('.') && codice.split('.').length > 1)
            ? codice.split('.')[1]
            : 'Principale';

    lista.add(
      WOModel(
        id: record['id'],
        codice: codice ?? 'Nessuno',
        descrizione: record['attributes']?['description'] ?? 'Nessuno',
        stato: descrizioneStato,
        natura:
            natura != null ? natura['attributes']['description'] : 'Nessuna',
        dataCreazione: record['attributes']?['createDate'] != null
            ? DateUtils.conversioneDataCarlFormatDateTime(
                record['attributes']['createDate'])
            : null,
        dataInizio: record['attributes']?['WOBegin'] != null
            ? DateUtils.conversioneDataCarlFormatDateTime(
                record['attributes']['WOBegin'])
            : null,
        dataFine: record['attributes']?['WOEnd'] != null
            ? DateUtils.conversioneDataCarlFormatDateTime(
                record['attributes']['WOEnd'])
            : null,
        operatoreLinea: record['attributes']?['xtraTxt01'] ?? 'Nessuna',
        statoMacchina: record['attributes']?['xtraTxt15'] ?? 'Non definito',
        assegnatoAId: assegnatoAId ?? 'Nessuno',
        assegnatoA: assegnatoA != null
            ? TecnicoEntity(
                id: assegnatoAId ?? 'Nessuno',
                codice: assegnatoA?['attributes']['code'],
                nome: assegnatoA?['attributes']['fullName'],
                stato: assegnatoA?['attributes']['statusCode'],
              )
            : null,
        puntoDiStrutturaId: puntoDiStrutturaId,
        puntoDiStruttura: puntoDiStruttura,
        impiantoId: impiantoId,
        impianto: impianto,
        tipoIntervento: tipoIntervento,
        note: note?['attributes']['rawDescription'],
      ),
    );
  }

  return lista;
}
