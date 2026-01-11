class BusSearchDto {
  //convert search request to json
  static Map<String, dynamic> searchToJson({
    required int originId,
    required int destinationId,
    required DateTime date,
  }) {
    // Format date as YYYY-MM-DD to match Rails backend
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    
    return {
      'origin_id': originId,
      'destination_id': destinationId,
      'date': dateStr,
    };
  }
}