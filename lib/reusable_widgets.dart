import 'package:flutter/material.dart';

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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
