class Prediction{

  String status;
  List<dynamic> predictions;

  Prediction({
    this.status = "invalid",
    this.predictions = const [],
  }) {
  }

  factory Prediction.fromJson(Map<String, dynamic> json){
    return Prediction(
      status: json['status'],
      predictions: (json['predictions'] as List<dynamic>?)
          ?.whereType<String>()
          .toList() ?? [],
    );
  }

}