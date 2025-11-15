import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/slogans.dart';
import 'package:task_app/core/enums/page_state.dart';
import 'package:task_app/pages/task2/task2_view.dart';
import 'package:task_app/providers/task2_provider.dart';
import 'package:task_app/widgets/empty_state_widget.dart';
import 'package:task_app/widgets/error_state_widget.dart';
import 'package:task_app/widgets/loading_state_widget.dart';

class Task2Page extends StatelessWidget {
  const Task2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Task2Provider>(
        builder: (_, provider, __) {
          if (provider.pageState == PageState.initial ||
              provider.pageState == PageState.loading) {
            return const LoadingStateWidget();
          } else if (provider.pageState == PageState.empty) {
            return const EmptyStateWidget();
          } else if (provider.pageState == PageState.success) {
            return const Task2View();
          } else {
            return ErrorStateWidget(
              errorMsg: provider.errorMessage ?? Slogans.somethingWentWrong,
            );
          }
        },
      ),
    );
  }
}
