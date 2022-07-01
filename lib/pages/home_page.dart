import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import '../widgets/tab_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  var _currentTab = TabItem.trips;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  Widget _buildBody() {
    return tabPage[_currentTab]!; // TODO: return a widget representing a page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: AppBottomNavigationBar(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }
}
