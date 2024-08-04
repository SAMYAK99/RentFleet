import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final int price;
  final String image;
  final Color backgroundColor;
  final String capacity;
  final int fuel ;

  const ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.backgroundColor,
    required this.capacity,
    required this.fuel,
    required this.price,
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
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) =>  Image.network('https://www.nicepng.com/png/detail/777-7772737_car-placeholder-image-lamborghini-gallardo.png'),
              placeholder: (context, url) => Image.network('https://www.nicepng.com/png/detail/777-7772737_car-placeholder-image-lamborghini-gallardo.png'),
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
                    const Icon(Icons.local_gas_station,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      fuel.toString(),
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
                      capacity,
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
                "\$ $price/day",
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
