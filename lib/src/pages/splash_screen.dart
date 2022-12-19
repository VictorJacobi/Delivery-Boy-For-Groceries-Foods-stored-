import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:products_deliveryboy/src/pages/login.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/splash_screen_controller.dart';
import '../repository/user_repository.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;

  SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    loadData();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginWidget()));
    });
  }

  void loadData() {
    _con.progress.addListener(() {
      double progress = 0;
      _con.progress.value.values.forEach((_progress) {
        progress += _progress;
      });
      if (progress == 100) {
        try {
          if (currentUser.value.apiToken == null) {
            Navigator.of(context).pushReplacementNamed('/Login');
          } else {
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
          }
        } catch (e) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginWidget()));
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/logo.png',
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 50),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
