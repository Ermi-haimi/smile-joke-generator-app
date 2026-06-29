import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile/l10n/app_localizations.dart';
import 'package:smile/reusable_widgets.dart';
import 'statistics_provider.dart';
import 'fav_joke_provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Column(
        children: [
          StatWidget(
            icon: Icons.eighteen_mp,
            statName: AppLocalizations.of(context)!.allViewed,
            statValue: context.read<StatisticsProvider>().viewedJokesNum,
          ),
          StatWidget(
            icon: Icons.favorite_outline_outlined,
            statName: AppLocalizations.of(context)!.favJokesNum,
            statValue: context.read<FavJokeProvider>().favJokes.length,
          ),
          StatWidget(
            icon: Icons.send_time_extension_sharp,
            statName: AppLocalizations.of(context)!.sharedJokesNum,
            statValue: context.read<StatisticsProvider>().sharedJokesNum,
          ),
          StatWidget(
            icon: Icons.content_paste_outlined,
            statName: AppLocalizations.of(context)!.copiedJokesNum,
            statValue: context.read<StatisticsProvider>().copiedJokesNum,
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionTile(
            shape: const Border(),
            collapsedShape: const Border(),
            title: Text(AppLocalizations.of(context)!.categoryView),
            children: [
              StatWidget(
                icon: Icons.circle_outlined,
                statName: 'Any',
                statValue:
                    context.read<StatisticsProvider>().categoryView['Any'] ?? 0,
              ),
              StatWidget(
                icon: Icons.computer_outlined,
                statName: 'Programming',
                statValue:
                    context
                        .read<StatisticsProvider>()
                        .categoryView['Programming'] ??
                    0,
              ),
              StatWidget(
                icon: Icons.insert_emoticon_outlined,
                statName: 'Spooky',
                statValue:
                    context.read<StatisticsProvider>().categoryView['Spooky'] ??
                    0,
              ),
              StatWidget(
                icon: Icons.cabin_outlined,
                statName: 'Christmas',
                statValue:
                    context
                        .read<StatisticsProvider>()
                        .categoryView['Christmas'] ??
                    0,
              ),
              StatWidget(
                icon: Icons.dangerous_outlined,
                statName: 'Dark',
                statValue:
                    context.read<StatisticsProvider>().categoryView['Dark'] ??
                    0,
              ),
              StatWidget(
                icon: Icons.book_outlined,
                statName: 'Pun',
                statValue:
                    context.read<StatisticsProvider>().categoryView['Pun'] ?? 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatWidget extends StatelessWidget {
  final IconData icon;
  final String statName;
  final int statValue;

  const StatWidget({
    super.key,
    required this.icon,
    required this.statName,
    required this.statValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(
                width: 15,
              ),
              Text(
                statName,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Text(
            statValue.toString(),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
