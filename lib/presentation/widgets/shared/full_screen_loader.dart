import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  FullScreenLoader({super.key});

  final messages = <String>[
    'Loading movies',
    'Loading Popular movies',
    'Making popcorn',
    'Loading top rated movies',
    'Getting recommendations',
    'Turning on the television',
    'Getting the popcorn ready',
    'This is taking longer than expected',
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Loading...'),
          const SizedBox(height: 20),
          CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (_, snapshot) => Text(snapshot.data ?? ''),
          ),
        ],
      ),
    );
  }
}
