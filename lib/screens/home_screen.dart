import 'dart:io';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final File? profileImage;
  final String fullName;

  const HomeScreen({
    super.key,
    required this.profileImage,
    required this.fullName,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: "Leaderboards"),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events), label: "Challenge"),
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: "Feeds"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP HEADER
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: widget.profileImage != null
                          ? FileImage(widget.profileImage!)
                          : const AssetImage("assets/profile_placeholder.png")
                      as ImageProvider,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Hello ${widget.fullName}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none),
                      onPressed: () {},
                    )
                  ],
                ),
              ),

              // PLAY & EARN SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Play and Earn Saabbi Coins (SC)",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Give answers to quizzes and start earning coins.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // GOLD STATS CARD
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: Colors.orange.shade100.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: const [
                        Text("75%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Win Rate"),
                      ],
                    ),
                    Column(
                      children: const [
                        Text("234",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Saabbi Coins"),
                      ],
                    ),
                    Column(
                      children: const [
                        Text("1350",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Streaks count"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // QUIZ STATS ROW
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _smallStat("Quiz done", "112"),
                    _smallStat("No of Participation", "202 X"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ACTIVITIES SECTION
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Activities",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 12),

              // ACTIVITY CARDS
              _activityCard("home1.jpeg", "Upcoming", "Starts in 3hrs"),
              _activityCard("home2.jpeg", "Ongoing", "03min left"),
              _activityCard("home3.jpeg", "Ended", ""),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _smallStat(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _activityCard(String image, String status, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset("assets/images/$image",
                  height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Tag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Burger",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: status == "Upcoming"
                              ? Colors.green.shade100
                              : status == "Ongoing"
                              ? Colors.yellow.shade100
                              : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text.rich(
                        TextSpan(
                          text: "Entry: ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "5Saabbi coins",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                      if (time.isNotEmpty)
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 16, color: Colors.red),
                            const SizedBox(width: 4),
                            Text(time,
                                style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}