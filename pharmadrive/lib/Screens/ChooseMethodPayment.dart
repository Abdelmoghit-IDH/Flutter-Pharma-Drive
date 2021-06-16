import 'package:flutter/material.dart';

import 'Payment.dart';

class ChooseMethodPayment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LaunchState();
}

class LaunchState extends State<ChooseMethodPayment> {
  int _value = 1;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Choose your Payment Method",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Radio(
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              SizedBox(
                width: 10.0,
              ),
              Text("Credit/Debit Card"),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              SizedBox(
                width: 10.0,
              ),
              Text("Cash On Delivery"),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 3,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              SizedBox(
                width: 10.0,
              ),
              Text("PayPal"),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 4,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              SizedBox(
                width: 10.0,
              ),
              Text("Google Wallet"),
            ],
          ),
          SizedBox(height: 100),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [new Color(0xffFF8000), new Color(0xffFFA140)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Container(
                constraints: const BoxConstraints(
                    maxWidth: 350.0,
                    minHeight: 40.0), // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  'Pay',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Payment()));
            },
          )
        ],
      ),
    );
  }
}
