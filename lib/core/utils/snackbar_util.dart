import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/main.dart';

class SnackBarUtil {
  static void showSnackBar({required String mes}) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 4000),
      content: Row(
        children: [
          Expanded(
            child: Text(
              mes,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.black,
    );

    if (messengerKey.currentState == null) {
      throw StateError('Null messenger state found!');
    }

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
