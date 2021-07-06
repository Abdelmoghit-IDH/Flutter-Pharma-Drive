import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

import 'Payment.dart';

class ChooseMethodPayment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LaunchState();
}

class LaunchState extends State<ChooseMethodPayment> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
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
    );*/
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  size: SizeConfig.blockSizeHorizontal * 7,
                ),
                color: Color(0xff2b383a),
              ),
              title: Center(
                child: Text(
                  "Payment",
                  style: TextStyle(
                    fontFamily: "Rota",
                    fontSize: SizeConfig.blockSizeHorizontal * 6,
                    color: Color(0xff2b383a),
                  ),
                ),
              ),
              trailing: Icon(null),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Choose your Payment Method",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: Color(0xffff8000),
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
                              activeColor: Color(0xffff8000),
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
                              activeColor: Color(0xffff8000),
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
                              activeColor: Color(0xffff8000),
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
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(15),
                width: SizeConfig.blockSizeHorizontal * 80,
                height: SizeConfig.blockSizeVertical * 6,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Color(0xffff8000),
                    onSurface: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Payment()));
                  },
                  child: Text(
                    'Pay',
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 6,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
