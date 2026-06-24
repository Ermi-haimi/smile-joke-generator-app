import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reusable_widgets.dart';
import 'constants.dart';
import 'joke_generator.dart';
import 'fav_joke_provider.dart';

String selectedCategory = 'Any';
String currentJoke = 'NO JOKE';
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
        currentJoke = "Sorry Cannot Load A Joke. \n Check your network Please.";
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
      body: Column(
        children: [
          CategorySelector(),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: JokeDisplayer(
              joke: currentJoke,
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
              color: successfulLoad ? Color(0xff013a63) : Colors.transparent,
              size: 29,
            ),
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
                    'Get A New Joke',
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
    return SizedBox(
      width: double.infinity,
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
