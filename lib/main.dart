import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/Start.dart';
import 'package:loginpage/login.dart';
import 'package:loginpage/signup.dart';
import 'package:loginpage/homepage.dart';

void main()async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
  theme:ThemeData(
    primaryColor: Colors.orange[200],
    
  ),
  title: "Login",
  home:MyApp(),
  debugShowCheckedModeBanner: false,

  ));
  }
  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primaryColor: Colors.orange
      ),
      debugShowCheckedModeBanner: false,
      home:HomePage(),

      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>Login(),
        "SignUp":(BuildContext context)=>SignUp(),
        "start":(BuildContext context)=>Start(),
      },
      
    );
  }

}
