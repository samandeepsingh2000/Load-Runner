import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text("Invite Friends",style: TextStyle(
          color: Color(0xfffd6204)
        ),),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: size.height*0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white)
              ),
              width: size.width*0.8,
              child: const Text("SHARE THIS APP WITH\nYOUR FRIENDS"
                  ,textAlign: TextAlign.left,style: TextStyle(
                fontSize: 20,fontWeight:FontWeight.bold,color: Color(0xfffd6204)
              ),),

            ),
            const SizedBox(height: 20,),
            const Text("Refer Friend Via"),
            const SizedBox(height: 20,),
            Container(
              color: Colors.grey,
              width: size.width*0.8,
              child:   InkWell(
                onTap:(){
                  Share.share('check out my website https://youtube.com');
                },
                child: const ListTile(

                  leading: FaIcon(FontAwesomeIcons.whatsapp,color: Colors.white,),
                  title: Text("Whatsapp",style: TextStyle(
                    color: Colors.white
                  ),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              color: Colors.purple,
              width: size.width*0.8,
              child:  InkWell(
                onTap:(){
                  Share.share('check out my website https://youtube.com');
                },
                child: const ListTile(

                  leading: Icon(Icons.sms_rounded,color: Colors.white,),
                  title: Text("SMS",style: TextStyle(
                    color: Colors.white
                  ),),
                  trailing: InkWell(child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: size.width*0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:  [
                  InkWell(
                      onTap:(){
                        Share.share('check out my website https://youtube.com');
                      },
                      child: const Icon(Icons.email,color: Color(0xfffd6204),)),
                  Container(
                    height: 80,
                    padding:  EdgeInsets.all(10),
                    child: const VerticalDivider(
                      color: Colors.black,
                      thickness: 3,
                      indent: 20,
                      endIndent: 0,
                      width: 20,
                    ),
                  ),
                  InkWell(onTap:(){
                    Share.share('check out my website https://youtube.com');
                  },child: const Icon(Icons.share,color: Color(0xfffd6204),)),

                ],
              )
            ),
            const SizedBox(height: 20,),
           const Text("Disclaimer",textAlign: TextAlign.left,),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.fromLTRB(30,0,30,0),
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea "
                  "commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa"
                  " qui officia deserunt mollit anim id est laborum.",style: TextStyle(color: Color(0xfffd6204)),),
            ),


          ],
        ),
      ),
    );
  }
}
