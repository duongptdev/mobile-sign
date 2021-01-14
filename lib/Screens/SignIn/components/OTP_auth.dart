import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myApp/constants.dart';
import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:myApp/Screens/SignIn/OTP_success.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

class OTPAuthentication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormOTPState();
  }
}

class _FormOTPState extends State<OTPAuthentication>
    with WidgetsBindingObserver {
  // final _connectController = TextEditingController();
  TextEditingController numberFieldCtrl;
  // FocusNode focusNode;
  bool _otpValidate = false;
  String _inputOTP, serial, pincode, document;
  int _counter;
  DeviceInfoPlugin deviceInfo =
      DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;
  IosDeviceInfo iosDeviceInfo;
  String id, otp, cts;
  String regid =
      "dS8rU4ecSaqiDg_e66IGC6:APA91bGSsbK8M_ojx189Rqf5R0WQRnWnnqYTiCZNAy0BT384N_aZF_jP0yeHE6-SRcGW1Jn6dGUEZYpiHQ-UXZwJvJS5fvfPyOv-fgox3miIZZYRxZkK97s4K1DJatAX1mFM9I8z74vC";
  // String _connect;
  @override
  void initState() {
    numberFieldCtrl = TextEditingController();
    // focusNode = FocusNode()..addListener(_rebuildOnFocusChange);
    super.initState();
    getDeviceinfo();
  }

  void _otpChange(text) {
    setState(() {
      _inputOTP = text;
      _otpValidate = false;
    });
  }

  void getDeviceinfo() async {
    androidDeviceInfo = await deviceInfo.androidInfo;
    // iosDeviceInfo = await deviceInfo.iosInfo;
    setState(() {
      if (Platform.isAndroid) {
        id = androidDeviceInfo.androidId;
      } else if (Platform.isIOS) {
        // id = iosDeviceInfo.identifierForVendor;
      }
    });
  }

  void _otpButton() async {
    setState(() {
      numberFieldCtrl.text.isEmpty || numberFieldCtrl.text.length < 4
          ? _otpValidate = true
          // : _otpValidate = false;
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => OTPSuccess()));
    });
  }

  void resendOTP() async {
    var envelope = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ResendOTP xmlns="http://tempuri.org/">
      <regid>$regid</regid>
    </ResendOTP>
  </soap:Body>
</soap:Envelope>''';
    http.Response response =
        await http.post('http://27.76.139.243:1111/service.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "http://tempuri.org/ResendOTP",
              "Host": "27.76.139.243"
            },
            body: envelope);
    xml.XmlDocument _document = xml.parse(response.body);
    document = _document.text;
  }
  // void _rebuildOnFocusChange() => setState(() {});

  // void _onButtonPressed() {}

  // void dispose() {
  //   _connectController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OTP Authentication",
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              minimum: const EdgeInsets.only(top: 40),
              child: Container(
                child: Column(
                  children: <Widget>[
                    //Appbar
                    appBar(context, 0.75),
                    SizedBox(height: 38),
                    Flexible(
                        child: Container(
                      padding: containerPadding,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingTitle(
                                title: 'Xác thực OTP',
                                subtitle:
                                    'Vui lòng nhập mã OTP để tiếp tục thao tác'),
                            TextField(
                                style:
                                    TextStyle(fontSize: 32, letterSpacing: 16),
                                keyboardType: TextInputType.numberWithOptions(),
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLength: 4,
                                autofocus: true,
                                decoration: InputDecoration(
                                  counterText: "",
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(17, 57, 125, 1))),
                                  // labelText: 'Nhập mã OTP',
                                  errorText: _otpValidate
                                      ? '\* Mã OTP chưa chính xác\. Vui lòng thử lại'
                                      : null,
                                  labelStyle: TextStyle(
                                      fontFamily: kPrimaryFontFamily,
                                      color: Color.fromRGBO(193, 199, 208, 1)),
                                ),
                                controller: numberFieldCtrl,
                                // focusNode: focusNode,
                                onChanged: _otpChange),
                            SizedBox(
                              height: 56,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: new FlatButton(
                                onPressed: _otpButton,
                                child: Text(
                                  'Xác nhận'.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: kPrimaryFontFamily,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                textColor: textButtonColor,
                                color: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                            SizedBox(
                              height: 48,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  child: FlatButton(
                                    child: Text(
                                      'Gửi lại mã OTP',
                                      style: TextStyle(
                                          color: Color.fromRGBO(52, 69, 99, 1),
                                          fontFamily: kPrimaryFontFamily,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: resendOTP,
                                  ),
                                ),
                                // InkWell(
                                //     child: Text(
                                //       'Gửi lại mã OTP',
                                //       style: TextStyle(
                                //           color: Color.fromRGBO(52, 69, 99, 1),
                                //           fontFamily: kPrimaryFontFamily,
                                //           fontWeight: FontWeight.w600),
                                //     ),
                                //     onTap: () => {})
                              ],
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ))),
      debugShowCheckedModeBanner: false,
    );
  }
}
