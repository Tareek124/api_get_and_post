import 'dart:ui';

import 'package:api_get_and_post/pages/add_data.dart';
import 'package:flutter/material.dart';
import 'get_users.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 60),
            const Image(
              image: AssetImage('assets/images/rain-drop-hi.png'),
              width: 500,
              height: 300,
            ),
            const Text(
              "API",
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GetUsersPage()),
                        );
                      },
                      child: const Text("Get Users")),
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddData()),
                        );
                      },
                      child: const Text("Add Users")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
