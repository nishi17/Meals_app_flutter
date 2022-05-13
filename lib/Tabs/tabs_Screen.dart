import 'package:flutter/material.dart';

import '../Category/categories_screen.dart';
import '../main_drawer.dart';
import '../model/meal.dart';
import 'favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favMeals;

  TabsScreen(this.favMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavouritesScreen(widget.favMeals), 'title': 'Your favourites'}
    ];

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return /* buildDefaultTabControllerTopTab()*/
        Scaffold(
      appBar: AppBar(
        title:
            Center(child: Text(_pages[_selectedPageIndex]['title'].toString())),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }

  DefaultTabController buildDefaultTabControllerTopTab() {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(
                Icons.category,
              ),
              text: 'Categories',
            ),
            Tab(
              icon: Icon(
                Icons.star,
              ),
              text: 'Favourites',
            ),
          ]),
        ),
        body: TabBarView(children: [CategoriesScreen(), FavouritesScreen(widget.favMeals)]),
      ),
    );
  }
}
