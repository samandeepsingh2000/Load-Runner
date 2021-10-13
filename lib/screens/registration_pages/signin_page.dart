// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load_runner/model/api.dart';
import 'package:load_runner/model/hexcolor.dart';
import 'package:load_runner/screens/home_pages/home_page.dart';
import 'package:load_runner/screens/home_pages/s2.dart';
import 'package:load_runner/screens/home_pages/waller_screen.dart';
import 'package:load_runner/screens/registration_pages/signup_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:load_runner/screens/review_screen/review_screen.dart';
import 'package:load_runner/screens/ride_pages/pickup_page.dart';
import 'package:load_runner/screens/ride_pages/wallet_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  bool? _passwordVisible = false;
  bool validatePhone = false;
  bool validatePassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,25,0,0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                color: Colors.orange,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          errorText: validatePhone == true ? 'Enter Phone Number' : null,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '+91',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black54,
                                width: 2,
                                style: BorderStyle.solid,
                              )),
                          labelStyle: TextStyle(
                            color: Color(0xff4a4a4a),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 1.2,
                          ),
                          labelText: 'Mobile Number',
                        ),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        controller: phoneNumber,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextField(

                        obscureText: !_passwordVisible!,
                        decoration: InputDecoration(
                          errorText: validatePassword == true ? 'Enter Password' : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible!
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible!;
                              });
                            },
                            iconSize: 30,
                            color: Colors.black54,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black54,
                                width: 2,
                                style: BorderStyle.solid,
                              )),
                          labelStyle: TextStyle(
                            color: Color(0xff4a4a4a),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 1.2,
                          ),
                          labelText: 'Password',
                        ),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.text,
                        controller: password,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15.0, 0, 10.0, 0),
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(50, 30),
                                    alignment: Alignment.centerLeft),
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: HexColor('#FD6204'),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if(phoneNumber.text.isEmpty){
                                    setState(() {
                                      validatePhone = true;
                                    });
                                  }else{
                                    setState(() {
                                      validatePhone = false;
                                    });
                                  }
                                  if(password.text.isEmpty){
                                    validatePassword = true;
                                  }else{
                                    validatePassword = false;

                                  }
                                  if(phoneNumber.text.length != 10 && phoneNumber.text.isNotEmpty){
                                    _showCupertinoDialog("Enter Valid phone Number");
                                  }
                                  var response = await loginDetails(
                                      phoneNumber.text, password.text);
                                  if (response!.statusCode == 401) {
                                    print(response.statusCode);
                                    var body =
                                    jsonDecode(response.body);
                                    print(body);
                                    print("hello");
                                    print(body["status"]);
                                    if(body['status'] == "false"){
                                      // setState(() {
                                      //   showAlert(context, "Your Credentials are wrong");
                                      //
                                      // });
                                      _showCupertinoDialog("Your Credentials are wrong");
                                    }
                                    if(body['errorCode'] == "INVALID_LOGIN"){
                                      // setState(() {
                                      //   showAlert(context, "Your Credentials are wrong");
                                      //
                                      // });
                                      _showCupertinoDialog("Your Credentials are wrong");
                                    }

                                  }

                                  // check( phoneNumber.text,password.text);
                                  if (response.statusCode == 200) {
                                    print(response.body);
                                    var body =
                                        jsonDecode(response.body);
                                    print(body);
                                    print("hello");
                                    print(body["status"]);
                                    if(body['status'] == false){
                                      _showCupertinoDialog("Your Credentials are wrong");
                                    }
                                    if(body['INVALID_LOGIN'] == false){
                                      _showCupertinoDialog("Your Credentials are wrong");
                                    }
                                    if (body['success'] == true) {

                                      Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    MapScreen(body["driver"]["status"].toString(),body["driver"]["firstname"].toString(),body["driver"]["Phone_No"].toString(),body["token2"].toString())));

                                    }

                                  }

                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  primary: HexColor('#FD6204'),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUpPage()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: HexColor('#FD6204'),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void showAlert(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(text),
        ));
  }
  void _showCupertinoDialog(String input) {
    showDialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Error'),
            content: Text(input
                .toUpperCase(), textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.7)),),
            // actions: <Widget>[
            //   TextButton(
            //       onPressed: () {
            //         Navigator.pushReplacement(
            //             context, new MaterialPageRoute(builder: (context) => SignInPage()));
            //       },
            //       child: Text('LOGOUT')),
            //   // TextButton(
            //   //   onPressed: () {
            //   //     print('HelloWorld!');
            //   //   },
            //   //   child: Text('HelloWorld!'),
            //   // )
            // ],
          );
        });
  }
 // Future check(String text1,text2) async{
 //    var response = await loginDetails(
 //        phoneNumber.text, password.text);
 //    check( phoneNumber.text,password.text);
 //    if (response!.statusCode == 200) {
 //      print(response.body);
 //      var body =
 //      jsonDecode(response.body);
 //      print(body);
 //      print("hello");
 //      print(body["status"]);
 //      if (body['success'] == true) {
 //        print(body);
 //      }
 //    }
 //  }
}
