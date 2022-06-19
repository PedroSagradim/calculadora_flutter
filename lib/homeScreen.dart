import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calculator_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //VARIAVEIS
  late double firstnum;
  late double secondnum;
  int count = 0;

  late String res;
  late String operation;
  String textDisplay = '';
  String historyDisplay = '';

  bool fezConta = false;

  List<String> history = [];

  void btnClick(String btnStr) {
    print(btnStr);

    if (btnStr == 'C') {
      textDisplay = '';
      firstnum = 0;
      secondnum = 0;
      res = '';
    } else if (btnStr == 'CE') {
      textDisplay = '';
      firstnum = 0;
      secondnum = 0;
      res = '';
      historyDisplay = '';
    } else if (btnStr == '+' ||
        btnStr == '-' ||
        btnStr == 'X' ||
        btnStr == '/' ||
        btnStr == '<') {
      //math error se textdisplay estiver vazio
      if (textDisplay != '') {
        firstnum = double.parse(textDisplay);
        res = '';
        operation = btnStr;
      } else {
        res = 'MATH ERROR';
      }
    } else if (btnStr == '=') {
      //verifica para somar o resultado ao inves do numero da tela
      if (!fezConta) {
        secondnum = double.parse(textDisplay);
      } else {
        firstnum = double.parse(res);
      }

      //switch case de operacao para definir o valor
      switch (operation) {
        case '+':
          res = (firstnum + secondnum).toString();
          break;
        case '-':
          res = (firstnum - secondnum).toString();
          break;
        case 'X':
          res = (firstnum * secondnum).toString();
          break;
        case '/':
          res = (firstnum / secondnum).toString();
          break;
        case '<':
          res = pow(firstnum, secondnum).toString();
          break;
      }

      /*
      se ele tiver + de 1 casa decimal, vai retorna com precisao, usando o proprio count
      como quantidade de numeros, limitado entre (2 e 7) -- CLAMP
      senao, vai verificar se res < 15, se sim, vai retornar o valor 'inteiro' (sem casas decimais)
      senao ele vai retornar com precisao, limitado em 7
      */
      res = countCasas(double.parse(res)) > 0
          ? double.parse(res).toStringAsPrecision(countCasas(double.parse(res)).clamp(2, 7))
          : res.length < 15
              ? double.parse(res).toStringAsFixed(0)
              : double.parse(res).toStringAsPrecision(7);

      history.add(
          firstnum.toString() + operation + secondnum.toString() + '=' + res);
      count++;

      historyDisplay =
          firstnum.toString() + operation + secondnum.toString() + '=';

      fezConta = true;

      //converte para negativo, math error se resultado for ''
    } else if (btnStr == '+/-') {
      res = res != ''
          ? (double.parse(res) * -1).toStringAsFixed(0)
          : 'MATH ERROR';
    } else {
      if (!fezConta) {
        res = double.parse(textDisplay + btnStr).toStringAsFixed(0);
      } else {
        res = double.parse(btnStr).toStringAsFixed(0);
        fezConta = false;
      }
    }

    setState(() {
      textDisplay = res;
    });
  }

  int countCasas(double dNum) {
    int tenMultiple = 10;
    int count = 0;
    double manipluatedNum = dNum;

    while (manipluatedNum.ceil() != manipluatedNum.floor()) {
      manipluatedNum = dNum * tenMultiple;
      count = count + 1;
      tenMultiple = tenMultiple * 10;
    }

    return count;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Colors.blueAccent,
        child: ListView.builder(
            itemCount: history.length + 1,
            itemBuilder: (context, index) {
              if (index < history.length) {
                return ListTile(
                    title: Text(history[index],
                        style: GoogleFonts.rubik(
                            fontSize: 22, color: Colors.white)));
              } else {
                return ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      history.clear();
                      count = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                  icon: Icon(Icons.delete),
                  label: Text('Clear History?'),
                );
              }
            }),
      ),
      appBar: AppBar(backgroundColor: Colors.blueAccent, actions: [
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ]),
      backgroundColor: Colors.blue[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment(1.0, 1.0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 1),
              child: Text(
                historyDisplay,
                style: GoogleFonts.rubik(color: Colors.white30, fontSize: 24),
              ),
            ),
          ),
          Container(
            alignment: Alignment(1.0, 1.0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 1, 12, 12),
              child: Text(
                textDisplay,
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 45),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calculatorButton(text: 'CE', callback: btnClick, fontSize: 20),
              calculatorButton(text: 'C', callback: btnClick),
              calculatorButton(
                  text: '<',
                  callback: btnClick,
                  colorButton: Colors.amberAccent),
              calculatorButton(
                  text: '/',
                  callback: btnClick,
                  colorButton: Colors.amberAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calculatorButton(text: '9', callback: btnClick),
              calculatorButton(text: '8', callback: btnClick),
              calculatorButton(text: '7', callback: btnClick),
              calculatorButton(
                  text: 'X',
                  callback: btnClick,
                  colorButton: Colors.amberAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calculatorButton(text: '6', callback: btnClick),
              calculatorButton(text: '5', callback: btnClick),
              calculatorButton(text: '4', callback: btnClick),
              calculatorButton(
                  text: '-',
                  callback: btnClick,
                  colorButton: Colors.amberAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calculatorButton(text: '3', callback: btnClick),
              calculatorButton(text: '2', callback: btnClick),
              calculatorButton(text: '1', callback: btnClick),
              calculatorButton(
                  text: '+',
                  callback: btnClick,
                  colorButton: Colors.amberAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calculatorButton(
                text: '+/-',
                callback: btnClick,
                fontSize: 20,
              ),
              calculatorButton(text: '0', callback: btnClick),
              calculatorButton(text: '00', callback: btnClick),
              calculatorButton(
                  text: '=',
                  callback: btnClick,
                  colorButton: Colors.amberAccent),
            ],
          ),
        ],
      ),
    );
  }
}
