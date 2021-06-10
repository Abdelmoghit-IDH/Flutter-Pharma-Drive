import 'package:flutter/material.dart';
import 'package:pharmadrive/Screens/Basket.dart';
import 'package:pharmadrive/model/user.dart';

class DataCenter extends ChangeNotifier {
  List<SelectedItem> listItems = [];
  List<int> listPrices = [];
  int sumItems = 0;
  List<int> listSelectedDrug = [];
  //***Initiale values of X,Y,Z axes***//
  double xOffsite = 0;
  double yOffsite = 0;
  double zOffsite = 0;

  //***Initiale values of X,Y,Z axes***/
  var activeNvg = true;
  bool state = false;

  // Todo : *******************Functions*********************

  // *** fct change the scale of MainNvgApp based in the state of drawer ***//

  double checkState(bool stateDrawer) {
    return stateDrawer ? 1.0 : 0.75;
  }

  // *** fct change the value of drawer (true or false) ***//

  setActiveNvg(bool newActiveNvg) {
    activeNvg = newActiveNvg;
    notifyListeners();
  }

  // *** fct get the value of drawer (true or false) ***//

  getActiveNvg() {
    return activeNvg;
  }

  // *** fct change the value X axe  ***//

  setXOffsite(double newXOffsite) {
    xOffsite = newXOffsite;
    notifyListeners();
  }

  // *** fct change the value Y axe  ***//

  setYOffsite(double newYOffsite) {
    yOffsite = newYOffsite;
    notifyListeners();
  }

  // *** fct get the value X axe ***//

  getXOffsite() {
    return xOffsite;
  }

  // *** fct get the value Y axe ***//

  getYOffsite() {
    return yOffsite;
  }

  // *** Add sellected item to the list of items  ***//

  setItem(String drugName, String urlImage, int price, int index) {
    if (!listItems.contains(SelectedItem(
        nameDrug: drugName, urlImage: urlImage, price: price, index: index))) {
      listItems.add(SelectedItem(
        nameDrug: drugName,
        urlImage: urlImage,
        price: price,
        index: index,
      ));
      notifyListeners();
    }
  }

  // *** fct get the value X axe ***//

  getItems() {
    return listItems;
  }

  //***set list items***\\

  setListPrice(int price) {
    listPrices.add(price);
    notifyListeners();
  }

  //****/
  int getElementPriceFromList(int index) {
    return listPrices[index];
  }

  //****/
  setElementPrice(int index, int price) {
    listPrices[index] = price;
    notifyListeners();
  }

  get getSumItems => sumItems;

  setAddSumItems(int value) {
    sumItems += value;
    notifyListeners();
  }

  setSubSumItems(int value) {
    sumItems -= value;
    notifyListeners();
  }

  getNbrSelectedDrug(int index) {
    return listSelectedDrug[index];
  }

  setNbrSelectedDrug() {
    listSelectedDrug.add(0);
    notifyListeners();
  }

  setNewNbrSelectedDrug(index, value) {
    listSelectedDrug[index] = value;
    notifyListeners();
  }

  //.........................USER...........................................
  WholeUserModel utilisateurConnecte;
}
