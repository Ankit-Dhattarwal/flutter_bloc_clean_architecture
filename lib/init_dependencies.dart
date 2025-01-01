import 'dart:ffi';

import 'package:flutter_bloc_clean_architecture/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_bloc_clean_architecture/core/network/connection_checker.dart';
import 'package:flutter_bloc_clean_architecture/core/secrets/app_secrets.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/datasources/auth_remote_source.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/usecases/get_all_brands.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  await Hive.openBox('blogs');

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => Hive.box('blogs'));

  _initAuth();
  _initBlog();

  // -- core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );

  /// --> return same object instance on every single time
}

void _initAuth() {
  // DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(serviceLocator()),

      /// --> return new object instance every single time
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    //UseCases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBLoc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ))
    // UseCases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
