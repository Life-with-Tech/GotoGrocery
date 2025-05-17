import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tango/core/constants/custom_cached_network_image.dart';

class CarouselWidget extends StatefulWidget {
  final List<String> imageUrls;
  final double? width;
  final double? height;
  final bool? show;

  const CarouselWidget({
    Key? key,
    required this.imageUrls,
    this.width,
    this.height,
    this.show = true,
  }) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return widget.imageUrls.isEmpty
                ? Image.asset(
                    'assets/images/food-13646 1.png',
                    fit: BoxFit.cover,
                    width: widget.width,
                    height: widget.height,
                  )
                : CustomCachedNetworkImage(
                    width: widget.width,
                    height: widget.height,
                    alignment: Alignment.topCenter,
                    imageUrl: widget.imageUrls[index],
                  );
          },
          options: CarouselOptions(
            height: widget.height ?? 200,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            autoPlay: false,
            enlargeCenterPage: false,
            viewportFraction: 1,
          ),
        ),
        if (widget.show ?? true)
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: widget.imageUrls.length,
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
          )
      ],
    );
  }
}
