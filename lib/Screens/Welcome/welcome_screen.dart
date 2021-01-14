import 'package:flutter/material.dart';
import 'package:myApp/Screens/SignIn/components/connect_device.dart';
import 'package:myApp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with WidgetsBindingObserver {
  DeviceInfoPlugin deviceInfo =
      DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;
  IosDeviceInfo iosDeviceInfo;
  String id, document;
  @override
  void initState() {
    super.initState();
    getDeviceinfo();
  }

  void _nextPage() async {
    var envelope = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetRequest xmlns="http://tempuri.org/">
      <devid>$id</devid>
    </GetRequest>
  </soap:Body>
</soap:Envelope>''';
    http.Response response =
        await http.post('http://27.76.139.243:1111/service.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "http://tempuri.org/GetRequest",
              "Host": "27.76.139.243"
            },
            body: envelope);
    xml.XmlDocument _document = xml.parse(response.body);
    document = _document.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConnectDevice()),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_welcome.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 70),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/logo_welcome.png',
              ),
              Container(
                margin: EdgeInsets.only(right: 16, left: 16, top: 36),
                child: Text(
                  '\" Làm việc từ xa, không ngại khoảng cách \"'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(9, 30, 66, 1),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 48),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: new FlatButton(
                    onPressed: _nextPage,
                    child: Text(
                      'Đăng nhập'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    textColor: textButtonColor,
                    color: buttonColor,
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
                    'Đăng ký'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
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
    ));
  }
}
