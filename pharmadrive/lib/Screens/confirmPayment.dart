import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

class ConfirmPayment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LaunchState();
}

class LaunchState extends State<ConfirmPayment> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 2);
    return Future.delayed(duration, () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
            ? Container(
                //..........................this is for loading after uploading an image
                width: double.infinity,
                height: double.infinity,
                child: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Color(0xffff8000),
                )),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(24), child: initScreen()),
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
                          Navigator.pushReplacementNamed(
                              context, '/StackProfilHome');
                        },
                        child: Text(
                          'Done',
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

  initScreen() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 5,
                    color: Color(0xffff8000),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(200))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.done_outline,
                  size: 70,
                  color: Color(0xffff8000),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 100.0)),
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
