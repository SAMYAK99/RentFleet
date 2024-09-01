import 'package:car_app/Constants/colors.dart';
import 'package:car_app/pages/car_details_screen.dart';
import 'package:car_app/provider/favourites_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/product_card.dart';
import '../data/car.dart';
import '../data/car_dummy_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = const ['All', 'Ferrari', 'Porsche', 'McLaren' , 'Lamborghini', 'Bugatti', 'Aston Martin'];

  late String selectedFilter;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch cars from Firestore database
  Future<List<Car>> fetchCars() async {
    QuerySnapshot snapshot = await _firestore.collection('cars').get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      print('Mapping document: $data');
      return Car.fromFirestore(data);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  void onAddToFavouritesClick(Map<String, Object> product) {
    Provider.of<FavouritesProvider>(context, listen: false)
        .addProductToFavourite(product);
    if(Provider.of<FavouritesProvider>(context, listen: false).favourites.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to favourites'),
          duration: Duration(seconds: 1),
        ),
      );
    }
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
        automaticallyImplyLeading: false, // This removes the back button
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
      body: FutureBuilder<List<Car>>(
        future: fetchCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cars found'));
          } else {
            return SingleChildScrollView(
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
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.75,
                              ),
                              itemBuilder: (context, index) {
                                Car car = snapshot.data![index];
                                final Map<String, Object> product = {
                                  'title': car.title,
                                  'price': car.price,
                                  'imageUrl': car.imageUrl,
                                  'fuel': car.fuel,
                                  'capacity': car.capacity,
                                  'topSpeed': car.topSpeed,
                                  'year': car.year,
                                };
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
                                    fuel: product['fuel'] as int,
                                    capacity: product['capacity'] as String,
                                    backgroundColor: index.isEven
                                        ? const Color.fromRGBO(216, 240, 253, 1)
                                        : const Color.fromRGBO(245, 247, 249, 1),
                                    onFavClick: onAddToFavouritesClick, // Pass the callback here
                                    product: product,
                                  ),
                                );
                              },
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                 Car car = snapshot.data![index];
                                 final Map<String, Object> product = {
                                   'title': car.title,
                                   'price': car.price,
                                   'imageUrl': car.imageUrl,
                                   'fuel': car.fuel,
                                   'capacity': car.capacity,
                                   'topSpeed': car.topSpeed,
                                    'year': car.year,
                                 };
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
                                    image: product['imageUrl'] as String,
                                    fuel: product['fuel'] as int,
                                    price: product['price'] as int,
                                    capacity: product['capacity'] as String,
                                    backgroundColor:  const Color.fromRGBO(245, 248, 248, 1) ,
                                    onFavClick: onAddToFavouritesClick, // Pass the callback here
                                    product: product,
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
            );
          }
        },
      ),
    );
  }
}

