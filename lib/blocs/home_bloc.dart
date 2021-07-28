import 'dart:async';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class HomeBloc {
  LatLng _location;
  LatLng _destination;

  final _viewStateStreamController = StreamController<HomeViewState>();
  StreamSink<HomeViewState> get _viewStateSink =>  _viewStateStreamController.sink;
  Stream<HomeViewState> get viewStateStream  => _viewStateStreamController.stream;

  HomeBloc() {
    _startLocationUpdate();
    _determinePosition().asStream().listen((event) {
      _location = event;
    });
  }

  Future<LatLng> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied, we cannot request permissions.");
    }

    Position position = await Geolocator.getLastKnownPosition();

    return Future.value(LatLng(position.latitude, position.longitude));
  }

  void _startLocationUpdate() async {
    bool serviceEnabled = true;
    LocationPermission permission;

    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied, we cannot request permissions.");
    }

    Geolocator.getPositionStream().listen((position) {
      _location = LatLng(position.latitude, position.longitude);
    });
  }

  void setDestination(LatLng location) {
    _destination = location;
  }

  void startUpdateDistance() {
    _updateDistance();
  }

  void _updateDistance() {
    if (_location == null || _destination == null) {
      _viewStateSink.add(HomeViewState.locationNotAvailable());
      return;
    }

    _viewStateSink.add(HomeViewState.distanceAvailable(_calculateDistanceFrom(_destination)));
  }

  double _calculateDistanceFrom(LatLng fromLocation) {
      if (fromLocation != null) {
        final Distance distance = new Distance();

        return distance.as(LengthUnit.Meter, fromLocation, _location);
      } else {
        return -1;
      }
  }
}

class HomeViewState {
  HomeViewState._();

  factory HomeViewState.locationNotAvailable() = LocationNotAvailable;
  factory HomeViewState.distanceAvailable(double distance) = DistanceAvailable;
}

class LocationNotAvailable extends HomeViewState {
  LocationNotAvailable(): super._();
}

class DistanceAvailable extends HomeViewState {
  DistanceAvailable(this.distanceInMeter): super._();

  final double distanceInMeter;
}