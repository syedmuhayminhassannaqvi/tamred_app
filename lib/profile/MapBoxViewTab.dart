// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// class MapBoxViews extends StatefulWidget {
//   const MapBoxViews({super.key});
//
//   @override
//   State<MapBoxViews> createState() => _MapBoxViewsState();
// }
//
// class _MapBoxViewsState extends State<MapBoxViews> {
//   List<Map<String, dynamic>> layout = [
//     {
//       'Image': 'assets/images/branch.png',
//       'Text':
//           'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to...'
//     },
//     {
//       'Image': 'assets/images/branch.png',
//       'Text':
//           'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to...'
//     },
//     {
//       'Image': 'assets/images/branch.png',
//       'Text':
//           'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to...'
//     },
//     {
//       'Image': 'assets/images/branch.png',
//       'Text':
//           'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to...'
//     },
//     {
//       'Image': 'assets/images/branch.png',
//       'Text':
//           'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to...'
//     }
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: layout.map((item) {
//                   return Container(
//                     margin:  EdgeInsets.only(right: 8),
//                     height: 100,
//                     width: MediaQuery.of(context).size.width / 1.15,
//                     decoration: BoxDecoration(
//                       color: Color.fromRGBO(202, 201, 201, 0.1),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding:  EdgeInsets.only(left: 5, right: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 height: 90,
//                                 width: 90,
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                   BorderRadius.circular(12.88),
//                                 ),
//                                 child: Image.asset(item['Image'],
//                                     fit: BoxFit.cover),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   children: [
//                                     const Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           'Belle Vue Sur Le Lac Moraine...',
//                                           style: TextStyle(
//                                               decoration:
//                                               TextDecoration.underline,
//                                               decorationColor: Colors.white,
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w900,
//                                               fontSize: 13,
//                                               fontFamily: 'Museo'),
//                                         ),
//                                         Icon(
//                                           Icons.clear,
//                                           color: Color.fromRGBO(
//                                               181, 181, 181, 1),
//                                           size: 15,
//                                         ),
//                                       ],
//                                     ),
//                                     Text(
//                                       item['Text'],
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w700,
//                                         fontFamily: 'Museo',
//                                       ),
//                                       maxLines: null,
//                                       softWrap: true,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           );
//         },
//       ),
//
//     );
//   }
// }
