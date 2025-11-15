import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/app_constant.dart';
import 'package:task_app/core/extentions/context_extension.dart';
import 'package:task_app/core/routes/app_routes.dart';
import 'package:task_app/core/utils/display_format.dart';
import 'package:task_app/modals/product_modal.dart';
import 'package:task_app/widgets/star_builder.dart';

class ProductCard extends StatelessWidget {
  final ProductModal product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: Container(
        padding: const EdgeInsets.all(AppConstant.smallPadding),
        width: context.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstant.smallRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Thumbnail
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.grey, width: 2),
                image: DecorationImage(
                  image: NetworkImage(product.thumbnail ?? ''),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: AppConstant.smallPadding),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    product.title ?? '-',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Category
                  Text(
                    product.category ?? '',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: AppConstant.smallPadding),

                  // Price & rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(DisplayFormat.formatPrice(product.price)),
                      ),

                      StarBuilder(rating: product.rating),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final navigator = Navigator.of(context);

    navigator.pushNamed(
      AppRoutes.productDetails,
      arguments: {'modal': product},
    );
  }
}
