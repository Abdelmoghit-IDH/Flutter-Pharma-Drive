import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/services/auth.dart';
import 'package:provider/provider.dart';

class ProfilClient extends StatelessWidget {
  const ProfilClient({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffA140),
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilInfos(),
            ListButtons(),
            LogOutButton(),
          ],
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataCenter data = Provider.of<DataCenter>(context);

    return ComponantDrawer(
      icon: Icons.logout,
      title: "Se deconnecter",
      fonction: () async {
        AuthController authController;
        await authController.signOutUser();
        Navigator.pushReplacementNamed(context, '/signIn');
      },
    );
  }
}

// Todo : Widget used to build Drawer Screen

//***Widget reasable ListTile***//

// ignore: must_be_immutable
class ListButtons extends StatelessWidget {
  ListButtons({
    Key key,
  }) : super(key: key);

  String textAboutApp = """
    Lorem Ipsum Lorem Ipsum 
    Lorem Ipsum Lorem Ipsum
    Lorem Ipsum Lorem Ipsum
    Lorem Ipsum Lorem Ipsum
    Lorem Ipsum Lorem Ipsum
    Lorem Ipsum Lorem Ipsum
  """;


  @override
  Widget build(BuildContext context) {
    _dialogMessageAboutApp() {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text(
            "À propos de l'application",
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 6,
              fontFamily: "Rota",
              color: Color(0xff2b383a),
            ),
          ),
          content: new Text(textAboutApp),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(
                "Fermer",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                  fontFamily: 'Rota',
                  color: Color(0xffff8000),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    _dialogMessageContact() {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text(
            "Nous contacter",
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 6,
              fontFamily: "Rota",
              color: Color(0xff2b383a),
            ),
          ),
          content: new Text(textAboutApp),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(
                "Fermer",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                  fontFamily: 'Rota',
                  color: Color(0xffff8000),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    DataCenter data = Provider.of<DataCenter>(context);

    return Column(
      children: [
        ComponantDrawer(
          icon: Icons.dashboard,
          title: "Home",
          fonction: () {
            data.setXOffsite(0);
            data.setYOffsite(0);
            data.setActiveNvg(true);
          },
        ),
        ComponantDrawer(
          icon: Icons.account_circle,
          title: "Mon compte",
          fonction: () {
            data.setXOffsite(0);
            data.setYOffsite(0);
            data.setActiveNvg(true);
            Navigator.pushNamed(context, "/EditProfil");
          },
        ),
        ComponantDrawer(
          icon: Icons.add_shopping_cart_rounded,
          title: "Mes commandes",
          fonction: () {},
        ),
        ComponantDrawer(
          icon: Icons.assignment,
          title: "À propos de l'application",
          fonction: _dialogMessageAboutApp,
        ),
        ComponantDrawer(
          icon: Icons.mail_sharp,
          title: "Nous contacter",
          fonction: _dialogMessageContact,
        ),
        ComponantDrawer(
          icon: Icons.star,
          title: "Rate app",
          fonction: () {},
        ),
      ],
    );
  }
}

//***Widget information of user***//

class ProfilInfos extends StatelessWidget {
  const ProfilInfos({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: SizeConfig.safeBlockHorizontal * 7),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
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
        SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
        IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Cloud & IoT',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                  fontFamily: "Rota",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'INPT',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Rota",
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

//***Widget ListTiles of the Drawer***//

class ComponantDrawer extends StatelessWidget {
  ComponantDrawer({
    @required this.title,
    @required this.icon,
    @required this.fonction,
    Key key,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function fonction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: fonction,
      leading: Icon(
        icon,
        size: SizeConfig.blockSizeHorizontal * 10,
        color: Color(0xff333b3d),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "JosefinSans",
          fontSize: SizeConfig.blockSizeHorizontal * 6.5,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
