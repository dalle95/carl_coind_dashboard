import 'package:carl_coind_dashboard/data/auth/models/signin_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/auth/usecases/signin.dart';

import '/presentation/auth/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  // Per gestire i log
  final logger = sl<Logger>();

  Future<void> signIn(
    String username,
    String password,
  ) async {
    logger.d('AuthCubit | Funzione: signIn');

    emit(
      state.copyWith(isLoading: true, errorMessage: null, isSuccess: false),
    );

    if (username.isEmpty || password.isEmpty) {
      logger.d('Errore validazione dati');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Username e password devono essere compilati',
        ),
      );
      return;
    }

    final result = await sl<SigninUseCase>().call(
      params: SigninParams(
        username: username,
        password: password,
      ),
    );

    result.fold(
      (error) {
        logger.d('Errore durante il login: $error');
        emit(
          state.copyWith(isLoading: false, errorMessage: error),
        );
      },
      (_) {
        logger.d('Login avvenuta con successo');
        emit(
          state.copyWith(isLoading: false, isSuccess: true),
        );
      },
    );
  }
}
