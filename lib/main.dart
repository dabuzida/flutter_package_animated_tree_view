import 'dart:math';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const showSnackBar = false;
const expandChildrenOnReady = true;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Animated Tree View',
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  TreeViewController? _treeViewController;
  String? _selectedNode;

// final _tree = TreeNode.root()
//   ..addAll(
//     <Node>[
//       TreeNode(key: '0A')..add(TreeNode(key: '0A1A')),
//       TreeNode(key: '0C')
//         ..addAll(
//           <Node>[
//             TreeNode(key: '0C1A'),
//             TreeNode(key: '0C1B'),
//             TreeNode(key: '0C1C')
//               ..addAll(
//                 <Node>[
//                   TreeNode(key: '0C1C2A')
//                     ..addAll(
//                       <Node>[
//                         TreeNode(key: '0C1C2A3A'),
//                         TreeNode(key: '0C1C2A3B'),
//                         TreeNode(key: '0C1C2A3C'),
//                       ],
//                     ),
//                 ],
//               ),
//           ],
//         ),
//       TreeNode(key: '0D'),
//       TreeNode(key: '0E'),
//     ],
//   );

  final _tree = TreeNode.root()
    ..addAll(
      <Node>[
        TreeNode(key: 'a')
          ..addAll(
            <Node>[
              TreeNode(key: '1'),
              TreeNode(key: '2'),
              TreeNode(key: '3'),
            ],
          ),
        TreeNode(key: 'b')
          ..addAll(
            <Node>[
              TreeNode(key: '4'),
              TreeNode(key: '5'),
              TreeNode(key: '6'),
            ],
          ),
        TreeNode(key: 'c')
          ..addAll(
            <Node>[
              TreeNode(key: '7'),
              TreeNode(key: '8'),
              TreeNode(key: '9'),
            ],
          ),
        TreeNode(key: 'd')
          ..addAll(
            <Node>[
              //
            ],
          ),
      ],
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _tree.expansionNotifier,
        // builder: (BuildContext context, bool value, Widget? child) {
        builder: (BuildContext context, bool isExpanded, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (_tree.isExpanded) {
                _treeViewController?.collapseNode(_tree);
              } else {
                _treeViewController?.expandAllChildren(_tree);
              }
            },
            label: isExpanded ? const Text('Collapse all') : const Text('Expand all'),
          );
        },
      ),
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              width: 200,
              child: TreeView.simple(
                tree: _tree,
                showRootNode: false,
                expansionIndicatorBuilder: (BuildContext context, ITreeNode node) {
                  // ExpansionIndicator
                  return ChevronIndicator.rightDown(
                    tree: node,
                    color: Colors.blue,
                    // padding: const EdgeInsets.all(8),
                    // padding: const EdgeInsets.all(30),
                    // curve: Curves.bounceIn,
                    // alignment: Alignment.center,
                    // alignment: Alignment.topCenter,
                    // alignment: Alignment.bottomCenter,
                    alignment: Alignment.centerLeft,
                    // alignment: Alignment.centerRight,
                  );
                },
                indentation: const Indentation(style: IndentStyle.squareJoint),
                onItemTap: (TreeNode item) {
                  // if (kDebugMode) print('Item tapped: ${item.key}');

                  // if (showSnackBar) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text('Item tapped: ${item.key}'),
                  //       duration: const Duration(milliseconds: 750),
                  //     ),
                  //   );
                  // }
                  if (item.level > 1) {
                    // 하위노드 expansion indicator 선택시 무시
                    return;
                  }

                  print('>> expansion indicator clicked ${_makeString(1)}');
                },
                onTreeReady: (TreeViewController<dynamic, TreeNode> controller) {
                  _treeViewController = controller;
                  if (expandChildrenOnReady) controller.expandAllChildren(_tree);
                },
                builder: (BuildContext context, TreeNode item) {
                  // return Container(
                  //   decoration: BoxDecoration(border: Border.all(color: Colors.green)),
                  //   child: Container(
                  //     decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                  //     width: 180,
                  //     height: 60,
                  //     // padding: EdgeInsets.symmetric(vertical: 10),
                  //     margin: const EdgeInsets.only(
                  //       left: 20,
                  //       // top: 10,
                  //       // bottom: 10,
                  //     ),
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         print('>> node key: ${item.key}, node level: ${item.level}');
                  //         _selectedKey = item.key;
                  //         setState(() {});
                  //       },
                  //       child: MouseRegion(
                  //         cursor: SystemMouseCursors.click,
                  //         child: Container(
                  //           color: _selectedKey != null && _selectedKey! == item.key ? Colors.blue : Colors.grey.shade100,
                  //           alignment: Alignment.center,
                  //           child: Text(item.key),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );

                  return Container(
                    decoration: BoxDecoration(
                      color: _selectedNode != null && _selectedNode! == item.key ? Colors.blue : Colors.grey.shade100,
                      border: Border.all(color: Colors.red),
                    ),
                    width: 180,
                    height: 60,
                    margin: const EdgeInsets.only(
                      left: 25,
                      // top: 10,
                      // bottom: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print('>> node key: ${item.key}, node level: ${item.level}');
                        _selectedNode = item.key;
                        setState(() {});
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            item.key,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              child: const Text('>> Testing <<'),
              onPressed: () {
                final TreeNode<int> s1 = TreeNode<int>();
                s1.data = 4;
                final TreeNode s2 = TreeNode.root();
                print(s1);
                print(s2);
                final zz = TreeNode.root()
                  ..addAll(
                    <Node>[
                      TreeNode(key: '0A')..add(TreeNode(key: '0A1A')),
                      TreeNode(key: '0C')
                        ..addAll(
                          <Node>[
                            TreeNode(key: '0C1A'),
                            TreeNode(key: '0C1B'),
                            TreeNode(key: '0C1C')
                              ..addAll(
                                <Node>[
                                  TreeNode(key: '0C1C2A')
                                    ..addAll(
                                      <Node>[
                                        TreeNode(key: '0C1C2A3A'),
                                        TreeNode(key: '0C1C2A3B'),
                                        TreeNode(key: '0C1C2A3C'),
                                      ],
                                    ),
                                ],
                              ),
                          ],
                        ),
                      TreeNode(key: '0D'),
                      TreeNode(key: '0E'),
                    ],
                  );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _makeString(int length) {
    const String xx = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List<String>.generate(length, (_) => xx[Random().nextInt(xx.length)]).join();
  }
}
