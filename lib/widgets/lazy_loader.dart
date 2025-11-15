import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_app/constants/app_constant.dart';
import 'package:task_app/core/utils/snackbar_util.dart';
import 'package:task_app/widgets/empty_state_widget.dart';
import 'package:task_app/widgets/loading_state_widget.dart';

class LazyLoader extends StatefulWidget {
  final int filterCount;
  final int maxCount;
  final Function() onMaxFetch;
  final Function(BuildContext context, int index) itemBuilder;

  const LazyLoader({
    super.key,
    required this.filterCount,
    required this.maxCount,
    required this.onMaxFetch,
    required this.itemBuilder,
  });

  @override
  State<LazyLoader> createState() => _LazyLoaderState();
}

class _LazyLoaderState extends State<LazyLoader> {
  bool _isMaxFetch = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_checkMaxExtent);
  }

  Future<void> _checkMaxExtent() async {
    if (!_isMaxFetch &&
        _scrollController.position.maxScrollExtent ==
            _scrollController.offset) {
      setState(() => _isMaxFetch = true);

      try {
        await Future.delayed(const Duration(milliseconds: 400));

        await widget.onMaxFetch();
      } catch (e) {
        log('Failed to load more items: $e');
        SnackBarUtil.showSnackBar(mes: 'Failed to load more items');
      } finally {
        if (mounted) setState(() => _isMaxFetch = false);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: widget.filterCount <= 0
                ? const Center(child: EmptyStateWidget())
                : ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.filterCount,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(AppConstant.smallPadding * 2),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppConstant.smallPadding + 2),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          widget.itemBuilder(context, index),

                          if (index >= widget.maxCount - 1)
                            const SizedBox(height: kToolbarHeight / 2),
                        ],
                      );
                    },
                  ),
          ),
        ),
        _isMaxFetch
            ? const Positioned(
                bottom: kToolbarHeight / 2,
                child: LoadingStateWidget(),
              )
            : Container(),
      ],
    );
  }
}
