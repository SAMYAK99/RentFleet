import 'package:action_slider/action_slider.dart';
import 'package:car_app/constants/colors.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.9,
              ],
              colors: [
                Color(0xFF0E0E10),
                Color(0xFF263339),
                Color(0xFF0E0E10),
              ],
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Luxury\nCar Rental',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Rent the car of your dreams to travel anywhere in the world',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(
                  height: 56,
                ),
                Image(
                  image: AssetImage('assets/images/car5.png'),
                ),
                Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ActionSlider.standard(
                    toggleColor: bluePrimary,
                    backgroundColor: pageBlack,
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    rolling: true,
                    action: (controller) async {
                      controller.loading();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }, //many more parameters
                  ),
                )
              ],
            )),
      ),
    );
  }
}
