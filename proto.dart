import 'package:flutter/material.dart';
import 'dart:math';

class protoApp extends StatefulWidget {
  const protoApp({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _protoState createState() => _protoState();
}

class _protoState extends State<protoApp> {
  String x_arx_txt = '';
  String y_arx_txt = '';
  String stxt = '';
  String gtxt = '';

  String textXtel = "No Value Entered";
  String textYtel = "No Value Entered";

  double rad2grad(double r) {
    return r * 200.0 / pi;
  }

  double grad2rad(double g) {
    return g * pi / 200.0;
  }

  List<double> proto(double xarx, double yarx, double s, double g) {
    g = grad2rad(g);

    double xtel = 0;
    double ytel = 0;

    xtel = xarx + s*sin(g);
    ytel = yarx + s*cos(g);

    return [xtel,ytel];
  }

  void _calculateSecond() {
    setState(() {
      var x_arx;
      var y_arx;
      var g;
      var s;

      x_arx = double.tryParse(x_arx_txt);
      y_arx = double.tryParse(y_arx_txt);
      g = double.tryParse(gtxt);
      s = double.tryParse(stxt);

      if (x_arx == null || y_arx == null || g == null || s == null) {
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
        var xtelCytel;
        xtelCytel = proto(x_arx, y_arx, s, g);

        textXtel = 'x τελικό = ' + xtelCytel[0].toString();
        textYtel = 'y τελικό = ' + xtelCytel[1].toString();
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
        title: const Text('Πρώτο Θεμελιώδες',
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
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Γωνία διεύθυνσης G'),
              keyboardType: TextInputType.number,
              onChanged: (value) => gtxt = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Απόσταση S'),
              keyboardType: TextInputType.number,
              onChanged: (value) => stxt = value,
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
            textXtel,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            textYtel,
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
