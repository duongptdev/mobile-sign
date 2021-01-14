import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myApp/Screens/SignIn/sign_in_success.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class SetPINPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SetPINState();
  }
}

class _SetPINState extends State<SetPINPassword> with WidgetsBindingObserver {
  // final _connectController = TextEditingController();
  TextEditingController numberFieldCtrl1;
  TextEditingController numberFieldCtrl2;
  final focus = FocusNode();
  bool _pinValidate = false;
  String _numberValidate1;
  String _numberValidate2;
  String document;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  // String _connect;
  @override
  void initState() {
    numberFieldCtrl1 = TextEditingController();
    numberFieldCtrl2 = TextEditingController();
    // focusNode = FocusNode()..addListener(_rebuildOnFocusChange);
    super.initState();
  }

  void setpin() async {
    if (numberFieldCtrl1.text == numberFieldCtrl2.text) {
      var envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <SetupPin xmlns="http://tempuri.org/">
      <devid>string</devid>
      <pin>string</pin>
    </SetupPin>
  </soap:Body>
</soap:Envelope>''';
      http.Response response =
          await http.post('http://27.76.139.243:1111/service.asmx',
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "http://tempuri.org/SetupPin",
                "Host": "27.76.139.243"
              },
              body: envelope);
      xml.XmlDocument _document = xml.parse(response.body);
      document = _document.text;

      // setState(() {
      //   numberFieldCtrl2.text.isEmpty & numberFieldCtrl1.text.isEmpty ||
      //           numberFieldCtrl2.text.length & numberFieldCtrl1.text.length <
      //               6 ||
      //           _numberValidate1 != _numberValidate2
      //       ? _pinValidate = true
      //       :Navigator.push(
      //   context, MaterialPageRoute(builder: (context) => SignInSuccess()));
      // });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInSuccess()));
    } else {
      setState(() {
        _pinValidate = true;
      });
    }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: new Icon(Icons.arrow_back_ios_rounded),
                              color: Color.fromRGBO(9, 30, 66, 1),
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    top: 16, bottom: 16, right: 16),
                                padding: const EdgeInsets.only(
                                    top: 2, right: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(17, 57, 125, 1)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Column(children: <Widget>[
                                  new LinearPercentIndicator(
                                    backgroundColor: Colors.transparent,
                                    width: 80.0,
                                    lineHeight: 10.0,
                                    percent: 1,
                                    progressColor:
                                        Color.fromRGBO(17, 57, 125, 1),
                                  ),
                                ]))
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 38),

                    //Set PIN password form
                    Flexible(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thiết lập mã PIN',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                color: Color.fromRGBO(9, 30, 66, 1),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Mã PIN này sẽ được sử dụng để xác thực khi bạn đăng nhập vào Mobile Sign.',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  height: 1.4,
                                  color: Color.fromRGBO(80, 95, 121, 1)),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              obscureText: _obscureText1,
                              keyboardType: TextInputType.numberWithOptions(),
                              textInputAction: TextInputAction.next,
                              onSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus);
                              },
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 6,
                              autofocus: true,
                              decoration: InputDecoration(
                                counterText: "",
                                suffixIcon: InkWell(
                                    onTap: _toggle1,
                                    child: Icon(
                                      _obscureText1
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.grey,
                                    )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(17, 57, 125, 1))),
                                labelText: 'Nhập mã PIN',
                                errorText: _pinValidate
                                    ? '\* Mã PIN chưa chính xác\. Vui lòng nhập lại'
                                    : null,
                                labelStyle: TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Color.fromRGBO(193, 199, 208, 1)),
                              ),
                              controller: numberFieldCtrl1,
                              // focusNode: focusNode,
                              onChanged: (text) {
                                setState(() {
                                  _numberValidate1 = text;
                                  _pinValidate = false;
                                });
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextField(
                              focusNode: focus,
                              obscureText: _obscureText2,
                              keyboardType: TextInputType.numberWithOptions(),
                              textInputAction: TextInputAction.done,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 6,
                              decoration: InputDecoration(
                                counterText: "",
                                suffixIcon: InkWell(
                                    onTap: _toggle2,
                                    child: Icon(
                                      _obscureText2
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.grey,
                                    )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(17, 57, 125, 1))),
                                labelText: 'Nhập lại mã PIN',
                                errorText: _pinValidate
                                    ? '\* Mã PIN chưa chính xác\. Vui lòng nhập lại'
                                    : null,
                                labelStyle: TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Color.fromRGBO(193, 199, 208, 1)),
                              ),
                              controller: numberFieldCtrl2,
                              // focusNode: focusNode,
                              onChanged: (text) {
                                setState(() {
                                  _pinValidate = false;
                                  _numberValidate2 = text;
                                });
                              },
                            ),
                            SizedBox(
                              height: 48,
                            ),

                            //Button
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: new FlatButton(
                                onPressed: setpin,
                                child: Text(
                                  'Xác nhận'.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                textColor: Colors.white,
                                color: Color.fromRGBO(17, 57, 125, 1),
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
