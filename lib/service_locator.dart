import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '/core/network/dio_client.dart';

import '/data/tecnici/repositories/tecnico.dart';
import '/data/tecnici/sources/tecnico.dart';
import '/data/auth/repositories/auth.dart';
import '/data/auth/sources/auth_api_service.dart';
import '/data/linee/repositories/linea.dart';
import '/data/linee/sources/linea.dart';
import '/data/legami/repositories/legame.dart';
import '/data/legami/sources/legame.dart';
import '/data/macchine/repositories/macchina.dart';
import '/data/macchine/sources/macchina.dart';
import '/data/wo/repositories/wo.dart';
import '/data/wo/sources/wo.dart';
import '/data/linea_dashboard/repositories/linea_dashboard.dart';
import '/data/linea_dashboard/sources/linea_dashboard.dart';
import '/data/tecnici_officina/repositories/tecnici_officina.dart';
import '/data/tecnici_officina/sources/tecnici_officina.dart';

import '/domain/auth/repositories/auth.dart';
import '/domain/auth/usecases/is_logged_in.dart';
import '/domain/auth/usecases/logout.dart';
import '/domain/auth/usecases/signin.dart';
import '/domain/linee/repositories/linea.dart';
import '/domain/linee/usecases/get_linee.dart';
import '/domain/tecnici/repositories/tecnico.dart';
import '/domain/tecnici/usecases/get_tecnici.dart';
import '/domain/legami/repositories/legame.dart';
import '/domain/legami/usecases/get_legami.dart';
import '/domain/macchine/repositories/macchina.dart';
import '/domain/macchine/usecases/get_macchine.dart';
import '/domain/wo/repositories/wo.dart';
import '/domain/wo/usecases/get_wo.dart';
import '/domain/auth/usecases/auto_login.dart';
import '/domain/linea_dashboard/repositories/linea_dashboard.dart';
import '/domain/linea_dashboard/usecases/get_linea_dashboard.dart';
import '/domain/tecnici_officina/repositories/tecnici_officina.dart';
import '/domain/tecnici_officina/usecases/get_tecnici_officina.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Singleton Tecnici
  sl.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
    ),
  );
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // Services
  sl.registerSingleton<AuthService>(AuthApiServiceImpl());
  sl.registerSingleton<TecnicoService>(TecnicoApiServiceImpl());
  sl.registerSingleton<LineaService>(LineaApiServiceImpl());
  sl.registerSingleton<MacchinaService>(MacchinaApiServiceImpl());
  sl.registerSingleton<LegameService>(LegameApiServiceImpl());
  sl.registerSingleton<WOService>(WOApiServiceImpl());
  sl.registerSingleton<LineaDashboardService>(LineaDashboardServiceImpl());
  sl.registerSingleton<TecniciOfficinaService>(TecniciOfficinaServiceImpl());

  // Repostories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<TecnicoRepository>(TecnicoRepositoryImpl());
  sl.registerSingleton<LineaRepository>(LineaRepositoryImpl());
  sl.registerSingleton<MacchinaRepository>(MacchinaRepositoryImpl());
  sl.registerSingleton<LegamiRepository>(LegameRepositoryImpl());
  sl.registerSingleton<WORepository>(WORepositoryImpl());
  sl.registerSingleton<LineaDashboardRepository>(
      LineaDashboardRepositoryImpl());
  sl.registerSingleton<TecniciOfficinaRepository>(
      TecniciOfficinaRepositoryImpl());

  // Usecases
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<AutoLoginUseCase>(AutoLoginUseCase());
  sl.registerSingleton<GetTecniciUseCase>(GetTecniciUseCase());
  sl.registerSingleton<GetLineeUseCase>(GetLineeUseCase());
  sl.registerSingleton<GetMacchineUseCase>(GetMacchineUseCase());
  sl.registerSingleton<GetLegamiUseCase>(GetLegamiUseCase());
  sl.registerSingleton<GetInterventiUseCase>(GetInterventiUseCase());
  sl.registerSingleton<GetLineeDashboardUseCase>(GetLineeDashboardUseCase());
  sl.registerSingleton<GetTecniciOfficinaUseCase>(GetTecniciOfficinaUseCase());
}
