
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/entities/user.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;

  const  AuthFailure(this.message); /// --> make this const firstly need to make superClass const by const constructor


}
