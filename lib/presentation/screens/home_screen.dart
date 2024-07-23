import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/presentation/views/captured_view.dart';
import 'package:pokedex_flutter_app/presentation/views/pokedex_view.dart';
import 'package:pokedex_flutter_app/shared/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';
  final int pageIndex;
  
  HomeScreen({
    super.key,
    required this.pageIndex
  });

  final viewRoutes =  <Widget>[
    const PokedexView(),
    const CapturedView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: pageIndex),
    );
  }
}