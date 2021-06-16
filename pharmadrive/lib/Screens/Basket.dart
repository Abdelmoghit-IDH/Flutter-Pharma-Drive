import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/Screens/testSomme.dart';
import 'package:provider/provider.dart';

ValueNotifier sumItems = ValueNotifier(0);
ValueNotifier<bool> state = ValueNotifier(false);
ValueNotifier<List<int>> listPricesState = ValueNotifier(null);

// ignore: must_be_immutable
class Basket extends StatefulWidget {
  Basket({
    Key key,
    this.listItems,
    this.listStateInfos,
  }) : super(key: key);

  List<SelectedItem> listItems = [];
  List<int> listStateInfos = [];

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    DataCenter data = Provider.of<DataCenter>(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
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
                "Mes commandes",
                style: TextStyle(
                  fontFamily: "Rota",
                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                  color: Color(0xff2b383a),
                ),
              ),
            ),
            trailing: Icon(null),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 70,
            child: ListView.builder(
                itemCount: widget.listItems.length,
                itemBuilder: (context, int index) {
                  return widget.listItems[index];
                }),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: SizeConfig.blockSizeHorizontal * 2,
              left: SizeConfig.blockSizeHorizontal * 2,
            ),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Total amount",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: sumItems,
                          builder: (context, value, widget) {
                            return Text(
                              '${value.toString()} MAD',
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 6,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }),
                    ],
                  ),
                  Center(
                    child: Container(
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
                          Navigator.pushNamed(context, '/Shipping');
                          data.setSommeItems(sumItems.value);
                        },
                        child: Text(
                          "Payer",
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
          )
        ],
      ),
    );
  }
}

class SelectedItem extends StatefulWidget {
  const SelectedItem({
    @required this.nameDrug,
    @required this.price,
    this.urlImage,
    @required this.index,
    Key key,
  }) : super(key: key);

  final String nameDrug;
  final int price;
  final String urlImage;
  final int index;

  @override
  _SelectedItemState createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  int nbrOfItems = 0;
  @override
  Widget build(BuildContext context) {
    DataCenter data = Provider.of<DataCenter>(context);
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 12,
              child: Card(
                color: Colors.orange[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 2.5,
                    left: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 20,
                            height: SizeConfig.blockSizeHorizontal * 20,
                            child: Image.network(widget.urlImage),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          IntrinsicWidth(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  widget.nameDrug,
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 5.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  !(data.getElementPriceFromList(
                                              widget.index) ==
                                          0)
                                      ? "${data.getElementPriceFromList(widget.index).toString()} MAD"
                                      : "${data.getElementPriceFromList(widget.index).toString()} MAD",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 26,
                        child: Row(
                          children: [
                            Container(
                              height: SizeConfig.blockSizeHorizontal * 8,
                              decoration: BoxDecoration(),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[350],
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                              ),
                                              bottomLeft: Radius.circular(
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                              ))),
                                      width: SizeConfig.blockSizeHorizontal * 8,
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            if (state.value) {
                                              state.value = false;
                                              listPricesState.value =
                                                  data.listPrices;
                                            } else {
                                              state.value = false;
                                              nbrOfItems++;
                                              listPricesState.value =
                                                  data.listPrices;
                                              print(listPricesState.value);

                                              data.setElementPrice(
                                                widget.index,
                                                widget.price * nbrOfItems,
                                              );

                                              data.setNewNbrSelectedDrug(
                                                widget.index,
                                                nbrOfItems,
                                              );
                                              sumItems.value =
                                                  getSumItems(data.listPrices);
                                              print(data.listPrices);
                                              print(state.value);
                                            }
                                          });
                                        },
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    3.7,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            data
                                                .getNbrSelectedDrug(
                                                    widget.index)
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      width:
                                          SizeConfig.blockSizeHorizontal * 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[350],
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      3),
                                              bottomRight: Radius.circular(
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      3))),
                                      width: SizeConfig.blockSizeHorizontal * 8,
                                      child: Center(
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              nbrOfItems--;
                                              if (state.value) {
                                                state.value = false;
                                                listPricesState.value =
                                                    data.listPrices;
                                                print(state.value);
                                              } else {
                                                state.value = false;
                                                if (nbrOfItems > 0) {
                                                  data.setElementPrice(
                                                    widget.index,
                                                    widget.price * nbrOfItems,
                                                  );
                                                  sumItems.value = getSumItems(
                                                    data.listPrices,
                                                  );
                                                  data.setNewNbrSelectedDrug(
                                                    widget.index,
                                                    nbrOfItems,
                                                  );
                                                  print(data.listPrices);
                                                  print(state.value);
                                                } else {
                                                  nbrOfItems = 0;
                                                  data.setElementPrice(
                                                    widget.index,
                                                    0,
                                                  );
                                                  data.setNewNbrSelectedDrug(
                                                    widget.index,
                                                    0,
                                                  );
                                                  sumItems.value = sumItems
                                                      .value = getSumItems(
                                                    data.listPrices,
                                                  );
                                                  print(data.listPrices);
                                                  print(state.value);
                                                }
                                              }
                                            });
                                          },
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.7,
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
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}

Widget slideRightBackground() {
  return Padding(
    padding: EdgeInsets.only(
      top: 14.0,
      bottom: 14.0,
    ),
    child: Container(
      width: double.infinity,
      height: SizeConfig.blockSizeVertical * 12,
      color: Color(0xffff8000),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            ),
            Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  " Supprimer",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    ),
  );
}

int getSumItems(List<int> listItems) {
  int sum = 0;
  for (int i = 0; i < listItems.length; i++) {
    sum += listItems[i];
  }

  return sum;
}
