import 'dart:developer';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:tango/core/constants/dropdown.dart';
import 'package:tango/core/utils/string_utils.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/text_field.dart';

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

  @override
  Widget build(BuildContext context) {
    log(widget.id);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.surface,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          TextFieldData.buildField(
            label: Text(
              "Product Name",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
          const Gap(5),
          TextFieldData.buildField(
            label: Text(
              "Price",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
          const Gap(5),
          DropdownView(
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
                    color: AppColors.primary,
                  ),
                ),
                child: ListTile(
                  title: Text(p1["name"]),
                  subtitle: Text(p1["description"]),
                ),
              );
            },
            searchHintText: "Selected Unit",
            validator: (value) {},
            hintTextName: "Unit",
            showSearchBar: true,
          ),
          const Gap(5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: AppColors.primary,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Switch(
                  inactiveThumbColor: AppColors.grey,
                  activeColor: AppColors.primary,
                  value: false,
                  onChanged: (value) {},
                )
              ],
            ),
          ),
          const Gap(5),
          TextFieldData.buildField(
            label: Text(
              "Discount Price",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
          const Gap(5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: AppColors.primary,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Switch(
                  inactiveThumbColor: AppColors.grey,
                  activeColor: AppColors.primary,
                  value: false,
                  onChanged: (value) {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
