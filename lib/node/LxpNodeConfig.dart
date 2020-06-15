

import 'package:flutter/material.dart';


 class LxpNodeConfig {
   //背景色
  Color bgColor;
  //线高度
  double lineHeight ;
  //圆半径
  double circleRadius ;
  //绘制多少个点
  int count ;
  //选中的颜色
  Color normalColor;
  //未选中的颜色
  Color selectColor;
  //选中位置的距离
  double distance;
  // 距离
  double dx,dy;

  LxpNodeConfig({
    this.bgColor=Colors.transparent,
    this.lineHeight=4,
    this.circleRadius=4,
    this.count = 5,
    this.normalColor = Colors.grey,
    this.selectColor= Colors.blue ,
    this.distance=0,
    this.dx=0,
    this.dy=0,

});
}