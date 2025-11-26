class DiscountCalculator {
  static double getWeeklyDiscount({
    required double dailyPrice,
    required double weeklyPrice,
  }) {
    final dailyTotal = dailyPrice * 7;
    final discount = 1 - (weeklyPrice / dailyTotal);
    return discount * 100; // dalam persen
  }

  static double getMonthlyDiscount({
    required double dailyPrice,
    required double monthlyPrice,
  }) {
    final dailyTotal = dailyPrice * 30;
    final discount = 1 - (monthlyPrice / dailyTotal);
    return discount * 100;
  }
}
