import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/custom_cached_network_image.dart';
import 'package:tango/state/providers/theme_provider.dart';

class CarouselHelper {
  static Widget createCarousel(List<String> imageUrls,
      {double? width, double? height, CarouselOptions? options}) {
    int currentIndex = 0;

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imageUrls.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return SizedBox(
              width: width ?? double.infinity,
              height: height ?? 250.0,
              child: CustomCachedNetworkImage(
                alignment: Alignment.topCenter,
                imageUrl: imageUrls[index],
              ),
            );
          },
          options: options ??
              CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: SmoothPageIndicator(
            controller: PageController(
              initialPage: currentIndex,
              viewportFraction: 1.0,
            ),
            count: imageUrls.length,
            effect: WormEffect(
              paintStyle: PaintingStyle.stroke,
              spacing: 5,
              activeDotColor: themeProvider.isDark
                  ? AppColors.darkPrimary
                  : AppColors.lightPrimary,
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
