import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/ankit-test/counter/counter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/theme/theme.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc_clean_architecture/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBLoc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.darkThemeMode,
        home: const LoginPage(),
      ),
    );
  }
}
