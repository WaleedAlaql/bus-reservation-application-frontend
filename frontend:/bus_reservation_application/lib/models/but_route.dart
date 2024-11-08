import 'package:freezed_annotation/freezed_annotation.dart';

part 'but_route.freezed.dart';
part 'but_route.g.dart';

@unfreezed
class BusRoute with _$BusRoute {
  // Factory constructor for creating a new BusRoute instance
  factory BusRoute({
    int? routeId, // Optional route ID
    required String routeName, // Name of the bus route
    required String cityFrom, // Starting city of the route
    required String cityTo, // Destination city of the route
    required double distanceInKm, // Distance of the route in kilometers
  }) = _BusRoute;

  // Factory constructor for creating a BusRoute instance from a JSON map
  factory BusRoute.fromJson(Map<String, dynamic> json) =>
      _$BusRouteFromJson(json);
}
