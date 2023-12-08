import 'package:flutter/material.dart';
import 'package:we_hire/src/constants/colors.dart';

final ButtonStyle buttomPrimary = ElevatedButton.styleFrom(
    minimumSize: Size(327, 50),
    primary: tBottomNavigation,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))));
