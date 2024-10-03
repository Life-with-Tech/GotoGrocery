import 'package:gap/gap.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/router/routing_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/user_provider.dart';
import 'package:tango/core/constants/cached_image_widget.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(
            color: AppColors.surface,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: MaterialButton(
              color: AppColors.surface,
              onPressed: () {},
              child: Text(
                "Add New Category",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("category").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && (snapshot.data?.docs ?? []).isNotEmpty) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.25,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return InkWell(
                  onTap: () {
                    RoutingService().pushNamed(
                      Routes.addProductScreen.name,
                      pathParameters: {
                        "id": item["id"],
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.secondary,
                      ),
                    ),
                    child: Column(
                      children: [
                        CachedImageWidget(
                          imageUrl:
                              item['logo'] ?? '', // Ensure imageUrl exists
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        const Gap(8),
                        Text(
                          item['name'] ?? 'Unknown Category',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No categories found.'));
        },
      ),
    );
  }
}
