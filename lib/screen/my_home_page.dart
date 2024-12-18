import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_manage/main.dart';
import 'package:state_manage/state/my_home_state.dart';
import 'package:state_manage/view_model/my_home_view_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('MyHomePageををビルド');
    return ProviderScope(
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

class WidgetB extends ConsumerWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('WidgetBをビルド');
    //watchはMyHomePageStateのnotifyListenersで、状態が変化した時だけ再描画
    final int counter = ref.watch<MyHomePageState>(myHomePageProvider).counter;
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends ConsumerWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('WidgetCをビルド');
    // readはMyHomePageStateのnotifyListenersで、再描画を行わない
    final Function increment = ref
        .read<MyHomePageStateNotifier>(myHomePageProvider.notifier)
        .increment;
    return ElevatedButton(
        onPressed: () {
          increment();
        },
        child: const Text('カウント'));
  }
}
