import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
    this.error,
    this.exception,
  }) : super(key: key);

  final Error? error;
  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    var sh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'https://camo.githubusercontent.com/6cad3438d083f9966c1a0d7a4119ab7ad4d8a278639c90bd6290d443c4c59367/68747470733a2f2f6968312e726564627562626c652e6e65742f696d6167652e313037363638373036362e303731362f73742c736d616c6c2c353037783530372d7061642c363030783630302c6638663866382e6a7067',
                width: sw * 0.6,
                height: sh * 0.4,
              ),
              Text('Error: $error'),
              Text('$exception'),
            ],
          ),
        ),
      ),
    );
  }
}
