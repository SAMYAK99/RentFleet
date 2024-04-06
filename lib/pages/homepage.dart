import 'package:car_app/Constants/colors.dart';
import 'package:car_app/pages/carDetailsScreen.dart';
import 'package:flutter/material.dart';

import '../Components/productCard.dart';
import '../data/CarDummyData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = const ['All', 'Ferrari', 'Porsche', 'McLaren' , 'Lamborghini', 'Bugatti', 'Aston Martin'];

  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                color: pageBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.location_on_outlined,
                    size: 24,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Location',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Manchester, UK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: pageBlack,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: const [
          Image(
            image: NetworkImage('https://nordicapis.com/wp-content/uploads/Profile-Pic-Circle-Grey-Large.png'),
          ) ,
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    itemCount: filters.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final filter = filters[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          child: Chip(
                            backgroundColor: selectedFilter == filter
                                ? pageBlack
                                : const Color.fromRGBO(245, 248, 248, 1),
                            side: const BorderSide(
                              color: Color.fromRGBO(245, 248, 248, 1),
                            ),
                            label: Text(filter ,
                            style: TextStyle(
                              color: selectedFilter == filter
                                  ? pageBackground
                                  : Colors.grey[600],
                            ),
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ) ,
                Text(
                  'Popular Cars',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 740) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.75,
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => CarDetails(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                            child: ProductCard(
                              title: product['title'] as String,
                              price: product['price'] as int,
                              image: product['imageUrl'] as String,
                              backgroundColor: index.isEven
                                  ? const Color.fromRGBO(216, 240, 253, 1)
                                  : const Color.fromRGBO(245, 247, 249, 1),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CarDetails(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                            child: ProductCard(
                              title: product['title'] as String,
                              price: product['price'] as int,
                              image: product['imageUrl'] as String,
                              backgroundColor:  const Color.fromRGBO(245, 248, 248, 1) ,
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

