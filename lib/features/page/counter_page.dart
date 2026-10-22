import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/counter_provider.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WATCH: rebuilds this widget when the counter changes.
    final count = ref.watch(counterProvider);

    // LISTEN: perform a side effect when the counter changes.
    // `ref.listen` is designed to be used in build().
    ref.listen<int>(counterProvider, (prev, next) {
      if (next == 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You have reach the limt (5)!')),
        );
        ref.read(counterProvider.notifier).reset();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Counter')),
      body: Center(child: Text('Count: $count')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // READ: access the notifier in response to a user action.
          ref.read(counterProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
