class GoldRate {
  final double price24k;
  final double price22k;
  final double price21k;
  final double price18k;
  final double change;
  final double changePercent;
  final DateTime updatedAt;

  GoldRate({
    required this.price24k,
    required this.price22k,
    required this.price21k,
    required this.price18k,
    required this.change,
    required this.changePercent,
    required this.updatedAt,
  });

  factory GoldRate.fromJson(Map<String, dynamic> json) {
    return GoldRate(
      price24k: (json['price_gram_24k'] ?? 0).toDouble(),
      price22k: (json['price_gram_22k'] ?? 0).toDouble(),
      price21k: (json['price_gram_21k'] ?? 0).toDouble(),
      price18k: (json['price_gram_18k'] ?? 0).toDouble(),
      change: (json['ch'] ?? 0).toDouble(),
      changePercent: (json['chp'] ?? 0).toDouble(),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        ((json['timestamp'] ?? 0) * 1000).toInt(),
      ),
    );
  }
}