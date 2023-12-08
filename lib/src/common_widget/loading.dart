import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondaryTitleLarge =
        Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.green);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16.0),
          Text('loading...', style: secondaryTitleLarge),
        ],
      ),
    );
  }
}
