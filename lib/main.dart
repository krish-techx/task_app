import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/constants/app_constant.dart';
import 'package:task_app/constants/app_theme.dart';
import 'package:task_app/core/routes/app_routes.dart';
import 'package:task_app/pages/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstant.designSize,
      builder: (_, __) => MaterialApp(
        title: 'Task App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getThemeData(),
        scaffoldMessengerKey: messengerKey,
        home: const OnboardingPage(),
        onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
      ),
    );
  }
}
