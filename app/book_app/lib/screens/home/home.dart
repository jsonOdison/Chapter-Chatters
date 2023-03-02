import 'package:book_app/screens/root/root.dart';
import 'package:book_app/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Future<void> fetchData() async {}
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFFFDD0),
      body: Column(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
              color: Color(0xffB4E4FF),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 80,
                  left: 0,
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 110,
                  left: 20,
                  child: Text(
                    "Welcome User",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 74, 73, 73)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.001,
          ),
          SizedBox(
            height: 230,
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  left: 30,
                  child: Material(
                    child: Container(
                      height: 180.0,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffB4E4FF),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 170,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/book1.jpg"))),
                    ),
                  ),
                ),
                Positioned(
                    top: 45,
                    left: 160,
                    child: SizedBox(
                      height: 150,
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Harry Potter : Deadly Hallow",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 51, 104, 195),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "J.K Rowling",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: Colors.black,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              CurrentUser currentUser =
                  Provider.of<CurrentUser>(context, listen: false);
              String returnString = await currentUser.SingOut();
              if (returnString == 'success') {
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyRoot()),
                    (route) => false);
              }
            },
            child: const Text("Sign out"),
          ),
        ],
      ),
    );
  }
}
