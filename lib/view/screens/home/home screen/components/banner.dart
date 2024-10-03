import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/view/widgets/other_widget.dart';

class BannerHome extends StatefulWidget {
  const BannerHome({super.key});

  @override
  State<BannerHome> createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("banner")
          .where("status", isEqualTo: "1")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List homeBanner = snapshot.data?.docs ?? [];
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    currentIndex = index;
                    setState(() {});
                  },
                  autoPlay: true,
                  height: fullHeight(context) / 5,
                  viewportFraction: 1.0,
                ),
                items: homeBanner.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: fullHeight(context) / 5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(i["image"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    color: AppColors.onSecondary.withOpacity(0.2),
                  ),
                  child: SmoothPageIndicator(
                    controller: PageController(
                      initialPage: currentIndex,
                      viewportFraction: 1.0,
                    ),
                    count: homeBanner.length,
                    effect: WormEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.surface,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                ),
              )
            ],
          );
        }

        return Container();
      },
    );
  }
}
