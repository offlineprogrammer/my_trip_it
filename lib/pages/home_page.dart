import 'package:flutter/material.dart';

import '../models/ModelProvider.dart';
import '../services/api_service.dart';
import '../widgets/add_trip.dart';
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
  final APIService _apiService = APIService();
  List<Trip> _trips = const [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getLatestTrips() async {
    try {
      final trips = await _apiService.getTrips();
      setState(() {
        _trips = trips?.whereType<Trip>().toList() ?? const [];
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      ));
    }
  }

  void _showAddTripDialog(BuildContext context) async {
    var value = await showDialog<Trip>(
      context: context,
      builder: (BuildContext context) {
        return AddTrip(_apiService);
      },
    );
    if (value != null) {
      await _apiService.saveTrip(value);
      await _getLatestTrips();
    }
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
