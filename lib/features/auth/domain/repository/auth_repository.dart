
 import 'package:flutter_bloc_clean_architecture/core/error/failure.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

/// --> NOTE: This interface is implementation in data layer.
abstract interface class AuthRepository{
 Future<Either<Failure, User>> signUpWithEmailAndPassword({
  required String name,
  required String email,
  required String password,
});
 Future<Either<Failure, User>> loginWithEmailAndPassword({
  required String email,
  required String password,
 });
}