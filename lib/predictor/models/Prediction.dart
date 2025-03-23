class Prediction{

  String status;
  String type;
  List<dynamic> predictions;

  Prediction({
    this.status = "invalid",
    this.type = "none",
    this.predictions = const [],
  }) {
  }

  factory Prediction.fromJson(Map<String, dynamic> json){
    return Prediction(
      status: json['status'],
      type: json['type'],
      predictions: (json['predictions'] as List<dynamic>?)
          ?.whereType<String>()
          .toList() ?? [],
    );
  }

}