import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomShareContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Share via",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildShareIcon(
                icon: Icons.facebook,
                label: "Facebook",
                onTap: () {
                  // Add Facebook sharing functionality
                  Navigator.pop(context);
                },
              ),
              _buildShareIcon(
                icon: Icons.whatshot,
                label: "WhatsApp",
                onTap: () async {
                  const String message = "Hello! Check out this cool app!";
                  const String phoneNumber =
                      "9065546703"; // Add recipient number if needed
                  final String whatsappUrl = phoneNumber.isNotEmpty
                      ? "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}"
                      : "https://wa.me/?text=${Uri.encodeComponent(message)}";

                  if (await canLaunch(whatsappUrl)) {
                    await launch(whatsappUrl);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("WhatsApp not installed.")),
                    );
                  }
                },
              ),
              _buildShareIcon(
                icon: Icons.email,
                label: "Email",
                onTap: () {
                  // Add Email sharing functionality
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Widget _buildShareIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
