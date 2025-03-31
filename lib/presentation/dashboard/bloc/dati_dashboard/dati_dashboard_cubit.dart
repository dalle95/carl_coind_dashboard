import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'dati_dashboard_state.dart';

import '/service_locator.dart';

import '/domain/linea_dashboard/usecases/get_linea_dashboard.dart';
import '/domain/linea_dashboard/entities/dettaglio_macchina.dart';
import '/domain/linea_dashboard/entities/linea_dashboard.dart';
import '/domain/tecnici/entities/tecnico.dart';
import '/domain/wo/entities/wo.dart';
import '/domain/wo/usecases/get_wo.dart';

class DatiDashboardCubit extends Cubit<DatiDashboardState> {
  DatiDashboardCubit() : super(DataLoading()) {
    getAllData();
  }

  Logger logger = sl<Logger>();

  Timer? _timerGetWO;
  Timer? _timerGetAllData;
  bool _isPolling = false;

  /// Metodo per avviare il polling
  void startPolling({int intervalInSeconds = 30, dynamic params}) {
    if (_isPolling) {
      return; // Previene una nuova inizializzazione se il polling è già attivo
    }
    // Attiva il polling
    _isPolling = true;

    // Attiva il timer per la richiesta dei dati WO (ogni 30 secondi)
    _timerGetWO = Timer.periodic(
      Duration(seconds: intervalInSeconds),
      (timer) => getWOData(params: params),
    );

    // Attiva il timer per la richiesta di tutti i dati (ogni ora)
    _timerGetAllData = Timer.periodic(
      const Duration(hours: 1),
      (timer) => getAllData(params: params),
    );
  }

  /// Metodo per fermare il polling
  void stopPolling() {
    _timerGetWO?.cancel();
    _timerGetWO = null;
    _timerGetAllData?.cancel();
    _timerGetAllData = null;
    _isPolling = false;
  }

  /// Metodo per ottenere i dati completi di: Linee, Macchine, Legami e WO
  void getAllData({dynamic params}) async {
    logger.d("DatiDashboardCubit | Funzione: getAllData");
    if (state is DataLoaded) {
      emit(
        (state as DataLoaded).copyWith(
          dataRefreshing: true,
        ),
      );
    }

    var returnedData =
        await sl<GetLineeDashboardUseCase>().call(params: params);
    returnedData.fold(
      (error) {
        Logger().e('LineeDettaglioCubit | Errore: $error');

        emit(FailureLoadData(errorMessage: error));
      },
      (data) {
        // Aggregazione dei dati
        List<LineaDashboardEntity> datiDashboard = [];

        for (var linea in data.linee) {
          List<DettaglioMacchina> dettagliMacchina = [];

          var legamiLinea =
              data.legami.where((legame) => legame.lineaId == linea.id);

          for (var legame in legamiLinea) {
            var macchina = data.macchine.firstWhere(
              (macchina) => macchina.id == legame.macchinaId,
            );

            var interventi = data.wo
                .where(
                  (wo) =>
                      wo.impiantoId == macchina.id &&
                      wo.puntoDiStrutturaId == linea.id,
                )
                .toList();

            final Set<TecnicoEntity> tecniciAssegnatiSet = {};
            for (final intervento in interventi) {
              final tecnico = intervento.assegnatoA;
              if (tecnico != null) {
                tecniciAssegnatiSet.add(tecnico);
              }
            }
            final List<TecnicoEntity> tecniciAssegnati =
                tecniciAssegnatiSet.toList();

            interventi = raggruppaWOEntity(interventi);

            var dettaglio = DettaglioMacchina(
              macchina: macchina,
              ordine: legame.ordine,
              interventi: interventi,
              tecnici: tecniciAssegnati,
            );

            dettagliMacchina.add(dettaglio);
          }
          dettagliMacchina.sort((a, b) => a.ordine.compareTo(b.ordine));

          datiDashboard.add(
            LineaDashboardEntity(
              linea: linea,
              listaMacchine: dettagliMacchina,
            ),
          );
        }

        emit(
          DataLoaded(
            datiDashboard: datiDashboard,
            linee: data.linee,
            legami: data.legami,
            macchine: data.macchine,
            wo: data.wo,
            dataRefreshed: DateTime.now(),
            dataRefreshing: false,
          ),
        );
      },
    );
    startPolling();
  }

  /// Metodo per ottenere tutti i dati di solo i WO
  void getWOData({dynamic params}) async {
    logger.d("DatiDashboardCubit | Funzione: getWOData");
    if (state is DataLoaded) {
      emit(
        (state as DataLoaded).copyWith(
          dataRefreshing: true,
        ),
      );
    }

    var returnedData = await sl<GetInterventiUseCase>().call(params: null);
    returnedData.fold(
      (error) {
        Logger().e('DatiDashboardCubit | Errore: $error');

        emit(FailureLoadData(errorMessage: error));
      },
      (data) {
        // Aggregazione dei dati
        List<LineaDashboardEntity> datiDashboard = [];

        for (var linea in (state as DataLoaded).linee) {
          List<DettaglioMacchina> dettagliMacchina = [];

          var legamiLinea = (state as DataLoaded)
              .legami
              .where((legame) => legame.lineaId == linea.id);

          for (var legame in legamiLinea) {
            var macchina = (state as DataLoaded).macchine.firstWhere(
                  (macchina) => macchina.id == legame.macchinaId,
                );

            var interventi = data
                .where(
                  (wo) =>
                      wo.impiantoId == macchina.id &&
                      wo.puntoDiStrutturaId == linea.id,
                )
                .toList();

            final Set<TecnicoEntity> tecniciAssegnatiSet = {};
            for (final intervento in interventi) {
              final tecnico = intervento.assegnatoA;
              if (tecnico != null) {
                tecniciAssegnatiSet.add(tecnico);
              }
            }
            final List<TecnicoEntity> tecniciAssegnati =
                tecniciAssegnatiSet.toList();

            interventi = raggruppaWOEntity(interventi);

            var dettaglio = DettaglioMacchina(
              macchina: macchina,
              ordine: legame.ordine,
              interventi: interventi,
              tecnici: tecniciAssegnati,
            );

            dettagliMacchina.add(dettaglio);
          }
          dettagliMacchina.sort((a, b) => a.ordine.compareTo(b.ordine));

          datiDashboard.add(
            LineaDashboardEntity(
              linea: linea,
              listaMacchine: dettagliMacchina,
            ),
          );
        }

        emit(
          (state as DataLoaded).copyWith(
            datiDashboard: datiDashboard,
            wo: data,
            dataRefreshed: DateTime.now(),
            dataRefreshing: false,
          ),
        );
      },
    );
    startPolling();
  }

  @override
  Future<void> close() {
    stopPolling(); // Ferma il polling quando il Cubit viene chiuso
    return super.close();
  }
}

List<WOEntity> raggruppaWOEntity(List<WOEntity> interventi) {
  // Mappa di "codice base" -> elenco di WO
  final Map<String, List<WOEntity>> allWOGroupedByCodice = {};
  // Mappa di "codice base" -> WO principale (se esiste)
  final Map<String, WOEntity> mainWOByCodice = {};

  for (var wo in interventi) {
    final codice = wo.codice ?? '';
    // Estraggo la parte prima del punto (se c’è)
    final codiceBase = codice.contains('.') ? codice.split('.').first : codice;

    // Salvo il WO nel raggruppamento
    allWOGroupedByCodice.putIfAbsent(codiceBase, () => []).add(wo);

    // Se questo WO è “principale” (niente ‘.’ nel codice), segno come main
    if (!codice.contains('.')) {
      mainWOByCodice[codiceBase] = wo;
    }
  }

  final List<WOEntity> result = [];

  for (var entry in allWOGroupedByCodice.entries) {
    final codiceBase = entry.key;
    final List<WOEntity> group = entry.value;

    // Prendo il WO principale se esiste, altrimenti uso il primo
    final baseWO = mainWOByCodice[codiceBase] ?? group.first;

    // Qui accumuleremo tutti i tecnici e tutte le note
    final List<TecnicoEntity> mergedTecnici = [];
    final List<String> noteList = [];
    final List<String> statoList = [];

    // Itero su TUTTI i WO di questo gruppo (principale + secondari)
    for (var wo in group) {
      // Accumulo stati
      if (wo.stato != null) {
        statoList.add(wo.stato!);
      }

      // Accumulo tecnici + note
      if (wo.assegnatoA != null) {
        final tecnico = wo.assegnatoA!;

        // Aggiungo il tecnico nella lista mergedTecnici se non presente
        // (Puoi anche usare un Set se vuoi evitare duplicati stretti)
        if (!mergedTecnici.any((t) => t.id == tecnico.id)) {
          mergedTecnici.add(tecnico);
        }

        // Se ci sono note non vuote, le aggiungo
        if (wo.note != null && wo.note!.trim().isNotEmpty) {
          // Se vuoi mostrare il nome del tecnico (se presente), altrimenti fallback
          final nomeTec = tecnico.nome.isNotEmpty == true
              ? tecnico.nome
              : 'Tecnico ${tecnico.codice}';
          noteList.add('$nomeTec: ${wo.note!.trim()}');
        }
      }
    }

    // Determinazione dello stato unificato
    String mergedStato;
    if (statoList.contains('In corso')) {
      mergedStato = 'In corso';
    } else if (statoList.contains('In pausa') &&
        statoList.every(
            (s) => s == 'In pausa' || s == 'In attesa di realizzazione')) {
      mergedStato = 'In pausa';
    } else {
      mergedStato = 'In attesa di realizzazione';
    }

    // Creo il nuovo WO "raggruppato" partendo dal baseWO
    final mergedWO = baseWO.copyWith(
      // Unisco tutti i tecnici trovati
      tecnici: mergedTecnici,
      // Se la lista note è vuota metto null, altrimenti concateno in multilinea
      note: noteList.isEmpty ? null : noteList.join('\n'),
      // Imposto lo stato calcolato
      stato: mergedStato,
    );

    result.add(mergedWO);
  }

  return result;
}
