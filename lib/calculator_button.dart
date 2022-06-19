import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class calculatorButton extends StatelessWidget {
  final String text;
  final Function callback;
  final Color colorButton;
  final double fontSize;

  const calculatorButton({
    required this.text,
    required this.callback,
    this.colorButton = Colors.blueAccent,
    this.fontSize = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: 70,
        height: 70,
        child: ElevatedButton(
          onPressed: (){callback(text);},
          child: Text(text,style:GoogleFonts.rubik(fontSize: fontSize,color: Colors.grey[900])),
          style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
              backgroundColor: MaterialStateProperty.all<Color>(colorButton)
          ),
        ),
      ),
    );
  }
}
