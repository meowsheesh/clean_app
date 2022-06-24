import 'package:cleanapp/screens/admin_page.dart';
import 'package:cleanapp/screens/todo_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id = 'login_page';

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/imgl.jpg'),
                ),
              ),
            ),
            Text(
              '#Нархоз_сортирует_2.0',
              style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value){
                email = value;
              },
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Login',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              onChanged: (value){
                password = value;
              },
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Color(0xFF32B67A),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    try{
                      final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if (newUser != null && newUser.user?.email == 'admin@email.com'){
                        Navigator.pushNamed(context, AdminPage.id);
                      }else if(newUser != null && newUser.user?.email != 'admin@email.com'){
                        Navigator.pushNamed(context, TodoPage.id);
                      }
                    }catch(e){
                      print(e);
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
