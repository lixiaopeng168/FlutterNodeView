
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'ImageUtils.dart';
import 'LxpCustomNodePainter.dart';
import 'LxpNodeConfig.dart';
import 'OnNodeViewListener.dart';


class LxpNodeView extends StatefulWidget{

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
  //总高度
  double height;
  //滑动条图片路径
  String nodePath;
  //回调事件
  OnNodeViewListener onNodeViewListener;

  LxpNodeView( {
    Key key,
    this.lineHeight=4,
    this.circleRadius=4,
    this.count = 5,
    this.normalColor = Colors.greenAccent,
    this.selectColor = Colors.blue,
    this.height = 130,
    this.nodePath,
    this.onNodeViewListener,

  }) : assert(nodePath != null),
  assert(onNodeViewListener != null),
//  assert(nodeSize != null),
  super( key:key);

  @override
  State<StatefulWidget> createState()  => _LxpNodeView();
}

class _LxpNodeView extends State<LxpNodeView>{

  //移动距离
  double distance = 0;
  double dx,dy;
  //图片
  ui.Image _image;
  //滑动类型
  NodeScrollType nodeScrollType;

  @override
  void initState() {
    super.initState();
    initPainter();
  }
  ///初始化资源
  void initPainter() {
    ImageUtils.getImage(widget.nodePath).then((value) => {
    _image =  value
    });
  }


  @override
  Widget build(BuildContext context) {
    return   new GestureDetector(

      child: new SizedBox(
        height: widget.height,
        child: new CustomPaint(
          painter: LxpCustomNodePainter(
            imageNode: _image,
            onNodeViewListener: widget.onNodeViewListener,
            nodeScrollType: nodeScrollType,
            config: new LxpNodeConfig(
              lineHeight: widget.lineHeight,
              circleRadius: widget.circleRadius,
              distance: distance,
              dx:dx,
              dy:dy,
            ),
          ),
        ),
      ),
      onHorizontalDragDown: (event){
          _setScrollState(NodeScrollType.down, event.localPosition.dx, event.localPosition.dy,true);
//        print("水平拖动down ${event.localPosition}   ${event.globalPosition}");
      },
      onHorizontalDragEnd: (DragEndDetails event){
          _setScrollState(NodeScrollType.up, 0, 0,false);
//        print("水平拖动end ");
      },
      onHorizontalDragUpdate: (DragUpdateDetails event){
          _setScrollState(NodeScrollType.drag, event.localPosition.dx, event.localPosition.dy,true);
//        print("水平拖动update  ${event.localPosition}  ${event.globalPosition}");
      },

    );
  }

  void _setScrollState(NodeScrollType type,double x,double y,bool flag){
    setState(() {
      if(flag) {
        dx = x;
        dy = y;
        distance = x;
      }
      nodeScrollType = type;
      widget.onNodeViewListener?.onScrollState();
    });
  }
}

