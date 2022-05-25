import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UploadsTab extends StatefulWidget {
  const UploadsTab({Key? key}) : super(key: key);

  @override
  State<UploadsTab> createState() => _UploadsTabState();
}

class _UploadsTabState extends State<UploadsTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Uploads Page'),
    );
  }
}
