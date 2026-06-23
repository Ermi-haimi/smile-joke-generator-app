import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reusable_widgets.dart';
import 'constants.dart';
import 'joke_generator.dart';
import 'fav_joke_provider.dart';

String selectedCategory = 'Any';
String currentJoke = 'NO JOKE';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> getJoke() async {
    final joke = await fetchJoke(
      category: selectedCategory,
    );

    setState(() {
      currentJoke = joke;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              if (currentJoke != "NO JOKE") {
                context.read<FavJokeProvider>().addJoke(
                  joke: currentJoke,
                );
              }
            },
            icon: Icon(
              // currentJoke in Fa,
              Icons.favorite_border,
              color: Colors.red,
              size: 29,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            onPressed: getJoke,
            child: Text(
              'Get A New Joke',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
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
            label: Text(category),
            showCheckmark: false,
            selectedColor: Color(0xFFACD3FA),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              joke,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
