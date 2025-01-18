import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/custom_cached_network_image.dart';
import 'package:tango/state/providers/theme_provider.dart';

class CarouselHelper extends StatefulWidget {
  final List imageUrls;
  final double? width;
  final double? height;
  const CarouselHelper({
    super.key,
    required this.imageUrls,
    this.width,
    this.height,
  });

  @override
  State<CarouselHelper> createState() => _CarouselHelperState();
}

class _CarouselHelperState extends State<CarouselHelper> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: CarouselSlider.builder(
            itemCount: widget.imageUrls.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return SizedBox(
                width: widget.width ?? double.infinity,
                height: widget.height ?? 250,
                child: CustomCachedNetworkImage(
                  alignment: Alignment.topCenter,
                  imageUrl: widget.imageUrls[index],
                ),
              );
            },
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
            ),
          ),
        ),
        const Gap(5),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: SmoothPageIndicator(
            controller: PageController(
              initialPage: _currentIndex,
              viewportFraction: 1.0,
            ),
            count: widget.imageUrls.length,
            effect: WormEffect(
              paintStyle: PaintingStyle.stroke,
              spacing: 5,
              activeDotColor:
                  themeProvider.isDark ? AppColors.grey : AppColors.black,
              dotColor: AppColors.grey,
              dotHeight: 5,
              dotWidth: 5,
            ),
          ),
        ),
      ],
    );
  }
}
