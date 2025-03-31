import 'package:carl_coind_dashboard/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '/domain/tecnici/entities/tecnico.dart';

class TecnicoSuMacchinaItem extends StatelessWidget {
  const TecnicoSuMacchinaItem({
    super.key,
    required this.tecnico,
    required this.dettaglio,
  });

  final TecnicoEntity tecnico;
  final bool dettaglio;

  @override
  Widget build(BuildContext context) {
    if (dettaglio) {
      return Column(
        children: [
          const SizedBox(
            height: 15,
            width: 20,
            child: CircleAvatar(
              maxRadius: 10,
              child: Icon(
                Icons.account_circle,
                size: 15,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 20,
            child: Text(
              tecnico.codice,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 7,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.clip,
                  ),
              maxLines: 2,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          const SizedBox(
            height: 10,
            width: 20,
            child: CircleAvatar(
              maxRadius: 15,
              child: Icon(
                Icons.account_circle,
                size: 15,
              ),
            ),
          ),
          SizedBox(
            height: 10,
            width: 20,
            child: Text(
              tecnico.codice,
              style: const TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 7,
                color: AppColors.secondBackground,
              ),
            ),
          ),
        ],
      );
    }
  }
}
