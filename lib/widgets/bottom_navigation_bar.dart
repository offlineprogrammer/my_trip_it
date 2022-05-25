import 'package:flutter/material.dart';

import 'tab_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar(
      {Key? key, required this.currentTab, required this.onSelectTab})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.trips),
        _buildItem(TabItem.uploads),
        _buildItem(TabItem.profile),
      ],
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: tabIcon[tabItem]!,
      label: tabName[tabItem],
    );
  }
}
