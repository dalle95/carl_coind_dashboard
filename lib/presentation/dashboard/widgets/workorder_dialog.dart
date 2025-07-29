import 'package:carl_coind_dashboard/core/configs/assets/app_images.dart';
import 'package:flutter/material.dart';

import '/domain/wo/entities/wo.dart';

import '/presentation/dashboard/pages/workorder_page.dart';

class WorkOrdersDialog extends StatelessWidget {
  final String titolo;
  final List<WOEntity> workOrders;

  const WorkOrdersDialog({
    super.key,
    required this.titolo,
    required this.workOrders,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titolo,
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: 400,
        height: 500,
        child: workOrders.isEmpty
            ? Center(
                child: Text(
                  'Nessun intervento presente',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              )
            : ListView.separated(
                itemCount: workOrders.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final wo = workOrders[index];
                  var listTile2 = ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    leading: getIcon(wo),
                    title: Text(
                      wo.codice ?? 'Senza codice',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      wo.descrizione ?? 'Nessuna descrizione',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (wo.tecnici.isNotEmpty == true)
                          Badge(
                            label: Text(
                              '${wo.tecnici.length}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Icon(
                              Icons.account_circle,
                              color: Theme.of(context).colorScheme.primary,
                              size: 40,
                            ),
                          ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WorkOrderDetailPage(workOrder: wo),
                        ),
                      );
                    },
                  );
                  var listTile = listTile2;
                  return listTile;
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Chiudi'),
        )
      ],
    );
  }

  Widget getIcon(WOEntity wo) {
    if (wo.natura == 'Cambio formato') {
      return SizedBox(
        width: 30,
        height: 30,
        child: ClipRRect(
          child: Image.asset(
            AppImages.cambiaFormatoInCorso,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            isAntiAlias: true,
          ),
        ),
      );
    }

    return wo.statoMacchina == 'Bloccante'
        ? const Icon(
            Icons.warning_amber_rounded,
            color: Colors.redAccent,
            size: 28,
          )
        : Icon(
            Icons.info_outlined,
            color: Colors.yellow[600],
            size: 28,
          );
  }
}
