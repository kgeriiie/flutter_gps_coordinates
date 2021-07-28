import 'package:flutter/material.dart';
import 'package:flutter_gps/ui/custom/circle_painter.dart';
import 'package:flutter_gps/ui/custom/header_card_painter.dart';
import 'package:flutter_gps/bo/distance.dart';
import 'dart:async';

class DistanceHeader extends StatefulWidget {

  DistanceHeaderWidgetController _controller;

  DistanceHeader({DistanceHeaderWidgetController controller}) {
    this._controller = controller;
  }

  @override
  _DistanceHeaderState createState() => _DistanceHeaderState();
}

class _DistanceHeaderState extends State<DistanceHeader> {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        child: Stack(
          children: [
            _background(),
            Center(child: _circle()),
            Center(child:
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _hudDisplay()
                ],
              )
            )
          ],
        )
    );
  }

  Widget _background() {
    return CustomPaint(
      size: Size.infinite,
      painter: HeaderCardPainter(
          color: Colors.blue[500],
          controlPointHeight: 65
      ),
    );
  }

  Widget _circle() {
    return CustomPaint(
      size: Size(230, 230),
      painter: CirclePainter(
        color: Colors.white
      ),
    );
  }

  Widget _hudDisplay() {
    return StreamBuilder<Object>(
      stream: widget._controller.distanceStream,
      builder: (context, snapshot) {
        double distance = 0;
        String unit = "m";

        if (snapshot.data is Distance) {
          Distance source = snapshot.data;

          distance = source.value;
          unit = source.unit;
        } else {
          // todo: handle this case
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text("$distance",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                )
            ),
            SizedBox(width: 8),
            Text(unit,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.normal
                )
            )
          ],
        );
      }
    );
  }
}

class DistanceHeaderWidgetController {
  StreamController<Distance> get _distanceStreamController => StreamController<Distance>();
  StreamSink<Distance> get _distanceSink =>  _distanceStreamController.sink;
  Stream<Distance> get distanceStream  => _distanceStreamController.stream;

  void setDistance(Distance distance) {
    _distanceSink.add(distance);
  }
}