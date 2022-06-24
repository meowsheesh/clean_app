import 'package:cleanapp/screens/admin_page.dart';
import 'package:cleanapp/screens/info_page.dart';
import 'package:cleanapp/screens/login_page.dart';
import 'package:cleanapp/screens/todo_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CleanAPP());
}

class CleanAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(

        platform: TargetPlatform.iOS,
        // primaryColor: Color(0xFF0A0E21),
        colorScheme: ColorScheme.light().copyWith(primary: Color(0xFF32B67A)),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        InfoPage.id: (context) => InfoPage(),
        TodoPage.id: (context) => TodoPage(),
        AdminPage.id: (context) => AdminPage(),
      },
    );
  }
}
