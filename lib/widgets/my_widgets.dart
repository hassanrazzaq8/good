import 'package:flutter/material.dart';

import '../constant/colors.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton(
      {Key? key, required this.child, required this.onButtonPressed})
      : super(key: key);
  final Widget child;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
            // gradient: const LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color.fromARGB(255, 190, 186, 186),
            //     Color.fromARGB(255, 52, 55, 61)
            //
            //     //add more colors
            //   ],
            // ),
          color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: const <BoxShadow>[
            //   BoxShadow(
            //       offset: Offset(2, 5),
            //       color: Color.fromARGB(255, 141, 136, 136), //shadow for button
            //       blurRadius: 5) //blur radius of shadow
            // ]
        ),
        child: ElevatedButton(
          child: child,
          // if VoidCallback function Used Instead of Function then use onPressed: function_Name
          onPressed: () => onButtonPressed(),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
            fixedSize: Size(width, 50),
          ),
        ),
      ),
    );
  }
}
