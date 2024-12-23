import 'package:flutter_bloc_clean_architecture/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  /// -->
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImp(this.supabaseClient);

  /// --> Here this is called the dependency Injection { here is constructor injection}
  @override
  Future<String> loginWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try{
     final response =  await supabaseClient.auth.signUp(password: password, email: email, data: {
        'name': name,
      });
     if(response.user == null){
       throw const ServerExpection('User is null!!');
     }
      return response.user!.id;
    }catch(e){
      throw ServerExpection(e.toString());
    }
  }
}
