import 'package:flutter/material.dart';

void main() {
  runApp(CalApp());
}

class CalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String op = "+";
  String displayExp = "";
  String displayResult = "";
  String currNum = "";
  num prevRes = 0;
  String res = "";
  String prevBtnVal = "";
  bool flag = false; // Set true when first operator button is clicked

  void btnClicked(String btnVal) {
    switch (btnVal) {
      case "C":
        displayResult = "";
        res = "";
        displayExp = "";
        op = "+";
        currNum = "";
        prevRes = 0;
        flag = false;
        break;
      case "+":
      case "-":
      case "/":
      case "x":
      case "%":
        if (prevBtnVal == btnVal || flag == false) break;
        displayExp = displayExp + btnVal;
        if (op == '+') prevRes = prevRes + num.parse(currNum);
        if (op == '-') prevRes = prevRes - num.parse(currNum);
        if (op == 'x') prevRes = prevRes * num.parse(currNum);
        if (op == '/') prevRes = prevRes / num.parse(currNum);
        if (op == '%') prevRes = prevRes % num.parse(currNum);
        currNum = "";
        op = btnVal;
        break;
      case "=":
        displayExp = res;
        break;
      case ".":
        displayExp = displayExp + btnVal;
        currNum = currNum + btnVal;
        res = res + btnVal;
        break;
      default:
        flag = true;
        displayExp = displayExp + btnVal;
        currNum = currNum + btnVal;
        if (op == '+') res = (prevRes + num.parse(currNum)).toString();
        if (op == '-') res = (prevRes - num.parse(currNum)).toString();
        if (op == 'x') res = (prevRes * num.parse(currNum)).toString();
        if (op == '/') res = (prevRes / num.parse(currNum)).toString();
        if (op == '%') res = (prevRes % num.parse(currNum)).toString();
    }
    prevBtnVal = btnVal;
    setState(() {
      displayExp = displayExp;
      displayResult = res;
    });
  }

  Widget buttons(String btnVal, Color btnTextColor) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 18),
      onPressed: () => btnClicked(btnVal),
      splashColor: Colors.cyan[100],
      highlightColor: Colors.cyan[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200.0),
      ),
      child: Text('$btnVal',
          style: TextStyle(
            fontSize: 24.0,
            color: btnTextColor,
          )),
    );
  }

  Widget customRow(String col1, String col2, String col3, String col4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buttons("$col1", Colors.grey[900]),
        buttons("$col2", Colors.grey[900]),
        buttons("$col3", Colors.grey[900]),
        buttons("$col4", Colors.cyan[500]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
            style: TextStyle(color: Colors.cyan),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[300],
                height: 3.5,
              ),
              preferredSize: Size.fromHeight(4.0)),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 8.0),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '$displayExp',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 20.0),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '$displayResult',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Colors.cyan[100], Colors.white],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    stops: [0.0, 1],
                  )),
                  child: Column(
                    children: <Widget>[
                      customRow('C', '%', '<', '/'),
                      customRow('7', '8', '9', 'x'),
                      customRow('4', '5', '6', '-'),
                      customRow('1', '2', '3', '+'),
                      customRow('0', '00', '.', '='),
                    ],
                  )),
            ],
          ),
        ));
  }
}
