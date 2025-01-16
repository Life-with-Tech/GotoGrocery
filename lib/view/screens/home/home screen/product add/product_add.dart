import 'dart:io';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/constants/dropdown.dart';
import 'package:tango/core/utils/string_utils.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/text_field.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:tango/view/widgets/other_widget.dart';

class ProductAdd extends StatefulWidget {
  final String id;
  const ProductAdd({super.key, required this.id});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  Map data = {
    "category_id": "",
    "discount": true,
    "discount_percentage": "10",
    "id": "3",
    "image_url":
        "https://firebasestorage.googleapis.com/v0/b/gotogrocery-15ced.appspot.com/o/products%2Fimages-removebg-preview%20(1).png?alt=media&token=94a52b8e-f029-4a84-85a8-d74c91f979fb",
    "in_stock": true,
    "is_organic": true,
    "name": "Milk",
    "on_sale": true,
    "price": "50",
    "quantity": "2",
    "rating": "2.0",
    "unit": "liters",
    "user_rating": "2"
  };
  List unitList = [
    {
      "name": "kg",
      "full_name": "Kilogram",
      "description":
          "Kilogram - Used for weight (e.g. fruits, vegetables, grains)",
    },
    {
      "name": "g",
      "full_name": "Gram",
      "description":
          "Gram - Used for smaller quantities of dry items like spices, herbs, or packaged food",
    },
    {
      "name": "mg",
      "full_name": "Milligram",
      "description":
          "Milligram - Used for very small quantities, typically for medicinal or supplement items",
    },
    {
      "name": "L",
      "full_name": "Liter",
      "description":
          "Liter - Used for measuring liquids such as milk, juices, and water",
    },
    {
      "name": "ml",
      "full_name": "Milliliter",
      "description":
          "Milliliter - Used for smaller quantities of liquids like oils, sauces, and beverages",
    },
    {
      "name": "pc",
      "full_name": "Piece",
      "description":
          "Piece - Used for items sold individually, like fruits, vegetables, or bakery items",
    },
    {
      "name": "pk",
      "full_name": "Pack",
      "description":
          "Pack - Used for pre-packaged items like cookies, noodles, or cereals",
    },
    {
      "name": "dozen",
      "full_name": "Dozen",
      "description":
          "Dozen - Used typically for eggs, sometimes for fruits like oranges",
    },
    {
      "name": "bundle",
      "full_name": "Bundle",
      "description":
          "Bundle - Used for herbs or greens like spinach or parsley that are sold in bunches",
    },
    {
      "name": "carton",
      "full_name": "Carton",
      "description": "Carton - Used for items like eggs, milk, or juices",
    },
    {
      "name": "bottle",
      "full_name": "Bottle",
      "description":
          "Bottle - Used for beverages like water, soda, juices, or liquid cleaning products",
    },
    {
      "name": "can",
      "full_name": "Can",
      "description":
          "Can - Used for canned goods like vegetables, soft drinks, or cooking ingredients",
    },
    {
      "name": "jar",
      "full_name": "Jar",
      "description": "Jar - Used for jams, pickles, or other preserved foods",
    },
    {
      "name": "box",
      "full_name": "Box",
      "description":
          "Box - Used for items like cereals, snacks, and frozen foods",
    },
    {
      "name": "tray",
      "full_name": "Tray",
      "description":
          "Tray - Used for packaging items like eggs, meat, or certain frozen foods",
    },
    {
      "name": "roll",
      "full_name": "Roll",
      "description":
          "Roll - Used for paper products like tissue, aluminum foil, or baking paper",
    },
    {
      "name": "bag",
      "full_name": "Bag",
      "description": "Bag - Used for items like chips, flour, or sugar",
    },
    {
      "name": "sachet",
      "full_name": "Sachet",
      "description":
          "Sachet - Used for small, single-use items like ketchup, spices, or shampoo",
    }
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool isDiscount = false;
  final TextEditingController _discountPresantageController =
      TextEditingController();
  bool isFlat = false;
  final TextEditingController _discountFlatController = TextEditingController();
  bool isStock = false;
  bool isOrganic = false;
  bool isSale = true;

  // List to hold images (nullable type)
  List<File?> images = [null, null, null];

  final ImagePicker _picker = ImagePicker();

  // Method to pick an image
  Future<void> _pickImage(int index) async {
    log("message");
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images[index] =
            File(pickedFile.path); // Update the image at the specified index
      });
    }
  }

  // Method to build an image widget (either network image, file, or placeholder)
  Widget _buildImage(int index) {
    if (images[index] != null) {
      return Image.file(images[index]!, fit: BoxFit.cover);
    } else {
      return Image.asset(
        'assets/images/food-13646 1.png', // Placeholder asset
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await Future.microtask(() {
              RoutingService().goBack();
            });
          },
          icon: Icon(
            (Platform.isAndroid)
                ? Icons.arrow_back
                : Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        children: [
          TextFieldData.buildField(
            style: TextStyle(
              color: themeProvider.isDark
                  ? AppColors.darkPrimary
                  : AppColors.lightPrimary,
              fontSize: 14,
            ),
            controller: _nameController,
            decoration: InputDecoration(
              label: Text(
                "Product Name",
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
              ),
              hintText: "Product Name",
              hintStyle: TextStyle(
                fontSize: 14,
                color: themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              errorMaxLines: 1,
              errorStyle: TextStyle(
                color: AppColors.red,
              ),
              enabledBorder: customOutlineInputBorder(
                themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              focusedBorder: customOutlineInputBorder(
                themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              disabledBorder: customOutlineInputBorder(
                themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              errorBorder: customOutlineInputBorder(
                AppColors.red,
              ),
              border: InputBorder.none,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(100),
            ],
            keyboardType: TextInputType.text,
            validator: (p0) =>
                (p0.toString().isEmpty) ? "Product name can't be empty" : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const Gap(10),
          TextFieldData.buildField(
            style: TextStyle(
              color: themeProvider.isDark
                  ? AppColors.darkPrimary
                  : AppColors.lightPrimary,
              fontSize: 14,
            ),
            controller: _priceController,
            decoration: InputDecoration(
              label: Text(
                "Product Price",
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
              ),
              hintText: "Product Price",
              hintStyle: TextStyle(
                fontSize: 14,
                color: themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              errorMaxLines: 1,
              errorStyle: TextStyle(
                color: AppColors.red,
              ),
              enabledBorder: customOutlineInputBorder(
                themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              focusedBorder: customOutlineInputBorder(
                themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              disabledBorder: customOutlineInputBorder(
                themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              errorBorder: customOutlineInputBorder(
                AppColors.red,
              ),
              border: InputBorder.none,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(8),
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            validator: (p0) =>
                (p0.toString().isEmpty) ? "Product Price can't be empty" : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const Gap(10),
          DropdownView(
            decoration: InputDecoration(
              label: Text(
                "Selected Unit",
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
              ),
              hintText: "Selected Unit",
              hintStyle: TextStyle(
                fontSize: 14,
                color: themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              errorMaxLines: 1,
              errorStyle: TextStyle(
                color: AppColors.red,
              ),
              enabledBorder: customOutlineInputBorder(
                themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              focusedBorder: customOutlineInputBorder(
                themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              disabledBorder: customOutlineInputBorder(
                themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
              errorBorder: customOutlineInputBorder(
                AppColors.red,
              ),
              border: InputBorder.none,
            ),
            items: unitList,
            itemAsString: (p0) => capitalizeFirstLetter(p0["name"].toString()),
            onChanged: (value) {},
            itemBuilder: (p0, p1, p2, p3) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: themeProvider.isDark
                        ? AppColors.darkSurface
                        : AppColors.lightSurface,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    p1["name"],
                    style: TextStyle(
                      color: themeProvider.isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    p1["description"],
                    style: TextStyle(
                      color: themeProvider.isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
            searchHintText: "Selected Unit",
            validator: (value) => value == null ? "Please select a unit" : null,
            hintTextName: "Unit",
            showSearchBar: false,
          ),
          if (!isFlat) const Gap(10),
          if (!isFlat)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: 14,
                        color: themeProvider.isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary,
                      ),
                    ),
                  ),
                  Switch(
                    inactiveThumbColor: AppColors.grey,
                    inactiveTrackColor: AppColors.white,
                    activeColor: themeProvider.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
                    value: isDiscount,
                    onChanged: (value) {
                      setState(() {
                        isDiscount = value;
                      });
                    },
                  )
                ],
              ),
            ),
          if (isDiscount && (!isFlat)) const Gap(10),
          if (isDiscount && (!isFlat))
            TextFieldData.buildField(
              style: TextStyle(
                color: themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                label: Text(
                  "Discount Percentage",
                  style: TextStyle(
                    fontSize: 14,
                    color: themeProvider.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
                  ),
                ),
                hintText: "Discount Percentage",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
                errorMaxLines: 1,
                errorStyle: TextStyle(
                  color: AppColors.red,
                ),
                enabledBorder: customOutlineInputBorder(
                  themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
                focusedBorder: customOutlineInputBorder(
                  themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
                disabledBorder: customOutlineInputBorder(
                  themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
                focusedErrorBorder: customOutlineInputBorder(
                  AppColors.red,
                ),
                errorBorder: customOutlineInputBorder(
                  AppColors.red,
                ),
                border: InputBorder.none,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              validator: (p0) => (p0.toString().isEmpty)
                  ? "Discount Percentage can't be empty"
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          if (!isDiscount) const Gap(10),
          if (!isDiscount)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Flat",
                      style: TextStyle(
                        fontSize: 14,
                        color: themeProvider.isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary,
                      ),
                    ),
                  ),
                  Switch(
                    inactiveThumbColor: AppColors.grey,
                    inactiveTrackColor: AppColors.white,
                    activeColor: themeProvider.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
                    value: isFlat,
                    onChanged: (value) {
                      setState(() {
                        isFlat = value;
                      });
                    },
                  )
                ],
              ),
            ),
          if (isFlat && (!isDiscount)) const Gap(10),
          if (isFlat && (!isDiscount))
            TextFieldData.buildField(
              style: TextStyle(
                color: themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                label: Text(
                  "Flat Price",
                  style: TextStyle(
                    fontSize: 14,
                    color: themeProvider.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
                  ),
                ),
                hintText: "Flat Price",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
                errorMaxLines: 1,
                errorStyle: TextStyle(
                  color: AppColors.red,
                ),
                enabledBorder: customOutlineInputBorder(
                  themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
                focusedBorder: customOutlineInputBorder(
                  themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
                disabledBorder: customOutlineInputBorder(
                  themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                ),
                focusedErrorBorder: customOutlineInputBorder(
                  AppColors.red,
                ),
                errorBorder: customOutlineInputBorder(
                  AppColors.red,
                ),
                border: InputBorder.none,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter((_priceController.text.isEmpty)
                    ? 1
                    : _priceController.text.length),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              validator: (p0) =>
                  (p0.toString().isEmpty) ? "Flat Price can't be empty" : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "In Stock",
                    style: TextStyle(
                      fontSize: 14,
                      color: themeProvider.isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                    ),
                  ),
                ),
                Switch(
                  inactiveThumbColor: AppColors.grey,
                  inactiveTrackColor: AppColors.white,
                  activeColor: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                  value: isStock,
                  onChanged: (value) {
                    setState(() {
                      isStock = value;
                    });
                  },
                )
              ],
            ),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "In Organic",
                    style: TextStyle(
                      fontSize: 14,
                      color: themeProvider.isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                    ),
                  ),
                ),
                Switch(
                  inactiveThumbColor: AppColors.grey,
                  inactiveTrackColor: AppColors.white,
                  activeColor: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                  value: isOrganic,
                  onChanged: (value) {
                    setState(() {
                      isOrganic = value;
                    });
                  },
                )
              ],
            ),
          ),
          const Gap(10),
          // if (1 != 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "In Sale",
                    style: TextStyle(
                      fontSize: 14,
                      color: themeProvider.isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                    ),
                  ),
                ),
                Switch(
                  inactiveThumbColor: AppColors.grey,
                  inactiveTrackColor: AppColors.white,
                  activeColor: themeProvider.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
                  value: isSale,
                  onChanged: (value) {},
                )
              ],
            ),
          ),
          const Gap(10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImageContainer(0),
              _buildImageContainer(1),
              _buildImageContainer(2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainer(int index) {
    return GestureDetector(
      onTap: () => _pickImage(index),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _buildImage(index),
        ),
      ),
    );
  }
}
