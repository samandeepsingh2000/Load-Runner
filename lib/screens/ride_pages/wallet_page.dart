// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          " Wallet",
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              " Your Wallet Balance",
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            " RS XXX",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20),
          Text(
            " ** *Minimum Recharge amount Rs . XXX",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            " ** *Minimum withdraw above Rs . XXX",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                    onPressed: () {},
                    child: Text("Recharge",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        )),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.deepOrange),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.deepOrange))))),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text("Withdraw",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      )),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepOrange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.deepOrange))))),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text("Transaction history "),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
