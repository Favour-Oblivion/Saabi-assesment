import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../bioinfo.dart';

class VerificationScreen extends StatefulWidget {
  final String email; // Pass the email from create account

  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  String correctOtp = "123456"; // Fixed OTP for now
  bool isButtonEnabled = false;
  int _secondsRemaining = 36;
  Timer? _timer;

  bool _showSuccessAlert = false; // to control success alert visibility

  @override
  void initState() {
    super.initState();
    _startTimer();

    _otpController.addListener(() {
      setState(() {
        isButtonEnabled = _otpController.text.length == 6;
      });
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    if (_otpController.text == correctOtp) {
      setState(() {
        _showSuccessAlert = true;
      });
      // After 2 seconds, hide and navigate
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _showSuccessAlert = false;
        });
        // ✅ Navigate to Bio Information screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const BioInformationScreen(),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Invalid OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ✅ SUCCESS ALERT (like screenshot)
            if (_showSuccessAlert)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Yeeeeah,! You verification is successful",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showSuccessAlert = false;
                        });
                      },
                      child: const Icon(Icons.close, color: Colors.black54),
                    ),
                  ],
                ),
              ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
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
                        Icon(Icons.circle, color: Colors.red),
                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 2),
                        ),
                        Icon(Icons.circle_outlined, color: Colors.grey),
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

                    // Title
                    const Text("Verify Account",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    // Subtitle with email
                    RichText(
                      text: TextSpan(
                        text:
                        "Please enter the 6-digit OTP sent to your email address, number ",
                        style:
                        const TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          TextSpan(
                            text: widget.email,
                            style: const TextStyle(color: Colors.teal),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // OTP Input
                    Pinput(
                      length: 6,
                      controller: _otpController,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Resend OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Didn't get OTP? "),
                        Text(
                          _secondsRemaining > 0
                              ? "Resend in 0:${_secondsRemaining}s"
                              : "Resend",
                          style: const TextStyle(color: Colors.teal),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Verify button
                    ElevatedButton(
                      onPressed: isButtonEnabled ? _verifyOtp : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55),
                        backgroundColor:
                        isButtonEnabled ? Colors.red : Colors.yellow.shade100,
                        foregroundColor:
                        isButtonEnabled ? Colors.white : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:
                      const Text("Verify", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}