import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import '../../../../controllers/dashboard/home/Address/mapScreenController.dart';

class MapScreen extends StatelessWidget {
  final MapScreenController mapScreenController = Get.put(MapScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PlacePicker(
          apiKey:'AIzaSyA1REc4g_Q3MyPZqHHVraDtH8wgPKbJvzE',
          hintText: "Find a place ...",
          searchingText: "Please wait ...",
          selectText: "CONFIRM LOCATION",
          outsideOfPickAreaText: "Place not in area",
          initialPosition: const LatLng(11.009128, 76.957778),
          useCurrentLocation: false,
          selectInitialPosition: true,
          usePinPointingSearch: true,
          usePlaceDetailSearch: true,
          onPlacePicked: (PickResult result) {
            mapScreenController.pickedPlace(result);
          },

        ),
    ));
      }
}
