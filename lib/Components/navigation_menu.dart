import 'package:car_app/Constants/colors.dart';
import 'package:car_app/pages/favourite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Pages/homepage.dart';
import '../pages/cart_page.dart';
import '../pages/profile_page.dart';


class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {

  int currentPage = 0;

  List<Widget> pages = const [HomePage(),FavouritePage() ,CartPage(),ProfilePage() ];

   _onWillPop() async {
     if(currentPage == 0){
       SystemNavigator.pop();
     }
    else  {
      // If currently on the 4th screen, navigate back to the home screen
      setState(() {
        currentPage = 0;
      });
      return false; // Prevent default back navigation
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: pageBackground,
        bottomNavigationBar: NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: pageBackground,
          selectedIndex: currentPage,
          onDestinationSelected: (index) {
              setState(() {
                currentPage = index;
              });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ) ,
        body:IndexedStack(
          index: currentPage,
          children: pages,
        )
      ),
    ) ;
  }
}

