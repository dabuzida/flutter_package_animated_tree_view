import 'dart:math';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';

class TreeViewSimple extends StatefulWidget {
  const TreeViewSimple({super.key});

  @override
  State<TreeViewSimple> createState() => _TreeViewSimpleState();
}

class _TreeViewSimpleState extends State<TreeViewSimple> {
  TreeViewController? _treeViewController; // 트리 전체 열기, 전체 닫기 같은 이벤트에 사용
  bool showSnackBar = false;
  bool expandChildrenOnReady = true;
  bool _nodeInfo = false;

  TreeNode? _selectedNodeOrigin;
  TreeNode? _selectedNodeCopy;

  TreeNode? _treeCopy;
  final TreeNode _treeOrigin = TreeNode.root()
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

  @override
  void initState() {
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 5.0),
          _buildUIOriginal(),
          const VerticalDivider(),
          _buildUICopy(),
          const VerticalDivider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildUIButtons(),
              Visibility(
                visible: _nodeInfo,
                child: Container(
                  width: 600,
                  height: 500,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                  child: _buildUISelectedNodeInfo(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUIOriginal() {
    return Column(
      children: <Widget>[
        const Text('원본'),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
          width: 200,
          height: 700,
          child: _buildUISimple(),
        ),
      ],
    );
  }

  Widget _buildUICopy() {
    return Column(
      children: <Widget>[
        const Text('사본'),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
          width: 200,
          height: 700,
          child: _buildUISimple2(),
        ),
      ],
    );
  }

  Widget _buildUISimple2() {
    if (_treeCopy == null) {
      return const Center(child: Text('empty'));
    }

    return TreeView.simple(
      tree: _treeCopy!,
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
        if (expandChildrenOnReady) controller.expandAllChildren(_treeOrigin);
      },
      builder: (BuildContext context, TreeNode node) {
        return Container(
          width: 180,
          height: 30,
          margin: const EdgeInsets.only(left: 25),
          decoration: BoxDecoration(
            color: _selectedNodeCopy != null && _selectedNodeCopy!.key == node.key ? Colors.blue : Colors.grey.shade100,
            border: Border.all(color: Colors.red),
          ),
          child: GestureDetector(
            onTap: () {
              print('>> node key: ${node.key}, node hierarchy: ${node.level}');
              _selectedNodeCopy = node;
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
                '키 정보',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),
            // @@@@@
            _buildUIItem(title: 'PATH', desc: _selectedNodeOrigin?.path),
            _buildUIItem(title: 'parent key', desc: _selectedNodeOrigin?.parent?.key),
            _buildUIItem(title: '선택된 키', desc: _selectedNodeOrigin?.key),
            _buildUIItem(title: 'hierarchy', desc: _selectedNodeOrigin?.level.toString()),
            _buildUIItem(title: '_treeSimple ', desc: _treeOrigin.toString()),
            _buildUIItem(title: '_treeSimple.children ', desc: _treeOrigin.children.toString()),
            _buildUIItem(title: '_treeSimple.childrenAsList ', desc: _treeOrigin.childrenAsList.toString()),
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

  Widget _buildUIButton({required String title, required void Function() onPressed, Color? color}) {
    return Container(
      width: 180,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.grey.shade200,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(12),

              ),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }

  Widget _buildUISimple() {
    return TreeView.simple(
      tree: _treeOrigin,
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
        if (expandChildrenOnReady) controller.expandAllChildren(_treeOrigin);
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
            color: _selectedNodeOrigin != null && _selectedNodeOrigin!.key == node.key ? Colors.blue : Colors.grey.shade100,
            border: Border.all(color: Colors.red),
          ),
          child: GestureDetector(
            onTap: () {
              print('>> node key: ${node.key}, node hierarchy: ${node.level}');
              _selectedNodeOrigin = node;
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

  Widget _buildUIButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          child: Column(
            children: <Widget>[
              _buildUIButton(
                title: '#####',
                onPressed: () {
                  _treeOrigin;
                  _treeCopy;
                  _treeOrigin.childrenAsList;
                  _treeOrigin.children;

                  _treeCopy = TreeNode.root();
                  _treeOrigin.children.values.toList().first.children.isEmpty;
                },
              ),
              _buildUIButton(
                title: '복사',
                onPressed: () {
                  final List<TreeNode> treeNodeList = <TreeNode>[];

                  for (final Node node in _treeOrigin.children.values) {
                    final List<TreeNode> childList = <TreeNode>[];
                    for (final String element in node.children.keys) {
                      childList.add(TreeNode(key: element));
                    }
                    treeNodeList.add(TreeNode(key: node.key)..addAll(childList));
                  }

                  _treeCopy = TreeNode.root();
                  for (final TreeNode element in treeNodeList) {
                    _copyNode(parentNode: _treeCopy!, node: element);
                  }

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '복사 2',
                onPressed: () {
                  _treeCopy = TreeNode.root();
                  // 재귀함수에 원본의 children을 인자로
                  for (final Node node in _treeOrigin.children.values.toList()) {
                    _copy2(targetTree: _treeCopy!, source: node);
                  }

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '복사 3',
                onPressed: () {
                  _treeCopy = TreeNode.root();
                  // 재귀함수에 원본을 인자로
                  _copy3(targetTree: _treeCopy!, source: _treeOrigin);

                  // _treeViewController?.collapseNode(_treeCopy!);
                  // _treeViewController?.expandAllChildren(_treeCopy!);

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '원본 초기화',
                onPressed: () {
                  _treeOrigin.clear();
                  // final TreeNode _treeOrigin = TreeNode.root()
                  _treeOrigin.addAll(
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

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '사본 초기화',
                onPressed: () {
                  _treeCopy = null;

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '원본 여닫기',
                onPressed: () {
                  if (_treeOrigin.isExpanded) {
                    _treeViewController?.collapseNode(_treeOrigin);
                  } else {
                    _treeViewController?.expandAllChildren(_treeOrigin);
                  }

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: _treeCopy == null
                    ? '#####'
                    : _treeCopy!.isExpanded
                        ? '사본 전체 닫기'
                        : '사본 전체 열기',
                onPressed: () {
                  if (_treeCopy == null) {
                    return;
                  }

                  if (_treeCopy!.isExpanded) {
                    _treeViewController?.collapseNode(_treeCopy!);
                  } else {
                    _treeViewController?.expandAllChildren(_treeCopy!);
                  }

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '노드 정보',
                onPressed: () {
                  _nodeInfo = !_nodeInfo;
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
                  _treeOrigin.add(TreeNode(key: _makeString(5)));

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '상위 노드 삭제',
                onPressed: () {
                  if (_selectedNodeOrigin == null || _selectedNodeOrigin!.level > 1) {
                    print('상위 노드를 선택하세요');
                    return;
                  }

                  _treeOrigin.removeWhere(
                    (Node element) {
                      // 하위 노드 같이 삭제
                      return _selectedNodeOrigin!.key == element.key;
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

                  _treeOrigin.addAll(parentNodeList);

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
                  if (_selectedNodeOrigin == null || _selectedNodeOrigin!.level > 1) {
                    print('상위 노드를 선택하세요');
                    return;
                  }

                  _selectedNodeOrigin!.add(TreeNode(key: _makeString(5)));

                  setState(() {});
                },
              ),
              _buildUIButton(
                title: '하위 노드 삭제',
                onPressed: () {
                  if (_selectedNodeOrigin == null || _selectedNodeOrigin!.level < 2) {
                    print('하위 노드를 선택하세요');
                    return;
                  }

                  // 선택된 하위노드 id: 상위노드 key, 하위노드 level로 구분
                  _treeOrigin.removeWhere(
                    (Node element) {
                      element.removeWhere(
                        (Node element) {
                          return _selectedNodeOrigin!.key == element.key;
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
                  _selectedNodeOrigin;
                  _treeOrigin;
                  _treeOrigin.childrenAsList;
                  _treeOrigin.children;

                  print('********** 1 **********');
                  for (final ListenableNode element in _treeOrigin.childrenAsList) {
                    // print(element.key); // 상위 노드 키
                    // print(element.value);
                    // print(element.parent);
                    // print(element.children);
                    // print(element.childrenAsList);
                  }

                  print('********** 2 **********');
                  for (final MapEntry<String, Node> element in _treeOrigin.children.entries) {
                    // print(element.key);
                    // print(element.value);
                  }

                  print('********** 3 **********');
                  for (final String element in _treeOrigin.children.keys.toList()) {
                    print(element);
                  }

                  print('********** 4 **********');
                  for (final Node element in _treeOrigin.children.values.toList()) {
                    print(element);
                  }

                  return;
                  final TreeNode tre3eSimple = TreeNode.root();
                  Node ww = Node();

                  /////////////////////////////////////////////////////////////////////

                  _treeOrigin.removeWhere(
                    (Node element) {
                      element.parent?.key;
                      element.key;
                      element.level;

                      final bool isSameParent = _selectedNodeOrigin!.parent!.key == element.parent?.key;
                      // final bool isSameHierachy = _selectedNode!.level == element.level;
                      final bool isSameKey = _selectedNodeOrigin!.key == element.key;
                      print('${_selectedNodeOrigin!.key} ${element.key}');
                      return isSameKey;
                      // return isSameParent && isSameKey;
                      // return isSameParent && isSameHierachy && isSameKey;
                    },
                  );

                  _treeOrigin.childrenAsList.removeWhere(
                    (Node element) {
                      element.parent?.key;
                      element.key;
                      element.level;

                      final bool isSameParent = _selectedNodeOrigin!.parent!.key == element.parent?.key;
                      // final bool isSameHierachy = _selectedNode!.level == element.level;
                      final bool isSameKey = _selectedNodeOrigin!.key == element.key;
                      print('${_selectedNodeOrigin!.key} ${element.key}');
                      return isSameKey;
                      // return isSameParent && isSameKey;
                      // return isSameParent && isSameHierachy && isSameKey;
                    },
                  );

                  /////////////////////////////////////////////////////////////////////
                  _treeOrigin.childrenAsList.removeWhere(
                    (Node element) {
                      element.parent?.key;
                      element.key;
                      element.level;
                      print(element.key);
                      print(_selectedNodeOrigin?.key);
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

  void _copy2({required TreeNode targetTree, required Node source}) {
    if (source.children.isEmpty) {
      targetTree.add(source);
      return;
    }

    for (final Node element in source.children.values) {
      _copy2(targetTree: source as TreeNode, source: element);
    }
  }

  // _copy3(targetTree: _treeCopy!, source: _treeOrigin);
  void _copy3({required TreeNode targetTree, required TreeNode source}) {
    print('>> targetTree: ${targetTree.key}, source: ${source.key}');

    return;
    if (source.children.isEmpty) {
      return;
    }

    for (final Node node in source.children.values) {
      final TreeNode treeNodeOrigin = TreeNode(key: node.key)..addAll(node.children.values);

      final TreeNode treeNodeCopy = TreeNode(key: node.key);
      targetTree.add(treeNodeCopy);

      _copy3(targetTree: treeNodeCopy, source: treeNodeOrigin);
      // _copy3(targetTree: treeNodeCopy, source: node as TreeNode);
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

  void _copyNode4({required TreeNode parentNode, required TreeNode node}) {
    if (node.children.isEmpty) {
      print('1 >> ${node.key}');
      parentNode.add(node);
      return;
    }
    // parentNode.add(TreeNode(key: addingNode.key));
    // final TreeNode treeNode = TreeNode(key: node.key);
    print('>> *****');
    final Map<String, TreeNode> treeNodeList = <String, TreeNode>{};
    for (final MapEntry<String, Node> element in node.children.entries) {
      final List<TreeNode> ww = <TreeNode>[];
      for (final String element in element.value.children.keys) {
        ww.add(TreeNode(key: element));
      }
      treeNodeList[element.key] = TreeNode(key: element.value.key)..addAll(ww);
    }

    for (final TreeNode element in treeNodeList.values.toList()) {
      print('2 >> ${node.key}');
      _copyNode(parentNode: node, node: element);
    }
  }

  String _makeString(int length) {
    const String xx = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List<String>.generate(length, (_) => xx[Random().nextInt(xx.length)]).join();
  }

  int _makeNumber() {
    return Random().nextInt(10);
  }
}
