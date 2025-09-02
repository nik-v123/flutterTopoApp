import 'package:flutter/material.dart';
import 'dart:math';

//void main() => runApp(myDataTable());



class odeusiApp extends StatefulWidget {
  @override
  _myOdeusiState createState() => _myOdeusiState();
}

class _myOdeusiState extends State<odeusiApp> {
  List<List<double>> dataVal = [];
  List<List<String>> data = [
    ["T1", "270.1350", "", "112.43","","","281.73","5818.96",""],
    ["T2", "187.4280", "", "137.12","","","1248.42","7143.24",""],
    ["Σ3", "208.5720", "", "124.19","","","","",""],
    ["Σ4", "189.1140", "", "119.79","","","","",""],
    ["Σ5", "205.8050", "", "127.16","","","","",""],
    ["Σ6", "118.0180", "", "","","","","",""],
    ["Τ7", "", "", "","","","1866.37","7124.23",""],
    ["Τ8", "", "", "","","","2332.15","8626.04",""],
    ["Σ", "", "", "","","","","",""],
    ["Σ", "", "", "","","","","",""],
    ["Σ", "", "", "","","","","",""],
    ["Σ", "", "", "","","","","",""],
    ["Σ", "", "", "","","","","",""],
    ["Σ", "", "", "","","","","",""],
    ["Σ", "", "", "","","","","",""],
  ];

  List<TextEditingController> pointControllers = [];
  List<TextEditingController> thControllers = [];
  List<TextEditingController> sControllers = [];
  List<TextEditingController> gControllers = [];
  List<TextEditingController> dxControllers = [];
  List<TextEditingController> dyControllers = [];
  List<TextEditingController> xControllers = [];
  List<TextEditingController> yControllers = [];
  List<TextEditingController> thCorControllers = [];
  


  //Variables
  String txtW = "Σφάλματα: ";

  //Functions
  List<double> convert2double(myList){
    List<double>myDoubleList = [];
      for (var el in myList){
        myDoubleList.add(double.parse(el));
      }
      return myDoubleList;
    }


double grad2rad(double g) {
  return g * pi / 200;
}

double rad2grad(double r) {
  return 200.0 * r / pi;
}

List<double> first(double x1, double y1, double s12, double g12) {
  double x2 = x1 + s12 * sin(grad2rad(g12));
  double y2 = y1 + s12 * cos(grad2rad(g12));
  return [x2, y2];
}

List<double> second(double x1, double y1, double x2, double y2) {
  double dx = x2 - x1;
  double dy = y2 - y1;
  double a = rad2grad(atan(dx.abs() / dy.abs()));
  double s12 = (pow(dx, 2) + pow(dy, 2)).toDouble();
  double g12;
  if (dx > 0) {
    if (dy > 0) {
      g12 = a;
    } else if (dy == 0) {
      g12 = 100;
    } else {
      g12 = 200 - a;
    }
  } else if (dx < 0) {
    if (dy > 0) {
      g12 = 400 - a;
    } else if (dy == 0) {
      g12 = 300;
    } else {
      g12 = 200 + a;
    }
  } else {
    if (dy > 0) {
      g12 = 0;
    } else if (dy == 0) {
      g12 = -999;
    } else {
      g12 = 200;
    }
  }
  return [g12, s12];
}

double conv2z4(double g) {
  double tempG = g;
  while (tempG >= 400) {
    tempG -= 400;
  }
  while (tempG <= 0) {
    tempG += 400;
  }
  return tempG;
}

List<double> third(double garx, List<double> thlasis) {
  List<double> gNew = [];
  double thNew = garx;
  for (double th in thlasis) {
    thNew += th + 200.0;
    gNew.add(conv2z4(thNew));
  }
  return gNew;
}

List<dynamic> calc(List<double> th, List<double> s, List<double> xGiven, List<double> yGiven) {
  print("x_given");
  print(xGiven);
  print("y_given");
  print(yGiven);
  print("thlasis");
  print(th);
  print("s");
  print(s);

  List<double> gArxS12 = second(xGiven[0], yGiven[0], xGiven[1], yGiven[1]);
  double gArx = gArxS12[0];
  double s12 = gArxS12[1];

  print("garx=$gArx");
  print("s12=$s12");

  List<double> gAllInit = third(gArx, th);

  print("g_all_init=$gAllInit");

  List<double> gPrepeiS34 = second(xGiven[2], yGiven[2], xGiven[3], yGiven[3]);
  double gPrepei = gPrepeiS34[0];

  print("gPrepei=$gPrepei");

  double dg = gPrepei - gAllInit.last; //g_all_init[-1]=gEinai

  double dgi = dg / th.length;

  print("dg=$dg dgi=$dgi");

  List<double> thCor = [];

  // Correction of direction angles
  for (double t in th) {
    thCor.add(t + dgi);
  }

  print("thCor=$thCor");

  List<double> gAllCor = third(gArx, thCor); // all corrected angles in a list

  print("g_all_cor=$gAllCor");

  // SO FAR SO GOOD

  // proto for many

  List<double> dxList = [];
  List<double> dyList = [];

  for (int i = 0; i < s.length; i++) {
    List<double> dxyi = first(0, 0, s[i], gAllCor[i]);
    dxList.add(dxyi[0]);
    dyList.add(dxyi[1]);
  }

  print("Dx=$dxList");
  print("Dy=$dyList");

  // xPrepei yPrepei

  double sDxEinai = dxList.reduce((a, b) => a + b); //?
  double sDyEinai = dyList.reduce((a, b) => a + b);

  print("SDxEinai=$sDxEinai SDyEinai=$sDyEinai");

  // SDxPrepei SDyPrepei

  double sDxPrepei = xGiven[xGiven.length-2] - xGiven[1]; //?
  double sDyPrepei = yGiven[yGiven.length-2] - yGiven[1];

  print("-----------------");
  print(xGiven[xGiven.length-2]);
  print(yGiven[yGiven.length-2]);
  print(xGiven[1]);
  print(yGiven[1]);
  print("------------------");

  print("SDxPrepei=$sDxPrepei SDyPrepei=$sDyPrepei");

  // calculation of linear corrections (Γραμμικές διορθώσεις)
  double wx = sDxPrepei - sDxEinai;
  double wy = sDyPrepei - sDyEinai;

  print("wx=$wx wy=$wy");

  // diorthosi grammikou sfalmatos

  double wxS = wx / s.reduce((a, b) => a + b); // wrong??
  double wyS = wy / s.reduce((a, b) => a + b);

  print("wxS=$wxS wyS=$wyS");

  // υπολογισμός της διόρθωσης για κάθε Δχ ή Δψ
  List<double> dx = [];
  List<double> dy = [];
  for (int i = 0; i < s.length; i++) {
    dx.add(wxS * s[i]);
    dy.add(wyS * s[i]);
  }

  print("dx=$dx dy=$dy");

  // υπολογισμός των διορθωμένων Dx και Dy

  List<double> dxCor = [];
  List<double> dyCor = [];
  for (int i = 0; i < dxList.length; i++) {
    dxCor.add(dxList[i] + dx[i]);
    dyCor.add(dyList[i] + dy[i]);
  }

  print("DxCor=$dxCor DyCor=$dyCor");

  List<double> xCor = [];
  List<double> yCor = [];
  double x = xGiven[1];
  double y = yGiven[1];
  for (int i = 0; i < dxCor.length; i++) {
    x += dxCor[i];
    y += dyCor[i];
    xCor.add(x);
    yCor.add(y);
  }

  gAllCor.insert(0,gArx);
  return [gAllCor, xCor, yCor,dxCor,dyCor,thCor,[dg,dgi,wx,wy]];
}

List<double> dValues(int i){
      List<String> dvtxt = data.map((innerList) => innerList[i]).toList();
      dvtxt.removeWhere((item) => item == "");
      List<double> dv = convert2double(dvtxt);
      return dv;
    }
  
  
  void solve(){
    setState((){
    print(data);
    print("ok1");
    print("ok2");
    
    List<double> g = [];
    List<double> x = [];
    List<double> y = [];
    List<double> dx = [];
    List<double> dy = [];
    List<double> thCor = [];
    List<double> w = [];

    List<double> dv1 = dValues(1);
    List<double> dv3 = dValues(3);
    List<double> dv6 = dValues(6);
    List<double> dv7 = dValues(7);

    print("ok3");
    
    [g,x,y,dx,dy,thCor,w]=calc(dv1,dv3,dv6,dv7);

    print("g=");
    print(g);
    print("x=");
    print(x);
    print("y=");
    print(y);
    
    for (var i=0; i<g.length; i++){
      gControllers[i].text = g[i].toString();
    }
    for (var i=0; i<x.length-1; i++){
      xControllers[i+2].text = x[i].toString();
    }
    for (var i=0; i<y.length-1; i++){
      yControllers[i+2].text = y[i].toString();
    }
    for (var i=0; i<dx.length; i++){
      dxControllers[i].text = dx[i].toString();
    }
    for (var i=0; i<dy.length; i++){
      dyControllers[i].text = dy[i].toString();
    }
    for (var i=0; i<thCor.length; i++){
      thCorControllers[i].text = thCor[i].toString();
    }
    txtW = "Σφάλματα: wβ="+w[0].toString()+"  wβi="+w[1].toString()+"  wx="+w[2].toString()+"  wy="+w[3].toString();
    }
    );
  }

  void clear(){
    for (var dc in pointControllers){
      dc.text = "";
    }
    for (var dc in sControllers){
      dc.text = "";
    }
    for (var dc in thControllers){
      dc.text = "";
    }
    for (var dc in gControllers){
      dc.text = "";
    }
    for (var dc in xControllers){
      dc.text = "";
    }
    for (var dc in yControllers){
      dc.text = "";
    }
    for (var dc in dyControllers){
      dc.text = "";
    }
    for (var dc in dxControllers){
      dc.text = "";
    }
    for (var dc in thCorControllers){
      dc.text = "";
    }
  }
  

  @override
  void initState() {
    super.initState();
    for (var row in data) {
      pointControllers.add(TextEditingController(text: row[0]));
      thControllers.add(TextEditingController(text: row[1]));
      gControllers.add(TextEditingController(text: row[2]));
      sControllers.add(TextEditingController(text: row[3]));
      dxControllers.add(TextEditingController(text: row[4]));
      dyControllers.add(TextEditingController(text: row[5]));
      xControllers.add(TextEditingController(text: row[6]));
      yControllers.add(TextEditingController(text: row[7]));
      thCorControllers.add(TextEditingController(text: row[8]));
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return //MaterialApp(
      //debugShowCheckedModeBanner: false,
      //theme: ThemeData.light(),
      //home: 
      Scaffold(
        appBar: AppBar(
          title: Text('Επίλυση Όδευσης',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),)),
          iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 255, 255, 255), //change your color here
        ),
          backgroundColor: Color.fromARGB(255, 49, 43, 140),
          actions:[
            TextButton(
              onPressed: solve,
              style: ButtonStyle(
                  //elevation: MaterialStateProperty.all(8),
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255))),
              child: const Text('Υπολογιαμός',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12.0))),
              const SizedBox(
            width: 8,
          ),
              TextButton(
              onPressed: clear,
              style: ButtonStyle(
                  //elevation: MaterialStateProperty.all(8),
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 248, 117, 117))),
              child: const Text('Καθαρισμός',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12.0))),
                  const SizedBox(
            width: 8,
          ),
          ]
        ),
        body: 
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
        Column(
          children:[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Σημείο')),
              DataColumn(label: Text('β (grad)')),
              DataColumn(label: Text('G (grad)')),
              DataColumn(label: Text('S (m)')),
              DataColumn(label: Text('Δx (m)')),
              DataColumn(label: Text('Δy (m)')),
              DataColumn(label: Text('X (m)')),
              DataColumn(label: Text('Y (m)')),
              DataColumn(label: Text('β Διόρθ. (grad)')),
            ],
            rows: List.generate(
              data.length,
              (index) => DataRow(
                cells: [
                  DataCell(
                    TextField(
                      controller: pointControllers[index],
                      onChanged: (value) {
                        data[index][0] = value;
                      },
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: thControllers[index],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[index][1] = value;
                      },
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: gControllers[index],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[index][2] = value;
                      },
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: sControllers[index],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[index][3] = value;
                      },
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: dxControllers[index],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[index][4] = value;
                      },
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: dyControllers[index],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[index][5] = value;
                      },
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: xControllers[index],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[index][6] = value;
                      },
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: yControllers[index],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[index][7] = value;
                      },
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: thCorControllers[index],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[index][8] = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        ),
        const SizedBox(
            height: 30,
          ),
        Text(
            txtW,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
      ]
      
      ),
        )
    )
    //)
    ;
  }
}