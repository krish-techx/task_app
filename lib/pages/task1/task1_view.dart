import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/task1_provider.dart';
import 'package:task_app/widgets/lazy_loader.dart';
import 'package:task_app/widgets/product_card.dart';

class Task1View extends StatefulWidget {
  const Task1View({super.key});

  @override
  State<Task1View> createState() => _Task1ViewState();
}

class _Task1ViewState extends State<Task1View> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Task1Provider>();

    return LazyLoader(
      filterCount: provider.loadedProductList.length,
      maxCount: provider.allProductList.length,
      onMaxFetch: () => provider.onMaxExtent(),

      itemBuilder: (context, index) {
        final prod = provider.loadedProductList[index];
        return ProductCard(product: prod);
      },
    );
  }
}
