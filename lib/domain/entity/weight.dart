class Weight {
  String? _imperial;
  String? _metric;

  Weight({String? imperial, String? metric}) {
    if (imperial != null) {
      this._imperial = imperial;
    }
    if (metric != null) {
      this._metric = metric;
    }
  }


  @override
  String toString() {
    return 'Weight{_imperial: $_imperial, _metric: $_metric}';
  }

  String? get imperial => _imperial;
  set imperial(String? imperial) => _imperial = imperial;
  String? get metric => _metric;
  set metric(String? metric) => _metric = metric;

  Weight.fromJson(Map<String, dynamic> json) {
    _imperial = json['imperial'];
    _metric = json['metric'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imperial'] = this._imperial;
    data['metric'] = this._metric;
    return data;
  }

  Weight copyWith({
    String? imperial,
    String? metric,
  }) {
    return Weight(
      imperial: imperial ?? this._imperial,
      metric: metric ?? this._metric,
    );
  }
}