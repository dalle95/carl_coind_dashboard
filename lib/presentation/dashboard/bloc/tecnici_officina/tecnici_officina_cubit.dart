import 'package:flutter_bloc/flutter_bloc.dart';

import 'tecnici_officina_state.dart';

import '/service_locator.dart';

import '/domain/tecnici_officina/usecases/get_tecnici_officina.dart';

import 'dart:async';

class TecniciOfficinaCubit extends Cubit<TecniciOfficinaState> {
  TecniciOfficinaCubit() : super(DataLoading());

  Timer? _timer;
  bool _isPolling = false;

  /// Metodo per avviare il polling
  void startPolling({int intervalInSeconds = 30}) {
    if (_isPolling) {
      return; // Previene una nuova inizializzazione se il polling è già attivo
    }
    _isPolling = true;

    _timer = Timer.periodic(
      Duration(seconds: intervalInSeconds),
      (timer) => getData(),
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
    var returnedData = await sl<GetTecniciOfficinaUseCase>().call();
    returnedData.fold(
      (error) {
        emit(FailureLoadData(errorMessage: error));
      },
      (data) {
        emit(DataLoaded(tecnici: data));
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
