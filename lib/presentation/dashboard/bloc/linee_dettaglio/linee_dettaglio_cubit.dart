import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'linee_dettaglio_state.dart';

import '/service_locator.dart';

import '/domain/linea_dashboard/usecases/get_linea_dashboard.dart';

class LineeDettaglioCubit extends Cubit<LineeDettaglioState> {
  LineeDettaglioCubit() : super(DataLoading());

  Logger logger = sl<Logger>();

  Timer? _timer;
  bool _isPolling = false;

  /// Metodo per avviare il polling
  void startPolling({int intervalInSeconds = 30, dynamic params}) {
    if (_isPolling) {
      return; // Previene una nuova inizializzazione se il polling è già attivo
    }
    _isPolling = true;

    _timer = Timer.periodic(
      Duration(seconds: intervalInSeconds),
      (timer) => getData(params: params),
    );
  }

  /// Metodo per fermare il polling
  void stopPolling() {
    _timer?.cancel();
    _timer = null;
    _isPolling = false;
  }

  /// Metodo per ottenere i dati
  void getData({dynamic params}) async {
    logger.d("LineeDettaglioCubit | Funzione: getData");
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
        emit(
          DataLoaded(
            linee: data,
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
