import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/app_constant.dart';
import 'package:task_app/core/extentions/context_extension.dart';
import 'package:task_app/core/utils/display_format.dart';
import 'package:task_app/modals/product_modal.dart';
import 'package:task_app/widgets/star_builder.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModal product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstant.smallPadding * 2),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    product.title ?? '-',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
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

                  // Desc
                  Text(
                    product.description ?? '-',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: AppConstant.smallPadding),

                  // Images
                  product.images != null
                      ? SizedBox(
                          height: context.height * 0.2,
                          child: PageView.builder(
                            itemCount: product.images?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(
                                  AppConstant.smallPadding,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.black.withValues(
                                    alpha: 0.02,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppConstant.smallRadius,
                                  ),
                                ),
                                child: Image.network(
                                  product.images![index],
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: AppConstant.smallPadding),

                  // Price & rating
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              DisplayFormat.formatPrice(product.price),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          StarBuilder(rating: product.rating),
                        ],
                      ),

                      // Discount
                      Row(
                        children: [
                          Text(
                            'Discount: ${product.discountPercentage ?? 0}%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.redAccent,
                            ),
                          ),
                          const Spacer(),

                          Text(
                            'Stock: ${product.stock ?? 0}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              // color: AppColors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstant.smallPadding),

                  Row(
                    children: [
                      const Expanded(child: SizedBox()),

                      // Stock avail
                      Expanded(
                        child: Text(
                          'Status: ${product.availabilityStatus ?? '-'}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            // color: AppColors.redAccent,
                          ),
                        ),
                      ),

                      // Min order
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstant.smallPadding,
                          vertical: AppConstant.smallPadding / 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          'Min Order: ${product.minimumOrderQuantity ?? 0}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstant.smallPadding),

                  // Return policy
                  Container(
                    width: context.width,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(
                        AppConstant.smallRadius,
                      ),
                    ),
                    child: Text(
                      product.returnPolicy ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstant.defaultPadding),

                  // Warranty information
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getTitle('Warranty Information'),

                      Text(
                        product.warrantyInformation ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstant.defaultPadding),

                  // Shipping  information
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getTitle('Shipping  Information'),

                      Text(
                        product.shippingInformation ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstant.defaultPadding),

                  // Reviews
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getTitle('Reviews'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: List.generate(product.reviews?.length ?? 0, (
                          index,
                        ) {
                          final review = product.reviews?[index];
                          return Column(
                            children: [
                              Material(
                                elevation: 2,
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(
                                  AppConstant.smallRadius,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    AppConstant.smallPadding / 2,
                                  ),
                                  child: Column(
                                    children: [
                                      // Name
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              review?.reviewerName ?? '',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: AppConstant.smallPadding,
                                          ),

                                          // Rating
                                          StarBuilder(
                                            rating: double.parse(
                                              '${review?.rating ?? 0.0}',
                                            ),
                                            starSize: 10,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: AppConstant.smallPadding,
                                      ),

                                      // Desc
                                      Text(
                                        product.description ?? '-',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black.withValues(
                                            alpha: 0.6,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppConstant.smallPadding),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
      ),
    );
  }
}
