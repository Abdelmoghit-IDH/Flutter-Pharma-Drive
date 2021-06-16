import 'package:flutter/material.dart';
import 'package:pharmadrive/Screens/ChooseMethodPayment.dart';

class Shipping extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LaunchState();
}

class LaunchState extends State<Shipping> {
  String _Email;
  String _Adr;
  String _Tel;
  String _City;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Your Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'Please Enter a V alid Email Adress ';
        }
        return null;
      },
      onSaved: (String value) {
        _Email = value;
      },
    );
  }

  Widget _buildAdr() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Adress'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Adress is Required';
        }
      },
      onSaved: (String value) {
        _Adr = value;
      },
    );
  }

  Widget _buildTel() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Tel'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Tel is Required';
        }
      },
      onSaved: (String value) {
        _Tel = value;
      },
    );
  }

  Widget _buildCity() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'City'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'City is Required';
        }
      },
      onSaved: (String value) {
        _City = value;
      },
    );
  }

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
          "Shipping",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildEmail(),
              _buildAdr(),
              _buildTel(),
              _buildCity(),
              SizedBox(height: 100),
              RaisedButton(
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
                      'Continue to payment',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print(_Email);
                  print(_Adr);
                  print(_Tel);
                  print(_City);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChooseMethodPayment()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
