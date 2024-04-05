import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final int price;
  final String image;
  final Color backgroundColor;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 240,
                child: Text(
                  title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(onPressed: () {},
                    icon: const Icon(Icons.favorite_border ,
                    size: 26,
                    )),
              )
            ],
          ) ,
          Center(
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.card_travel_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '4.5',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.people,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '4',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                "\$120/day",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ) ,
        ],
      ),
    );
  }
}
