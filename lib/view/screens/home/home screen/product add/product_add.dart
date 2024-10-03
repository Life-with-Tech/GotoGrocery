import 'dart:developer';
import 'package:flutter/material.dart';


class ProductAdd extends StatefulWidget {
  final String id;
  const ProductAdd({super.key, required this.id});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  @override
  Widget build(BuildContext context) {
    log(widget.id);
    return Scaffold();
  }
}
