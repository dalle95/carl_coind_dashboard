import 'package:flutter/material.dart';

import '/domain/wo/entities/wo.dart';
import '/domain/tecnici/entities/tecnico.dart';

class WorkOrderDetailPage extends StatelessWidget {
  final WOEntity workOrder;

  const WorkOrderDetailPage({super.key, required this.workOrder});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        title: Text(
          'Dettaglio Intervento',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.surface),
        ),
        iconTheme: IconThemeData(color: colorScheme.onBackground),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          color: const Color(0xFF2C2B2B),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                _buildRow(context, 'Codice', workOrder.codice, textTheme),
                _buildRow(
                    context, 'Descrizione', workOrder.descrizione, textTheme),
                _buildRow(context, 'Tipologia', workOrder.natura, textTheme),
                if (workOrder.natura == 'Cambio formato') ...[
                  Row(
                    children: [
                      SizedBox(
                        width: 450,
                        child: _buildRow(context, 'Data Creazione',
                            _formatDate(workOrder.dataCreazione), textTheme),
                      ),
                      SizedBox(
                        width: 450,
                        child: _buildRow(context, 'Data Programmata',
                            _formatDate(workOrder.dataInizio), textTheme),
                      ),
                    ],
                  ),
                ] else ...[
                  _buildRow(context, 'Data Creazione',
                      _formatDate(workOrder.dataCreazione), textTheme),
                ],
                _buildRow(context, 'Operatore Linea', workOrder.operatoreLinea,
                    textTheme),
                if (workOrder.natura == 'Cambio formato') ...[
                  Row(
                    children: [
                      SizedBox(
                        width: 450,
                        child: _buildRow(context, 'Da',
                            workOrder.cambioFormatoDa, textTheme),
                      ),
                      SizedBox(
                        width: 450,
                        child: _buildRow(
                            context, 'A', workOrder.cambioFormatoA, textTheme),
                      ),
                    ],
                  ),
                ],
                if (workOrder.natura != 'Cambio formato') ...[
                  _buildRow(context, 'Gravità guasto', workOrder.statoMacchina,
                      textTheme),
                ],
                _buildRow(context, 'Stato', workOrder.stato, textTheme),
                const Divider(height: 32),
                _buildRow(context, 'Linea',
                    workOrder.puntoDiStruttura?.descrizione ?? '-', textTheme),
                if (workOrder.natura != 'Cambio formato') ...[
                  _buildRow(context, 'Macchina',
                      workOrder.impianto?.descrizione ?? '-', textTheme),
                ],
                const Divider(height: 32),
                Text(
                  'Note Meccanico:',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  constraints: const BoxConstraints(minHeight: 160),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      workOrder.note?.trim() ?? 'Nessuna nota disponibile.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 32),
                TecniciListWidget(tecnici: workOrder.tecnici),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label,
    String? value,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              '$label:',
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? '-',
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}

class TecniciListWidget extends StatelessWidget {
  final List<TecnicoEntity> tecnici;

  const TecniciListWidget({super.key, required this.tecnici});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (tecnici.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Nessun tecnico assegnato',
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tecnici operativi:',
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tecnici.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final tecnico = tecnici[index];
              return Container(
                width: 250,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.surface,
                            size: 50,
                          ),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          child: Text(
                            'Badge: ${tecnico.codice}',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Text(
                        tecnico.nome,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
