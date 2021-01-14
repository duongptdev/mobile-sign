import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:myApp/constants.dart';
import 'OTP_auth.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class DigitalCertificate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CertificateState();
  }
}

enum SingingCharacter { digitalcertificate }

class _CertificateState extends State<DigitalCertificate> {
  SingingCharacter _character = SingingCharacter.digitalcertificate;
  DeviceInfoPlugin deviceInfo =
      DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;
  IosDeviceInfo iosDeviceInfo;
  String model, id;
  String cts, document, serial, status, info, text;
  String regid =
      "dS8rU4ecSaqiDg_e66IGC6:APA91bGSsbK8M_ojx189Rqf5R0WQRnWnnqYTiCZNAy0BT384N_aZF_jP0yeHE6-SRcGW1Jn6dGUEZYpiHQ-UXZwJvJS5fvfPyOv-fgox3miIZZYRxZkK97s4K1DJatAX1mFM9I8z74vC";
  @override
  void initState() {
    super.initState();
    getDeviceinfo();
    getSerial();
    getCTS();
    getInfo();
  }

  void getDeviceinfo() async {
    androidDeviceInfo = await deviceInfo.androidInfo;
    // iosDeviceInfo = await deviceInfo.iosInfo;
    setState(() {
      if (Platform.isAndroid) {
        model = androidDeviceInfo.model;
        id = androidDeviceInfo.androidId;
      } else if (Platform.isIOS) {
        //     model = iosDeviceInfo.name;
        //     id = iosDeviceInfo.identifierForVendor;
      }
    });
  }

  void getCTS() async {
    var envelope = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetIDCTSFromDevID xmlns="http://tempuri.org/">
      <devid>$id</devid>
    </GetIDCTSFromDevID>
  </soap:Body>
</soap:Envelope>''';
    http.Response response =
        await http.post('http://27.76.139.243:1111/service.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "http://tempuri.org/GetIDCTSFromDevID",
              "Host": "27.76.139.243"
            },
            body: envelope);
    setState(() {
      xml.XmlDocument _document = xml.parse(response.body);
      cts = _document.text;
    });
  }

  void getInfo() async {
    var envelope = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetInfo xmlns="http://tempuri.org/">
      <idcts>$cts</idcts>
    </GetInfo>
  </soap:Body>
</soap:Envelope>''';
    http.Response response =
        await http.post('http://27.76.139.243:1111/service.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "http://tempuri.org/GetInfo",
              "Host": "27.76.139.243"
            },
            body: envelope);
    setState(() {
      xml.XmlDocument _document = xml.parse(response.body);
      info = _document.text;
    });
  }

  void getSerial() async {
    var envelope = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetSerialFromIDCTS xmlns="http://tempuri.org/">
      <idcts>$cts</idcts>
    </GetSerialFromIDCTS>
  </soap:Body>
</soap:Envelope>''';
    http.Response response =
        await http.post('http://27.76.139.243:1111/service.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "http://tempuri.org/GetSerialFromIDCTS",
              "Host": "27.76.139.243"
            },
            body: envelope);
    setState(() {
      xml.XmlDocument _document = xml.parse(response.body);
      document = _document.text;
    });
  }

  void activeDevide() async {
    var envelope = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <InsertDeviceID xmlns="http://tempuri.org/">
      <idcts>$cts</idcts>
      <device_id>$id</device_id>
      <serial>$document</serial>
      <regid>$regid</regid>
    </InsertDeviceID>
  </soap:Body>
</soap:Envelope>''';
    http.Response response =
        await http.post('http://27.76.139.243:1111/service.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "http://tempuri.org/InsertDeviceID",
              "Host": "27.76.139.243"
            },
            body: envelope);
    xml.XmlDocument _document = xml.parse(response.body);
    document = _document.text;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OTPAuthentication()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Certificate',
      home: Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 245, 1),
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 40),
          child: Container(
            child: Column(
              children: [
                //Appbar
                appBar(context, 0.5),
                SizedBox(height: 38),

                //Screen Title
                Flexible(
                    child: Container(
                  padding: containerPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingTitle(
                            title: 'Xác nhận chứng thư',
                            subtitle:
                                'Vui lòng xác thực serial để kết nối và kích hoạt thiết bị với ứng dụng'),

                        //Infomation of digital certificate
                        titleCard(titleOfCard: 'Thiết bị'),
                        SizedBox(height: 2),
                        Container(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                firstContent(firstCard: '$model'),
                                secondContent(secondContent: '$id'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 28),
                        titleCard(titleOfCard: 'Thông tin công ty'),
                        SizedBox(height: 2),
                        Container(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                firstContent(
                                    firstCard:
                                        'Công Ty Thương Mại Cổ Phần Công Nghệ Thẻ Nacencomm,$info'),
                                secondContent(secondContent: '0103930279')
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 28),
                        titleCard(titleOfCard: 'Số serial'),
                        SizedBox(height: 2),
                        Container(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 16, left: 16, bottom: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Chọn số serial kích hoạt',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: kPrimaryFontFamily,
                                            color:
                                                Color.fromRGBO(9, 30, 66, 1)),
                                      ),
                                      ListTile(
                                        title: Text(
                                          '1234567891234,$document',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  37, 110, 189, 1),
                                              fontSize: 14,
                                              fontFamily: kPrimaryFontFamily),
                                        ),
                                        leading: Radio(
                                          value: SingingCharacter
                                              .digitalcertificate,
                                          groupValue: _character,
                                          onChanged: (SingingCharacter value) {
                                            setState(() {
                                              _character = value;
                                            });
                                          },
                                        ),
                                      ),
                                      // listOfCertificate(
                                      //     certificateID: '000-112',
                                      //     stateOfCertificate: 'Đã kích hoạt'),
                                      // listOfCertificate(
                                      //     certificateID: '000-183',
                                      //     stateOfCertificate: 'Đã kích hoạt'),
                                      // listOfCertificate(
                                      //     certificateID: '000-165',
                                      //     stateOfCertificate: 'Đã kích hoạt'),
                                      // listOfCertificate(
                                      //     certificateID: '000-137',
                                      //     stateOfCertificate: 'Đã kích hoạt'),
                                      // listOfCertificate(
                                      //     certificateID: '000-115',
                                      //     stateOfCertificate: 'Đã kích hoạt'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),

        //Bottom button
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(30.0),
          child: FlatButton(
            onPressed: activeDevide,
            child: Text(
              'Kích hoạt'.toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            height: 44,
            textColor: textButtonColor,
            color: buttonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
