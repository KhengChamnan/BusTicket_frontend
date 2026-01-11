import 'package:citym/data/repository/abstract/bus_schedule_repository.dart';
import 'package:citym/data/repository/rails/rails_bus_schedules_repository.dart';
import 'package:citym/models/bus_schedules.dart';
import 'package:flutter/material.dart';
import 'package:citym/providers/asyncvalue.dart';

class BusSchedulesProvider extends ChangeNotifier {
  final BusScheduleRepository _busScheduleRepository= RailsBusSchedulesRepository();
  AsyncValue<List<dynamic>>? busSchedulesValue;
  Future<List<BusSchedules>> fetchBusSchedules({
    required int  originId,
    required int destinationId,
    required DateTime date,
  }) async {
    busSchedulesValue = AsyncValue.loading();
    notifyListeners();

    try {
      final results = await Future.wait([
        _busScheduleRepository.fetchBusSchedules(
          originId: originId,
          destinationId: destinationId,
          date: date,
        ),
        Future.delayed(const Duration(seconds: 2)),
      ]);
      
      final schedules = results[0] as List<BusSchedules>;

      busSchedulesValue = AsyncValue.success(schedules);
      notifyListeners();
      return schedules;
    } catch (error) {
      busSchedulesValue = AsyncValue.error(error);
      notifyListeners();
      return [];
    }
  }
}