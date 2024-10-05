import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:shop/common/app/providers/email_provider.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/route/router.dart' as router;
import 'package:shop/screens/auth/presentation/adapter/auth_adapter.dart';
import 'package:shop/services/injection_container/main.dart';
import 'package:shop/theme/app_theme.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add EmailProvider to the MultiProvider
        ChangeNotifierProvider(create: (_) => EmailProvider()),

        // Keep the existing BlocProvider for AuthCubit
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: ThemeData.light(),
            onGenerateRoute: router.generateRoute,
            initialRoute: signUpScreenRoute,
          );
        },
      ),
    );
  }
}
