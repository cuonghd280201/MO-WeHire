import 'package:flutter/material.dart';
import 'package:we_hire/src/constants/colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isDotActive = true; // Biến để kiểm tra trạng thái hoạt động

  void toggleDotActive() {
    setState(() {
      isDotActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kRed,
      body: ListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDotActive ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(
                    width: 16), // Khoảng cách giữa dấu chấm và biểu tượng
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.access_alarm,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            title: const Text("Notification"),
            subtitle: const Text("Staff invited you to take part"),
            onTap: () {
              toggleDotActive();
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: 25,
      ),
    );
  }
}
