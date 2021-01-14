import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myApp/constants.dart';
import 'digital_certificate_validate.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

class ConnectDevice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormConnectState();
  }
}

class _FormConnectState extends State<ConnectDevice>
    with WidgetsBindingObserver {
  // final _connectController = TextEditingController();
  TextEditingController textFieldCtrl;
  // FocusNode focusNode;
  bool _connectValidate = false;
  String _userCode;
  DeviceInfoPlugin deviceInfo =
      DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;
  IosDeviceInfo iosDeviceInfo;
  String id, document;

  String regid =
      "dS8rU4ecSaqiDg_e66IGC6:APA91bGSsbK8M_ojx189Rqf5R0WQRnWnnqYTiCZNAy0BT384N_aZF_jP0yeHE6-SRcGW1Jn6dGUEZYpiHQ-UXZwJvJS5fvfPyOv-fgox3miIZZYRxZkK97s4K1DJatAX1mFM9I8z74vC";
  @override
  void initState() {
    textFieldCtrl = TextEditingController();
    // focusNode = FocusNode()..addListener(_rebuildOnFocusChange);
    super.initState();
    getDeviceinfo();
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

  void _validateButton() async {
    if (textFieldCtrl.text != "" && textFieldCtrl.text.length == 6) {
      var envelope = '''<?xml version="1.0" encoding="utf-8"?>
      <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Body>
          <InsertTempRemote xmlns="http://tempuri.org/">
            <idcts>$textFieldCtrl</idcts>
            <regid>$regid</regid>
            <devid>$id</devid>
          </InsertTempRemote>
        </soap:Body>
      </soap:Envelope>''';
      http.Response response =
          await http.post('http://27.76.139.243:1111/service.asmx',
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "http://tempuri.org/InsertTempRemote",
                "Host": "27.76.139.243"
              },
              body: envelope);

      xml.XmlDocument _document = xml.parse(response.body);
      document = _document.text;

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DigitalCertificate()));
      // } else {
      //   textError.text = "Sai mã";

    } else {
      setState(() {
        _connectValidate = true;
      });
    }
  }

  void _textChange(text) {
    setState(() {
      _userCode = text;
      _connectValidate = false;
    });
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
      title: "Connect Device",
      home: Scaffold(
          body: SafeArea(
              minimum: const EdgeInsets.only(top: 40),
              child: Container(
                child: Column(
                  children: <Widget>[
                    //Appbar

                    appBar(context, 0.25),
                    SizedBox(height: 38),
                    //Connect device form
                    Flexible(
                        child: Container(
                      padding: containerPadding,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            headingTitle(
                                title: 'Kết nối thiết bị',
                                subtitle:
                                    'Chúng tôi đã gửi mã kết nối đến địa chỉ Email của bạn. Vui lòng kiểm tra và kết nối'),
                            TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z0-9]"))
                              ],
                              maxLength: 6,
                              autofocus: true,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(17, 57, 125, 1))),
                                labelText: 'Nhập mã kết nối',
                                errorText: _connectValidate
                                    ? '\* Mã kết nối chưa chính xác\. Vui lòng thử lại'
                                    : null,
                                labelStyle: TextStyle(
                                    fontFamily: kPrimaryFontFamily,
                                    color: Color.fromRGBO(193, 199, 208, 1)),
                              ),
                              controller: textFieldCtrl,
                              // focusNode: focusNode,
                              onChanged: _textChange,
                            ),
                            SizedBox(
                              height: 48,
                            ),

                            //Button
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: new FlatButton(
                                onPressed: _validateButton,
                                child: Text(
                                  'Kết nối'.toUpperCase(),
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
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ))),
      debugShowCheckedModeBanner: false,
    );
  }
}
