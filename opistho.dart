import 'package:flutter/material.dart';
import 'dart:math';

class opisthoApp extends StatefulWidget {
  const opisthoApp({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _opisthoState createState() => _opisthoState();
}

class _opisthoState extends State<opisthoApp> {
  String a = '';

  String d = '';

  String x0cy0 = '';
  String x1cy1 = '';
  String x2cy2 = '';

  String textXmOpistho = "No Value Entered";
  String textYmOpistho = "No Value Entered";

  double grad2rad(double g) {
    return g * pi / 200.0;
  }

  double cot(double grads) {
    return 1 / tan(grad2rad(grads));
  }

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

  List<double> opistho(List<dynamic> x, List<dynamic> y, double d, double a) {
    double b = 400.0 - a - d;

    //print('a,d,b: $a, $d, $b');

    List<double> d12G12 = deutero(x[0], y[0], x[1], y[1]);
    List<double> d23G23 = deutero(x[1], y[1], x[2], y[2]);
    List<double> d31G31 = deutero(x[2], y[2], x[0], y[0]);

    double G12 = convToZF(d12G12[1]);
    double G21 = invDirection(G12);
    //print('G12: $G12, G21: $G21');

    double G23 = convToZF(d23G23[1]);
    double G32 = invDirection(G23);
    //print('G23: $G23, G32: $G32');

    double G31 = convToZF(d31G31[1]);
    double G13 = invDirection(G31);
    //print('G31: $G31, G13: $G13');

    double A = convToZF(G13 - G21 - 200.0);
    double B = convToZF(G21 - G32 - 200.0);
    double D = convToZF(G32 - G13 - 200.0);

    //print('A,B,D: $A, $B, $D');
    //print('A+B+D: ${A + B + D}');

    double K1 = 1 / (cot(A) - cot(a));
    double K2 = 1 / (cot(B) - cot(b));
    double K3 = 1 / (cot(D) - cot(d));
    double SK = K1 + K2 + K3;

    //String kstr = 'K1,K2,K3: ';
    //for (double i in [K1, K2, K3]) {
    //  kstr += '$i,';
    //}
    //print('K1,K2,K3: $K1, $K2, $K3');

    double xm = (K1 * x[0] + K2 * x[1] + K3 * x[2]) / SK;
    double ym = (K1 * y[0] + K2 * y[1] + K3 * y[2]) / SK;

    //String strprint = 'XM=${xm.toStringAsFixed(5)},YM=${ym.toStringAsFixed(5)}';
    //print(strprint);

    return [xm, ym];
  }

  void _calculateOpistho() {
    setState(() {
      var aVar;
      var dVar;
      var sp1;
      var sp2;
      var sp3;
      var xmym = [];
      var x = [];
      var y = [];

      bool xyIsNull = false;

      print(x.length);

      sp1 = x0cy0.split(',');
      print(sp1);

      print(sp1);

      sp2 = x1cy1.split(',');

      print(sp2);

      sp3 = x2cy2.split(',');

      print(sp3);

      aVar = double.tryParse(a);
      dVar = double.tryParse(d);

      if (sp1.length != 2) {
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
      } else if (sp2.length != 2) {
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
      } else if (sp3.length != 2) {
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
      } else if (aVar == null || dVar == null) {
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
        //sum = _add(aVar,bVar);
        x.add(double.tryParse(sp1[0]));
        y.add(double.tryParse(sp1[1]));

        x.add(double.tryParse(sp2[0]));
        y.add(double.tryParse(sp2[1]));

        x.add(double.tryParse(sp3[0]));
        y.add(double.tryParse(sp3[1]));

        for (var i = 0; i < 3; i++) {
          if (x[i] == null || y[i] == null) {
            xyIsNull = true;
          }
        }

        if (xyIsNull == true) {
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
          xmym = opistho(x, y, dVar, aVar);
          textXmOpistho = 'xm = ' + xmym[0].toString();
          textYmOpistho = 'ym = ' + xmym[1].toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return //MaterialApp(
        //home: DefaultTabController(
        //length: 3,
        //child:
        Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Οπισθοτομία',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 255, 255, 255), //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 49, 43, 140),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Γωνία α'),
              keyboardType: TextInputType.number,
              onChanged: (value) => a = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Γωνία δ'),
              keyboardType: TextInputType.number,
              onChanged: (value) => d = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'x0,y0'),
              keyboardType: TextInputType.number,
              onChanged: (value) => x0cy0 = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'x1,y1'),
              keyboardType: TextInputType.number,
              onChanged: (value) => x1cy1 = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'x2,y2'),
              keyboardType: TextInputType.number,
              onChanged: (value) => x2cy2 = value,
            ),
          ),
          const SizedBox(
            height: 8,
          ),

          TextButton(
              onPressed: _calculateOpistho,
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
            textXmOpistho,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            textYmOpistho,
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
