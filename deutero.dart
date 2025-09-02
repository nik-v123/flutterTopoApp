import 'package:flutter/material.dart';
import 'dart:math';

class deuteroApp extends StatefulWidget {
  const deuteroApp({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _deuteroState createState() => _deuteroState();
}

class _deuteroState extends State<deuteroApp> {
  String x_arx_txt = '';
  String y_arx_txt = '';
  String x_tel_txt = '';
  String y_tel_txt = '';

  String textD = "No Value Entered";
  String textG = "No Value Entered";

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

  void _calculateSecond() {
    setState(() {
      var x_arx;
      var y_arx;
      var x_tel;
      var y_tel;

      x_arx = double.tryParse(x_arx_txt);
      y_arx = double.tryParse(y_arx_txt);
      x_tel = double.tryParse(x_tel_txt);
      y_tel = double.tryParse(y_tel_txt);

      if (x_arx == null || y_arx == null || x_tel == null || y_tel == null) {
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
        var DcG;
        DcG = deutero(x_arx, y_arx, x_tel, y_tel);

        textD = 'D = ' + DcG[0].toString();
        textG = 'G = ' + DcG[1].toString();
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
        title: const Text('Δεύτερο Θεμελιώδες',
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
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'x αρχικό'),
              keyboardType: TextInputType.number,
              onChanged: (value) => x_arx_txt = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'y αρχικό'),
              keyboardType: TextInputType.number,
              onChanged: (value) => y_arx_txt = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'x τελίκό'),
              keyboardType: TextInputType.number,
              onChanged: (value) => x_tel_txt = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'y τελικό'),
              keyboardType: TextInputType.number,
              onChanged: (value) => y_tel_txt = value,
            ),
          ),
          const SizedBox(
            height: 8,
          ),

          TextButton(
              onPressed: _calculateSecond,
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
            textD,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            textG,
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
