import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void login(String email, String password) async{
    try{
      http.Response response = await http.post(
        Uri.parse("https://reqres.in/api/register"),
          headers: {
            "x-api-key": "reqres-free-v1"
          },
        body: { //he API expects x-www-form-urlencoded, then just keep body: {...}
          "email": email,
          "password": password,
        },
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print("Successfully signed in!");
      }
      else{
        throw Exception("Incorrect email or password");
      }
    }
    catch(e){
      print(e.toString());

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body:
        GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: 
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60.0,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',

                      labelStyle: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
            
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,

                ),
                Password(passwordController: passwordController),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    login(emailController.text.toString(), passwordController.text.toString());
                  },
                  child: Text("Sign Up",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    fixedSize: Size(200, 50),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                )
              ],
            ),
          ),
        )
    );
  }
}

class Password extends StatefulWidget {
  TextEditingController passwordController = TextEditingController();

  Password({super.key, required this.passwordController});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        controller: widget.passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,

          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orangeAccent),
          ),
          prefixIcon: Icon(
            Icons.password,
            color: Colors.orangeAccent,
          ),
          suffixIcon: IconButton(
              icon: Icon(

                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.orangeAccent,
              ),
            onPressed: () {
                // print("Password visibility changed to ${_obscureText ? "Visible" : "Hidden"}");
              setState(() {
              _obscureText = !_obscureText; // toggle visibility
              }
              );
            }
          ),
        ),
      ),
    );
  }
}
