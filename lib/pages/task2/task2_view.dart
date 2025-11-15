import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/app_constant.dart';
import 'package:task_app/core/extentions/context_extension.dart';
import 'package:task_app/providers/task2_provider.dart';
import 'package:task_app/widgets/task2_product_card.dart';

class Task2View extends StatefulWidget {
  const Task2View({super.key});

  @override
  State<Task2View> createState() => _Task2ViewState();
}

class _Task2ViewState extends State<Task2View> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey _headerKey = GlobalKey();
  double _expandedHeight = 200;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          _headerKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        setState(() {
          _expandedHeight = renderBox.size.height;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Task2Provider>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [
            // App bar
            SliverAppBar(
              pinned: true,
              floating: false,
              backgroundColor: AppColors.primary,
              expandedHeight: _expandedHeight,
              flexibleSpace: LayoutBuilder(
                key: _headerKey,
                builder: (ctx, constraints) {
                  final minHeight =
                      kToolbarHeight + MediaQuery.of(ctx).padding.top;
                  final maxHeight = 180.0;

                  final scale =
                      (constraints.maxHeight - minHeight) /
                      (maxHeight - minHeight);
                  final showWelcome = scale > 0.3;
                  final showSearch = scale > 0.8;

                  return Padding(
                    padding: const EdgeInsets.only(
                      top: AppConstant.smallPadding * 2,
                      left: AppConstant.smallPadding * 2,
                      right: AppConstant.smallPadding * 2,
                    ),
                    child: Container(
                      height: context.height,
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                // Avatar
                                Transform.scale(
                                  scale: scale >= 1 ? 1 : 0.8 + 0.6 * scale,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.outline,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.highlight,
                                        width: 6,
                                      ),
                                    ),
                                    child: const CircleAvatar(
                                      radius: 24,
                                      backgroundImage: NetworkImage(
                                        'https://randomuser.me/api/portraits/men/1.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: AppConstant.smallPadding * 2,
                                ),

                                // Welcome
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (showWelcome)
                                        Text(
                                          'Good Morning!',
                                          style: TextStyle(
                                            color: AppColors.white.withValues(
                                              alpha: 0.8,
                                            ),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),

                                      if (showWelcome)
                                        const Text(
                                          'Arun Kumar, 👋',
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                // Notification
                                Transform.scale(
                                  scale: scale >= 1 ? 1 : 0.8 + 0.6 * scale,
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                      AppConstant.smallPadding,
                                    ),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.tint,
                                    ),
                                    child: const Icon(
                                      Icons.notifications_outlined,
                                      color: AppColors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: AppConstant.defaultPadding + 4,
                            ),

                            // Search
                            if (showSearch)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppConstant.smallPadding + 4,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: AppConstant.smallPadding,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                    AppConstant.defaultPadding * 2,
                                  ),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: AppConstant.smallRadius / 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: AppConstant.defaultPadding / 2,
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 0,
                                      minHeight: 0,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppConstant.defaultPadding + 4),
                    topRight: Radius.circular(AppConstant.defaultPadding + 4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstant.smallPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Products',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGrey,
                            ),
                          ),
                          SizedBox(width: AppConstant.smallPadding),
                          Icon(Icons.arrow_downward_rounded, size: 18),
                        ],
                      ),
                      const SizedBox(height: AppConstant.smallPadding),

                      ...provider.productList.map(
                        (prod) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppConstant.smallPadding,
                          ),
                          child: Task2ProductCard(product: prod),
                        ),
                      ),

                      const SizedBox(height: kToolbarHeight / 2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
