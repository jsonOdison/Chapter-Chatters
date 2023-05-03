import 'package:book_app/services/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/book.dart';
import '../../services/Books_api/fetch_books.dart';
import '../../widgets/widgets.dart';

class SearchBook extends StatefulWidget {
  const SearchBook({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  TextEditingController searchBookController = TextEditingController();
  bool _isLoading = false;
  List<BookModel> books = [];

  Future<void> _fetchBooks(String searchTerm) async {
    setState(() {
      _isLoading = true;
    });
    List<BookModel> fetchedBooks = await BooksApi().fetchBooks(searchTerm);
    setState(() {
      _isLoading = false;
      books = fetchedBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "Search books",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    color: Colors.black,
                    onPressed: () {
                      // Do something
                    },
                  ),
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      AssetImage("assets/icons/avatar_profile.png"),
                ),
              ],
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.1,
              color: Colors.white.withOpacity(0.9),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.8,
                    child: TextField(
                      controller: searchBookController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade600, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "isbn , author , title ",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _fetchBooks(searchBookController.text),
                    child: Container(
                      width: screenWidth * 0.1,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40)),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        var book = books[index];
                        var bookId = book.id;
                        var bookTitle = book.title;

                        var img = book.thumbnail;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(
                              img,
                              height: screenHeight * 0.2,
                              width: screenWidth * 0.2,
                            ),
                            title: Text(bookTitle),
                            trailing: ElevatedButton(
                                onPressed: () {
                                  addToLibrary(bookId);
                                },
                                child: const Text("Add book")),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addToLibrary(bookId) async {
    await DatabaseService().addBookToLibrary(bookId, "");
    if (kDebugMode) {
      print("successfully added");
    }
    showSnackBar(BuildContext, "Book created succesfully",
        const Color.fromARGB(255, 50, 114, 52));
  }
}
