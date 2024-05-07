import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  void _createGroup(BuildContext context, String groupName) async {
    // CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    // String returnString =
    //     await DatabaseService().createGroup(groupName, currentUser.getUid!.uid);
    // if (returnString == 'success') {
    //   // ignore: use_build_context_synchronously
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const MyRoot(),
    //       ),
    //       (route) => false);
    // }
  }

  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
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
                    controller: _groupNameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.add_alarm_outlined),
                        hintText: 'Enter Group Name'),
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
                        _createGroup(context, _groupNameController.text),
                    child: const Text("Create"),
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
