
import 'package:flutter_bloc_clean_architecture/core/common/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/core/error/failure.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams>{
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async{
    return await authRepository.signUpWithEmailAndPassword(
        name: params.name,
        email: params.email,
        password: params.password,
    );
  }
  
}

class UserSignUpParams{
  final String email;
  final String password;
  final String name;

  UserSignUpParams({
   required this.email,
   required this.password,
   required this.name,
});
}
