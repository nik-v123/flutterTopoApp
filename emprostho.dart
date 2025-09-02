import 'package:flutter/material.dart';
import 'dart:math';

class emprosthoApp extends StatefulWidget {
  const emprosthoApp({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _emprosthoState createState() => _emprosthoState();
}

class _emprosthoState extends State<emprosthoApp> {
  String textXmEmprostho = "No Value Entered";
  String textYmEmprostho = "No Value Entered";

  String aEmprostho = '';
  String bEmprostho = '';

  String xAcyA = '';
  String xBcyB = '';

  double grad2rad(double g) {
    return g * pi / 200.0;
  }

  //double cot(double grads) {
  //  return 1 / tan(grad2rad(grads));
  //}

  double convToZF(double g) {
    while (g >= 400.0) {
      g -= 400.0;
    }
    while (g < 0.0) {
      g += 400.0;
    }
    return g;
  }

  double invDirection(double g) {
    return convToZF(g - 200.0);
  }

  double rad2grad(double r) {
    return r * 200.0 / pi;
  }

  List<double> deutero(double xarx, double yarx, double xtel, double ytel) {
    double dx = xtel - xarx;
    double dy = ytel - yarx;
    double D = sqrt(dx * dx + dy * dy);

    if (dx == 0) {
      if (dy == 0) {
        // print("απροσδιόριστο"); // You might want to handle this differently
        return [-999, -999];
      } else if (dy < 0) {
        return [D, 200.0];
      } else {
        return [D, 0];
      }
    } else if (dx < 0) {
      if (dy == 0) {
        return [D, 200.0];
      } else if (dy < 0) {
        double a = atan((dx / dy).abs());
        return [D, 200.0 + rad2grad(a)];
      } else {
        double a = atan((dx / dy).abs());
        return [D, 400.0 - rad2grad(a)];
      }
    } else {
      if (dy == 0) {
        return [D, 100.0];
      } else if (dy < 0) {
        double a = atan((dx / dy).abs());
        return [D, 200.0 - rad2grad(a)];
      } else {
        double a = atan((dx / dy).abs());
        return [D, rad2grad(a)];
      }
    }
  }

  List<double> emprostho(List<dynamic> x, List<dynamic> y, double a, double b) {
    //print("a,b: ", a, ",", b);

    List<double> dAB_GAB = deutero(x[0], y[0], x[1], y[1]);
    double dAB = dAB_GAB[0];
    double GAB = dAB_GAB[1];

    GAB = convToZF(GAB);
    double GBA = invDirection(GAB);
    //print("G12:", GAB, "G21:", GBA);

    double g = 200.0 - a - b;

    double dAM = dAB * sin(grad2rad(b)) / sin(grad2rad(g));
    double dBM = dAB * sin(grad2rad(a)) / sin(grad2rad(g));

    double GAM = GBA + a + 200.0;
    GAM = convToZF(GAM);

    double GBM = GAB - b + 600.0; //GAB + 400.0 - b + 200.0
    GBM = convToZF(GBM);

    double xm1 = x[0] + dAM * sin(grad2rad(GAM));
    double ym1 = y[0] + dAM * cos(grad2rad(GAM));

    double xm2 = x[1] + dBM * sin(grad2rad(GBM));
    double ym2 = y[1] + dBM * cos(grad2rad(GBM));

    return [xm1, ym1, xm2, ym2];
  }

  void _calculateEmprostho() {
    setState(() {
      var aEmpVar;
      var bEmpVar;
      var spA;
      var spB;
      var xA, yA, xB, yB;

      aEmpVar = double.tryParse(aEmprostho);
      bEmpVar = double.tryParse(bEmprostho);

      spA = xAcyA.split(',');
      spB = xBcyB.split(',');

      if (spA.length != 2) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Σφάλμα'),
            content: const Text('Τα δεδομένα έχουν λάθος μορφή'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        //
      } else if (spB.length != 2) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Σφάλμα'),
            content: const Text('Τα δεδομένα έχουν λάθος μορφή'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (aEmpVar == null || bEmpVar == null) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Σφάλμα'),
            content: const Text('Τα δεδομένα έχουν λάθος μορφή'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        xA = double.tryParse(spA[0]);
        yA = double.tryParse(spA[1]);

        xB = double.tryParse(spB[0]);
        yB = double.tryParse(spB[1]);

        if (xA == null || yA == null || xB == null || yB == null) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Σφάλμα'),
              content: const Text('Τα δεδομένα έχουν λάθος μορφή'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          var xym;
          xym = emprostho([xA, xB], [yA, yB], aEmpVar, bEmpVar);
          textXmEmprostho = 'xm = ' + xym[0].toString();
          textYmEmprostho = 'ym = ' + xym[1].toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        //MaterialApp(
        //home: DefaultTabController(
        //length: 3,
        //child:
        Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Εμπροσθοτομία',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 255, 255, 255), //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 49, 43, 140),
      ),
      body:
          //Δεύτερο
          Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Γωνία α'),
              keyboardType: TextInputType.number,
              onChanged: (value) => aEmprostho = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Γωνία β'),
              keyboardType: TextInputType.number,
              onChanged: (value) => bEmprostho = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'xA,yA'),
              keyboardType: TextInputType.number,
              onChanged: (value) => xAcyA = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'xB,yB'),
              keyboardType: TextInputType.number,
              onChanged: (value) => xBcyB = value,
            ),
          ),
          const SizedBox(
            height: 8,
          ),

          TextButton(
              onPressed: _calculateEmprostho,
              style: ButtonStyle(
                  //elevation: MaterialStateProperty.all(8),
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 49, 43, 140))),
              child: const Text('Υπολογιαμός',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 15.0))),
          // RaisedButton is deprecated and should not be used
          // Use ElevatedButton instead

          // RaisedButton(
          //	 onPressed: _setText,
          //	 child: Text('Submit'),
          //	 elevation: 8,
          // ),
          const SizedBox(
            height: 20,
          ),
          Text(
            textXmEmprostho,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            textYmEmprostho,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          // changes in text
          // are shown here
        ],
      ),
    );
    //),
    //);
  }
}
