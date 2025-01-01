import 'package:flutter_bloc_clean_architecture/core/common/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_bloc_clean_architecture/core/error/failure.dart';
import 'package:flutter_bloc_clean_architecture/core/network/connection_checker.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/datasources/auth_remote_source.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/model/user_model.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class AuthRepositoryImpl implements AuthRepository {
  /*
  not do like this bcz we not want to authRepositoryImpl depend on the AuthRemoteDataSource.
    final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
    //// ---> so use the dependency injection.
   */

  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker,);


  @override
  Future<Either<Failure, User>> currentUser() async{
   try{
     if(!await connectionChecker.isConnected){
       final session = remoteDataSource.currentUserSession;

       if(session == null){
         return left(Failure('User is not logged in!'));
       }

       return right(UserModel(id: session.user.id, email: session.user.email ?? '', name: ''),);
     }
     final user = await remoteDataSource.getCurrentUserData();
     if(user == null){
       return left(Failure('User is not logged in!'));
     }
     return right(user);

   }on ServerExpection catch(e){
     return left(Failure(e.message));
   }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if(!await connectionChecker.isConnected){
        return left(Failure('No Internet Connection!!!'));
      }
      final user = await fn();

      return right(user);
    } on sp.AuthException catch (e){
      return left(Failure(e.message));
    }
    on ServerExpection catch (e) {
      return left(Failure(e.message));
    }
  }
}
