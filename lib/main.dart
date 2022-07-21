import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/providers/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Theme project
import 'core/theme/app_theme.dart';

//Config project
import 'core/config/inital_config.dart';

// Routes
import 'core/paths/app_paths.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initalConfig();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: storeProviders,
      child: MaterialApp(
        initialRoute: _auth.currentUser == null ? '/' : 'main',
        theme: AppTheme.light(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouterGenerator.generateRoute,
      ),
    );
  }
}
