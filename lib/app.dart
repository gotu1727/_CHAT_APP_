import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterwhatsappclone/Screens/bottombar/newTabber.dart';
import 'package:flutterwhatsappclone/Screens/intro.dart';
import 'package:flutterwhatsappclone/Screens/videoCall/user_provider.dart';
import 'package:flutterwhatsappclone/constatnt/global.dart';
import 'package:flutterwhatsappclone/provider/countries.dart';
import 'package:flutterwhatsappclone/provider/phone_auth.dart';
import 'package:flutterwhatsappclone/share_preference/preferencesKey.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class App extends StatefulWidget {
  final SharedPreferences prefs;
  App(this.prefs);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FirebaseAuth.instance.currentUser().then((user) {
        if (user != null)
          _database.reference().child("user").child(user.uid).update({
            "status": "Online",
          });
      });
    } else {
      FirebaseAuth.instance.currentUser().then((user) {
        if (user != null)
          _database.reference().child("user").child(user.uid).update({
            "status": DateTime.now().millisecondsSinceEpoch.toString(),
            "inChat": ""
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(appColorBlue);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(
            create: (context) => CountryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PhoneAuthDataProvider(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Montserrat',
          ),

          debugShowCheckedModeBanner: false,
          home: _handleCurrentScreen(widget.prefs),
          // home: PhoneAuthGetPhone(),
        ));
  }

  Widget _handleCurrentScreen(SharedPreferences prefs) {
    String data = prefs.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    preferences = prefs;

    if (data == null) {
      //  Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (_) => Intro()));
      return Intro();
    } else {
      return TabbarScreen();
    }
  }
}
