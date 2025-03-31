import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/common/helper/errors/carl_gestione_errori.dart';

import '/core/constants/api_url.dart';
import '/core/network/dio_client.dart';

import '/data/auth/models/signin_params.dart';
import '/data/auth/models/actor.dart';

abstract class AuthService {
  // Per gestire i log
  final logger = sl<Logger>();

  Future<Either<String, String>> getToken(SigninParams params);

  Future<Either<String, Actor?>> getActor(SigninParams params);
}

class AuthApiServiceImpl extends AuthService {
  final DioClient _dio = sl<DioClient>();

  @override
  Future<Either<String, String>> getToken(SigninParams params) async {
    try {
      // Chiamata di autenticazione per estrazione token
      var responseToken = await _dio.authentication(params);

      // Gestione Ambiente non raggiungibile
      if (responseToken.statusCode == 502) {
        //TODO: lable
        throw CARLException('Ambiente non raggiungibile');
      }

      // Gestione errore credenziali
      if (responseToken.statusCode! >= 401) {
        //TODO: lable
        throw CARLException('Credenziali errate o utente bloccato');
      }

      // Estraggo il token
      String? token = responseToken.data['X-CS-Access-Token'];
      if (token != null) {
        return Right(token);
      } else {
        return const Left('Utente non valido');
      }
    } on CARLException catch (e) {
      logger.e(
          'AuthApiServiceImpl | Funzione: getToken | Errore Carl: ${e.toString()}');
      return Left(e.toString());
    } catch (e) {
      logger.d(
          'AuthApiServiceImpl | Funzione: getToken | Errore: ${e.toString()}');
      return Left(e.toString());
    }
  }

  @override

  /// Ritorna il token di autenticazione per l'utente che effettua la chiamata.
  ///
  /// Se la chiamata va a buon fine, viene restituito il token di autenticazione
  /// dell'utente. Se la chiamata va in errore, vengono restituiti messaggi di
  /// errore specifici.
  ///
  Future<Either<String, Actor?>> getActor(SigninParams params) async {
    try {
      // Definisco l'url per la chiamata di estrazione informazioni attore
      String urlAttore = '${ApiUrl.attore}${params.username}';

      // Chiamata di estrazione informazioni attore
      var response = await _dio.get(urlAttore);

      // Gestione Ambiente non raggiungibile
      if (response.statusCode == 502) {
        //TODO: lable
        throw CARLException('Ambiente non raggiungibile');
      }

      // Gestione errore credenziali
      if (response.statusCode! >= 401) {
        //TODO: lable
        throw CARLException('Credenziali errate o utente bloccato');
      }

      // Estraggo le informazioni dell'attore
      String id = response.data['data'][0]['id'];
      String codice = response.data['data'][0]['attributes']['code'];
      String nome = response.data['data'][0]['attributes']['fullName'] ?? '';

      // Creo l'attore con le informazioni estratte
      Actor actor = Actor(id: id, codice: codice, nome: nome);

      return Right(actor);
    } on CARLException catch (e) {
      logger.d(
          'AuthApiServiceImpl | Funzione: getActor | Errore: ${e.toString()}');
      return Left(e.toString());
    } catch (e) {
      logger.d(
          'AuthApiServiceImpl | Funzione: getActor | Errore: ${e.toString()}');
      return Left(e.toString());
    }
  }
}
