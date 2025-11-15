import 'package:flutter/material.dart';
import 'package:task_app/constants/app_constant.dart';
import 'package:task_app/core/routes/app_routes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _onAction(context, 0),
                child: const Text('Task 1'),
              ),
              const SizedBox(height: AppConstant.smallPadding),
              ElevatedButton(
                onPressed: () => _onAction(context, 1),
                child: const Text('Task 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAction(BuildContext context, int action) {
    final navigator = Navigator.of(context);
    switch (action) {
      case 0:
        navigator.pushNamed(AppRoutes.task1);
      case 1:
        navigator.pushNamedAndRemoveUntil(AppRoutes.task2, (route) => false);
    }
  }
}
