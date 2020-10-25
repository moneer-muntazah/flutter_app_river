import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final future = Future<List<String>>.delayed(Duration(seconds: 5), () {
    return <String>["cool", "dude", "girl"];
  });
  final children = <Widget>[];
  final controller = StreamController();

  MyHomePage() {
    future.then((List<String> ks) {
      if (ks.isNotEmpty) controller.add(ks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("river"),
      ),
      body: Center(
        child: StreamBuilder(
            stream: controller.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                // final x = snapshot.data.map((String k) {
                //   return Text(
                //     k,
                //     style: Theme.of(context).textTheme.headline4,
                //   );
                // });
                // print(x.runtimeType);
                // keywords.addAll(x);
                if (snapshot.data is String) {
                  children.add(
                    Text(
                      snapshot.data,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  );
                }
                if (snapshot.data is List<String>) {
                  children.addAll(snapshot.data.map<Widget>((String k) {
                    return Text(
                      k,
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }));
                }
                // Investigate:
                // MappedListIterable<String, Widget> vs
                // MappedListIterable<String, dynamic>
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                );
              }
              return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.add("new");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
