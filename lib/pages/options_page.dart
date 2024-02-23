import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:systolic/components/page_template.dart';
import 'package:systolic/components/options_tile.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      pageTitle: AppLocalizations.of(context)!.options,
      pageContent: const Column(
        children: [
          OptionsTile(
            id: 'placeholder',
            title: 'Placeholder',
          ),
          OptionsTile(
            id: 'placeholder2',
            title: 'Placeholder2',
          ),
        ],
      ),
    );
  }
}
