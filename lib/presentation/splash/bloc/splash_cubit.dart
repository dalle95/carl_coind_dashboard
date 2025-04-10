import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/auth/usecases/is_logged_in.dart';

import '/presentation/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  // Per gestire i log
  final logger = sl<Logger>();

  void appStarted() async {
    logger.d('SplashCubit | Funzione: appStarted');

    // Attesa per visualizzare lo spash screen
    await Future.delayed(const Duration(seconds: 1));

    // Controllo lo stato dell'utente (loggato o no)
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();

    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
