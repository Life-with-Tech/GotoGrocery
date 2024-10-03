import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tango/core/constants/app_colors.dart';

class TextFieldData {
  /// test field email

  static buildField({
    int? minLines,
    bool? enabled,
    int? maxLines,
    bool? obscureText,
    Color? cursorColor,
    TextStyle? style,
    Widget? suffixIcon,
    Widget? prefixIcon,
    InputDecoration? decoration,
    bool? readOnly,
    String? hintText,
    void Function()? onTap,
    void Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    AutovalidateMode? autovalidateMode,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextEditingController? controller,
    Widget? label,
  }) {
    return TextFormField(
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      enabled: enabled,
      onTap: onTap,
      minLines: minLines ?? 1,
      maxLines: obscureText ?? false ? 1 : maxLines ?? 5,
      inputFormatters: inputFormatters,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      autovalidateMode: autovalidateMode,
      validator: validator,
      cursorColor: cursorColor,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      controller: controller,
      style: style ??
          const TextStyle(
            color: Colors.black,
          ),
      decoration: decoration ??
          InputDecoration(
            suffixIcon: suffixIcon,
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
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.greenAccent,
              ),
            ),
            contentPadding: const EdgeInsets.all(10.0),
            labelStyle: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            label: label,
            prefixIcon: prefixIcon,
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
    );
  }
}
