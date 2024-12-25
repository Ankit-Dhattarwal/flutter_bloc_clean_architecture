import 'package:flutter_bloc_clean_architecture/core/secrets/app_secrets.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/datasources/auth_remote_source.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);

  serviceLocator.registerLazySingleton(() => supabase.client);

  /// --> return same object instance on every single time
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImp(serviceLocator()),

    /// --> return new object instance every single time
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBLoc(
      userSignUp: serviceLocator(),
    ),
  );
}
