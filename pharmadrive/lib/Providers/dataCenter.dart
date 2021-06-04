import 'package:flutter/material.dart';

class DataCenter extends ChangeNotifier {
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
}
