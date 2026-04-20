class ExportLog {
  final String id;
  final String filePath;
  final String createdAt;
  final String reportType;

  const ExportLog({
    required this.id,
    required this.filePath,
    required this.createdAt,
    required this.reportType,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'filePath': filePath,
    'createdAt': createdAt,
    'reportType': reportType,
  };

  factory ExportLog.fromJson(Map<String, dynamic> json) => ExportLog(
    id: json['id'] as String,
    filePath: json['filePath'] as String,
    createdAt: json['createdAt'] as String,
    reportType: json['reportType'] as String,
  );
}
