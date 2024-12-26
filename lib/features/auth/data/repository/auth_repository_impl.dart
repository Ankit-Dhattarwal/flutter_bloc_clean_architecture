import 'package:flutter_bloc_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_bloc_clean_architecture/core/error/failure.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/datasources/auth_remote_source.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  /*
  not do like this bcz we not want to authRepositoryImpl depend on the AuthRemoteDataSource.
    final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
    //// ---> so use the dependency injection.
   */

  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name, required String email, required String password}) async{
    try {
     final user = await remoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password);

     return right(user);
    } on ServerExpection catch(e){
      return left(Failure(e.message));
    }
  }
}
