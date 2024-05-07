// import 'package:book_app/services/database/database.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   List<dynamic> _library = [];

//   @override
//   void initState() {
//     super.initState();
//     _initLibrary();
//   }

//   Future<void> _initLibrary() async {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//     final library = await DatabaseService().getLibraryFromDB(userId);
//     setState(() {
//       _library = library;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Book List'),
//       ),
//       body: ListView.builder(
//         itemCount: _library.length,
//         itemBuilder: (BuildContext context, int index) {
//           final bookData = _library[index] as Map<String, dynamic>;
//           final bookId = bookData['id'] as String;
//           return ListTile(
//             title: Text(bookId),
//           );
//         },
//       ),
//     );
//   }
// }
