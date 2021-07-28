//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:string_validator/string_validator.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _name, _email, _password,check;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("${check} and ${_password}");
    if(equals(check,_password)){
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser!.updateProfile(displayName: _name);
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
      } catch (e) {
        showError(e.toString(),"error");
        print(e);
      }
    }
    else{
      showError("Password unmatched", "Incorrect");
    }
   }
  }
 showError(String errormessage,String val) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${val}'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
 navigatortostart()async{
    Navigator.pushReplacementNamed(context, "start");
  }
@override
Widget build(BuildContext context){
  return Scrollbar(
      child: Scaffold(
      appBar: AppBar(
        title:Row(
            children: <Widget>[
            IconButton(onPressed: navigatortostart,icon: Icon(Icons.arrow_back,size: 25,)),
            SizedBox(width:10),
            Text("Register"),
          ],
          
        ),
      ),
      backgroundColor: Colors.orange.shade400,
      body:Center(
        child: Container(
          height: MediaQuery.of(context).size.height-250,
          width: MediaQuery.of(context).size.width-50,
          
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
            elevation: 10.0,
            child: Form(
              key:_formKey,
              child:Column(
                children:<Widget>[
                  SizedBox(height:30),
                    Card(elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                       child: TextFormField(
                        validator: (inout){
                          if (inout!.isEmpty) return"Fill this field";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "name",
                          prefixIcon: Icon(Icons.people,size: 15,)
                        ),
                        onSaved: (inout)=>_name=inout!,
                      ),
                    ),
                    SizedBox(height:30),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                      elevation: 5,
                     child: TextFormField(
                        validator: (inout){
                          if (inout!.isEmpty) return"Fill this field";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "email",
                          prefixIcon: Icon(Icons.email,size: 15,)
                        ),
                        onSaved: (inout)=>_email=inout!,),
                    ),
                    SizedBox(height:30),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                      elevation: 5,
                      child: TextFormField(
                        validator: (inout){
                          if (inout!.length<6) return"password length short";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock,size: 15,)
                        ),
                        obscureText: true,
                        onSaved: (inout)=>_password=inout!,),
                    ),
                    
                    SizedBox(height:30),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                      elevation: 5,
                      child: TextFormField(
                        validator: (inout){
                          if (inout!.length<6) return"password length short";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "confirm Password",
                          prefixIcon: Icon(Icons.lock,size: 15,)
                        ),
                        obscureText: true,
                        onSaved: (inout)=>check=inout!,),
                    ),
                    SizedBox(height:30),
                    RaisedButton(
                      onPressed: signUp,
                      child: Text("Register"),
                      )
                ]
              ) ),
          ),
        ),
      ) ,
    ),
  );
}
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: SingleChildScrollView(
  //     child: Container(
  //       child: Column(
  //         children: <Widget>[
            
  //           Container(
  //             child: Form(
  //               key: _formKey,
  //               child: Column(
  //                 children: <Widget>[
  //                   Container(
  //                     child: TextFormField(
  //                         validator: (input) {
  //                           if (input!.isEmpty) return 'Enter Name';
  //                         },
  //                         decoration: InputDecoration(
  //                           labelText: 'Name',
  //                           prefixIcon: Icon(Icons.person),
  //                         ),
  //                         onSaved: (input) => _name = input),
  //                   ),
  //                   Container(
  //                     child: TextFormField(
  //                         validator: (input) {
  //                           if (input!.isEmpty) return 'Enter Email';
  //                         },
  //                         decoration: InputDecoration(
  //                             labelText: 'Email',
  //                             prefixIcon: Icon(Icons.email)),
  //                         onSaved: (input) => _email = input),
  //                   ),
  //                   Container(
  //                     child: TextFormField(
  //                         validator: (input) {
  //                           if (input!.length < 6)
  //                             return 'Provide Minimum 6 Character';
  //                         },
  //                         decoration: InputDecoration(
  //                           labelText: 'Password',
  //                           prefixIcon: Icon(Icons.lock),
  //                         ),
  //                         obscureText: true,
  //                         onSaved: (input) => _password = input),
  //                   ),
  //                   SizedBox(height: 20),
  //                   RaisedButton(
  //                     padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
  //                     onPressed: signUp,
  //                     child: Text('SignUp',
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 20.0,
  //                             fontWeight: FontWeight.bold)),
  //                     color: Colors.orange,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(20.0),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ));
  // }
}