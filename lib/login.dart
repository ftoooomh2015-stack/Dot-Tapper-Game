import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 50 ,
                fontFamily: "kotten",
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: 370,
              child: TextField(
                controller: con,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Your name',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 33,),
            ElevatedButton(
                onPressed: () async {
                  if (con.text.isEmpty){}else{
                    final SharedPreferences login = await SharedPreferences.getInstance();
                    login.setString("name", con.text);
                    login.setBool("islogin", true);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TapTheDot()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  fixedSize: Size(250, 60),
                  backgroundColor:  Colors.cyanAccent,
                ),
                child: Text("Let's go!", style: TextStyle(color: Colors.black87),)
            ),
          ],
        ),
      ),
    );
  }
}
