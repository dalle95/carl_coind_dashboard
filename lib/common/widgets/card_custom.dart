import 'package:flutter/material.dart';

import '/core/configs/theme/app_colors.dart';

class CardCustom extends StatelessWidget {
  const CardCustom({
    super.key,
    required this.titolo,
    required this.contenuto,
    this.titoloBackgroundColor,
    this.onTitleTap,
  });

  final String titolo;
  final Widget contenuto;
  final Color? titoloBackgroundColor;
  final VoidCallback? onTitleTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTitleTap,
            child: Container(
              width: double.infinity,
              color: titoloBackgroundColor ?? AppColors.primary,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                titolo.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: titoloBackgroundColor == Colors.yellow
                          ? Colors.black
                          : Theme.of(context).colorScheme.background,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: contenuto,
            ),
          ),
        ],
      ),
    );
  }
}
