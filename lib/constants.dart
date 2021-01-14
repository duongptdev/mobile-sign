import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

const kPrimaryColor = Color.fromRGBO(26, 65, 171, 1);
const kPrimaryLightColor = Color.fromRGBO(235, 239, 252, 1);
const kPrimaryFontFamily = 'Gilroy';
const buttonColor = Color.fromRGBO(17, 57, 125, 1);
const textButtonColor = Colors.white;
const containerPadding = EdgeInsets.symmetric(horizontal: 16);

Widget appBar(BuildContext context, double percentProgress) {
  return Row(
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
              margin: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
              padding: const EdgeInsets.only(top: 2, right: 2, bottom: 2),
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Color.fromRGBO(17, 57, 125, 1)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(children: <Widget>[
                new LinearPercentIndicator(
                  backgroundColor: Colors.transparent,
                  width: 80.0,
                  lineHeight: 10.0,
                  percent: percentProgress,
                  progressColor: Color.fromRGBO(17, 57, 125, 1),
                ),
              ]))
        ],
      ),
    ],
  );
}

Widget headingTitle({String title, String subtitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: kPrimaryFontFamily,
            color: Color.fromRGBO(9, 30, 66, 1)),
      ),
      SizedBox(height: 16),
      Text(
        subtitle,
        style: TextStyle(
            fontSize: 16,
            fontFamily: kPrimaryFontFamily,
            height: 1.4,
            color: Color.fromRGBO(80, 95, 121, 1)),
      ),
      SizedBox(height: 24),
    ],
  );
}

Widget listOfCertificate({String certificateID, String stateOfCertificate}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 16, bottom: 16),
        child: Column(
          children: [
            Text(
              certificateID,
              style: TextStyle(
                  color: Color.fromRGBO(107, 119, 140, 1),
                  fontFamily: 'Gilroy',
                  fontSize: 14),
            )
          ],
        ),
      ),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16, bottom: 16),
            child: Text(
              stateOfCertificate,
              style: TextStyle(
                  color: Color.fromRGBO(183, 192, 204, 1),
                  fontFamily: 'Gilroy',
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      ))
    ],
  );
}

Widget titleCard({String titleOfCard}) {
  return Text(
    titleOfCard.toUpperCase(),
    style: TextStyle(
        fontSize: 14,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(9, 30, 66, 1)),
  );
}

Widget firstContent({String firstCard}) {
  return Container(
    padding: EdgeInsets.only(top: 14, left: 14, bottom: 4),
    child: Column(
      children: [
        Text(
          firstCard,
          style: TextStyle(
              fontSize: 14,
              fontFamily: kPrimaryFontFamily,
              color: Color.fromRGBO(9, 30, 66, 1)),
        ),
      ],
    ),
  );
}

Widget secondContent({String secondContent}) {
  return Container(
    padding: EdgeInsets.only(left: 14, bottom: 14),
    child: Column(
      children: [
        Text(
          secondContent,
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Gilroy',
              color: Color.fromRGBO(107, 119, 140, 1)),
        ),
      ],
    ),
  );
}
