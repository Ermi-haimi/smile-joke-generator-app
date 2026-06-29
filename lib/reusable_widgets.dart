import 'package:flutter/material.dart';
import 'package:smile/fav_joke_screen.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isFavPage;

  const Appbar({
    this.isFavPage = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'SMILE',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: [
        isFavPage
            ? SizedBox(
                width: 0,
              )
            : IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavJokeScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: Color(0xFF61a5c2),
                  size: 29,
                ),
              ),
        IconButton(
          onPressed: () {
            context.read<ThemeProvider>().toggleTheme();
          },
          icon: Icon(
            context.watch<ThemeProvider>().isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
