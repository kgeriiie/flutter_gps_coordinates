import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gps/blocs/home_bloc.dart';
import 'package:flutter_gps/ui/custom/header_card_painter.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_gps/app_localizations.dart';
import 'package:flutter_gps/ui/custom/distance_header.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final DistanceHeaderWidgetController _headerController = DistanceHeaderWidgetController();
  final HomeBloc _positionBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("home_title_text")),
          elevation: 0,
          backgroundColor: Colors.blue[500],
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DistanceHeader(controller: _headerController),
            SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _coordinateWidget("Latitude", 122.34154),
                  Container(
                    width: 1,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: Colors.grey,
                  ),
                  _coordinateWidget("Longitude", 22.3354),
                ],
              ),
            )
          ],
        )
      );
  }

  Widget _coordinateWidget(String label, double value) {
    String dmsValue = "";

    int degree = value.floor();
    double minute = ((value - degree) * 60);
    double second = ((minute - minute.floor()) * 60);

    dmsValue = "$degree° ${minute.floor()}’ ${second.toStringAsFixed(2)}”";

    return Container(
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                color: Colors.blue[500],
                fontSize: 25,
                fontWeight: FontWeight.w600
              )
          ),
          SizedBox(height: 6),
          Text("$value",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w800
              )
          ),
          Text(dmsValue,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              ))
        ],
      ),
    );
  }

  Widget _getEmptyWidget() {
    return Container(
        width: 250,
        child: Text(AppLocalizations.of(context).translate("home_distance_not_available_text"),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16
          ),
        )
    );
  }
}
