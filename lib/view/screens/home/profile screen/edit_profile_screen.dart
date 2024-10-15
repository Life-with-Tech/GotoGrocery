import 'dart:developer';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tango/core/constants/text_field.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/photo_type.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/state/providers/user_provider.dart';
import 'package:tango/core/constants/profile_bottom_semi_circle_clipper.dart';

class EditProfileScreen extends StatefulWidget {
  final int? id;
  const EditProfileScreen({super.key, this.id});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          if (widget.id == 1) {
          } else {}
        },
        child: Container(
          width: fullWidth(context),
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary,
          ),
          child: Text(
            "Edit Profile",
            style: TextStyle(
              color: AppColors.surface,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      appBar: AppBar(
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipPath(
                clipper: BottomSemiCircleClipper(),
                child: Container(
                  width: fullWidth(context),
                  height: fullHeight(context) / 7,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: loadImage(userProvider.currentUser?.image),
                        ),
                        color: AppColors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.surface,
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              children: [
                TextFieldData.buildField(
                  label: Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Gap(10),
                TextFieldData.buildField(
                  readOnly: true,
                  enabled: false,
                  label: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Gap(10),
                TextFieldData.buildField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  label: Text(
                    "Number",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Gap(10),
                TextFieldData.buildField(
                  readOnly: true,
                  onTap: () => selectDate(context),
                  label: Text(
                    "DOB",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.grey,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Select Gender",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              if (gender != "Male") {
                                gender = "Male";
                                setState(() {});
                              }
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: (gender == "Male")
                                    ? AppColors.primary
                                    : AppColors.surface,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.primary,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    color: (gender == "Male")
                                        ? AppColors.surface
                                        : AppColors.primary,
                                    Icons.boy,
                                    size: 35,
                                  ),
                                  Text(
                                    "Male",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (gender == "Male")
                                          ? AppColors.surface
                                          : AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (gender != "Female") {
                                gender = "Female";
                                setState(() {});
                              }
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: (gender == "Female")
                                    ? AppColors.primary
                                    : AppColors.surface,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.primary,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    color: (gender == "Female")
                                        ? AppColors.surface
                                        : AppColors.primary,
                                    Icons.girl,
                                    size: 35,
                                  ),
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (gender == "Female")
                                          ? AppColors.surface
                                          : AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      String date = DateFormat('dd/MM/yyyy').format(pickedDate);

      log(date.toString());
    }
    return pickedDate;
  }
}
