import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 20,
                                    right: 40,
                                    left: 10,
                                  ),
                                  child: Text(
                                    item,
                                    style: TextStyle(),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        SharePlus.instance.share(
                                          ShareParams(
                                            text: favoriteJokes[index],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.share,
                                        color: Color(0xff69b3f6),
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
                                        color: Color(0xff69b3f6),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              right: 1,
                              top: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.copy,
                                  color: Color(0xff69b3f6),
                                ),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(text: item),
                                  );

                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text('Joke copied!'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
              ],
            ),
    );
  }
}
