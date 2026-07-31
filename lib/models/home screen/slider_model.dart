class SliderModel {
  bool? success;
  List<Sliders>? sliders;

  SliderModel({this.success, this.sliders});

  SliderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (sliders != null) {
      data['sliders'] = sliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  String? heading1;
  String? heading2;
  String? heading3;
  String? heading4;
  String? sliderImage;

  Sliders(
      {this.heading1,
        this.heading2,
        this.heading3,
        this.heading4,
        this.sliderImage});

  Sliders.fromJson(Map<String, dynamic> json) {
    heading1 = json['heading1'];
    heading2 = json['heading2'];
    heading3 = json['heading3'];
    heading4 = json['heading4'];
    sliderImage = json['slider_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heading1'] = heading1;
    data['heading2'] = heading2;
    data['heading3'] = heading3;
    data['heading4'] = heading4;
    data['slider_image'] = sliderImage;
    return data;
  }
}
