import 'package:gap/gap.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/text_field.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tango/state/providers/view_all_provider.dart';

class RateProduct extends StatefulWidget {
  final String productId;
  const RateProduct({super.key, required this.productId});

  @override
  State<RateProduct> createState() => _RateProductState();
}

class _RateProductState extends State<RateProduct> {
  TextEditingController reviewController = TextEditingController();
  double _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ratings & Reviews"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar(
              initialRating: _currentRating,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: Icon(Icons.star, color: Colors.amber),
                half: Icon(Icons.star_half, color: Colors.amber),
                empty: Icon(Icons.star_border, color: Colors.grey),
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _currentRating = rating;
                });
              },
            ),
            const Gap(10),
            TextFieldData.buildField(
              controller: reviewController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(300),
              ],
              minLines: 5,
              maxLines: 10,
              hintText: "Review",
            ),
            const Gap(20),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  int submit = await viewAllProvider.setRatingAndReview(
                    productId: widget.productId,
                    rating: _currentRating.toString(),
                    review: reviewController.text,
                  );

                  if (submit == 1) {
                    RoutingService().goBack();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: fullWidth(context) / 2,
                  height: fullHeight(context) / 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primary,
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
