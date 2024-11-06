import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({super.key});

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  String? username;
  final TextEditingController textEditingController = TextEditingController();

  setSharedPref(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", value);
  }

  getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello, ${username ?? "Username"}!",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: textEditingController,
          ),
          ElevatedButton(
              onPressed: () {
                if (textEditingController.text.isEmpty) {
                  SnackBar snackBar =
                      SnackBar(content: Text("Field tidak boleh kosong!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  setState(() {
                    username = textEditingController.text;
                    setSharedPref(username!);
                  });
                }
              },
              child: Text("Save"))
        ],
      ),
    );
  }
}
