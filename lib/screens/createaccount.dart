import 'package:flutter/material.dart';
import 'package:saabi/screens/verification_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CreateAccountPage(),
  ));
}

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _agree = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = _agree && _emailController.text.isNotEmpty;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 10),

              // Step indicator
              Row(
                children: [
                  stepCircle(true, "Account"),
                  stepLine(),
                  stepCircle(false, "Verification"),
                  stepLine(),
                  stepCircle(false, "Bio information"),
                ],
              ),

              const SizedBox(height: 30),

              // Title
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Begin your registration process by providing your email address.",
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 20),

              // Email input
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email Address *",
                  hintText: "e.g example@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) {
                  setState(() {}); // refresh button state on typing
                },
              ),

              const SizedBox(height: 20),

              // OR Divider
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 15),

              // Google button
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Colors.black12),
                ),
                icon: Image.network(
                  "https://img.icons8.com/color/48/google-logo.png",
                  height: 24,
                ),
                label: const Text("Continue with Google"),
                onPressed: () {},
              ),

              const SizedBox(height: 200),

              // Checkbox + terms
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    onChanged: (val) {
                      setState(() {
                        _agree = val!;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: "I agree to the ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Saabbi’s Terms and Conditions.",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Get Started button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isActive ? Colors.amber : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: isActive
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationScreen(email: "lobar***@gmail.com"),
                      ),
                    );
                  }
                      : null,
                  child: const Text(
                    "Get Started",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login link
              Center(
                child: RichText(
                  text: const TextSpan(
                    text: "Have an account? ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Log In",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Step circle widget
  Widget stepCircle(bool active, String title) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: active ? Colors.red : Colors.grey[300],
            child: active
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 12,
                  color: active ? Colors.black : Colors.grey)),
        ],
      ),
    );
  }

  // Line between steps
  Widget stepLine() {
    return Container(
      height: 1,
      width: 20,
      color: Colors.grey,
    );
  }
}