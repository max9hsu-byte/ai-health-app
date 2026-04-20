class HealthRecord {
  final String id;
  final String category;
  final String subcategory;
  final String item;
  final String value;
  final String unit;
  final String date;
  final String notes;

  const HealthRecord({
    required this.id,
    required this.category,
    required this.subcategory,
    required this.item,
    required this.value,
    required this.unit,
    required this.date,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'subcategory': subcategory,
    'item': item,
    'value': value,
    'unit': unit,
    'date': date,
    'notes': notes,
  };

  factory HealthRecord.fromJson(Map<String, dynamic> json) => HealthRecord(
    id: json['id'] as String,
    category: json['category'] as String,
    subcategory: json['subcategory'] as String,
    item: json['item'] as String,
    value: json['value'] as String,
    unit: json['unit'] as String? ?? '',
    date: json['date'] as String,
    notes: json['notes'] as String? ?? '',
  );
}
