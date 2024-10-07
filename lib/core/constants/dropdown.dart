import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:tango/core/constants/app_colors.dart';

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
  });

  final String? hintText;
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
    return DropdownSearch<T>(
      compareFn: (item1, item2) {
        return true;
      },
      popupProps: PopupProps.dialog(
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
      // selectedItem: selectedClient.clientCompany,
      onChanged: widget.onChanged,
      selectedItem: widget.selectedItem,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,

      items: (filter, loadProps) => widget.items,
      itemAsString: widget.itemAsString,
      decoratorProps: DropDownDecoratorProps(
        baseStyle: TextStyle(
          color: AppColors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          label: Text(
            widget.hintTextName,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
          hintMaxLines: 1,
          // iconColor: color,
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
