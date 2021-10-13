// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletL extends StatelessWidget {
  const WalletL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text('WALLET'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 2, color: Colors.grey),
                    bottom: BorderSide(width: 2, color: Colors.grey))),
            height: size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 6,
                ),
                Center(
                  child: Text(
                    'YOUR WALLET BALANCE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Center(
                  child: Text(
                    'RS.XXX',
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
                    Text(' **Minimum Recharge amount Rs . XXX '),
                    Text(' **Minimum Withdraw Above Rs . XXX '),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 18, right: 18, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Text(
                            'RECHARGE',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
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
    );
  }
}
