import 'package:citym/models/bus_schedules.dart';

abstract class BusScheduleRepository {
  Future<List<BusSchedules>> fetchBusSchedules({
    required int originId,
    required int destinationId,
    required DateTime date,
  });
}