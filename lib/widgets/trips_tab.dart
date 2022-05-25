import 'package:flutter/material.dart';

import '../models/ModelProvider.dart';
import '../services/api_service.dart';
import 'add_trip.dart';

class TripsTab extends StatefulWidget {
  const TripsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<TripsTab> createState() => _TripsTabState();
}

class _TripsTabState extends State<TripsTab> {
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

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page'),
    );
  }
}
