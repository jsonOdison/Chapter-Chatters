import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LibrarySection extends StatefulWidget {
  const LibrarySection({super.key});

  @override
  State<LibrarySection> createState() => _LibrarySectionState();
}

class _LibrarySectionState extends State<LibrarySection> {
  late DocumentReference<Map<String, dynamic>> userRef;
  late double _cardWidth;
  @override
  void initState() {
    super.initState();
    setState(() {
      userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: userRef.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        final library =
            (snapshot.data?.data() as Map<String, dynamic>)['library'] ?? [];
        final screenWidth = MediaQuery.of(context).size.width;
        if (screenWidth < 600) {
          _cardWidth = (screenWidth - 30) / 2;
        } else {
          _cardWidth = (screenWidth - 50) / 4;
        }
        return library.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Your Library is currently Empty ",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              )
            : const Text("data");
      },
    );
  }
}
