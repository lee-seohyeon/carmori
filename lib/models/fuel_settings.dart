class FuelEfficiencySettings {
  double? cityEfficiency;
  double? highwayEfficiency;
  double? combinedEfficiency;
  
  FuelEfficiencySettings({
    this.cityEfficiency,
    this.highwayEfficiency,
    this.combinedEfficiency,
  });

  double getEffectiveEfficiency() {
    if (combinedEfficiency != null) return combinedEfficiency!;
    if (cityEfficiency != null && highwayEfficiency != null) {
      return (cityEfficiency! + highwayEfficiency!) / 2;
    }
    if (cityEfficiency != null) return cityEfficiency!;
    if (highwayEfficiency != null) return highwayEfficiency!;
    return 0.0;
  }
}

class FuelPriceSettings {
  double customPrice;
  bool useCustomPrice;
  
  // 전기차 전용 설정
  double? slowChargingPrice;
  double? fastChargingPrice;
  Map<String, double>? timeBasedPrices; // 시간대별 요금
  
  FuelPriceSettings({
    required this.customPrice,
    this.useCustomPrice = false,
    this.slowChargingPrice,
    this.fastChargingPrice,
    this.timeBasedPrices,
  });

  double getEffectivePrice(String fuelType, {String? chargingType}) {
    if (!useCustomPrice) return customPrice;
    
    if (fuelType == '전기') {
      if (chargingType == '완속') return slowChargingPrice ?? customPrice;
      if (chargingType == '급속') return fastChargingPrice ?? customPrice;
      // 시간대별 요금이 설정되어 있다면 현재 시간에 해당하는 요금 반환
      final now = DateTime.now();
      final currentHour = now.hour;
      if (timeBasedPrices != null && timeBasedPrices!.isNotEmpty) {
        return timeBasedPrices!.entries
          .firstWhere(
            (entry) => entry.key == currentHour.toString(),
            orElse: () => MapEntry(currentHour.toString(), customPrice)
          ).value;
      }
    }
    
    return customPrice;
  }
} 