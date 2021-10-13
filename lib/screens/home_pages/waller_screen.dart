// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load_runner/screens/home_pages/pPay.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class Wallet2 extends StatefulWidget {
  final String name,number,token;
Wallet2(this.name,this.number, this.token);
  @override
  _Wallet2State createState() => _Wallet2State();
}

class _Wallet2State extends State<Wallet2> {
  int minBalance = 300;
  late int withdrawBalance = 100;
  late int walletBalance = 0;
  late int walletRecharge;
  late int walletWithdraw;
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    getPayment();
    super.initState();
    // Future.delayed(Duration.zero, () => showDialog1(context: context));
  }

  void showDialog1({
    required BuildContext context,
    String title = "Withdraw",
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)), //this right here
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Rs. ',
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        alignLabelWithHint: true,
                        helperText: xy(title),
                        helperStyle: TextStyle(
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Container(
                        width: size.width / 2,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              walletRecharge = int.parse(_textEditingController.text) ;
                              walletWithdraw = int.parse(_textEditingController.text) ;
                            });
                            if(title == "Recharge"){
                              setState(() {
                                // walletBalance == 0? walletBalance = walletRecharge : walletBalance = walletBalance+walletRecharge;
                                // _pPayment();
                                Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>  pPay(_textEditingController.text, widget.name, widget.number)),)
                                    .then((val)=>val?getPayment():null);
                              });
                            }else{


                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) =>
                              //             pPay(_textEditingController.text, widget.name, widget.number)));

                            }
                            // if(_textEditingController.text.isNotEmpty && title == "Recharge"){
                            //   _pPayment();
                            // }

                          },
                          child: Text(
                            title == "Withdraw" ? 'SUBMIT' : "NEXT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'WALLET',
          style: TextStyle(color: Color.fromRGBO(253, 98, 4, 1)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 2, color: Colors.grey),
                      bottom: BorderSide(width: 2, color: Colors.grey))),
              height: size.height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  const Center(
                    child: Text(
                      'YOUR WALLET BALANCE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                   Center(
                    child: Text(
                      'RS.' + walletBalance.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Minimum Recharge amount Rs:  ' ),
                      Text(' **Minimum Withdraw Above Rs:  ' ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog1(context: context, title: "Recharge");
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 10, bottom: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Text(
                                'RECHARGE',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog1(context: context, title: "Withdraw");
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 18, right: 18, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Text(
                                'WITHDRAW',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
                width: size.width * 0.7,
                height: size.height * 0.5,
                child: Center(
                    child: Text(
                  'Transaction History SCROLL',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )))
          ],
        ),
      ),
    );
  }
  String xy(String text){
    final String Itype;
    if(text == "Withdraw"){
       Itype = "Minimum Withdraw Balance";
    }else{
      Itype = "Minimum Recharge Balance";
    }

    return Itype;
  }
  Widget _pPayment(){
    String Url = "https://bf94-2402-3a80-1b25-91d2-aea8-7552-69b6-9106.ngrok.io/api/payment/neworder/";
    return WebView(
      initialUrl:'https://flutter.dev' ,
      javascriptMode: JavascriptMode.unrestricted,

    );
  }
  Future getPayment() async{

    String url = "https://loadrunner12.herokuapp.com/api/payment/getBalance";
    try {
      var jsonResponse;
      var response = await http.get(Uri.parse("https://loadrunner12.herokuapp.com/api/payment/getBalance"), headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
         'Cookie': "token2=${widget.token}"
      });
      if (response.statusCode == 200) {
        print("jsonResponse1");
        print(response.body);
        print("jsonResponse1");
        var cookies = response.headers['set-cookie'];
        if (cookies != null) {
          print(cookies);
        }
        jsonResponse = json.decode(response.body);
        print("jsonResponse1");
        print(jsonResponse);

        setState(() {
         walletBalance = jsonResponse['balance'];
        });

      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      // print("Hello");
    }

  }
}
