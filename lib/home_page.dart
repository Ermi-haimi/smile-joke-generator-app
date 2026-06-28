import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'language_provider.dart';
import 'reusable_widgets.dart';
import 'constants.dart';
import 'joke_generator.dart';
import 'fav_joke_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'recent_jokes.dart';

String selectedCategory = 'Any';
String currentJoke = '';
bool isLoading = false;
bool successfulLoad = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RecentJokes recents = RecentJokes();

  Future<void> getJoke() async {
    setState(() {
      isLoading = true;
    });

    try {
      final joke = await fetchJoke(category: selectedCategory);

      setState(() {
        recents.addJoke(joke: joke);
        // recents.resetIndex();
        currentJoke = joke;
        successfulLoad = true;
      });
    } catch (e) {
      setState(() {
        currentJoke = AppLocalizations.of(context)!.errorWhileFetching;
        successfulLoad = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<FavJokeProvider>().isFavorite(currentJoke);
    return Scaffold(
      appBar: Appbar(),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(
                AppLocalizations.of(context)!.lang,
              ),
              onTap: () {
                showLanguageDialog(context);
              },
              splashColor: null,
            ),
            AboutListTile(
              icon: Icon(Icons.info_outline),
              applicationName: 'Smile',
              applicationVersion: '1.0.0',
              applicationLegalese: '© Ermias Haimanot Tsegaye',
              aboutBoxChildren: [
                SizedBox(height: 10),
                Text(AppLocalizations.of(context)!.description),
              ],
              child: Text(AppLocalizations.of(context)!.about),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          CategorySelector(),
          SizedBox(
            height: 30,
          ),
          JokeDisplayer(
            joke: currentJoke.isEmpty
                ? AppLocalizations.of(context)!.noNewJoke
                : currentJoke,
            status: successfulLoad,
          ),

          successfulLoad
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: recents.hasPrev()
                              ? () {
                                  setState(() {
                                    currentJoke = recents.getPrevJoke();
                                  });
                                }
                              : null,
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: recents.hasNext()
                              ? () {
                                  setState(() {
                                    currentJoke = recents.getNextJoke();
                                  });
                                }
                              : null,
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            SharePlus.instance.share(
                              ShareParams(text: currentJoke),
                            );
                          },
                          icon: Icon(
                            Icons.share,
                            color: Color(0xff69b3f6),
                          ),
                        ),
                        IconButton(
                          onPressed: successfulLoad
                              ? () {
                                  context
                                      .read<FavJokeProvider>()
                                      .toggleFavorite(
                                        joke: currentJoke,
                                      );
                                }
                              : null,
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Color(0xff69b3f6),
                            size: 29,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : SizedBox(
                  height: 25,
                ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            onPressed: isLoading ? null : getJoke,
            child: isLoading
                ? CircularProgressIndicator(
                    backgroundColor: Color(0xFFe9ecef),
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  )
                : Text(
                    AppLocalizations.of(context)!.getJoke,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 15,
        children: categories.map((category) {
          return ChoiceChip(
            label: Text(
              category,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            showCheckmark: false,
            selected: selectedCategory == category,
            onSelected: (selected) {
              setState(() {
                selectedCategory = category;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}

class JokeDisplayer extends StatelessWidget {
  final String joke;
  final bool status;

  const JokeDisplayer({super.key, required this.joke, required this.status});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Theme.of(context).cardTheme.color,
        shadowColor: Theme.of(context).cardTheme.shadowColor,

        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, 0.05),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    joke,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                    key: ValueKey(joke),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              child: IconButton(
                icon: Icon(Icons.copy),
                onPressed: status
                    ? () {
                        Clipboard.setData(
                          ClipboardData(text: joke),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Joke copied!'),
                          ),
                        );
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.lang,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('English'),
              onTap: () {
                context.read<LanguageProvider>().changeLanguage('en');

                Navigator.pop(context);
              },
              splashColor: null,
            ),
            ListTile(
              title: Text('አማርኛ'),
              onTap: () {
                context.read<LanguageProvider>().changeLanguage('am');

                Navigator.pop(context);
              },
              splashColor: null,
            ),
          ],
        ),
      );
    },
  );
}
