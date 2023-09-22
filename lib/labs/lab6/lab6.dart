import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:school_labs/labs/lab6/cropped_position.dart';
import 'package:school_labs/labs/lab6/geolocator_service.dart';
import 'package:school_labs/labs/lab6/helpers.dart';

part 'widgets/current_coord_widget.dart';
part 'widgets/tracked_coord_list.dart';

const _minDistance = 100.0;

class Lab6 extends StatefulWidget {
  const Lab6({super.key});

  @override
  State<Lab6> createState() => _Lab6State();
}

class _Lab6State extends State<Lab6> {
  final _service = GeolocatorService();
  Stream<Position>? positionsStream;

  List<CroppedPosition> positionsToTrack = mockedPositions;

  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (positionsStream == null) {
      _service.initCoords(context).then((value) {
        setState(() => positionsStream = value);
      });
    }
  }

  void addCoordToTrack() {
    final double? lat = num.tryParse(latController.text)?.toDouble();
    final double? long = num.tryParse(longController.text)?.toDouble();

    if (lat == null || long == null || nameController.text.trim().isEmpty) {
      return;
    }

    final position = CroppedPosition(
      latitude: lat,
      longitude: long,
      name: nameController.text,
    );

    positionsToTrack.add(position);
    setState(() {});
    latController.clear();
    longController.clear();
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Lab 6 David Daniel')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            child: Column(
              children: [
                CurrentCoordinatesWidget(positionsStream: positionsStream),
                Divider(
                  height: 22,
                  color: Colors.green[700],
                ),
                const Text(
                  'Get the distance to: ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Name',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: latController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Latitude',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: longController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Longitude',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CupertinoButton(
                        onPressed: addCoordToTrack,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.green[800],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                            'Add coord to track',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (positionsToTrack.isNotEmpty) ...[
                  const Text(
                    'Tracked coordinates: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  _TrackedCoordinatesWidget(
                    positionsStream: positionsStream,
                    positionsToTrack: positionsToTrack,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
