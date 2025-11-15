import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorMsg;

  const ErrorStateWidget({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMsg,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
