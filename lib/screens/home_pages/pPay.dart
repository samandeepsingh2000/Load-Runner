import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class pPay extends StatefulWidget {
 String amount,name,phone;
 pPay(this.amount,this.name,this.phone);

  @override
  _pPayState createState() => _pPayState();
}

class _pPayState extends State<pPay> {
  String Url = "https://loadrunner12.herokuapp.com/api/payment/neworder/";
  WebViewController? _webViewController;
  @override
  void initState() {
    _webViewController = null;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String pass = Url + widget.amount+"/"+widget.name+"/"+widget.phone;
    print(pass);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap:(){
          Navigator.pop(context,true);
        },child: Icon(Icons.arrow_back)),
      ),
      body: WebView(
        debuggingEnabled: false,
        initialUrl: pass,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller){
          _webViewController = controller;
        },
      ),
    );
  }
}
