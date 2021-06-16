import 'package:flutter/material.dart';

class ConfirmPayment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LaunchState();
}

class LaunchState extends State<ConfirmPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "Payment",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: initScreen(),
    );
  }

  initScreen() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/logo-PharmaDrive.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Confirmation",
              style: TextStyle(fontSize: 25.0, color: Colors.black),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "You have successfully completed your payment",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          ],
        )
      ],
    );
  }
}
