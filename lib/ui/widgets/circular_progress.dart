import 'package:flutter/material.dart';

class circularProgress extends StatelessWidget {
  const circularProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(),);
  }
}