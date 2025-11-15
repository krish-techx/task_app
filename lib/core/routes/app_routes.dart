import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/modals/product_modal.dart';
import 'package:task_app/pages/onboarding_page.dart';
import 'package:task_app/pages/page_not_found.dart';
import 'package:task_app/pages/product_details_page.dart';
import 'package:task_app/pages/task1/task1_page.dart';
import 'package:task_app/pages/task2/task2_page.dart';
import 'package:task_app/providers/task1_provider.dart';
import 'package:task_app/providers/task2_provider.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String task1 = '/task1';
  static const String task2 = '/task2';
  static const String productDetails = '/product_details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case task1:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => Task1Provider(),
            child: const Task1Page(),
          ),
        );
      case task2:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => Task2Provider(),
            child: const Task2Page(),
          ),
        );
      case productDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final ProductModal modal = args['modal'];
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(product: modal),
        );
      default:
        return MaterialPageRoute(builder: (_) => const PageNotFound());
    }
  }
}
