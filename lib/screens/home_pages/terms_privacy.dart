import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class TermsAndPrivacy extends StatelessWidget {
  String url,name;
TermsAndPrivacy(this.url,this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffd6204),
        shadowColor: Colors.transparent,
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: WebView(
          debuggingEnabled: false,
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          // onWebViewCreated: (controller){
          //   _webViewController = controller;
          // },
          // onPageFinished: (page){
          //   print(page);
          //
          //   if (page.contains("/verify")) {
          //     Future.delayed(Duration(seconds: 2), () {
          //       Navigator.pop(context,true);
          //       Navigator.pop(context,true);
          //     });
          //   }
          // },
        ),
      ),
    );
  }
}
