import 'package:flutter/material.dart';
import 'package:tango/router/routing_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/view/widgets/other_widget.dart';

class GlobalLoading {
  static void showLoadingDialog() {
    showDialog(
      context: RoutingService.navigatorKey.currentContext!,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SpinKitWaveSpinner(
              size: fullHeight(context) / 10,
              trackColor: AppColors.lightPrimary,
              waveColor: AppColors.lightPrimary,
              color: AppColors.lightOnPrimary,
            ),
          ),
        );
      },
    );
  }
}
