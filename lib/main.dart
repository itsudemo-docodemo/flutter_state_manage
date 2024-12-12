import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('MyHomePageををビルド');
    return ChangeNotifierProvider(
      create: (context) => MyHomePageState(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Provider'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[WidgetA(), WidgetB(), WidgetC()],
          ),
        ),
      ),
    );
  }
}

class MyHomePageState extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }

  void reBuild() {
    notifyListeners();
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({super.key});

  @override
  Widget build(BuildContext context) {
    print('WidgetAをビルド');
    return const Text(
      'You have pushed the button this many times:',
    );
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    print('WidgetBをビルド');
    //watchはMyHomePageStateのnotifyListenersで、常に再描画
    // final int counter = context.watch<MyHomePageState>().counter;
    //selectはMyHomePageStateのnotifyListenersで、指定した状態が変化した時だけ再描画
    final int counter =
        context.select<MyHomePageState, int>((state) => state.counter);
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context) {
    print('WidgetCをビルド');
    //readはMyHomePageStateのnotifyListenersで、再描画を行わない
    // final Function increment = context.read<MyHomePageState>().reBuild();
    final Function increment = context.read<MyHomePageState>().increment;
    return ElevatedButton(
        onPressed: () {
          increment();
        },
        child: const Text('カウント'));
  }
}
