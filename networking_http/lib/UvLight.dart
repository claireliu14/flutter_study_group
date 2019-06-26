import 'dart:convert';

class UvLight {
  final String County;
  final String PublishAgency;
  final String PublishTime;
  final String SiteName;
  final String UVI;

  UvLight({this.County,
    this.PublishAgency,
    this.PublishTime,
    this.SiteName,
    this.UVI});


  static List<UvLight> fromJson(List<dynamic> list) {
    return new List<UvLight>.generate(
        list.length, (index) => UvLight.parseUvLight(list[index]));
  }

  factory UvLight.parseUvLight(Map<String, dynamic> json) {
    return UvLight(
        County: json['County'],
        PublishAgency: json['PublishAgency'],
        PublishTime: json['PublishTime'],
        SiteName: json['SiteName'],
        UVI: json['UVI']);
  }
}
