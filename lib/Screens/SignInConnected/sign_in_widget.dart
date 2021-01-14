import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInConnected extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormConnectedState();
  }
}

class _FormConnectedState extends State<SignInConnected>
    with WidgetsBindingObserver {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
  // final _connectController = TextEditingController();
  TextEditingController numberFieldCtrl = TextEditingController();
  // FocusNode focusNode;
  // bool _connectValidate = false;
  bool _pinValidate = false;
  String _numberValidate;
  bool countDownComplete = false;

  void showWidget() {
    setState(() {
      numberFieldCtrl.text.isEmpty || numberFieldCtrl.text.length < 6
          ? _pinValidate = true
          : _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Đăng nhập thành công!')));
    });
  }

  // String _connect;
  @override
  void initState() {
    // numberFieldCtrl = TextEditingController();
    // focusNode = FocusNode()..addListener(_rebuildOnFocusChange);
    super.initState();
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
      title: "Sign In Connected",
      home: Scaffold(
        backgroundColor: Color.fromRGBO(17, 57, 125, 1),
        key: _scaffoldKey,
        body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'Vui lòng nhập mã PIN để đăng nhập',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilroy',
                        fontSize: 14.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 64, bottom: 12),
                    padding:
                        const EdgeInsets.only(top: 12, bottom: 12, right: 40),
                    height: 58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(fontSize: 32, letterSpacing: 12),
                      textAlign: TextAlign.center,
                      obscureText: true,
                      keyboardType: TextInputType.numberWithOptions(),
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 6,
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        labelStyle: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Color.fromRGBO(193, 199, 208, 1),
                        ),
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color.fromRGBO(183, 192, 204, 1),
                        ),
                        // errorText: _pinValidate
                        //     ? '\*Mật khẩu chưa chính xác\. Bạn còn 3 lần thử'
                        //     : null,
                      ),
                      controller: numberFieldCtrl,
                      // focusNode: focusNode,
                      onChanged: (text) {
                        setState(() {
                          _numberValidate = text;
                          _pinValidate = false;
                        });
                      },
                    ),
                  ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _pinValidate,
                      child: Center(
                          child: Text(
                              '\*Mật khẩu chưa chính xác. Vui lòng nhập lại',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)))),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: new FlatButton(
                      onPressed: showWidget,
                      child: Text(
                        'Đăng nhập'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  InkWell(
                      child: Container(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Image.asset('assets/images/faceid_icon.png')
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Column(
                                children: [
                                  Text(
                                    'Đăng nhập bằng FaceID',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () => {}),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Text(
                            'Quên mật khẩu',
                            style: TextStyle(
                                color: Color.fromRGBO(183, 192, 204, 1),
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: () => {})
                    ],
                  ),
                ],
              ),
            )),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
