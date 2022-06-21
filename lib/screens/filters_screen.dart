import 'package:flutter/material.dart';
import 'package:meals_app/widgets/drawer_main.dart';

class FiltersScreen extends StatefulWidget {
  static String routeName = '/filters';
  final Function setFilters;
  final Map<String,bool> currentFilters ;

  const FiltersScreen({Key? key, required this.setFilters,required this.currentFilters}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegan = false;
  var _vegeterian = false;
  var _lactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegeterian = widget.currentFilters['vegeterian']!;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      var currentValue, Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten' : _glutenFree,
                  'lactose' : _lactoseFree,
                  'vegan' : _vegan,
                  'vegeterian' :_vegeterian,
                };
                widget.setFilters(selectedFilters);
              })
        ],
      ),
      drawer: const DrawerMain(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  'Gluten-Free', 'Only include gluten-free meals.', _glutenFree,
                  (value) {
                setState(() {
                  _glutenFree = value;
                });
              }),
              _buildSwitchListTile('Lactose-Free',
                  'Only include Lactose-free meals.', _lactoseFree, (value) {
                setState(() {
                  _lactoseFree = value;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only include vegan meals.', _vegan,
                  (value) {
                setState(() {
                  _vegan = value;
                });
              }),
              _buildSwitchListTile(
                  'Vegeterian', 'Only include vegeterian meals.', _vegeterian,
                  (value) {
                setState(() {
                  _vegeterian = value;
                });
              }),
            ],
          )),
        ],
      ),
    );
  }
}
