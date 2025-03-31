import 'package:flutter/material.dart';

// class ResponsiveGridView<T> extends StatelessWidget {
//   final int itemCount;
//   final NullableIndexedWidgetBuilder itemBuilder;
//   final double desiredItemWidth;
//   final double desiredItemHeight;
//   final double mainAxisSpacing;
//   final double crossAxisSpacing;
//   final EdgeInsetsGeometry? padding;
//   final ScrollPhysics? physics;
//   final bool shrinkWrap;

//   const ResponsiveGridView({
//     super.key,
//     required this.itemCount,
//     required this.itemBuilder,
//     this.desiredItemWidth = 220.0,
//     this.desiredItemHeight = 180.0,
//     this.mainAxisSpacing = 8.0,
//     this.crossAxisSpacing = 8.0,
//     this.padding,
//     this.physics,
//     this.shrinkWrap = false, // Modificato per partire dall'alto
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         int crossAxisCount = (constraints.maxWidth / desiredItemWidth).floor();
//         crossAxisCount =
//             crossAxisCount.clamp(1, 4); // Limitato tra 1 e 4 colonne

//         double actualItemWidth =
//             (constraints.maxWidth - (crossAxisCount - 1) * crossAxisSpacing) /
//                 crossAxisCount;
//         double childAspectRatio = actualItemWidth / desiredItemHeight;

//         return Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start, // Allineamento dall'alto
//           children: [
//             Expanded(
//               child: GridView.builder(
//                 shrinkWrap: shrinkWrap,
//                 physics: physics ?? const AlwaysScrollableScrollPhysics(),
//                 padding: padding,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: crossAxisCount,
//                   mainAxisSpacing: mainAxisSpacing,
//                   crossAxisSpacing: crossAxisSpacing,
//                   childAspectRatio: childAspectRatio,
//                 ),
//                 itemCount: itemCount,
//                 itemBuilder: (context, index) => itemBuilder(context, index),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> items;

  const ResponsiveGrid({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determina il numero di colonne in base al numero di item
    int columns = 1;
    if (items.length >= 4 && items.length <= 8) {
      columns = 2;
    } else if (items.length >= 9 && items.length <= 15) {
      columns = 3;
    } else if (items.length > 15) {
      columns = 4;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calcola la dimensione di ogni cella in base al numero di colonne
        final double itemWidth = constraints.maxWidth / columns;
        final double itemHeight =
            constraints.maxHeight / (items.length / columns).ceil();

        return GridView.builder(
          padding: EdgeInsets.zero, // Rimuove eventuali padding
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: itemWidth / itemHeight,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),

          itemCount: items.length,
          physics: const NeverScrollableScrollPhysics(), // Disabilita lo scroll
          itemBuilder: (context, index) {
            // return Container(
            //   alignment: Alignment.center,
            //   child: items[index],
            // );
            return LayoutBuilder(
              builder: (context, itemConstraints) {
                return SizedBox(
                  width: itemConstraints.maxWidth,
                  height: itemConstraints.maxHeight,
                  child: items[index],
                );
              },
            );
          },
        );
      },
    );
  }
}
