import 'package:flutter/material.dart';
import 'package:generated/generated.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:weather_forecast_app/core/providers/router_provider.dart';

import 'package:weather_forecast_app/core/widgets/base_widget.dart';
import 'package:weather_forecast_app/core/widgets/error_dialog.dart';

class ErrorHandlingScreen extends ConsumerStatefulWidget {
  final Failure failure;
  final Widget? fallbackContent;

  const ErrorHandlingScreen({
    super.key,
    required this.failure,
    this.fallbackContent,
  });

  @override
  ConsumerState<ErrorHandlingScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends ConsumerState<ErrorHandlingScreen> {
  bool _handled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_handled) return;
    _handled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final failure = widget.failure;

      if (failure.statusCode == 401) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message.tr())));
        context.replace(Routes.initial); // yönlendir
      } else if (failure.isShow) {
        showFailureDialog(context, failure);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      childBody:
          widget.fallbackContent ??
          Center(
            child: Text(
              widget.failure.message.tr(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ),
    );
  }
}
