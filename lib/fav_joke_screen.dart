import 'package:flutter/material.dart';
import 'package:smile/l10n/app_localizations.dart';
import 'reusable_widgets.dart';
import 'fav_joke_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class FavJokeScreen extends StatelessWidget {
  const FavJokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteJokes = context.watch<FavJokeProvider>().favJokes;
    return Scaffold(
      appBar: Appbar(isFavPage: true),
      body: favoriteJokes.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.noFavourite,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    AppLocalizations.of(context)!.favourites,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteJokes.length,
                    itemBuilder: (context, index) {
                      final item = favoriteJokes[index];
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(item),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                onPressed: () {
                                  SharePlus.instance.share(
                                    ShareParams(text: favoriteJokes[index]),
                                  );
                                },
                                icon: Icon(
                                  Icons.share,
                                  color: Color(0xff01497c),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<FavJokeProvider>()
                                      .toggleFavorite(
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
