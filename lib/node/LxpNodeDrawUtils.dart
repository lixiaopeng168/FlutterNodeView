
import 'dart:core';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'LxpNodeConfig.dart';

class  LxpNodeDrawUtils  {

  LxpNodeConfig config;

  LxpNodeDrawUtils(this.config);

  /// 检测边界不越界
  void checkOutOf(Size size,ui.Image imageNode){
    if(config.distance > size.width - imageNode.width){
      config.distance = size.width - imageNode.width;
    }
    if(config.distance < 1){
      config.distance = 0;
    }
  }

  /// 百分比
  int percentage(Size size){
    int  percentage = (config.distance / size.width * 100).toInt();
    if(percentage > 100){
      percentage = 100;
    }
    if(percentage < 0){
      percentage = 0;
    }
    return percentage;
  }

  /// 绘制背景
  void drawBg(Size size,Paint paint,Canvas canvas){
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    paint.color = config.bgColor;
    canvas.drawRect(rect, paint);
  }

  /// 绘制线
  void drawLine(double startX,double startY,double endX,double endY , Paint paint,Canvas canvas){
    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
  }

  ///绘制节点
  void drawNode(double sy, Size size,Paint paint,Canvas canvas){
    int i =0;
    //第一个点位置
    double cw = (size.width - config.circleRadius * 2) / (config.count-1);
    while(i < config.count){
      double dx,dy = sy;
      if(i == 0){
        //起始位置
        dx = config.circleRadius;
      }else if(i == config.count - 1){
        //最后一个位置
        dx = size.width - config.circleRadius;
      }
      else {
        dx = cw * i + config.circleRadius;
//        print("tradePaint  i: $i  dx: $dx  ");
      }
      if(config.distance > (dx-config.circleRadius)) {
        //绘制选中区域
        paint.color = config.selectColor;
        canvas.drawCircle(Offset(dx, dy), config.circleRadius, paint);
      }else {
        paint.color = config.normalColor;
        canvas.drawCircle(Offset(dx, dy), config.circleRadius, paint);
      }
      i++;
    }


  }

}