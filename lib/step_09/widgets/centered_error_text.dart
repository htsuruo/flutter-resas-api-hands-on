import 'package:flutter/material.dart';

import '../api_exception.dart';

class CenteredErrorText extends StatelessWidget {
  const CenteredErrorText({super.key, required this.error});

  // FutureBuilderのsnapshot.errorには単純には型が付かないのでひとまずObject型にしておきます。
  // Object型では基本的にどんな型でも許容されてしまい、想定以外の値も許容されてしまうため基本使わないほうが良いです。
  final Object error;

  @override
  Widget build(BuildContext context) {
    final String label;
    final error = this.error;
    if (error is ApiException) {
      label = '${error.message}\n${error.description}';
    } else {
      label = error.toString();
    }
    return Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }
}
