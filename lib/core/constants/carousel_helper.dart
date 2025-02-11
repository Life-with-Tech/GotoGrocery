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

  const CarouselWidget({
    Key? key,
    required this.imageUrls,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

  @override
  State<CarouselHelper> createState() => _CarouselHelperState();
}

class _CarouselHelperState extends State<CarouselHelper> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

       
        CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return SizedBox(
              width: widget.width ?? double.infinity,
              height: widget.height ?? 250.0,
              child: CustomCachedNetworkImage(
                alignment: Alignment.topCenter,
                imageUrl: widget.imageUrls[index],
              ),
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            autoPlay: false,
            enlargeCenterPage: false,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
          ),
        ),
        const Gap(5),
        Container(
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
