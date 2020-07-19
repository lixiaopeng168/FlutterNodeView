import 'package:flutter/material.dart';
import 'package:lxpNode/node/LxpNodeView.dart';
import 'package:lxpNode/node/OnNodeViewListener.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '进度展示',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  String progress="0";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with OnNodeViewListener{


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("NodeView"),
      ),
      body: new Column(
        children: [
          new Text("进度:${widget.progress}"),

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
        ],
      ) ,
    );
  }

  @override
  void onScrollDown(double dx, double dy, int progress) {
    // TODO: implement onScrollDown
    super.onScrollDown(dx, dy, progress);
    setState(() {
      widget.progress = "$progress %";
    });
  }
  @override
  void onScrollDrag(double dx, double dy, int progress) {
    // TODO: implement onScrollDrag
    super.onScrollDrag(dx, dy, progress);

    widget.progress = "$progress %";
  }
}
