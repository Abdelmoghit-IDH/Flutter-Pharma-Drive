import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

class MonStock extends StatefulWidget {
  MonStock({Key key}) : super(key: key);

  @override
  _MonStockState createState() => _MonStockState();
}

class _MonStockState extends State<MonStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add,
          color: Color(0xffffa140),
        ),
        label: Text(
          "Ajouter un nouveau medicament",
          style: TextStyle(color: Color(0xffffa140)),
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        onPressed: () {},
      ),
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                size: SizeConfig.blockSizeHorizontal * 8,
              ),
              color: Color(0xff2b383a),
            ),
            title: Center(
              child: Text(
                "Gérer mon stock",
                style: TextStyle(
                  fontFamily: "Rota",
                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                  color: Color(0xff2b383a),
                ),
              ),
            ),
            trailing: Icon(null),
          ),
        ],
      )),
    );
  }
}
