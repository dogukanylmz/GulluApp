

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gullu_app/Views/history_view.dart';

import 'package:gullu_app/Views/products_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBar extends StatelessWidget{
   NavBar({super.key});

   List<Widget> _screens(){
    return [
      const Products(),
      const HistoryView()
    ];
   }
  final PersistentTabController _controller=PersistentTabController(initialIndex: 0);
   List<PersistentBottomNavBarItem> _navbaricons(){
    return [
      PersistentBottomNavBarItem(icon:const Icon(Icons.shopping_bag_rounded),
        activeColorPrimary: Colors.red,
      inactiveColorPrimary: Colors.grey,
      title:"Ürünler"
       ),
      PersistentBottomNavBarItem(icon:const Icon(FontAwesomeIcons.fileContract),
      activeColorPrimary: Colors.red,
      inactiveColorPrimary: Colors.grey,
      title:"Geçmiş",
      
       )
    ];
   }
 @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,

        controller: _controller,
        screens: _screens(),
        items: _navbaricons() ,
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties:const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation:const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds:400),
        ),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}




