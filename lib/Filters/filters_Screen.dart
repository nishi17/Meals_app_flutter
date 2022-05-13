import 'package:flutter/material.dart';
import 'package:meals_app_flutter/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String rountname = '/fliters';
  Function saveFilters;
final Map<String,bool> filters;
  FiltersScreen(this.filters,this.saveFilters);


  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _gluteenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {

    _gluteenFree = widget.filters['gulten'];
    _lactoseFree = widget.filters['lactose'];
    _vegan = widget.filters['vegan'];
    _vegetarian = widget.filters['vegetarian'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filters'),
      actions: [IconButton(onPressed: (){
        final selectedFilters = {
          'gulten': _gluteenFree,
          'lactose': _lactoseFree,
          'vegan': _vegan,
          'vegetarian': _vegetarian,
        };

        widget.saveFilters(selectedFilters);}, icon: Icon(Icons.save))],),

      drawer: MainDrawer(),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Adjust your meal selection.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten-free',
                    'Only include gluten-free meals.',
                    _gluteenFree,
                    (newValue) {
                      setState(
                        () {
                          _gluteenFree = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                      'Vegetarian',
                      'Only include vegetarian meals.',
                      _vegetarian, (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegan', 'Only include vegan meals.', _vegan, (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Lactose-free',
                      'Only include lactose-free meals.',
                      _lactoseFree, (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }
}
