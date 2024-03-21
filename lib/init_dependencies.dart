import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:muxik/features/auth/domain/use_cases/user_log_out.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/cubit/app_user_cubit.dart';
import 'core/network/connection_checker.dart';
import 'core/secrets/supabase_secrets.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/current_user.dart';
import 'features/auth/domain/use_cases/user_login.dart';
import 'features/auth/domain/use_cases/user_sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/song/data/data_sources/song_remote_data_source.dart';
import 'features/song/data/repositories/song_repository_impl.dart';
import 'features/song/domain/repositories/song_repository.dart';
import 'features/song/domain/use_cases/get_all_songs.dart';
import 'features/song/presentation/bloc/song_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initSong();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supbaseAnonKey,
  );

  ///  new instance created every time
  /// serviceLocator.registerFactory(() => null);
  ///  will create singleton when required

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerFactory(
    () => InternetConnection(),
  );

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuth() {
  serviceLocator
    //  data -> data source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    //  data -> repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    //  domain -> use case -> user sign up
    ..registerFactory(
      () => UserSignUp(serviceLocator()),
    )
    //  domain -> use case -> user login
    ..registerFactory(
      () => UserLogin(serviceLocator()),
    )
    //  domain -> use case -> current user
    ..registerFactory(
      () => CurrentUser(serviceLocator()),
    )
    ..registerFactory(
      () => UserLogOut(serviceLocator()),
    )
    //  presentation -> bloc -> auth bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        userLogOut: serviceLocator(),
      ),
    );
}

void _initSong() {
  serviceLocator
    //  data -> data source
    ..registerFactory<SongRemoteDataSource>(
      () => SongRemoteDataSourceImpl(serviceLocator()),
    )
    //  data -> repositories
    ..registerFactory<SongRepository>(
      () => SongRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    //  domain -> use case -> get all blogs
    ..registerFactory(
      () => GetAllSongs(serviceLocator()),
    )
    //  presentation -> bloc -> blog bloc
    ..registerLazySingleton(
      () => SongBloc(
        getAllSongs: serviceLocator(),
      ),
    );
}
