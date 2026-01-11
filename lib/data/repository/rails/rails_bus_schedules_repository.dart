import 'dart:convert';
import 'package:citym/data/dto/bus_schedules_dto.dart';
import 'package:citym/data/dto/bus_search_dto.dart';
import 'package:citym/data/repository/abstract/bus_schedule_repository.dart';
import 'package:citym/models/bus_schedules.dart';
import 'package:citym/network/api_constant.dart';
import 'package:http/http.dart' as http;

class RailsBusSchedulesRepository extends BusScheduleRepository {

  @override
  Future<List<BusSchedules>> fetchBusSchedules({
    required int originId,
    required int destinationId,
    required DateTime date,
  }) async {
    try {
      // 1 - Prepare query parameters using BusSearchDto
      final searchParams = BusSearchDto.searchToJson(
        originId: originId,
        destinationId: destinationId,
        date: date,
      );

      // 2 - Build URL with query parameters
      final uri = Uri.parse('${ApiEndPoints.baseUrl}/api/bus_schedules/by_route').replace(
        queryParameters: searchParams.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      );

      // 3 - Send GET request
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      // 4 & 5 - Parse response and return schedules
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return [];
      }

      final List<dynamic> schedulesList = json.decode(response.body);

      return schedulesList
          .map((schedule) =>
              BusSchedulesDto.fromJson(schedule as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
}