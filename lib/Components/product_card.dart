import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favourites_provider.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final int price;
  final String image;
  final Color backgroundColor;
  final String capacity;
  final int fuel ;
  final Function(Map<String, Object> product)? onFavClick;
  final  Map<String, Object> product ;

  const ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.backgroundColor,
    required this.capacity,
    required this.fuel,
    required this.price,
    required this.onFavClick,
    required this.product
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    bool isFavourite = false;
    isFavourite = Provider.of<FavouritesProvider>(context, listen: false)
        .isFavourite(widget.product);

    void _toggleFavourite() {
      if (isFavourite) {
        Provider.of<FavouritesProvider>(context, listen: false)
            .removeProductFromFavourite(widget.product);
      } else {
        widget.onFavClick!(widget.product);
      }
      setState(() {
        isFavourite = !isFavourite;
      });
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
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
                  widget.title,
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
                child: IconButton(onPressed: () {
                    _toggleFavourite();
                },
                    icon: isFavourite ? const Icon(Icons.favorite,
                      color: Colors.red,
                      size: 26,
                    ) : const Icon(Icons.favorite_border,
                      color: Colors.grey,
                    size: 26,
                    )),
              )
            ],
          ) ,
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.image,
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
                      widget.fuel.toString(),
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
                      widget.capacity,
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
                "\$ ${widget.price}/day",
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
