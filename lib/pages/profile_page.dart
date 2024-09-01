import 'package:car_app/pages/phone_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // Get the currently signed-in user
  String? phone = FirebaseAuth.instance.currentUser?.phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: pageBackground,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: pageBackground,
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 60,
                  child: Image(
                    image: NetworkImage(
                        'https://nordicapis.com/wp-content/uploads/Profile-Pic-Circle-Grey-Large.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                phone ?? '91xxxxxxxxxxx',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 140,
              ),
              TextButton(onPressed:() async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const PhoneAuth()));
                await FirebaseAuth.instance.signOut();
              },
                  child: const Text("Logout", style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                  ),
                  )
              )
            ],
          ),
        )
       );
  }
}
