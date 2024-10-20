import "dart:io";
import "package:tango/l10n/l10n.dart";
import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "package:tango/router/routing_service.dart";
import "package:tango/core/constants/app_colors.dart";
import "package:tango/view/widgets/other_widget.dart";
import "package:tango/core/constants/custom_cached_network_image.dart";



class ImagePreviewModal extends StatefulWidget {
  const ImagePreviewModal({required this.body, super.key});
  final String body;
  @override
  State<ImagePreviewModal> createState() => _ImagePreviewModalState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty("body", body));
  }
}

class _ImagePreviewModalState extends State<ImagePreviewModal> {
  Widget getImageTypeWidget(String name) {
    if (name.contains("https")) {
      return CustomCachedNetworkImage(
        imageUrl: name,
        fit: BoxFit.contain,
      );
    } else {
      return Image.memory(
        File(name).readAsBytesSync(),
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
           leading: IconButton(
          onPressed: () async {
            await RoutingService().goBack();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.surface,
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColors.surface,
        ),
        title: Text(
          L10n().getValue()!.profile,
          style: TextStyle(
            color: AppColors.surface,
            fontSize: 18,
          ),
        ),
      ),
        body: ColoredBox(
          color: AppColors.black,
          child: Stack(
            children: [
              Align(child: getImageTypeWidget(widget.body)),
             
            ],
          ),
        ),
      );
}
