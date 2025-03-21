import 'package:chat/constants.dart';
import 'package:flutter/material.dart';

OutlineInputBorder inputDecoration() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: kPrimaryColor, width: 2),
    borderRadius: BorderRadius.circular(35),
  );
}
