import 'dart:io';
import 'dart:async';
import 'dart:developer';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tango/router/routing_service.dart';
import '../../../../router/app_routes_constant.dart';
import 'package:tango/core/constants/text_field.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/photo_type.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/state/providers/user_provider.dart';
import 'package:tango/core/utils/image_preview_modal.dart';
import 'package:tango/core/utils/image_picker_helper.dart';
import 'package:tango/core/utils/global_image_cropper.dart';
import 'package:tango/core/utils/image_storage_helper.dart';
import 'package:tango/core/constants/profile_bottom_semi_circle_clipper.dart';

class EditProfileScreen extends StatefulWidget {
  final String? email;
  final String? id;

  const EditProfileScreen({super.key, this.email, this.id});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String gender = "Male";
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await doThisLunchScreen();
    });
  }

  Future doThisLunchScreen() async {
    log("${userProvider.currentUser?.toJson()}");
    if (widget.id != null && widget.email != null) {
      emailController.text = widget.email ?? "";
    } else {
      nameController.text = userProvider.currentUser?.name ?? "";
      emailController.text = userProvider.currentUser?.email ?? "";
      dobController.text = userProvider.currentUser?.dob ?? "";
      gender = userProvider.currentUser?.gender ?? "";
      numberController.text = userProvider.currentUser?.number ?? "";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          log("Starting profile update...");
          String? imageLink = await ImageStorageHelper().uploadImage(
            _selectedImage,
            folderPath: "user_profile/${widget.id}",
          );
          Map<String, dynamic> deviceData = await getDeviceData();
          if (widget.id != null && widget.email != null) {
            await userProvider.createUser(
              userId: widget.id ?? "",
              userData: {
                "uid": widget.id,
                "image": imageLink,
                "name": nameController.text,
                "email": emailController.text,
                "number": numberController.text,
                "dob": dobController.text,
                "gender": gender,
                "location": {
                  "state": "Bihar",
                  "district": "Chapra",
                  "city": "Amnour",
                  "pincode": "841418",
                  "latitude": "-12.451585",
                  "longitude": "74.5571242",
                },
                "platform": deviceData,
                "fcm": userProvider.token,
                "status": true,
                "updatedAt": "",
                "createdAt": DateTime.now().toString(),
              },
            );

            log("User created, navigating...");
          } else {
            log("Missing ID or email, cannot proceed with profile update.");
          }
        },
        child: Container(
          width: fullWidth(context),
          height: 50,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.primary,
          ),
          child: const Text(
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
        leading: IconButton(
          onPressed: () async {
            if (widget.id != null && widget.email != null) {
              RoutingService().goName(Routes.loginScreen.name);
            } else {
              unawaited(RoutingService().goBack());
            }
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.surface,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.surface,
        ),
        title: Text(
          L10n().getValue()!.profile,
          style: const TextStyle(
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
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImagePreviewModal(
                              body: _selectedImage!.path,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: loadImage(_selectedImage?.path ??
                                userProvider.currentUser?.image ??
                                ""),
                          ),
                          color: AppColors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.surface,
                        ),
                        onPressed: () {
                          _showImagePickerBottomSheet(context);
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          // color: AppColors.primary,
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
                  controller: nameController,
                  label: const Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Gap(10),
                TextFieldData.buildField(
                  controller: emailController,
                  readOnly: true,
                  enabled: false,
                  label: const Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Gap(10),
                TextFieldData.buildField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  label: const Text(
                    "Number",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Gap(10),
                TextFieldData.buildField(
                  controller: dobController,
                  readOnly: true,
                  onTap: () => selectDate(context),
                  label: const Text(
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
                      const Text(
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

  Future<void> _getCroppedImage(ImageSource source) async {
    final croppedImage = await GlobalImageCropper.pickAndCropImage(
      cropStyle: CropStyle.circle,
      source: source,
      aspectRatio: const CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
    );
    RoutingService().goBack();
    log(croppedImage.toString());
    if (croppedImage != null) {
      setState(() {
        _selectedImage = croppedImage;
      });
    }
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose an option',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                ),
                title: const Text('Camera'),
                onTap: () => _getCroppedImage(
                  ImageSource.camera,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_album,
                ),
                title: const Text('Gallery'),
                onTap: () => _getCroppedImage(
                  ImageSource.gallery,
                ),
              ),
              if (_selectedImage != null)
                ListTile(
                  leading: const Icon(
                    Icons.delete,
                  ),
                  title: const Text('Remove Photo'),
                  onTap: () {
                    _selectedImage = null;
                    RoutingService().goBack();
                    setState(() {});
                  },
                ),
            ],
          ),
        );
      },
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
      dobController.text = date;
      log(date.toString());
    }
    return pickedDate;
  }
}
