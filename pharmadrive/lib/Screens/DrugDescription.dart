import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

class DrugDescription extends StatefulWidget {
  DrugDescription({
    Key key,
    @required this.description,
    @required this.nameDrug,
    @required this.price,
    @required this.urlImage,
  }) : super(key: key);

  //Variable declaration for
  final String urlImage, description, nameDrug;
  final int price;

  @override
  _DrugDescriptionState createState() => _DrugDescriptionState();
}

class _DrugDescriptionState extends State<DrugDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 3),
          ListTile(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                size: SizeConfig.blockSizeHorizontal * 8,
              ),
              color: Color(0xff2b383a),
            ),
          ),
          Container(
              height: SizeConfig.blockSizeVertical * 40,
              width: double.infinity,
              child: Container(
                width: double.infinity,
                child: Image.network(widget.urlImage),
              )),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(
                SizeConfig.blockSizeHorizontal * 5,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(SizeConfig.blockSizeHorizontal * 10),
                  topLeft: Radius.circular(SizeConfig.blockSizeHorizontal * 10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        adaptiveTitle(widget.nameDrug),
                        style: TextStyle(
                          fontSize: widget.nameDrug.length > 13
                              ? SizeConfig.blockSizeHorizontal * 6
                              : SizeConfig.blockSizeHorizontal * 7,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      WidgetAddItem()
                    ],
                  ),
                  Text('${widget.price.toString()} MAD',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockSizeHorizontal * 8,
                      )),
                  Text('${widget.description} MAD',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.blockSizeHorizontal * 4,
                      )),
                  Text(
                    'Related items',
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeHorizontal * 20,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        RelatedItems(
                            urlImage: widget.urlImage,
                            nameDrug: widget.nameDrug,
                            price: widget.price),
                        RelatedItems(
                            urlImage: widget.urlImage,
                            nameDrug: widget.nameDrug,
                            price: widget.price),
                        RelatedItems(
                            urlImage: widget.urlImage,
                            nameDrug: widget.nameDrug,
                            price: widget.price)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical / 2,
                  ),
                  Center(
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 80,
                      height: SizeConfig.blockSizeVertical * 8,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color(0xffff8000),
                          onSurface: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Acheter",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 7,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RelatedItems extends StatelessWidget {
  const RelatedItems({
    Key key,
    @required this.urlImage,
    @required this.nameDrug,
    @required this.price,
  }) : super(key: key);

  final String urlImage;
  final String nameDrug;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      width: SizeConfig.blockSizeHorizontal * 40,
      height: SizeConfig.blockSizeVertical * 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.blockSizeHorizontal * 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      urlImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2.5,
                ),
                Container(
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          adaptiveTitle(nameDrug),
                          style: TextStyle(
                            fontSize: adaptiveFontSize(nameDrug),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$price MAD',
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class WidgetAddItem extends StatefulWidget {
  WidgetAddItem({
    Key key,
  }) : super(key: key);

  @override
  _WidgetAddItemState createState() => _WidgetAddItemState();
}

class _WidgetAddItemState extends State<WidgetAddItem> {
  int nbrOfItems = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 26,
      child: Row(
        children: [
          Container(
            height: SizeConfig.blockSizeHorizontal * 7,
            decoration: BoxDecoration(),
            child: Container(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                SizeConfig.blockSizeHorizontal * 3),
                            bottomLeft: Radius.circular(
                                SizeConfig.blockSizeHorizontal * 3))),
                    width: SizeConfig.blockSizeHorizontal * 8,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          nbrOfItems++;
                        });
                      },
                      child: Text(
                        "+",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          nbrOfItems.toString(),
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                SizeConfig.blockSizeHorizontal * 3),
                            bottomRight: Radius.circular(
                                SizeConfig.blockSizeHorizontal * 3))),
                    width: SizeConfig.blockSizeHorizontal * 8,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (nbrOfItems > 0) {
                              nbrOfItems--;
                            } else {
                              nbrOfItems = 0;
                            }
                          });
                        },
                        child: Text(
                          "-",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

String adaptiveTitle(String name) {
  List<String> nm;
  if (name.length <= 30 && name.length >= 17) {
    nm = name.split(' ');
    return nm[0];
  } else {
    return name;
  }
}

double adaptiveFontSize(String name) {
  if (name.length >= 16) {
    return SizeConfig.blockSizeHorizontal * 2.2;
  } else if (name.length > 13) {
    return SizeConfig.blockSizeHorizontal * 2.5;
  } else {
    return SizeConfig.blockSizeHorizontal * 3.5;
  }
}
