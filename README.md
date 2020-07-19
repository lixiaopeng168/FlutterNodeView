项目中经常会使用到节点进度条的需求，因为flutter是新的没有在网上找到成熟的节点进度条。就自己手动撸个吧。
### 实现思路
1. 自定义view，在flutter中是CustomPaint。CustomPaint有个painter属性，需要实现CustomPainter进行绘制。
2. 在CustomPainter中需要实现paint方法绘制。其中Canvas是画布，Size是大小。可以通过canvas.drawLine绘制线，canvas.drawCircle绘制圆点。
3. 手势控制通过GestureDetector，其中有方法onHorizontalDragDown是水平滚动按下，onHorizontalDragEnd是水平滚动离开，onHorizontalDragUpdate是水平滚动监听。

### 效果
[图片](https://upload-images.jianshu.io/upload_images/5421492-4b65e8ee3b7e07b3.gif?imageMogr2/auto-orient/strip)

### 属性
| 字段 | 语义 |
| ---- | ---- |
| lineHeight | 线高度 |
| circleRadius | 圆半径 |
| count | 绘制多少个点 |
| selectColor | 选中的颜色 |
| normalColor | 常规颜色 |
| height | 总高度 |
| nodePath | 滑动条路径 |
| OnNodeViewListener | 滑动回调事件 |

### 使用注意必须在外部设置宽度,我这里是Row，你也可以用SizeBox设置width
```
 Row(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: [
          new Expanded(
              child: new LxpNodeView(
                lineHeight: 4,
                circleRadius: 6,
                nodePath: "images/trade_node.png",
                onNodeViewListener: this,
//              width: sizedBox.width ,
                height: 130,
//              nodeSize: new Size(ScreenUtil().setWidth(100), ScreenUtil().setWidth(100)),
              ),)

        ],
      )
```

[代码Git地址](https://github.com/lixiaopeng168/FlutterNodeView)