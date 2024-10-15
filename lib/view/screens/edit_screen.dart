// import 'package:gap/gap.dart';
// import 'package:flutter/material.dart';
// import 'package:tango/view/widgets/other_widget.dart';
// import '../../core/constants/app_colors.dart'; // Ensure you have this import for your color constants
// import '../../core/constants/text_field.dart'; // Make sure you have your TextFieldData class implemented

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   String profileImageUrl = 'https://via.placeholder.com/150';
//   late ScrollController _scrollController;
//   final ValueNotifier<double> _imageSizeNotifier = ValueNotifier(100.0);
//   final ValueNotifier<double> _imageTranslationXNotifier = ValueNotifier(0.0);
//   final ValueNotifier<double> _imageOpacityNotifier = ValueNotifier(1.0);

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(() {
//       double offset = _scrollController.offset;
//       _imageSizeNotifier.value = 100 - offset.clamp(0, 40);
//       _imageTranslationXNotifier.value = offset.clamp(0, 200);
//       _imageOpacityNotifier.value = (1 - (offset / 200)).clamp(0.0, 1.0);
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         controller: _scrollController,
//         slivers: <Widget>[
//           SliverAppBar(
//             expandedHeight: fullHeight(context) / 5,
//             floating: false,
//             pinned: true,
//             actions: [
//               ValueListenableBuilder<double>(
//                 valueListenable: _imageTranslationXNotifier,
//                 builder: (context, translationX, child) {
//                   return Opacity(
//                     opacity: (translationX > fullHeight(context) / 7) ? 1 : 0,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Stack(
//                         children: [
//                           CircleAvatar(
//                             radius: 20,
//                             backgroundImage: NetworkImage(profileImageUrl),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: CircleAvatar(
//                               backgroundColor: AppColors.primary,
//                               radius: 10,
//                               child: Icon(
//                                 Icons.camera_alt,
//                                 size: 10,
//                                 color: AppColors.surface,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//             iconTheme: IconThemeData(
//               color: AppColors.surface,
//             ),
//             title: ValueListenableBuilder<double>(
//               valueListenable: _imageTranslationXNotifier,
//               builder: (context, translationX, child) {
//                 return (translationX > fullHeight(context) / 7)
//                     ? Text(
//                         "Edit Profile",
//                         style: TextStyle(
//                           color: AppColors.surface,
//                           fontSize: 15,
//                         ),
//                       )
//                     : const SizedBox.shrink();
//               },
//             ),
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 margin: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                     color: AppColors.onPrimary,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Center(
//                   child: ValueListenableBuilder<double>(
//                     valueListenable: _imageOpacityNotifier,
//                     builder: (context, opacity, child) {
//                       return AnimatedOpacity(
//                         duration: const Duration(milliseconds: 300),
//                         opacity: opacity,
//                         child: ValueListenableBuilder<double>(
//                           valueListenable: _imageSizeNotifier,
//                           builder: (context, size, child) {
//                             return Transform(
//                               transform: Matrix4.translationValues(
//                                   _imageTranslationXNotifier.value, 0, 0),
//                               child: Stack(
//                                 children: [
//                                   AnimatedContainer(
//                                     duration: const Duration(milliseconds: 300),
//                                     width: size,
//                                     height: size,
//                                     child: CircleAvatar(
//                                       radius: 50,
//                                       backgroundImage:
//                                           NetworkImage(profileImageUrl),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 0,
//                                     right: 0,
//                                     child: CircleAvatar(
//                                       backgroundColor: AppColors.onPrimary,
//                                       radius: size / 6,
//                                       child: Icon(
//                                         Icons.camera_alt,
//                                         size: size / 6,
//                                         color: AppColors.surface,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       TextFieldData.buildField(
//                         label: const Text(
//                           'Name',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                       ),
//                       const Gap(10),
//                       TextFieldData.buildField(
//                         label: const Text(
//                           'Email',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                       ),
//                       const Gap(10),
//                       TextFieldData.buildField(
//                         label: const Text(
//                           'Phone Number',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                       ),
//                       const Gap(10),
//                       TextFieldData.buildField(maxLines: 3),
//                       const SizedBox(height: 20),
//                       TextFieldData.buildField(maxLines: 3),
//                       const SizedBox(height: 20),
//                       TextFieldData.buildField(maxLines: 3),
//                       const SizedBox(height: 20),
//                       TextFieldData.buildField(maxLines: 3),
//                       const SizedBox(height: 20),
//                       TextFieldData.buildField(maxLines: 3),
//                       const SizedBox(height: 20),
//                       TextFieldData.buildField(maxLines: 3),
//                       const SizedBox(height: 20),
//                       TextFieldData.buildField(maxLines: 3),
//                       const SizedBox(height: 20),
//                       TextFieldData.buildField(maxLines: 3),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Handle update action
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Profile Updated!')),
//                           );
//                         },
//                         child: const Text('Update Profile'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               childCount: 1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
