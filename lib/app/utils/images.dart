

import 'package:flutter/material.dart';

Widget imageFromSource(String source,{double size=52}) {
  if (source.contains('http')) {
    return Image.network(
      source,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  } else if (source.contains('asset')) {
    return Image.asset(
      source,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
  return Icon(Icons.image , size: size,);
}