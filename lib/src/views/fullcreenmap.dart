import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;

  final center = LatLng(37.810367, -122.479344);
  String selectedStyle = 'mapbox://styles/wizok/ckeq1hwq432eq19s0kptg6s0j';
  final oscuroStyle = 'mapbox://styles/wizok/ckeq1chyy4jhm19o0ijvfm9x7';
  final streetStyle = 'mapbox://styles/wizok/ckeq1hwq432eq19s0kptg6s0j';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Simbolos
        FloatingActionButton(
          child: Icon(Icons.sentiment_very_dissatisfied),
          onPressed: () {
            mapController.addSymbol(
              SymbolOptions(
                geometry: center,
                iconSize: 3,
                iconImage: 'attraction-15',
                textField: 'Montaña creada aquí',
                textOffset: Offset(0, 2),
              ),
            );
          },
        ),
        SizedBox(height: 5),

        // Zoom in
        FloatingActionButton(
            child: Icon(Icons.zoom_in),
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomIn());
            }),
        SizedBox(height: 5),

        // Zoom out
        FloatingActionButton(
            child: Icon(Icons.zoom_out),
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomOut());
            }),
        SizedBox(height: 5),

        // Cambiar Estilos
        FloatingActionButton(
          child: Icon(Icons.add_to_home_screen),
          onPressed: () {
            if (selectedStyle == oscuroStyle) {
              selectedStyle = streetStyle;
            } else {
              selectedStyle = oscuroStyle;
            }
            setState(() {});
          },
        ),
      ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 14,
      ),
    );
  }
}
