

abstract class OnNodeViewListener{

  //初始化函数
  /// 按下位置
  void onScrollDown(double dx,double dy,int progress){}

  /// 拖动位置
  void onScrollDrag(double dx,double dy,int progress){}

  /// 结束位置
  void onScrollEnd(double dx,double dy,int progress){}


  /// 测试回调更新
  void onScrollState(){}

}