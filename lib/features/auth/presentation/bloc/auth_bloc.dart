import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/error/failure.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_state.dart';

class AuthBLoc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;

  AuthBLoc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,

    /// --> here you can direct use AuthBloc(this._userSignUp) , but prefer named arguments.
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) {
              print(r.id);
              print(r.name);
              print(r.email);
              emit(
                AuthSuccess(r),
              );
            });
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    // _userSignUp.call(params);    --> _userSignUp();

    emit(AuthLoading());
    final res = await _userSignUp(UserSignUpParams(
        email: event.email, password: event.password, name: event.name));

    res.fold((l) => emit(AuthFailure(l.message)),
        (user) => emit(AuthSuccess(user))); // here r is uid and l for failure
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    res.fold((l) => emit(AuthFailure(l.message)), (user) => AuthSuccess(user));
  }
}
