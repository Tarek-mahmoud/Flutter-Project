import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Open navigation bar
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${DateTime.now().day} ${DateTime.now().month}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isVerified = !isVerified;
                });
                if (isVerified) {
                  await FirebaseFirestore.instance.collection('attendance').add({
                    'date': DateTime.now(),
                    'userId': FirebaseAuth.instance.currentUser!.uid,
                  });
                }
              },
              child: Container(
                width: 200,
                height: 100,
                color: isVerified ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    "Click to verify attendance",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
