import 'package:flutter/material.dart';

import '/core/configs/theme/app_colors.dart';

import '/domain/tecnici/entities/tecnico.dart';

class TecnicoItem extends StatelessWidget {
  const TecnicoItem({
    super.key,
    required this.tecnico,
    required this.maxHeight,
  });

  final TecnicoEntity tecnico;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: maxHeight * 0.05),
        child: Row(
          children: [
            Icon(
              Icons.man_3,
              size: maxHeight * 0.7,
              color: AppColors.secondBackground,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              tecnico.nome,
              style: TextStyle(
                fontSize: maxHeight * 0.7,
                color: AppColors.secondBackground,
              ),
            )
          ],
        ),
      ),
    );
  }
}
