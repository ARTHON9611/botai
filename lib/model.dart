import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class imgModel {

  dynamic imgDesc;
  dynamic imgHead;
  dynamic genImg;
  dynamic imgUrl;
  imgModel(
      {this.imgDesc = "Some News",
      this.imgHead = "Breaking News",
      this.genImg = "url",
      this.imgUrl = "url"});

  factory imgModel.fromMap(element) {
    return imgModel(
        imgDesc: element["prompt"],
        imgHead: element["id"],
        genImg: element["src"],
        imgUrl: element["srcSmall"]);
  }
}