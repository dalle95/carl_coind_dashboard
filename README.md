# Carl Coind Dashboard

**Carl Coind Dashboard** è un'app **desktop** realizzata con Flutter, progettata per monitorare in tempo reale lo stato operativo delle linee di produzione e gestire gli ordini di lavoro. L'app è ottimizzata per ambienti industriali e interfacce su schermi di grandi dimensioni, garantendo un'esperienza fluida ed efficiente anche su dispositivi touch o a controllo remoto.

## 🚀 Caratteristiche principali

- 🔄 **Aggiornamento automatico**:
  - Ordini di lavoro aggiornati ogni **30 secondi**
  - Organizzazione delle linee/macchine aggiornata ogni **ora**

- 🏭 **Monitoraggio delle linee di produzione**:
  - Visualizzazione gerarchica di linee e macchine
  - Stato macchina colorato (verde, giallo, rosso) per un'immediata comprensione dello stato operativo

- 🧾 **Gestione interventi e ordini di lavoro**:
  - Visualizzazione dettagliata degli ordini di lavoro aperti
  - Stato dell'intervento (In corso, In pausa, In attesa)
  - Gravità del guasto (es. Bloccante)

- 👷 **Tecnici assegnati**:
  - Rappresentazione grafica dei tecnici al lavoro
  - Badge e indicatori con numero di tecnici per ogni intervento

- 🎨 **Indicatori visivi intelligenti**:
  - Icone dinamiche e badge che evidenziano la gravità o la presenza di tecnici
  - Layout responsivo per ambienti desktop

- 🧭 **Navigazione fluida**:
  - Passaggio rapido tra dashboard delle linee, interventi e dettagli

- ⚠️ **Gestione avanzata degli errori**:
  - Messaggi chiari e dettagliati in caso di errori di rete o sessione scaduta

## 🧱 Architettura

Il progetto segue i principi della **Clean Architecture**:

- **Layered separation** (domain, data, presentation)
- **Cubit (flutter_bloc)** per la gestione dello stato reattivo
- Codice modulare e testabile

## 🛠️ Tecnologie utilizzate

- **Flutter**: UI reattiva multipiattaforma (**target desktop**)
- **Dartz**: Programmazione funzionale con gestione `Either` per gli errori
- **Cubit (flutter_bloc)**: Stato gestito in modo semplice ma potente
- **Material Design**: UI coerente e professionale
- **HTTP + Dio**: Comunicazione API ottimizzata e flessibile