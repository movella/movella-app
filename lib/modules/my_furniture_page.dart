import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movella_app/utils/services/localization.dart';
import 'package:movella_app/widgets/no_furniture_for_rent_widget.dart';
import 'package:movella_app/widgets/no_furniture_rented_widget.dart';

class MyFurniturePage extends StatefulWidget {
  const MyFurniturePage({Key? key}) : super(key: key);

  static const route = 'my_furniture';

  @override
  _MyFurniturePageState createState() => _MyFurniturePageState();
}

class _MyFurniturePageState extends State<MyFurniturePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.localize(context).myFurniture),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          Center(child: NoFurnitureRentedWidget()),
          Center(child: NoFurnitureForRentWidget()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Renting',
            icon: Icon(MdiIcons.arrowDown),
          ),
          BottomNavigationBarItem(
            label: 'For rent',
            icon: Icon(MdiIcons.arrowUp),
          ),
        ],
      ),
    );
  }
}
