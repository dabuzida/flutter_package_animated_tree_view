import 'dart:developer';
import 'dart:math';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';

import 'tree_view_index_typed.dart';
import 'tree_view_indexed.dart';
import 'tree_view_simple.dart';
import 'tree_view_simple_typed.dart';

const showSnackBar = false;
const expandChildrenOnReady = true;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'package: animated_tree_view',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('package: animated_tree_view'),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: const <Widget>[
            TreeViewSimple(),
            // TreeViewSimpleTyped(),
            // TreeViewIndexed(),
            // TreeViewIndexTyped(),
          ],
        ),
      ),
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
  TreeNode? _selectedNode2;

  // TreeNode? _treeSimple2;
  TreeNode? _treeSimpleCopy;
  final TreeNode _treeSimpleOriginal = TreeNode.root()
    ..addAll(
      [
        TreeNode(key: 'a')
          ..addAll(
            [
              TreeNode(key: '1'),
              TreeNode(key: '2'),
              TreeNode(key: '3'),
            ],
          ),
        TreeNode(key: 'b')
          ..addAll(
            [
              TreeNode(key: '4'),
            ],
          ),
        TreeNode(key: 'd')
          ..addAll(
            [
              //
            ],
          ),
      ],
    );

  // final TreeNode<String> _treeSimple = TreeNode<String>.root()
  //   ..addAll(
  //     <Node>[
  //       TreeNode<String>(key: 'a'),
  //     ],
  //   );
  final Node ee = Node(
    key: '',
    parent: Node(),
  );

  final TreeNode rr = TreeNode(
    key: '',
    parent: Node(),
    data: '',
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
  void initState() {
    super.initState();
    //
  }

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
          _buildUITreeViewSimple(),
          const VerticalDivider(),
          _buildUITreeViewSimple2(),
          const VerticalDivider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildUIButtons(),
              Container(
                width: 600,
                height: 500,
                decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                child: _buildUISelectedNodeInfo(),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
  Widget _buildUITreeViewSimple() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          const Text('TreeViewSimple'),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: 200,
            height: 700,
            child: _buildUISimple(),
          ),
        ],
      ),
    );
  }

  Widget _buildUITreeViewSimple2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          const Text('TreeViewSimple2##'),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: 200,
            height: 700,
            child: _buildUISimple2(),
          ),
        ],
      ),
    );
  }

  Widget _buildUISimple2() {
    if (_treeSimpleCopy == null) {
      return const Text('empty');
    }

    return TreeView.simple(
      tree: _treeSimpleCopy!,
      // showRootNode: false,
      expansionIndicatorBuilder: (BuildContext context, ITreeNode node) {
        return ChevronIndicator.rightDown(
          tree: node,
          color: Colors.blue,
          alignment: Alignment.centerLeft,
        );
      },
      indentation: const Indentation(style: IndentStyle.squareJoint),
      onItemTap: (TreeNode node) {
        if (node.level > 1) {
          // 하위노드 expansion indicator 선택시 무시
          return;
        }

        print('>> expansion indicator clicked ${node.key}');
      },
      onTreeReady: (TreeViewController<dynamic, TreeNode> controller) {
        _treeViewController = controller;
        if (expandChildrenOnReady) controller.expandAllChildren(_treeSimpleOriginal);
      },
      builder: (BuildContext context, TreeNode node) {
        return Container(
          width: 180,
          height: 30,
          margin: const EdgeInsets.only(left: 25),
          decoration: BoxDecoration(
            color: _selectedNode2 != null && _selectedNode2!.key == node.key ? Colors.blue : Colors.grey.shade100,
            border: Border.all(color: Colors.red),
          ),
          child: GestureDetector(
            onTap: () {
              print('>> node key: ${node.key}, node hierarchy: ${node.level}');
              _selectedNode2 = node;
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

  Widget _buildUISelectedNodeInfo() {
    return ListView(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: const Text(
                '선택한 키 정보99999',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),
            // @@@@@
            _buildUIItem(title: 'PATH', desc: _selectedNode?.path),
            _buildUIItem(title: 'parent key', desc: _selectedNode?.parent?.key),
            _buildUIItem(title: '선택된 키', desc: _selectedNode?.key),
            _buildUIItem(title: 'hierarchy', desc: _selectedNode?.level.toString()),
            _buildUIItem(title: '_treeSimple ', desc: _treeSimpleOriginal.toString()),
            _buildUIItem(title: '_treeSimple.children ', desc: _treeSimpleOriginal.children.toString()),
            _buildUIItem(title: '_treeSimple.childrenAsList ', desc: _treeSimpleOriginal.childrenAsList.toString()),
            // _buildUIItem(title: 'root ', desc: _selectedNode?.level.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildUIItem({required String title, required String? desc}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(title),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: SelectableText(desc.toString()),
            // child: Text(desc.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildUIButton({required String title, required void Function() onPressed, Color color = Colors.white}) {
    return Container(
      width: 180,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        child: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(12),

              ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildUISimple() {
    return TreeView.simple(
      tree: _treeSimpleOriginal,
      // showRootNode: false,
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

        print('>> expansion indicator clicked ${node.key}');
      },
      onTreeReady: (TreeViewController<dynamic, TreeNode> controller) {
        _treeViewController = controller;
        if (expandChildrenOnReady) controller.expandAllChildren(_treeSimpleOriginal);
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
  Widget _buildUIButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          child: Column(
            children: <Widget>[
              _buildUIButton(
                title: 'Tree 복사11111',
                onPressed: () {
                  _treeSimpleOriginal;
                  _treeSimpleCopy;
                  _treeSimpleOriginal.childrenAsList;
                  _treeSimpleOriginal.children;

                  // _buildUIItem(title: 'root ', desc: _treeSimple.children.toString()),
                  // _buildUIItem(title: 'root ', desc: _treeSimple.childrenAsList.toString()),
                  // _buildUIItem(title: 'root ', desc: _treeSimple.toString()),

                  // print(_treeSimple.children.runtimeType);
                  // print(_treeSimple.childrenAsList.runtimeType);
                  // print(_treeSimple.runtimeType);

                  // for (final ListenableNode element in _treeSimple.childrenAsList) {}

                  // for (final MapEntry<String, Node> element in _treeSimple.children.entries) {
                  //   // print('>> ${element.key}');
                  //   // print('** ${element.value.key}');
                  //   print('^^ ${element.value.children}');
                  // }

                  // for (final String element in _treeSimple.children.keys.toList()) {}
                  // for (final Node element in _treeSimple.children.values) {}
                  // setState(() {});

                  _treeSimpleOriginal;
                  _treeSimpleOriginal.children;
                  _treeSimpleOriginal.childrenAsList;
                  _treeSimpleCopy = TreeNode.root();
                  _treeSimpleOriginal.children.values.toList().first.children.isEmpty;

                  _treeSimpleCopy!.addAll(
                    <Node>[
                      TreeNode(key: 'a')
                        ..addAll(
                          <Node>[
                            TreeNode(key: '1'),
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
                },
              ),
              _buildUIButton(
                title: 'Tree 복사22222',
                onPressed: () {
                  _treeSimpleOriginal;
                  _treeSimpleOriginal.children;
                  _treeSimpleOriginal.childrenAsList;
                  _treeSimpleCopy = TreeNode.root();
                  _treeSimpleOriginal.children.values.toList().first.children.isEmpty;
                  final TreeNode ww = TreeNode.root()
                    ..add(
                      TreeNode(key: 'd')
                        ..add(
                          TreeNode(key: '1'),
                        ),
                    );

                  // print(ww.children);
                  // print(ww.children.values.toList());
                  // print(ww.children.values.toList().first);
                  print(ww.children.values.toList().first.children);
                  print(ww.children.values.toList().first.children.isEmpty);

                  for (final Node element in ww.children.values.toList()) {
                    // _copyNode(element);
                  }
                },
              ),
              _buildUIButton(
                title: 'Tree 복사33333',
                onPressed: () {
                  final List<TreeNode> treeNodeList = <TreeNode>[];

                  for (final Node node in _treeSimpleOriginal.children.values) {
                    final List<TreeNode> childList = <TreeNode>[];
                    for (final String element in node.children.keys) {
                      childList.add(TreeNode(key: element));
                    }
                    treeNodeList.add(TreeNode(key: node.key)..addAll(childList));
                  }

                  _treeSimpleCopy = TreeNode.root();
                  for (final TreeNode element in treeNodeList) {
                    _copyNode(parentNode: _treeSimpleCopy!, node: element);
                  }

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: 'Tree 복사77777',
                onPressed: () {
                  _treeSimpleCopy = TreeNode.root();
                  for (final Node element in _treeSimpleOriginal.children.values.toList()) {
                    _copyNode3(parentNode: _treeSimpleCopy!, node: element);
                  }

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: 'Tree 복사44444',
                onPressed: () {
                  _treeSimpleCopy = TreeNode.root();
                  _copyNode2(parentNode: _treeSimpleCopy!, node: _treeSimpleOriginal);

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: 'Tree Reset99999',
                onPressed: () {
                  _treeSimpleCopy = null;

                  setState(() {});
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: 200,
          child: Column(
            children: <Widget>[
              _buildUIButton(
                title: '상위 노드 추가',
                onPressed: () {
                  _treeSimpleOriginal.add(TreeNode(key: _makeString(5)));

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

                  _treeSimpleOriginal.removeWhere(
                    (Node element) {
                      // 하위 노드 같이 삭제
                      return _selectedNode!.key == element.key;
                    },
                  );

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '상/하위 노드 추가',
                color: Colors.purple.shade200,
                onPressed: () {
                  // _treeSimple.addAll(
                  //   <Node>[
                  //     TreeNode(key: _makeString(6))..add(TreeNode(key: _makeString(6))),
                  //     TreeNode(key: _makeString(6))
                  //       ..addAll(
                  //         <Node>[
                  //           TreeNode(key: _makeString(6)),
                  //           TreeNode(key: _makeString(6)),
                  //           TreeNode(key: _makeString(6)),
                  //         ],
                  //       ),
                  //   ],
                  // );
                  final List<Node> parentNodeList = <Node>[];
                  final List<Node> childNodeList = <Node>[];

                  for (int i = 0; i < _makeNumber(); i++) {
                    childNodeList.clear();

                    for (int j = 0; j < _makeNumber(); j++) {
                      childNodeList.add(TreeNode(key: _makeString(6)));
                    }

                    parentNodeList.add(
                      TreeNode(key: _makeString(6))..addAll(childNodeList),
                    );
                  }

                  _treeSimpleOriginal.addAll(parentNodeList);

                  setState(() {});
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: 200,
          child: Column(
            children: <Widget>[
              _buildUIButton(
                title: '하위 노드 추가',
                onPressed: () {
                  if (_selectedNode == null || _selectedNode!.level > 1) {
                    print('상위 노드를 선택하세요');
                    return;
                  }

                  _selectedNode!.add(TreeNode(key: _makeString(5)));

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

                  // 선택된 하위노드 id: 상위노드 key, 하위노드 level로 구분
                  _treeSimpleOriginal.removeWhere(
                    (Node element) {
                      element.removeWhere(
                        (Node element) {
                          return _selectedNode!.key == element.key;
                        },
                      );

                      return false;
                    },
                  );

                  setState(() {});
                },
              ),
              //
              _buildUIButton(
                title: '테스트',
                color: Colors.red,
                onPressed: () {
                  _selectedNode;
                  _treeSimpleOriginal;
                  _treeSimpleOriginal.childrenAsList;
                  _treeSimpleOriginal.children;

                  print('********** 1 **********');
                  for (final ListenableNode element in _treeSimpleOriginal.childrenAsList) {
                    // print(element.key); // 상위 노드 키
                    // print(element.value);
                    // print(element.parent);
                    // print(element.children);
                    // print(element.childrenAsList);
                  }

                  print('********** 2 **********');
                  for (final MapEntry<String, Node> element in _treeSimpleOriginal.children.entries) {
                    // print(element.key);
                    // print(element.value);
                  }

                  print('********** 3 **********');
                  for (final String element in _treeSimpleOriginal.children.keys.toList()) {
                    print(element);
                  }

                  print('********** 4 **********');
                  for (final Node element in _treeSimpleOriginal.children.values.toList()) {
                    print(element);
                  }

                  return;
                  final TreeNode tre3eSimple = TreeNode.root();
                  Node ww = Node();

                  /////////////////////////////////////////////////////////////////////

                  _treeSimpleOriginal.removeWhere(
                    (Node element) {
                      element.parent?.key;
                      element.key;
                      element.level;

                      final bool isSameParent = _selectedNode!.parent!.key == element.parent?.key;
                      // final bool isSameHierachy = _selectedNode!.level == element.level;
                      final bool isSameKey = _selectedNode!.key == element.key;
                      print('${_selectedNode!.key} ${element.key}');
                      return isSameKey;
                      // return isSameParent && isSameKey;
                      // return isSameParent && isSameHierachy && isSameKey;
                    },
                  );

                  _treeSimpleOriginal.childrenAsList.removeWhere(
                    (Node element) {
                      element.parent?.key;
                      element.key;
                      element.level;

                      final bool isSameParent = _selectedNode!.parent!.key == element.parent?.key;
                      // final bool isSameHierachy = _selectedNode!.level == element.level;
                      final bool isSameKey = _selectedNode!.key == element.key;
                      print('${_selectedNode!.key} ${element.key}');
                      return isSameKey;
                      // return isSameParent && isSameKey;
                      // return isSameParent && isSameHierachy && isSameKey;
                    },
                  );

                  /////////////////////////////////////////////////////////////////////
                  _treeSimpleOriginal.childrenAsList.removeWhere(
                    (Node element) {
                      element.parent?.key;
                      element.key;
                      element.level;
                      print(element.key);
                      print(_selectedNode?.key);
                      return false;
                    },
                  );

                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // void _copyNode(Node node) {
  //   if (node.children.isEmpty) {
  //     // node.add(TreeNode(key: node.key));
  //     print('1 >> ${node.key}');
  //     return;
  //   }

  //   for (final Node element in node.children.values.toList()) {
  //     print('2 >> ${node.key}');
  //     _copyNode(element);
  //   }

  //   print('3 >> ${node.key}');
  //   // _treeSimple2!.add(Node(key: node.key));
  //   _treeSimple2!.add(TreeNode(key: node.key));
  // }

  // void _copyNode({required TreeNode parentNode, required TreeNode node}) {
  //   if (node.children.isEmpty) {
  //     print('1 >> ${node.key}');
  //     parentNode.add(node);
  //     return;
  //   }
  //   // parentNode.add(TreeNode(key: addingNode.key));
  //   // final TreeNode treeNode = TreeNode(key: node.key);
  //   print('>> *****');
  //   final Map<String, TreeNode> treeNodeList = <String, TreeNode>{};
  //   for (final MapEntry<String, Node> element in node.children.entries) {
  //     final List<TreeNode> ww = <TreeNode>[];
  //     for (final String element in element.value.children.keys) {
  //       ww.add(TreeNode(key: element));
  //     }
  //     treeNodeList[element.key] = TreeNode(key: element.value.key)..addAll(ww);
  //   }

  //   for (final TreeNode element in treeNodeList.values.toList()) {
  //     print('2 >> ${node.key}');
  //     _copyNode(parentNode: node, node: element);
  //   }
  // }

  void _copyNode({required TreeNode parentNode, required TreeNode node}) {
    if (node.children.isEmpty) {
      print('1 >> ${node.key}');
      parentNode.add(node);
      return;
    }

    final List<TreeNode> treeNodeList = <TreeNode>[];
    for (final Node node in node.children.values) {
      final List<TreeNode> childList = <TreeNode>[];
      for (final String element in node.children.keys) {
        childList.add(TreeNode(key: element));
      }
      treeNodeList.add(TreeNode(key: node.key)..addAll(childList));
    }

    for (final TreeNode element in treeNodeList) {
      print('2 >> ${node.key}');
      // _copyNode(parentNode: node, node: element);
    }
  }

  void _copyNode3({required TreeNode parentNode, required Node node}) {
    if (node.children.isEmpty) {
      parentNode.add(node);
      return;
    }

    for (final Node element in node.children.values) {
      _copyNode3(parentNode: node as TreeNode, node: element);
    }
  }

  // _copyNode2(parentNode: _treeSimpleCopy!, node: _treeSimpleOriginal);
  void _copyNode2({required TreeNode parentNode, required TreeNode node}) {
    // if (node.children.isEmpty) {
    //   if (node.key != '/' && parentNode.key != node.key) {
    //     final TreeNode treeNode = TreeNode(key: node.key);
    //     parentNode.add(treeNode);
    //   }

    //   return;
    // }

    if (node.children.isEmpty) {
      if (node.key == '/' || parentNode.key == node.key) {
        return;
      }
    }

    // parentNode.add(TreeNode(key: node.key));
    for (final Node element in node.children.values) {
      // final TreeNode node = TreeNode(key: element.key)..addAll(element.children.values);
      final TreeNode treeNode = TreeNode(key: element.key);
      // final TreeNode treeNode2 = TreeNode(key: element.key)..addAll(element.children.values);
      final TreeNode treeNode2 = element as TreeNode;

      parentNode.add(treeNode);
      _copyNode2(parentNode: treeNode, node: treeNode2);
    }

    // final TreeNode eee = TreeNode(key: '')..add(TreeNode());
    // _copyNode2(parentNode: node, node: _treeSimpleOriginal);

    // final List<TreeNode> treeNodeList = <TreeNode>[];
    // for (final Node node in node.children.values) {
    //   final List<TreeNode> childList = <TreeNode>[];
    //   for (final String element in node.children.keys) {
    //     childList.add(TreeNode(key: element));
    //   }
    //   treeNodeList.add(TreeNode(key: node.key)..addAll(childList));
    // }

    // for (final TreeNode element in treeNodeList) {
    //   print('2 >> ${node.key}');
    //   // _copyNode2(parentNode: node, node: element);
    // }
  }

  String _makeString(int length) {
    const String xx = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List<String>.generate(length, (_) => xx[Random().nextInt(xx.length)]).join();
  }

  int _makeNumber() {
    return Random().nextInt(10);
  }
}
