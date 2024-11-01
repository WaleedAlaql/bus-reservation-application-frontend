import 'package:freezed_annotation/freezed_annotation.dart';

part 'but_route.freezed.dart';
part 'but_route.g.dart';

@unfreezed
class BusRoute with _$BusRoute {
  factory BusRoute({
    int? routeId,
    required String routeName,
    required String cityFrom,
    required String cityTo,
    required double distanceInKm,
  }) = _BusRoute;

  factory BusRoute.fromJson(Map<String, dynamic> json) =>
      _$BusRouteFromJson(json);
}
