import "package:flutter/material.dart";
import 'package:topo/deutero.dart';
import 'package:topo/emprostho.dart';
import 'package:topo/opistho.dart';
import 'package:topo/proto.dart';
import 'package:topo/odeusi.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('Topo',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
                backgroundColor: Color.fromARGB(255, 49, 43, 140),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // The action to perform when the button is pressed
                      _showInfoDialog(context);
                    },
                    child: const Text(
                      'Πληροφορίες',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                  padding: const EdgeInsets.all(30),
                  child: 
                  SingleChildScrollView(child:
                  Column(children: <Widget>[
                    //Expanded(
                        //child: 
                        //GridView.count(
                      //crossAxisCount: 2, // This sets the number of columns to 2
                      //crossAxisSpacing:
                      //    30.0, // Horizontal spacing between items
                      //mainAxisSpacing: 30.0, // Vertical spacing between items
                      //children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                        child:
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const protoApp()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 49, 43, 140)),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(100, 100)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15.0), // Adjust the radius for more or less roundedness
                                ),
                              ),
                            ),
                            child: const Text(
                              'Πρώτο \nΘεμελιώδες',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 10.0),
                              textAlign: TextAlign.center,
                            )), ),

                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child:

                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const deuteroApp()),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 49, 43, 140)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(100, 100)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        15.0), // Adjust the radius for more or less roundedness
                                  ),
                                )),
                            child: const Text(
                              'Δεύτερο\n Θεμελιώδες',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 10.0),
                              textAlign: TextAlign.center,
                            )), ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const emprosthoApp()),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 49, 43, 140)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(100, 100)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15.0), // Adjust the radius for more or less roundedness
                                ))),
                            child: const Text(
                              'Εμπροσθοτομία',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 10.0),
                              textAlign: TextAlign.center,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const opisthoApp()),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 49, 43, 140)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(100, 100)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15.0), // Adjust the radius for more or less roundedness
                                ))),
                            child: const Text(
                              'Οπισθοτομία',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 10.0),
                              textAlign: TextAlign.center,
                            )),

                        const SizedBox(
                        height: 10,
                        ),
                        Center(
                        child:

                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => odeusiApp()),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 49, 43, 140)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(100, 100)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15.0), // Adjust the radius for more or less roundedness
                                ))),
                            child: const Text(
                              'Επίλυση\n Όδευσης',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 10.0),
                              textAlign: TextAlign.center,
                            )), ),
                      ],
                    ))),
                    
                  )),
            );
  }
}

void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Πληροφορίες εφαρμογής',style: TextStyle(fontSize: 20),),
        content: const Column(
          // The mainAxisSize property is important to prevent the Column from taking
          // up the full height of the dialog.
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            //const Text('This is the information message.'),
            const Text(
              "Χρησιμοποιήστε την τελεία (.) για τον διαχωρισμό των δεκαδικών ψηφίων και όχι το κόμμα (,)!",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Creator: Nikos Ververidis\nApp developed using Flutter framework",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Κλείσιμο'),
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
