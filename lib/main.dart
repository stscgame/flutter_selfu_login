import 'package:flutter/material.dart';
import 'package:login/page/home.dart';
import 'package:login/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page/login.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: LanchPage(),
  ));
}

class LanchPage extends StatelessWidget {
  const LanchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final readData = readLocalData();
   readData.then((token) {
     if (token != "") {
       final autoLoginHandle = autoLogin(token, "");
       autoLoginHandle.then((user) {
         // ignore: unnecessary_null_comparison
         if (user.userId != null) {
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(
               builder: (BuildContext context) => HomePage(user: user,),
             ),
             (route) => false,
           );
         }else {
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(
               builder: (BuildContext context) => const LoginPage(),
             ),
             (route) => false,
           );
         }
       });
     } else {
       Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(
           builder: (BuildContext context) =>  const LoginPage(),
         ),
         (route) => false,
       );
     }
   }).catchError((error) {
     Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(
           builder: (BuildContext context) => const LoginPage(),
         ),
         (route) => false,
       );
   });

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center),
    );
  }
}

Future<String> readLocalData() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'my_token';
  final value = prefs.getString(key) ?? "";
  print('read: $value');
  return value;
}

saveToLocalData(String token) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'my_token';
  final value = token;
  prefs.setString(key, value);
  print('saved $value');
}

clearLocalData() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'my_token';
  prefs.remove(key);
}