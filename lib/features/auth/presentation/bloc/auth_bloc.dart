import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_state.dart';

class AuthBLoc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBLoc({
    required UserSignUp userSignUp,

    /// --> here you can direct use AuthBloc(this._userSignUp) , but prefer named arguments.
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUpEvent>((event, emit) async {
      // _userSignUp.call(params);    --> _userSignUp();

    final res =  await  _userSignUp(UserSignUpParams(
          email: event.email, password: event.password, name: event.name));

    res.fold((l) => emit(AuthFailure(l.message)), (user) => emit(AuthSuccess(user)));  // here r is uid and l for failure
    });
  }
}
