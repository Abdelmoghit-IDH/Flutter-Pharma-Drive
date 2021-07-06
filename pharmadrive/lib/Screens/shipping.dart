import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Screens/ChooseMethodPayment.dart';

class Shipping extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LaunchState();
}

class LaunchState extends State<Shipping> {
  String _email;
  String _adr;
  String _tel;
  String _city;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
    return Theme(
      data: ThemeData(primaryColor: Color(0xffff8000)),
      child: TextFormField(
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
          _email = value;
        },
      ),
    );
  }

  Widget _buildAdr() {
    return Theme(
      data: ThemeData(primaryColor: Color(0xffff8000)),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Adress'),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Adress is Required';
          }
        },
        onSaved: (String value) {
          _adr = value;
        },
      ),
    );
  }

  Widget _buildTel() {
    return Theme(
      data: ThemeData(primaryColor: Color(0xffff8000)),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Tel'),
        keyboardType: TextInputType.phone,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Tel is Required';
          }
        },
        onSaved: (String value) {
          _tel = value;
        },
      ),
    );
  }

  Widget _buildCity() {
    return Theme(
      data: ThemeData(primaryColor: Color(0xffff8000)),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'City'),
        validator: (String value) {
          if (value.isEmpty) {
            return 'City is Required';
          }
        },
        onSaved: (String value) {
          _city = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                'Shipping',
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 10,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 100),
                        _buildEmail(),
                        _buildAdr(),
                        _buildTel(),
                        _buildCity(),
                      ],
                    ),
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
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    print(_email);
                    print(_adr);
                    print(_tel);
                    print(_city);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChooseMethodPayment()));
                  },
                  child: Text(
                    'Continue to payment',
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
