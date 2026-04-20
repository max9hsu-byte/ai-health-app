class GeneRecord {
  final String id;
  final String functionName;
  final String geneLocus;
  final String genotype;
  final String risk;
  final String description;

  const GeneRecord({
    required this.id,
    required this.functionName,
    required this.geneLocus,
    required this.genotype,
    required this.risk,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'functionName': functionName,
    'geneLocus': geneLocus,
    'genotype': genotype,
    'risk': risk,
    'description': description,
  };

  factory GeneRecord.fromJson(Map<String, dynamic> json) => GeneRecord(
    id: json['id'] as String,
    functionName: json['functionName'] as String,
    geneLocus: json['geneLocus'] as String,
    genotype: json['genotype'] as String,
    risk: json['risk'] as String,
    description: json['description'] as String,
  );
}
