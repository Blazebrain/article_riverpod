import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RiverPodApp(),
    ),
  );
}

final favoriteProvider = ChangeNotifierProvider((ref) => Favorites());

class RiverPodApp extends ConsumerWidget {
  const RiverPodApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My favorite fruit is ' + watch(favoriteProvider).fruit),
        ),
        body: Center(
          child: Column(
            children: [
              FruitButton('Apples'),
              FruitButton('Oranges'),
              FruitButton('Bananas'),
            ],
          ),
        ),
      ),
    );
  }
}

class FruitButton extends StatelessWidget {
  final String fruit;

  FruitButton(this.fruit);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(fruit),
      onPressed: () {
        context.read(favoriteProvider).changeFruit(fruit);
      },
    );
  }
}

class Favorites extends ChangeNotifier {
  String fruit = 'unknown';

  void changeFruit(String newFruit) {
    fruit = newFruit;
    notifyListeners();
  }
}
