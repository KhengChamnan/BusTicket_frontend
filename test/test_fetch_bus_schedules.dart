import 'package:citym/data/repository/rails/rails_bus_schedules_repository.dart';

void main() async {
  try {
    final repository = RailsBusSchedulesRepository();
    
    print('🔵 Fetching bus schedules...');
    print('Origin ID: 1');
    print('Destination ID: 2');
    print('Date: 2026-01-10');
    print('');
    
    final schedules = await repository.fetchBusSchedules(
      originId: 1,
      destinationId: 2,
      date: DateTime(2026, 1, 10),
    );

    print('✅ Fetch completed');
    print('Total schedules found: ${schedules.length}');
    print('');
    
    if (schedules.isEmpty) {
      print('❌ No schedules found');
      return;
    }
    
    // Print details of each schedule
    for (int i = 0; i < schedules.length; i++) {
      final schedule = schedules[i];
      print('📦 Schedule ${i + 1}:');
      print('  ID: ${schedule.id}');
      print('  Departure: ${schedule.departureTime}');
      print('  Arrival: ${schedule.arrivalTime}');
      print('  Seat Price: ${schedule.seatPrice}');
      print('  Available Seats: ${schedule.availableSeats}');
      print('  Status: ${schedule.status}');
      print('  Bus Plate: ${schedule.bus.plateNumber}');
      print('  Bus Capacity: ${schedule.bus.capacity}');
      print('  Route: ${schedule.route.origin} → ${schedule.route.destination}');
      print('');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}
