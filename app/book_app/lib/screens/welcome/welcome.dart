import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../root/root.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 28),
            child: const Text(
              "Chapter chatters",
              style: TextStyle(
                  color: Color(0xff43434F),
                  height: 4,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Aclonica'),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 60),
                  child: SvgPicture.asset(
                    'assets/images/readingTime.svg',
                    height: 226.0,
                    width: 293.0,
                  ),
                ),
                Container(
                  height: 282,
                  color: const Color(0xff292731),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            "A new way to connect",
                            style: TextStyle(
                                color: Color(
                                  0xFFDA4565,
                                ),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Connect, discuss and Discover",
                            style: TextStyle(
                                color: Color.fromARGB(255, 236, 232, 233),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "The complete book forum app",
                            style: TextStyle(
                                color: Color.fromARGB(255, 243, 237, 239),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyRoot()),
                              );
                            },
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Color(0xFFDA4565),
                              ),
                              foregroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 250, 245, 246),
                              ),
                              minimumSize: MaterialStatePropertyAll(
                                Size(200, 40),
                              ),
                            ),
                            child: const Text("Get started"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    Path path0 = Path();
    path0.moveTo(w * 0.0008333, h * 0.0014286);
    path0.lineTo(w * 0.9991667, 0);
    path0.quadraticBezierTo(
        w * 0.8337500, h * 0.1421429, w * 0.5008333, h * 0.1457143);
    path0.quadraticBezierTo(
        w * 0.1675000, h * 0.1425000, w * 0.0008333, h * 0.0014286);
    path0.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
