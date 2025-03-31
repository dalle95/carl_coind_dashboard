import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/data/auth/sources/auth_api_service.dart';
import '/data/auth/models/signin_params.dart';
import '/data/auth/models/utente.dart';

import '/domain/auth/repositories/auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FlutterSecureStorage _storage = sl<FlutterSecureStorage>();

  @override
  Future<Either<String, Utente>> signin(SigninParams params) async {
    logger.d("AuthRepositoryImpl | Funzione: signin");

    // Inizializzo la data di aggiornamento del token
    final refreshDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).toIso8601String();

    // Faccio la chiamata per l'estrazione del token
    var tokenData = await sl<AuthService>().getToken(params);

    // Propagazione del risultato del token
    return await tokenData.fold(
      (error) async {
        // Gestione errore
        return Left(error);
      },
      (token) async {
        // Scrivo il token nello storage
        await _storage.write(key: 'token', value: token);

        // Chiamo la chiamata per l'estrazione dell'attore
        var actorData = await sl<AuthService>().getActor(params);

        // Propagazione del risultato dell'attore
        return await actorData.fold(
          (error) async {
            // Gestione errore
            return Left(error);
          },
          (actor) async {
            // Scrivo l'attore nello storage
            await _storage.write(
              key: 'attore',
              value: jsonEncode(actor!.toJson()),
            );

            // Creo l'utente con le informazioni estratte
            Utente utente = Utente(
              token: token,
              username: params.username,
              password: params.password,
              refreshDate: refreshDate,
            );

            // Scrivo l'utente nello storage
            await _storage.write(
              key: 'utente',
              value: jsonEncode(utente.toJson()),
            );

            return Right(utente);
          },
        );
      },
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    logger.d("AuthRepositoryImpl | Funzione: isLoggedIn");

    String? token = await _storage.read(key: 'token');
    return token != null;
  }

  @override
  Future<Either<String, void>> logout() async {
    logger.d("AuthRepositoryImpl | Funzione: logout");

    try {
      await _storage.delete(key: 'token');
      await _storage.delete(key: 'utente');
      await _storage.delete(key: 'attore');

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
