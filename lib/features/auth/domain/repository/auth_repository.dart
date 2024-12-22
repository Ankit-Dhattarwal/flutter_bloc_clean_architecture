
 import 'package:flutter_bloc_clean_architecture/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
 Future<Either<Failure, String>> signUpWithEmailAndPassword({
  required String name,
  required String email,
  required String password,
});

 Future<Either<Failure, String>> loginWithEmailAndPassword({
  required String email,
  required String password,
 });
}