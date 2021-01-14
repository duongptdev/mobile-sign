import 'package:flutter/material.dart';
import 'package:myApp/Screens/SignIn/components/set_pin_password.dart';
import 'package:myApp/constants.dart';

class OTPSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Authentication Successful',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/otp_success.png',
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  'Xác thực thành công',
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
                  'Bạn cần thiết lập mã PIN để hoàn thiện hồ sơ\nVui lòng tiếp tục',
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
                                    builder: (context) => SetPINPassword()),
                              );
                            },
                            child: Text(
                              'Thiết lập mã PIN'.toUpperCase(),
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
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: new FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Xem chứng thư số'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: kPrimaryFontFamily),
                          ),
                          textColor: Color.fromRGBO(26, 65, 171, 1),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromRGBO(26, 65, 171, 0.3),
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      )
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
