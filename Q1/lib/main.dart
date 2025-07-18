import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidaritodo/localization/kinyarwanda_fallback_delegate.dart';
import 'package:vidaritodo/providers/task_provider.dart';
import 'package:vidaritodo/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('rw'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Vidari Todo',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.green.shade600,
            secondary: Colors.orange.shade600,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.orange.shade600,
            foregroundColor: Colors.white,
          ),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localizationsDelegates: [
          ...context.localizationDelegates,
          const KinyarwandaFallbackDelegate(),
          DefaultWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}
