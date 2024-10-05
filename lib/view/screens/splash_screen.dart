import 'dart:developer';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:tango/router/routing_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {});
  // }

  final List _imagePaths = [
    {
      "image": "assets/images/pngwing 2@2x.png",
      "title": "Fast Delivery",
      "discription":
          "The dish is artfully drizzled with a velvety balsamic glaze, creating a harmonious blend of sweet and savory notes that dance on your palate. Each  bite is a journey through a culinary wonderland, where freshness meets finesse",
    },
    {
      "image": "assets/images/pngwing 1@2x.png",
      "title": "Find Food You Love",
      "discription":
          "Indulge in the exquisite flavors of our culinary masterpiece – a symphony of succulent grilled chicken, nestled on a bed of perfectly seasoned quinoa and adorned with a medley of vibrant, roasted vegetables."
    },
    {
      "image": "assets/images/food-13646 1@2x.png",
      "title": "Welcome to QuickBit",
      "discription":
          "Elevate your dining experience with this gastronomic delight that transcends ordinary meals into extraordinary feasts!",
    },
  ];
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: fullHeight(context) / 1.5,
              onPageChanged: (index, reason) {
                // if (index == 2) {
                RoutingService().goName(
                  Routes.home.name,
                );
                // }
                log(index.toString());
                currentIndex = index;
                setState(() {});
              },
              viewportFraction: 1.0,
            ),
            items: _imagePaths.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: fullHeight(context) / 2.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(i["image"]),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Gap(5),
                      Text(
                        textAlign: TextAlign.center,
                        i["title"],
                        style: TextStyle(
                          color: AppColors.surface,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        textAlign: TextAlign.center,
                        i["discription"],
                        style: TextStyle(
                          color: AppColors.surface,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
          const Gap(10),
          SmoothPageIndicator(
            controller: PageController(
              initialPage: currentIndex,
              viewportFraction: 1.0,
            ),
            count: _imagePaths.length,
            effect: WormEffect(
              activeDotColor: AppColors.secondary,
              dotColor: AppColors.surface,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ],
      ),
    );
  }
}
