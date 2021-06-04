import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

class ProfilEditing extends StatelessWidget {
  const ProfilEditing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.arrow_back,
              size: SizeConfig.blockSizeHorizontal * 8,
              color: Color(0xff2b383a),
            ),
            title: Center(
              child: Text(
                "Editer le profil",
                style: TextStyle(
                  fontFamily: "Rota",
                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                  color: Color(0xff2b383a),
                ),
              ),
            ),
            trailing: Icon(null),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 30,
            height: SizeConfig.blockSizeHorizontal * 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: ExactAssetImage('assets/images/profil.png'),
                fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: Offset(0, 3), // Todo: changes position of shadow
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
