import 'dart:developer';
import 'dart:math';

import 'package:animated_tree_view/animated_tree_view.dart';
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
  TreeViewController? _treeViewController; // 트리 전체 열기, 전체 닫기 같은 이벤트에 사용
  // String? _selectedNode;
  TreeNode? _selectedNode;

  final TreeNode _treeSimple = TreeNode.root()
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

  final TreeNode _treeSimpleTyped = TreeNode.root()
    ..addAll(
      <Node>[
        TreeNode(key: 'qqq')
          ..addAll(
            <Node>[
              TreeNode(key: '1'),
              TreeNode(key: '2'),
              TreeNode(key: '3'),
            ],
          ),
        TreeNode(key: 'www')
          ..addAll(
            <Node>[
              TreeNode(key: '4'),
            ],
          ),
        TreeNode(key: 'rrr')
          ..addAll(
            <Node>[
              //
            ],
          ),
      ],
    );

  final IndexedTreeNode _treeIndexed = IndexedTreeNode.root()
    ..addAll(
      <IndexedNode>[
        IndexedNode(key: 'gg')
          ..addAll(
            <IndexedNode>[
              IndexedNode(key: '1'),
              IndexedNode(key: '2'),
              IndexedNode(key: '3'),
            ],
          ),
        IndexedNode(key: 'hh')
          ..addAll(
            <IndexedNode>[
              IndexedNode(key: '4'),
            ],
          ),
        IndexedNode(key: 'jj')
          ..addAll(
            <IndexedNode>[
              //
            ],
          ),
      ],
    );

  final TreeNode _treeIndexTyped = TreeNode.root()
    ..addAll(
      <Node>[
        TreeNode(key: 'pp')
          ..addAll(
            <Node>[
              TreeNode(key: '1'),
              TreeNode(key: '2'),
              TreeNode(key: '3'),
            ],
          ),
        TreeNode(key: 'yy')
          ..addAll(
            <Node>[
              TreeNode(key: '4'),
            ],
          ),
        TreeNode(key: 'zz')
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
      // floatingActionButton: ValueListenableBuilder<bool>(
      //   valueListenable: _tree.expansionNotifier,
      //   builder: (BuildContext context, bool isExpanded, _) {
      //     return const SizedBox();
      //     // return FloatingActionButton.extended(
      //     //   label: Text(isExpanded ? 'Collapse all' : 'Expand all'),
      //     //   onPressed: () {
      //     //     if (_tree.isExpanded) {
      //     //       _treeViewController?.collapseNode(_tree);
      //     //     } else {
      //     //       _treeViewController?.expandAllChildren(_tree);
      //     //     }
      //     //   },
      //     // );
      //   },
      // ),
      body: Row(
        children: <Widget>[
          // TODO: 차이 리서치중
          // TreeView.simple >> _buildUITreeViewSimple
          // TreeView.simpleTyped >> _buildUITreeViewSimpleTyped
          // TreeView.indexed >> _buildUITreeViewIndexed
          // TreeView.indexTyped >> _buildUITreeViewIndexTyped
          Column(
            children: <Widget>[
              const Text('TreeViewSimple'),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                width: 200,
                height: 700,
                child: _buildUITreeViewSimple(),
              ),
              _buildUITestButton(),
            ],
          ),
          const VerticalDivider(),
          Column(
            children: <Widget>[
              _buildUIButton(
                title: '상위 노드 추가',
                onPressed: () {
                  // 중복 키가 존재하면 불가
                  _treeSimple.add(TreeNode(key: _makeString(5)));

                  setState(() {});

                  // _treeSimple.addedNodes;
                  // _treeSimple.clear;
                  // _treeSimple.add(TreeNode(key: _makeString(3)));
                  // _treeSimple.children.entries;
                  // _treeSimple.children.entries.first;
                  // print('key: ${_treeSimple.children.entries.first.key}');
                  // print('value: ${_treeSimple.children.entries.first.value}');
                  // print('key: ${_treeSimple.children.entries.first.key}, value: ${_treeSimple.children.entries.first.value}');

                  // print(_treeSimple.children.length);
                  // for (MapEntry<String, Node> element in _treeSimple.children.entries) {
                  //   print('key: ${element.key}, value: ${element.value}');
                  // }

                  // addAll(
                  //   <Node>[
                  //     TreeNode(key: _makeString(4))
                  //       ..addAll(
                  //         <Node>[
                  //           TreeNode(key: _makeString(5)),
                  //           TreeNode(key: _makeString(6)),
                  //         ],
                  //       ),
                  //   ],
                  // );

                  //
                },
              ),
              _buildUIButton(
                title: '하위 노드 추가',
                onPressed: () {
                  if (_selectedNode == null || _selectedNode!.level > 1) {
                    print('상위 노드를 선택하세요');
                    return;
                  }

                  // 중복 키가 존재하면 불가
                  _selectedNode!.add(TreeNode(key: _makeString(8)));

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '상위 노드 삭제',
                onPressed: () {
                  if (_selectedNode == null || _selectedNode!.level > 1) {
                    print('상위 노드를 선택하세요');
                    return;
                  }

                  // 로직. 하위 노드도 같이 모두 삭제

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '하위 노드 삭제',
                onPressed: () {
                  if (_selectedNode == null || _selectedNode!.level < 2) {
                    print('하위 노드를 선택하세요');
                    return;
                  }

                  _treeSimple;
                  _selectedNode;

                  print(_selectedNode!.path);
                  print(_selectedNode!.parent?.key);
                  print(_selectedNode!.key);
                  // final TreeNode tre3eSimple = TreeNode.root();
                  // Node ww = Node();
                  _treeSimple.remove(Node(key: '4'));

                  // for (ListenableNode element in _treeSimple.childrenAsList) {
                  //   print(element.key); // 상위 노드 키
                  // }

                  //
                  setState(() {});
                },
              ),
              Container(
                width: 400,
                height: 300,
                decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                child: _buildUINodeInfo(),
              ),
            ],
          ),

          // const VerticalDivider(),
          // Column(
          //   children: <Widget>[
          //     const Text('TreeViewSimpleTyped'),
          //     Container(
          //       decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          //       width: 200,
          //       height: 700,
          //       child: _buildUITreeViewSimpleTyped(),
          //     ),
          //   ],
          // ),
          // const VerticalDivider(),
          // Column(
          //   children: <Widget>[
          //     const Text('TreeViewIndexed'),
          //     Container(
          //       decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          //       width: 200,
          //       height: 700,
          //       child: _buildUITreeViewIndexed(),
          //     ),
          //   ],
          // ),
          // const VerticalDivider(),
          // Column(
          //   children: <Widget>[
          //     const Text('TreeViewIndexTyped'),
          //     Container(
          //       decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          //       width: 200,
          //       height: 700,
          //       child: _buildUITreeViewIndexTyped(),
          //     ),
          //   ],
          // ),

          //
        ],
      ),
    );
  }

  Widget _buildUINodeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text(
            '선택한 키 정보',
            style: TextStyle(
              fontSize: 20,
              color: Colors.green,
            ),
          ),
        ),
        _buildUIItem(title: 'PATH', desc: _selectedNode?.path),
        _buildUIItem(title: 'parent key', desc: _selectedNode?.parent?.key),
        _buildUIItem(title: '키', desc: _selectedNode?.key),
      ],
    );
  }

  Widget _buildUIItem({required String title, required String? desc}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(title),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(desc.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildUIButton({required String title, required void Function() onPressed}) {
    return Container(
      width: 200,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        child: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(12),

              ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildUITreeViewSimple() {
    return TreeView.simple(
      tree: _treeSimple,
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
      onItemTap: (TreeNode node) {
        if (node.level > 1) {
          // 하위노드 expansion indicator 선택시 무시
          return;
        }

        print('>> expansion indicator clicked ${_makeString(1)}');
      },
      onTreeReady: (TreeViewController<dynamic, TreeNode> controller) {
        _treeViewController = controller;
        if (expandChildrenOnReady) controller.expandAllChildren(_treeSimple);
      },
      builder: (BuildContext context, TreeNode node) {
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
          width: 180,
          height: 30,
          margin: const EdgeInsets.only(
            left: 25,
            // top: 10,
            // bottom: 10,
            // right: 10,
          ),
          decoration: BoxDecoration(
            color: _selectedNode != null && _selectedNode!.key == node.key ? Colors.blue : Colors.grey.shade100,
            border: Border.all(color: Colors.red),
          ),
          child: GestureDetector(
            onTap: () {
              print('>> node key: ${node.key}, node hierarchy: ${node.level}');
              _selectedNode = node;
              setState(() {});
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                alignment: Alignment.center,
                child: Text(node.key),
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _buildUITreeViewSimpleTyped() {
  //   return TreeView.simpleTyped(
  //     tree: _treeSimpleTyped,
  //     showRootNode: false,
  //     expansionIndicatorBuilder: (BuildContext context, ITreeNode node) {
  //       // ExpansionIndicator
  //       return ChevronIndicator.rightDown(
  //         tree: node,
  //         color: Colors.blue,
  //         alignment: Alignment.centerLeft,
  //       );
  //     },
  //     indentation: const Indentation(style: IndentStyle.squareJoint),
  //     onItemTap: (TreeNode node) {
  //       if (node.level > 1) {
  //         return;
  //       }

  //       print('>> expansion indicator clicked ${_makeString(1)}');
  //     },
  //     onTreeReady: (TreeViewController<dynamic, TreeNode> controller) {
  //       _treeViewController = controller;
  //       if (expandChildrenOnReady) controller.expandAllChildren(_treeSimpleTyped);
  //     },
  //     builder: (BuildContext context, TreeNode node) {
  //       return Container(
  //         width: 180,
  //         height: 60,
  //         margin: const EdgeInsets.only(left: 25),
  //         decoration: BoxDecoration(
  //           color: _selectedNode != null && _selectedNode! == node.key ? Colors.blue : Colors.grey.shade100,
  //           border: Border.all(color: Colors.red),
  //         ),
  //         child: GestureDetector(
  //           onTap: () {
  //             print('>> node key: ${node.key}, node hierarchy: ${node.level}');
  //             _selectedNode = node.key;
  //             setState(() {});
  //           },
  //           child: MouseRegion(
  //             cursor: SystemMouseCursors.click,
  //             child: Container(
  //               alignment: Alignment.center,
  //               child: Text(node.key),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildUITreeViewIndexed() {
  //   // return TreeView.indexed(builder: builder, tree: IndexedTreeNode());

  //   return TreeView.indexed(
  //     tree: _treeIndexed,
  //     showRootNode: false,
  //     expansionIndicatorBuilder: (BuildContext context, ITreeNode node) {
  //       return ChevronIndicator.rightDown(
  //         tree: node,
  //         color: Colors.blue,
  //         alignment: Alignment.centerLeft,
  //       );
  //     },
  //     indentation: const Indentation(style: IndentStyle.squareJoint),
  //     onItemTap: (IndexedTreeNode node) {
  //       if (node.level > 1) {
  //         return;
  //       }

  //       print('>> expansion indicator clicked ${_makeString(1)}');
  //     },
  //     onTreeReady: (TreeViewController<dynamic, IndexedTreeNode> controller) {
  //       _treeViewController = controller;
  //       if (expandChildrenOnReady) controller.expandAllChildren(_treeIndexed);
  //     },
  //     // onTreeReady: (TreeViewController<dynamic, TreeNode> controller) {
  //     //   _treeViewController = controller;
  //     //   if (expandChildrenOnReady) controller.expandAllChildren(_treeIndexed);
  //     // },
  //     // builder: (BuildContext context, TreeNode node) {
  //     builder: (BuildContext context, IndexedTreeNode node) {
  //       return Container(
  //         width: 180,
  //         height: 60,
  //         margin: const EdgeInsets.only(left: 25),
  //         decoration: BoxDecoration(
  //           color: _selectedNode != null && _selectedNode! == node.key ? Colors.blue : Colors.grey.shade100,
  //           border: Border.all(color: Colors.red),
  //         ),
  //         child: GestureDetector(
  //           onTap: () {
  //             print('>> node key: ${node.key}, node hierarchy: ${node.level}');
  //             _selectedNode = node.key;
  //             setState(() {});
  //           },
  //           child: MouseRegion(
  //             cursor: SystemMouseCursors.click,
  //             child: Container(
  //               alignment: Alignment.center,
  //               child: Text(node.key),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildUITreeViewIndexTyped() {
  //   return TreeView.simple(
  //     tree: _treeIndexTyped,
  //     showRootNode: false,
  //     expansionIndicatorBuilder: (BuildContext context, ITreeNode node) {
  //       return ChevronIndicator.rightDown(
  //         tree: node,
  //         color: Colors.blue,
  //         alignment: Alignment.centerLeft,
  //       );
  //     },
  //     indentation: const Indentation(style: IndentStyle.squareJoint),
  //     onItemTap: (TreeNode node) {
  //       if (node.level > 1) {
  //         return;
  //       }

  //       print('>> expansion indicator clicked ${_makeString(1)}');
  //     },
  //     onTreeReady: (TreeViewController<dynamic, TreeNode> controller) {
  //       _treeViewController = controller;
  //       if (expandChildrenOnReady) controller.expandAllChildren(_treeIndexTyped);
  //     },
  //     builder: (BuildContext context, TreeNode node) {
  //       return Container(
  //         width: 180,
  //         height: 60,
  //         margin: const EdgeInsets.only(left: 25),
  //         decoration: BoxDecoration(
  //           color: _selectedNode != null && _selectedNode! == node.key ? Colors.blue : Colors.grey.shade100,
  //           border: Border.all(color: Colors.red),
  //         ),
  //         child: GestureDetector(
  //           onTap: () {
  //             print('>> node key: ${node.key}, node hierarchy: ${node.level}');
  //             _selectedNode = node.key;
  //             setState(() {});
  //           },
  //           child: MouseRegion(
  //             cursor: SystemMouseCursors.click,
  //             child: Container(
  //               alignment: Alignment.center,
  //               child: Text(node.key),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildUITestButton() {
    return ElevatedButton(
      child: const Text('>> Testing <<'),
      onPressed: () {
        // TODO: TreeNode 구조, 사용방법 #####
        _treeSimple;

        final TreeNode<String> tree = TreeNode<String>.root();
        final TreeNode<String> tree2 = TreeNode<String>();

        final TreeNode<String> tree3 = TreeNode<String>.root()
          // final TreeNode<String> tree3 = TreeNode<String>()
          ..addAll(
            <Node>[
              TreeNode(key: '0A')..add(TreeNode(key: '0A1A')),
              TreeNode(key: '0C')
                ..addAll(
                  <Node>[
                    TreeNode(key: '0C1A'),
                    TreeNode(key: '0C1C')
                      ..addAll(
                        <Node>[
                          TreeNode(key: '0C1C2A')
                            ..addAll(
                              <Node>[
                                TreeNode(key: '0C1C2A3A'),
                              ],
                            ),
                        ],
                      ),
                  ],
                ),
            ],
          );
      },
    );
  }

  String _makeString(int length) {
    const String xx = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List<String>.generate(length, (_) => xx[Random().nextInt(xx.length)]).join();
  }
}
