import 'package:flutter_bloc_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
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
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async{
    try{
      final response =  await supabaseClient.auth.signInWithPassword(password: password, email: email);
      if(response.user == null){
        throw const ServerExpection('User is null!!');
      }
      return UserModel.fromJson(response.user!.toJson());
    }catch(e){
      throw ServerExpection(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
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
      return UserModel.fromJson(response.user!.toJson());
    }catch(e){
      throw ServerExpection(e.toString());
    }
  }
}
