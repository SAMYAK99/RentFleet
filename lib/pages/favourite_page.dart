import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/provider/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/colors.dart';
import '../provider/cart_provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {

  @override
  Widget build(BuildContext context) {

    final favourites = context.watch<FavouritesProvider>().favourites;

    return Scaffold(
        backgroundColor: pageBackground,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: pageBackground,
          title: Text(
            'Favorites',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
        ),
        body: favourites.isEmpty
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bookmark_add_outlined,
                size: 100,
                color: Colors.grey,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'No favorites yet',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          itemCount: favourites.length,
          itemBuilder: (context, index) {
            final product = favourites[index];
            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: product['imageUrl'],
                    width: 85,
                    height: 60,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => Image.network(
                        'https://www.nicepng.com/png/detail/777-7772737_car-placeholder-image-lamborghini-gallardo.png'),
                    placeholder: (context, url) => Image.network(
                        'https://www.nicepng.com/png/detail/777-7772737_car-placeholder-image-lamborghini-gallardo.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          product['title'],
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Price: \$${product['price']} / day',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context
                          .read<FavouritesProvider>()
                          .removeProductFromFavourite(product);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
