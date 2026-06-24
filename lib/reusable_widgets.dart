import 'package:flutter/material.dart';
import 'package:smile/fav_joke_screen.dart';

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
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 25,
        ),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF2a6f97),
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
                      builder: (context) => const FavJokeScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: Color(0xFF61a5c2),
                  size: 29,
                ),
              ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
