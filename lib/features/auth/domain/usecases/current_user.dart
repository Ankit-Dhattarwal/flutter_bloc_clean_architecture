
import 'package:flutter_bloc_clean_architecture/core/common/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/core/error/failure.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams>{
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async{
    return await authRepository.currentUser();
  }

}