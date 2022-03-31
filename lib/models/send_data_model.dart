class SendDataModel {
  // Json Body
  // {
  //     "name": "morpheus",
  //     "job": "leader"
  // }

  final String? name;
  final String? job;

  SendDataModel({
    this.name,
    this.job,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['job'] = job;
    return data;
  }
}
