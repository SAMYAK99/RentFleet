import 'package:action_slider/action_slider.dart';
import 'package:car_app/Constants/colors.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
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
      bottomNavigationBar:   Padding(
        padding: const EdgeInsets.all(16.0),
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
            controller.loading();
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => const HomePage(),
            //   ),
            // );
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
            Hero(
              tag: 'car',
              child: Center(
                child: Image.asset(
                  widget.product['imageUrl'] as String,
                  fit: BoxFit.fill,
                ),
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
                      ItemCard(
                          Icons.local_gas_station, 'Fuel', 'L', widget.product['fuel'] as double, context),
                      ItemCard(Icons.speed, 'Top Speed', 'mph', widget.product['topSpeed'] as double, context),
                      ItemCard(Icons.people, 'Capacity', 'seats', widget.product['capacity'] as String, context),
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
