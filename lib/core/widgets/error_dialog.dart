import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:generated/generated.dart';

Future<void> showFailureDialog(BuildContext context, Failure failure) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Error'.tr()),
        content: Text(failure.message.tr()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text('OK'.tr()),
          ),
        ],
      );
    },
  );
}
