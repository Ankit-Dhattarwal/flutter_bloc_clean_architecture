import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/ankit-test/counter/counter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_bloc_clean_architecture/core/theme/theme.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc_clean_architecture/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBLoc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    context.read<AuthBLoc>().add(AuthIsUserLoggedInEvent());
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: AppTheme.darkThemeMode,
        home: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state){
            return state is AppUserLoggedIn;
          },
            builder: (context, isLoggedIn) {
            if(isLoggedIn) {
              return const Scaffold(
                body: Center(child: Text('Home')),
              );
            }
              return const LoginPage();
            },
        ),
      );
  }
}
