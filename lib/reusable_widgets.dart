import 'package:flutter/material.dart';
import 'package:smile/fav_joke_screen.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('SMILE'),
      centerTitle: true,
      backgroundColor: Colors.blue,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.menu,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavJokeScreen()),
            );
          },
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
            size: 29,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
