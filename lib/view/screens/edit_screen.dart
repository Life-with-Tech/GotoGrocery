import 'package:flutter/material.dart';
import '../../core/constants/text_field.dart';
import '../widgets/other_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: fullHeight(context) / 15),
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                          "assets/images/pngwing 1.png"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: fullHeight(context) / 55),
              const Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: fullHeight(context) * 0.01),
              TextFieldData.buildField(
                controller: TextEditingController(),
                hintText: "Enter your full name",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: fullHeight(context) / 55),
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: fullHeight(context) * 0.01),
              TextFieldData.buildField(
                controller: TextEditingController(),
                hintText: "Enter email address",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: fullHeight(context) / 55),
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: fullHeight(context) * 0.01),
              TextFieldData.buildField(
                controller: TextEditingController(),
                hintText: "Enter your number",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: fullHeight(context) / 55),
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: fullHeight(context) * 0.01),
              TextFieldData.buildField(
                controller: TextEditingController(),
                hintText: "Edit Address",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: fullHeight(context) * 0.05),
              Center(
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Update")))
            ],
          ),
        ),
      ),
    );
  }
}
