import 'package:flutter/material.dart';
import 'package:myApp/Screens/SignInConnected/sign_in_widget.dart';
import 'package:myApp/constants.dart';

class SignInSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Authentication Successful',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/sign_in_success.png',
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  'Thiết lập thành công',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: kPrimaryFontFamily,
                      color: Color.fromRGBO(9, 30, 66, 1)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Bạn đã kích hoạt Remote Signing thành công.\nHãy bắt đầu trải nghiệm cùng Mobile Sign',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: kPrimaryFontFamily,
                      height: 1.4,
                      color: Color.fromRGBO(80, 95, 121, 1)),
                ),
                SizedBox(
                  height: 64,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: new FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInConnected()),
                              );
                            },
                            child: Text(
                              'Bắt đầu'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: kPrimaryFontFamily),
                            ),
                            textColor: Colors.white,
                            color: Color.fromRGBO(26, 65, 171, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
