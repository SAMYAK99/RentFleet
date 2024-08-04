import 'package:action_slider/action_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/Constants/colors.dart';
import 'package:car_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetails extends StatefulWidget {
  final Map<String, Object> product;

  const CarDetails({
    super.key,
    required this.product,
  });

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  void onAddToCartClick() {
    Provider.of<CartProvider>(context, listen: false)
        .addProduct(widget.product);
    if(Provider.of<CartProvider>(context, listen: false).cart.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to cart'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: pageBackground,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 26,
                )),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 26,
                  )),
            ),
          )
        ],
        title: Text(
          'Car Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32 , vertical:  16.0),
        child: ActionSlider.standard(
          toggleColor: bluePrimary,
          backgroundColor: pageBlack,
          child: Text(
            'Add to Cart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          rolling: true,
          action: (controller) async {
            onAddToCartClick();
            controller.loading();
            Navigator.of(context).pop();
          }, //many more parameters
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product['title'] as String,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      widget.product['year'] as String,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ]),
            ),
            const SizedBox(height: 24),
            Center(
              child: CachedNetworkImage(
                imageUrl: widget.product['imageUrl'] as String,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) =>  Image.network('https://www.nicepng.com/png/detail/777-7772737_car-placeholder-image-lamborghini-gallardo.png'),
                placeholder: (context, url) => Image.network('https://www.nicepng.com/png/detail/777-7772737_car-placeholder-image-lamborghini-gallardo.png'),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Car Specs",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemCard(Icons.local_gas_station, 'Fuel', 'L',
                          widget.product['fuel'] as int, context),
                      ItemCard(Icons.speed, 'Top Speed', 'mph',
                          widget.product['topSpeed'] as int, context),
                      ItemCard(Icons.people, 'Capacity', 'seats',
                          widget.product['capacity'] as String, context),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image(
                        image: AssetImage('assets/images/location.png'),
                        height: 150,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget ItemCard(IconData icon, String title, String units, dynamic value,
    BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.grey,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Row(
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              units,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        )
      ],
    ),
  );
}
