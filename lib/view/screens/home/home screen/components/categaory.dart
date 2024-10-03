import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/cached_image_widget.dart';
import 'package:tango/view/widgets/other_widget.dart';

class Categaory extends StatefulWidget {
  const Categaory({super.key});

  @override
  State<Categaory> createState() => _CategaoryState();
}

class _CategaoryState extends State<Categaory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.center,
                "Category",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: fullHeight(context) / 8,
          width: fullWidth(context),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("category")
                .where("status", isEqualTo: "1")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = snapshot.data?.docs[index]
                        .data() as Map<String, dynamic>;

                    return Container(
                      height: fullHeight(context) / 8,
                      width: fullWidth(context) / 4,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Center(
                        child: CachedImageWidget(
                          imageUrl: item['logo'],
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
