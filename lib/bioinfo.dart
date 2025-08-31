import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'screens/home_screen.dart';

class BioInformationScreen extends StatefulWidget {
  const BioInformationScreen({super.key});

  @override
  State<BioInformationScreen> createState() => _BioInformationScreenState();
}

class _BioInformationScreenState extends State<BioInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final picker = ImagePicker();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  String? _gender;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final fullName = _nameController.text;
      final tag = _tagController.text;

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dotted background + lightning bolt
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/congrats_bg.png"), // dotted bg image
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.bolt,
                        color: Colors.orange,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Congratulations",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome to Saabbi.\nYou have successfully created your account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(
                            profileImage: _profileImage,
                            fullName: fullName,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.orange.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Done", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text("Back", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 20),

                // Progress bar
                Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.red),
                    Expanded(
                      child: Divider(color: Colors.red, thickness: 2),
                    ),
                    Icon(Icons.check_circle, color: Colors.red),
                    Expanded(
                      child: Divider(color: Colors.red, thickness: 2),
                    ),
                    Icon(Icons.circle_outlined, color: Colors.red),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text("Account"),
                    Text("Verification"),
                    Text("Bio information"),
                  ],
                ),
                const SizedBox(height: 30),

                const Text(
                  "Bio Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text("Kindly provide your basic information.",
                    style: TextStyle(fontSize: 14)),
                const SizedBox(height: 20),

                // Profile Image
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const AssetImage("assets/profile_placeholder.png")
                        as ImageProvider,
                      ),
                      TextButton(
                        onPressed: _pickImage,
                        child: const Text(
                          "Change Image",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Full Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Full name *",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? "Enter your full name" : null,
                ),
                const SizedBox(height: 15),

                // Date of Birth
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: "Date of Birth *",
                    hintText: "DOB",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? "Enter your date of birth" : null,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      _dobController.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                ),
                const SizedBox(height: 15),

                // Gender
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: const InputDecoration(
                    labelText: "Gender *",
                    border: OutlineInputBorder(),
                  ),
                  items: ["Male", "Female"]
                      .map((g) => DropdownMenuItem(
                    value: g,
                    child: Text(g),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) =>
                  value == null ? "Select gender" : null,
                ),
                const SizedBox(height: 15),

                // Saabbi Tag
                TextFormField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    labelText: "Saabbi Tag *",
                    hintText: "Enter a username",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? "Enter a tag/username" : null,
                ),
                const SizedBox(height: 15),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password *",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) => value!.length < 6
                      ? "Password must be at least 6 chars"
                      : null,
                ),
                const SizedBox(height: 15),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Confirm Password *",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: Colors.orange.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Submit", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}