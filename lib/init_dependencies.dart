import 'package:flutter_bloc_clean_architecture/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_bloc_clean_architecture/core/secrets/app_secrets.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/datasources/auth_remote_source.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);

  serviceLocator.registerLazySingleton(() => supabase.client);

  // -- core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

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
      () => AuthRepositoryImpl(serviceLocator()),
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
    // Repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
          serviceLocator(),
        ))
    // UseCases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        serviceLocator(),
      ),
    );
}
