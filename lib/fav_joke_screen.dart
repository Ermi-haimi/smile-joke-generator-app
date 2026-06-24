import 'package:flutter/material.dart';
import 'reusable_widgets.dart';
import 'fav_joke_provider.dart';
import 'package:provider/provider.dart';

class FavJokeScreen extends StatelessWidget {
  const FavJokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteJokes = context.watch<FavJokeProvider>().favJokes;
    return Scaffold(
      appBar: Appbar(isFavPage: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context, index) {
                final item = favoriteJokes[index];
                return Card(
                  // color: Color(0xFF89c2d9),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            softWrap: true,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<FavJokeProvider>().toggleFavorite(
                              joke: favoriteJokes[index],
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xff01497c),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
