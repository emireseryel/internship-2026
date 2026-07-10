import 'package:flutter/material.dart';
import 'package:pharmacy_app/themes/app_theme.dart';
import 'package:pharmacy_app/viewmodels/home_viewmodel.dart';
import 'package:pharmacy_app/viewmodels/result_viewmodel.dart';
import 'package:pharmacy_app/viewmodels/detail_viewmodel.dart';
import 'package:pharmacy_app/viewmodels/theme_viewmodel.dart';
import 'package:pharmacy_app/views/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),

      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ChangeNotifierProvider(create: (_) => ResultViewModel()),
          ChangeNotifierProvider(create: (_) => DetailViewModel()),
          ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeView = context.watch<ThemeViewModel>();

    return MaterialApp(
      themeMode: themeView.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      title: "Pharmacy App",
      home: const HomePage(),
    );
  }
}
