double calculateTotalPrice(int pricePerDay, int duration) {
  if (duration <= 1) return pricePerDay.toDouble();
  return pricePerDay + (pricePerDay * 0.1 * (duration - 1));
}
