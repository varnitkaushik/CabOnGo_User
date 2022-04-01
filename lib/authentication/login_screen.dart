
import 'package:cabongo_users_app/authentication/sign_screen.dart';
import 'package:cabongo_users_app/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget
{


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {

     if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    }

    else if(passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required.");
    }
    else
    {
      loginUserNow();
    }
  }



  loginUserNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait. . .",);
        }
    );

    final User? firebaseUser =(
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),              //trim used for removing extra space
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString() );
        })
    ).user;

    if(firebaseUser !=null)
    {


      currentFirebaseUser= firebaseUser;
      Fluttertoast.showToast(msg: "Login Successful. "  );
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login. "  );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              const SizedBox(height:30,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo.png"),
              ),

              const SizedBox(height: 10,),

              const Text(
                  "Login as a User",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
              ),

              TextField(
                controller: emailTextEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",

                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),

                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),

              ),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",

                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),

                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),

              ),
              
              const SizedBox(height: 20,),

              ElevatedButton(
                  onPressed: ()
                  {
                    validateForm();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text(
                    'LogIn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),

                  )),
              
              TextButton(
                child: const Text(
                  "Do not have an Account? SIGNUP HERE",
                      style: TextStyle(color: Colors.grey),
                ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>SignUpScreen()));

                  },
              ),

            ],

          ),
        ),
      )
    );
  }
}
