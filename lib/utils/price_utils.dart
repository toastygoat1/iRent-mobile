double calculateTotalPrice(int pricePerDay, int duration) {
  if (duration <= 1) return pricePerDay.toDouble();
  return pricePerDay + (pricePerDay * 0.05 * (duration - 1));
}
