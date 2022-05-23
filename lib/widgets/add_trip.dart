import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/ModelProvider.dart';
import '../services/api_service.dart';
import 'package:intl/intl.dart';

class AddTrip extends StatefulWidget {
  const AddTrip(this.apiService, {Key? key}) : super(key: key);

  final APIService apiService;

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Trip here',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formGlobalKey,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _tripNameController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    const _validationError = 'Enter a valid trip name';
                    if (value == null || value.isEmpty) {
                      return _validationError;
                    }

                    return null;
                  },
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: "Trip Name"),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _destinationController,
                  autofocus: true,
                  autocorrect: false,
                  decoration:
                      const InputDecoration(hintText: "Trip Destination"),
                  textInputAction: TextInputAction.next,
                  validator: (name) {
                    if (name != null && name.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter a valid expense name';
                    }
                  },
                ),
                TextFormField(
                  controller: _startDateController,
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: "Start Date"),
                  textInputAction: TextInputAction.next,
                  validator: (name) {
                    if (name != null && name.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter a valid expense name';
                    }
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        _startDateController.text = formattedDate;
                        //  dateinput.text = formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                TextFormField(
                  controller: _endDateController,
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: "End Date"),
                  textInputAction: TextInputAction.next,
                  validator: (name) {
                    if (name != null && name.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter a valid expense name';
                    }
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = //pickedDate.toIso8601String();
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        setState(() {
                          _endDateController.text = formattedDate;
                          //  dateinput.text = formattedDate; //set output date to TextField value.
                        });
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: "Description"),
                  textInputAction: TextInputAction.done,
                  validator: (name) {
                    if (name != null && name.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter a valid expense name';
                    }
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            child: const Text('OK'),
            onPressed: () async {
              final currentState = formGlobalKey.currentState;
              if (currentState == null) {
                return;
              }
              if (currentState.validate()) {
                Trip trip = Trip(
                  tripName: _tripNameController.text,
                  destination: _destinationController.text,
                  startDate: TemporalDateTime(
                      DateTime.parse(_startDateController.text)),
                  endDate:
                      TemporalDateTime(DateTime.parse(_endDateController.text)),
                  description: _descriptionController.text,
                );

                Navigator.of(context).pop(trip);
              }
            } //,
            ),
      ],
    );
  }
}
