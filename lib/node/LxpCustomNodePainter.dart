


import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui' ;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'LxpNodeConfig.dart';
import 'LxpNodeDrawUtils.dart';
import 'OnNodeViewListener.dart';

enum NodeScrollType{
  //按下。拖动。离开
  down,drag,up
}

class LxpCustomNodePainter extends CustomPainter{

  Paint paintNode = new Paint();


  //滑动条
  ui.Image imageNode;
  //参数配置
  LxpNodeConfig config;
  //绘制方法
  LxpNodeDrawUtils drawUtils;
  //回调
  OnNodeViewListener onNodeViewListener;
  //类型
  NodeScrollType nodeScrollType;



  LxpCustomNodePainter({
    this.config,
    this.imageNode,
    this.nodeScrollType,
    this.onNodeViewListener,
  }):assert(config != null)

{
  paintNode.color = Colors.red;
  paintNode.style = PaintingStyle.fill;
  paintNode.strokeWidth = config.lineHeight;
    drawUtils = new LxpNodeDrawUtils(config);
  }
//  super(key : key);


  @override
  void paint(Canvas canvas, Size size) {

    canvas.save();
    // 绘制背景
    drawUtils?.drawBg(size, paintNode,canvas);

    //绘制线 线的位置在中心 p1 起始位置的x和y  p2截止位置的x和y
    //起始位置的 y 为 高度 - 线的高度 - 圆的直径
    double sy = size.height  - config.lineHeight*2 - config.circleRadius;
    paintNode.color = config.normalColor;
    canvas.drawLine(Offset(0, sy), Offset(size.width, sy), paintNode);

    //绘制5个点 ，分别是 0 - 25 - 50 - 75 - 100
    drawUtils?.drawNode(sy, size, paintNode, canvas);

    //百分比计算
    int  percentage = drawUtils?.percentage(size);
//    print("百分比1.  $percentage ");

    //绘制滑动图片
    if(imageNode != null) {
    //检测distance越界
    drawUtils?.checkOutOf(size, imageNode);


    //选中的线
    paintNode.color = config.selectColor;
    canvas.drawLine(Offset(0, sy), Offset(config.distance, sy), paintNode);


//    print("执行 custom paint   ${imageNode == null ? 1 : 2}  ${size.width}  distance:${config.distance} "
//        " 百分比:$distanceX  $percent  ${distanceX/size.width}  ${config.distance / size.width}");


      canvas.drawImage(imageNode, Offset(config.distance, sy - imageNode.height/2) , paintNode) ;
    }

    canvas.restore();

    //回调
    _scrollStatus(percentage);
  }
  TimingsCallback timingsCallback;

  void _scrollStatus(int progress){
//    timingsCallback;
//    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    SchedulerBinding.instance.removeTimingsCallback((timings) { });
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        switch (nodeScrollType) {
          case NodeScrollType.down:
//       print("scroll状态按下2  $progress");
            onNodeViewListener?.onScrollDown(config.dx, config.dy, progress);
            break;
          case NodeScrollType.drag:
            onNodeViewListener?.onScrollDown(config.dx, config.dy, progress);
            break;
          case NodeScrollType.up:
            onNodeViewListener?.onScrollEnd(config.dx, config.dy, progress);
            break;
        }
      });

  }



  //决定当条件变化时是否需要重画
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {

    return true ;
  }





}
