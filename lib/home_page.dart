import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'language_provider.dart';
import 'reusable_widgets.dart';
import 'constants.dart';
import 'joke_generator.dart';
import 'fav_joke_provider.dart';
import 'package:share_plus/share_plus.dart';

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
  Future<void> getJoke() async {
    setState(() {
      isLoading = true;
    });

    try {
      final joke = await fetchJoke(category: selectedCategory);

      setState(() {
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
              leading: const Icon(Icons.language),
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
          ),

          successfulLoad
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
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
                              context.read<FavJokeProvider>().toggleFavorite(
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
                )
              : SizedBox(
                  height: 5,
                ),
          SizedBox(
            height: 50,
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

  const JokeDisplayer({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Theme.of(context).cardTheme.color,
        shadowColor: Theme.of(context).cardTheme.shadowColor,

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              joke,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
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
              title: const Text('English'),
              onTap: () {
                context.read<LanguageProvider>().changeLanguage('en');

                Navigator.pop(context);
              },
              splashColor: null,
            ),
            ListTile(
              title: const Text('አማርኛ'),
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
