import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/database.dart';
import '../../../states/current_user.dart';
import '../../root/root.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({super.key});

  @override
  State<JoinGroup> createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  void _joinGroup(BuildContext context, String groupId) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString =
        await Database().createGroup(groupId, currentUser.getUid!.uid);
    if (returnString == 'success') {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyRoot(),
          ),
          (route) => false);
    }
  }

  final TextEditingController _groupIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 200,
              color: Colors.white,
              child: Column(
                children: [
                  const BackButton(),
                  TextFormField(
                    controller: _groupIDController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.add_alarm_outlined),
                        hintText: 'Enter Group ID'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 78, 24, 148),
                      ),
                    ),
                    onPressed: () =>
                        _joinGroup(context, _groupIDController.text),
                    child: const Text("Join"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
