import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/state/providers/theme_provider.dart';

// ignore: must_be_immutable
class DropdownView<T> extends StatefulWidget {
  DropdownView({
    super.key,
    this.hintText,
    required this.items,
    required this.itemAsString,
    required this.onChanged,
    required this.validator,
    required this.hintTextName,
    required this.showSearchBar,
    this.selectedItem,
    this.itemBuilder,
    this.searchHintText,
    this.decoration,
  });

  final String? hintText;
  final InputDecoration? decoration;
  final String hintTextName;
  final List<T> items;
  final T? selectedItem;
  final String Function(T)? itemAsString;
  final String? Function(T? value)? validator;
  void Function(T? value)? onChanged;
  final Widget Function(BuildContext, T, bool, bool)? itemBuilder;
  final bool showSearchBar;
  final String? searchHintText;
  @override
  State<DropdownView<T>> createState() => _DropdownViewState<T>();
}

class _DropdownViewState<T> extends State<DropdownView<T>> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return DropdownSearch<T>(
      compareFn: (item1, item2) {
        return true;
      },
      popupProps: PopupProps.dialog(
        dialogProps: DialogProps(
          backgroundColor: themeProvider.isDark
              ? AppColors.darkPrimary
              : AppColors.lightPrimary,
        ),
        fit: FlexFit.loose,
        showSelectedItems: false,
        showSearchBox: widget.showSearchBar,
        itemBuilder: widget.itemBuilder,
        searchFieldProps: TextFieldProps(
          maxLines: 1,
          style: TextStyle(color: AppColors.black),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: AppColors.black, fontSize: 14),
            hintText: widget.searchHintText ?? "Search...",
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
          ),
          cursorColor: Colors.blue,
        ),
      ),
      onChanged: widget.onChanged,
      selectedItem: widget.selectedItem,
      suffixProps: DropdownSuffixProps(
        dropdownButtonProps: DropdownButtonProps(
          color: themeProvider.isDark
              ? AppColors.darkPrimary
              : AppColors.lightPrimary,
        ),
      ),
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      items: (filter, loadProps) => widget.items,
      itemAsString: widget.itemAsString,
      decoratorProps: DropDownDecoratorProps(
        baseStyle: TextStyle(
          color: themeProvider.isDark
              ? AppColors.darkPrimary
              : AppColors.lightPrimary,
          fontSize: 14,
        ),
        decoration: widget.decoration ??
            InputDecoration(
              label: Text(
                widget.hintTextName,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
              hintMaxLines: 1,
              iconColor: themeProvider.isDark
                  ? AppColors.darkPrimary
                  : AppColors.lightPrimary,
              // labelStyle: TextStyle(color: grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.grey,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.black,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.greenAccent,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              border: const OutlineInputBorder(),
            ),
      ),
    );
  }
}
