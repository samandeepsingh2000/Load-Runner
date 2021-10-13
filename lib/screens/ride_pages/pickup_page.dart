// ignore_for_file: use_key_in_widget_constructors, must_call_super, avoid_unnecessary_containers, prefer_const_constructors, unused_import, avoid_print, sized_box_for_whitespace

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:load_runner/screens/home_pages/home_page.dart';
import 'package:load_runner/screens/home_pages/waller_screen.dart';
import 'package:load_runner/screens/registration_pages/signin_page.dart';
import 'package:location/location.dart';
import 'package:load_runner/screens/ride_pages/localWidgets/rolling_switch.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:firebase_core/firebase_core.dart';
class MapScreen extends StatefulWidget {
  final String? status,name,number,token;
  MapScreen(this.status,this.name,this.number, this.token);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
   AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      playSound: true);


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _message = '';
  late LocationData _currentPosition;
  late String _address,_dateTime;
  late GoogleMapController mapController;
  late Marker marker;
  Location location = Location();

  late GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  double latitude = 0.0;
  double longitude = 0.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('A bg message just showed up :  ${message.messageId}');
  }
   late FirebaseMessaging messaging;
   Future<void> _messageHandler(RemoteMessage message) async {
     print('background message ${message.notification!.body}');
   }
  @override
  void initState() {
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    // });
    //
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title!),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body!)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print("Hello");
      print(value);
      print("Token");

    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });    // getLocation();
    getLoc();
  }

  // void getLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //   }
  //   LocationPermission permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.low);
  //   latitude = position.latitude;
  //   longitude = position.longitude;
  // }

  bool sliderBool = false;

  @override

  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      if(widget.status == "Pending"){

        _showCupertinoDialog();
      }
      // Add Your Code here.
    });

    return Scaffold(
      key: _scaffoldKey,

      drawer: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Side menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/cover.jpg'))),
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Welcome'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text('Wallet'),
              onTap: () => { Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => Wallet2(widget.name!,widget.number!,widget.token!)))
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pickup'),
              onTap: () => { Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => MyHomePageState()))},
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Feedback'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => {
              Navigator.of(context).pushAndRemoveUntil(
              // the new route
              MaterialPageRoute(
              builder: (BuildContext context) => SignInPage(),
              ),

              // this function should return true when we're done removing routes
              // but because we want to remove all other screens, we make it
              // always return false
              (Route route) => false,
              )
              },
            ),
          ],
        ),
      ),
      // appBar: AppBar(
      //   title: Text("Map"),
      // ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          _scaffoldKey.currentState!.openDrawer();

                        },
                        child: SizedBox(
                          width: 50,
                          height: 30,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 5, top: 5, right: 5),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Color.fromRGBO(253, 98, 4, 1)),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Color.fromRGBO(253, 98, 4, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5, top: 5),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Color.fromRGBO(253, 98, 4, 1)),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Color.fromRGBO(253, 98, 4, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      RollingSwitch.widget(
                        onChanged: (bool state) {
                          print('turned ${(state) ? 'on' : 'off'}');
                        },
                        rollingInfoRight: RollingWidgetInfo(
                          //icon: FlutterLogo(),
                          text: Text('Online'),
                          backgroundColor: Color.fromRGBO(253, 98, 4, 1),
                        ),
                        rollingInfoLeft: RollingWidgetInfo(
                          // icon: FlutterLogo(
                          //   style: FlutterLogoStyle.stacked,
                          // ),
                          backgroundColor: Color.fromRGBO(253, 98, 4, 1),
                          text: Text('Offline'),
                        ),
                      ),

                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 70,
                            height: 70,
                            // decoration: BoxDecoration(
                            //   color: Color.fromRGBO(253, 98, 4, 1),
                            //   borderRadius: BorderRadius.circular(100),
                            // ),
                            child: Center(
                                child: Icon(Icons.support,size: 50,)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(10),
                          //   width: 60,
                          //   height: 60,
                          //   decoration: BoxDecoration(
                          //     color: Color.fromRGBO(253, 98, 4, 1),
                          //     borderRadius: BorderRadius.circular(100),
                          //   ),
                          //   child: Center(
                          //       child: Text(
                          //     "GPS \nIcon",
                          //     style: TextStyle(color: Colors.white),
                          //     textAlign: TextAlign.center,
                          //   )),
                          // ),
                        ],
                      )

                      // Container(
                      //   height: 30,
                      //   width: 80,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: Colors.grey.shade400,
                      //             offset: Offset(0, 0),
                      //             blurRadius: 12,
                      //             spreadRadius: 2)
                      //       ]),
                      //   child: RollingSwitch(
                      //     size: size,
                      //     textOn: 'On',
                      //     textOff: 'Off',
                      //     colorOn: Colors.yellow,
                      //     colorOff: Colors.grey,
                      //     iconOff: Icons.arrow_right,
                      //     onChanged: (value) {
                      //       value = !value;
                      //       print(value);
                      //       //setState(() {
                      //       sliderBool = value;
                      //       // /});
                      //     },
                      //     value: sliderBool,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  child:  GoogleMap(
                    initialCameraPosition: CameraPosition(target: _initialcameraposition,
                        zoom: 15),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Pickup Now or Daily Rental",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                            ),
                          ),
                          Container(
                              child: Column(
                            children: [
                              Text(
                                "Pickup and Drop Location ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "13,Anand Vihar, New Delhi",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Text(
                                "City College,New Delhi",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              ConfirmationSlider(
                                backgroundColor:
                                    Color.fromRGBO(228, 221, 221, 1),
                                foregroundColor: Color.fromRGBO(253, 98, 4, 1),
                                iconColor: Color.fromRGBO(253, 98, 4, 1),
                                text: "Swipe to Accept",
                                onConfirmation: () => {},
                                backgroundShape: BorderRadius.circular(30),
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(113, 112, 112, 1),
                                    fontWeight: FontWeight.bold),
                                // sliderButtonContent: Container(
                                //   padding: EdgeInsets.all(0),
                                //
                                //   decoration: BoxDecoration(
                                //       color: Color.fromRGBO(253, 98, 4, 1),
                                //       borderRadius: BorderRadius.circular(10)
                                //   ),
                                // ),
                              ),
                              SizedBox(height: 15,),
                              GestureDetector(onTap:(){
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignInPage()));
                              },child: Text("SIGN OUT"))
                            ],
                          ))
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showCupertinoDialog() {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('ALERT'),
            content: Text('Your Account is in Review Will be approved within 24hrs'
                .toUpperCase(), textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.7)),),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, new MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                  child: Text('LOGOUT')),
              // TextButton(
              //   onPressed: () {
              //     print('HelloWorld!');
              //   },
              //   child: Text('HelloWorld!'),
              // )
            ],
          );
        });
  }
  drawerMenu(){
    return Drawer(
      child:ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
  getLoc() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition = LatLng(_currentPosition.latitude!,_currentPosition.longitude!);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition = LatLng(_currentPosition.latitude!,_currentPosition.longitude!);

        DateTime now = DateTime.now();
      });
    });
  }

}
