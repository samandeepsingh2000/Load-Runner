import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  String email = "support@loadrunnr.in";
  String phone = "08046810555";
  // String urlEmail = 'mailto:' + email;
  // String urlPhone = 'tel:' + phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Support",style: TextStyle(
          color: Color(0xfffd6204)
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,100,0,0),
        child: Column(
          children: [
        Center(
        child: Image.asset("assets/images/customer-service.png")),
        const SizedBox(height: 25,),
            const Text("How can we help You ?",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
            const SizedBox(height: 20,),
            const Text("It looks like you are experiencing a problem,\nWe are here to help you.\nPlease get in touch with us",textAlign: TextAlign.center,
            style: TextStyle(
              color:Color(0xfffd6204),
              fontSize: 14
            ),),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: ()async{
                        await launch('mailto:' + email);

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.mail,color: Color(0xfffd6206),),
                          SizedBox(height: 5,),
                          Text("E-MAIL US")
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width:50,),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: ()async{
                       await launch('tel://' + phone);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          FaIcon(FontAwesomeIcons.phoneAlt, color: Color(0xfffd6206)),
                          SizedBox(height: 5,),
                          Text("CALL US")
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )



          ],

        ),
      ),
    );
  }
}
