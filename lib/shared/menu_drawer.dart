import 'package:flutter/material.dart';
import 'package:globo_fitness/screens/add_item.dart';
import 'package:globo_fitness/screens/bmi_screen.dart';
import 'package:globo_fitness/screens/intro_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Home',
      'Inventory',
      'Menu',
      'Add an Item'
    ];

    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text(
        'Ordering App',
        style: TextStyle(color: Colors.white, fontSize: 28),
      ),
    ));

    for (var element in menuTitles) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(element, style: const TextStyle(fontSize: 18)),
        onTap: () {
          switch (element) {
            case 'Home':
              screen = const IntroScreen();
              break;
            case 'Inventory':
              screen = const BmiScreen();
              break;
            case 'Add an Item':
              screen = const AddItem();
              break;
          }
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
      ));
    }

    return menuItems;
  }
}
