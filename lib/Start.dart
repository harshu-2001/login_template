import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'SignUp.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "SignUp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          
            appBar: AppBar(
              title: Text("Login"),
            ),
            backgroundColor: Colors.orange[400],
            
            body: Center(
              child: Container(
                height: MediaQuery.of(context).size.height-400,
                width: MediaQuery.of(context).size.width-50,
                //color: Colors.red,
                
                
                child: Center(
                  child: Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                    elevation: 30.0,
                            child: Column(
                      children: [
                        SizedBox(height: 50.0),
                      RichText(
                        text: TextSpan(
                          text: "hello Friend",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),
                          children: <TextSpan>[
                            TextSpan(text: ":)",style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                            ))
                          ]
                          )
                          ),
                      SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              padding: EdgeInsets.only(left:10,right:10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onPressed: navigateToLogin,
                              color: Colors.amber,
                              elevation: 10,
                              child: Text("Login"
                              ,style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                
    
                            ),
                            ),
                            ),
                            ),
                            SizedBox(width: 20,),
    
                          RaisedButton(
                            padding: EdgeInsets.only(left:10,right:10),
                            onPressed: navigateToRegister,
                            color: Colors.amber,
                            elevation: 10,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Text("Register",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              
                              ),
                              ),
                              ),
                              
                        ],
                      ),
                    
                      //SizedBox(height:50),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(color: Colors.grey,),
                      ),
                            SignInButton(
                              Buttons.Google,
                              text: "Sign in with Google",
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                               onPressed: googleSignIn
                           ),
                    ],),
                  ),
                ),
              ),
            ),
            drawer: Drawer(),
        );
      
  }
}