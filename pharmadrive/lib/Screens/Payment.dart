import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/Screens/confirmPayment.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LaunchState();
}

class LaunchState extends State<Payment> {
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
      body: initScreen(),
    );*/
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              trailing: Icon(null),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Payment',
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 10,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Container(margin: EdgeInsets.all(24), child: initScreen()),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ConfirmPayment()));
                  },
                  child: Text(
                    'Confirm',
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

  Widget initScreen() {
    DataCenter data = Provider.of<DataCenter>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            //margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Image(
              image: AssetImage("assets/images/visa.png"),
              //height: 300,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Add new card',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.add_circle_outline,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          /*Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Best Sale: ",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Text(
                  (data.getSomme()).toString() + " MAD",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),*/
          /*Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Discount: ",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Text(
                  "10%",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),*/
          /*Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Shipping: ",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Text(
                  "10.00 MAD",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),*/
          SizedBox(
            height: 70,
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Total Amount ",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                Text(
                  (data.getSomme() + 10).toDouble().toString() + " MAD",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          /*Center(
              child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ConfirmPayment()));
                    }, // When Click on Button goto Login Screen

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                new Color(0xffFF8000),
                                new Color(0xffFFA140)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Container(
                        constraints: const BoxConstraints(
                            maxWidth: 350.0,
                            minHeight: 40.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text(
                          'Confirm',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ))),*/
        ],
      ),
    );
  }
}
