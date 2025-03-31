import 'package:flutter/material.dart';

import '/core/configs/theme/app_colors.dart';

import '/domain/linea_dashboard/entities/linea_dashboard.dart';

// class LineaItem extends StatelessWidget {
//   const LineaItem({
//     super.key,
//     required this.lineaDettaglio,
//   });

//   final LineaDashboardEntity lineaDettaglio;

//   Color getColoreLinea() {
//     switch (lineaDettaglio.getStato()) {
//       case 'Attiva':
//         return Colors.green;
//       case 'Non bloccata':
//         return Colors.yellow;
//       case 'Bloccata':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: 2,
//         horizontal: 6,
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 15,
//             backgroundColor: getColoreLinea(),
//             child: const Icon(
//               Icons.lan_outlined,
//               size: 15,
//               color: AppColors.secondBackground,
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Text(
//             lineaDettaglio.linea.descrizione,
//             style: const TextStyle(
//               color: AppColors.secondBackground,
//               fontWeight: FontWeight.w500,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class LineaItem extends StatelessWidget {
  const LineaItem({
    super.key,
    required this.lineaDettaglio,
    required this.maxHeight,
  });

  final LineaDashboardEntity lineaDettaglio;
  final double maxHeight;

  Color getColoreLinea() {
    switch (lineaDettaglio.getStato()) {
      case 'Attiva':
        return Colors.green;
      case 'Non bloccata':
        return Colors.yellow;
      case 'Bloccata':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

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
            CircleAvatar(
              radius: 15,
              backgroundColor: getColoreLinea(),
              child: Icon(
                Icons.lan_outlined,
                size: maxHeight * 0.7,
                color: AppColors.secondBackground,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                lineaDettaglio.linea.descrizione,
                style: TextStyle(
                  fontSize: maxHeight * 0.7,
                  color: AppColors.secondBackground,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis, // Per il testo lungo
              ),
            ),
          ],
        ),
      ),
    );
  }
}
