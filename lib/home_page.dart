import 'package:flutter/material.dart';
import 'reusable_widgets.dart';
import 'constants.dart';
import 'joke_generator.dart';

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
    print(joke);

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
          JokeDisplayer(
            joke: currentJoke,
          ),
          ElevatedButton.icon(
            onPressed: getJoke,
            icon: const Icon(Icons.refresh),
            label: const Text('Get a Joke'),
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
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 15,
      children: categories.map((category) {
        return ChoiceChip(
          label: Text(category),
          selected: selectedCategory == category,
          onSelected: (selected) {
            setState(() {
              selectedCategory = category;
            });
          },
        );
      }).toList(),
    );
  }
}

class JokeDisplayer extends StatelessWidget {
  final String joke;

  const JokeDisplayer({required this.joke});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          joke,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
