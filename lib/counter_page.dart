import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter extends ChangeNotifier {
  int count = 0;
  bool loading = true;

  void increment() {
    count++;
    print(count);
    notifyListeners();
  }

  void incrementOneHundred() async {
    await Future.delayed(Duration(seconds: 2));
    count += 100;
    notifyListeners();
  }
}

class CounterPage extends StatelessWidget {
  CounterPage._({Key key}) : super(key: key);

  static Widget wrapped() {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: CounterPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// メソッド呼び出しの際など、参照だけが欲しい時
    final controller = Provider.of<Counter>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            _CounterWidget(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              controller.increment();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              controller.incrementOneHundred();
            },
            tooltip: 'Increment',
            child: Icon(Icons.comment),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _CounterWidget extends StatelessWidget {
  const _CounterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterValue = Provider.of<Counter>(context).count;

    return Text(
      counterValue?.toString() ?? '',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
