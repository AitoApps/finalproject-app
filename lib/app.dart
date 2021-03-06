import 'package:app/core/authentication/authentication_interceptor.dart';
import 'package:app/core/authentication/bloc/authentication_bloc.dart';
import 'package:app/core/notifications/bloc/notification_bloc.dart';
import 'package:app/core/notifications/token_interceptor.dart';
import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/features/login/login_page.dart';
import 'package:app/features/report/report.dart';
import 'package:app/features/signup/signup_page.dart';
import 'package:app/features/splash/splash.dart';
import 'package:app/shared/repositories/token_repository.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> navigator = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          lazy: false,
          create: (ctx) => AuthenticationBloc(
            rootBloc: ctx.read<RootBloc>(),
            userRepository: ctx.read<UserRepository>(),
            tokenRepository: ctx.read<TokenRepository>(),
            authenticationInterceptor: ctx.read<AuthenticationInterceptor>(),
            navigator: navigator,
          )..add(AppStarted()),
        ),
        BlocProvider(
          lazy: false,
          create: (ctx) => NotificationBloc(
            rootBloc: ctx.read<RootBloc>(),
            tokenInterceptor: ctx.read<TokenInterceptor>(),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigator,
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => SplashPage(),
          '/login': (ctx) => LoginPage(),
          '/report': (ctx) => ReportPage(),
          '/signup': (ctx) => SignupPage(),
        },
      ),
    );
  }
}
