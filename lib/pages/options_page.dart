import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:systolic/components/page_template.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      pageTitle: AppLocalizations.of(context)!.options,
      pageContent: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: const Center(
          child: Text(
            'Work in Progress.',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
