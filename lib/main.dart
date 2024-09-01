import 'package:car_app/Components/navigation_menu.dart';
import 'package:car_app/pages/car_details_screen.dart';
import 'package:car_app/pages/intropage.dart';
import 'package:car_app/pages/phone_auth.dart';
import 'package:car_app/provider/cart_provider.dart';
import 'package:car_app/provider/favourites_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavouritesProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Figtree',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2F2E33) ,
            primary: const Color.fromRGBO(254, 206, 1, 1),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize:26,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            bodyLarge: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),

          ),
        ),
        home: CheckUser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


class CheckUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the currently signed-in user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is logged in
    if (user != null) {
      // The user is logged in
      return const NavigationMenu();
    } else {
      // No user is logged in
      return const PhoneAuth();
    }
  }
}
