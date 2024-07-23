import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatelessWidget {

  final int currentIndex;

  const BottomNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch(index) {
      case 0:
        context.go('/home/0');
        break;
      
      case 1:
        context.go('/home/1');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Pokedex'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.catching_pokemon),
          label: 'Capturados'
        ),
      ],
    );
  }
}