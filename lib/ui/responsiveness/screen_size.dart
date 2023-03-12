import 'package:flutter/material.dart';


double screenHeight(BuildContext context, double height){
  return MediaQuery.of(context).size.height *
      (height / 926);
}

double screenWidth(BuildContext context, double width){
  return MediaQuery.of(context).size.width *
      (width / 428);
}