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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Animated Tree Demo',
      localizationsDelegates: const [
        // GlobalCupertinoLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
      locale: Locale('en'),
      supportedLocales: [Locale('en'), Locale('ar')],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Simple Animated Tree Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TreeViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: sampleTree.expansionNotifier,
        builder: (context, isExpanded, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (sampleTree.isExpanded) {
                _controller?.collapseNode(sampleTree);
              } else {
                _controller?.expandAllChildren(sampleTree);
              }
            },
            label: isExpanded ? const Text("Collapse all") : const Text("Expand all"),
          );
        },
      ),
      body: TreeView.simple(
        tree: sampleTree,
        showRootNode: true,
        expansionIndicatorBuilder: (BuildContext context, ITreeNode node) => ChevronIndicator.rightDown(
          tree: node,
          color: Colors.blue[700],
          padding: const EdgeInsets.all(8),
        ),
        indentation: const Indentation(style: IndentStyle.roundJoint),
        onItemTap: (TreeNode item) {
          // if (kDebugMode) print("Item tapped: ${item.key}");

          // if (showSnackBar) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text("Item tapped: ${item.key}"),
          //       duration: const Duration(milliseconds: 750),
          //     ),
          //   );
          // }

          // TODO: sss

          final TreeNode<int> s1 = TreeNode<int>();
          s1.data = 4;
          final TreeNode s2 = TreeNode.root();
          print(s1);
          print(s2);
          final zz = TreeNode.root()
            ..addAll(
              <Node>[
                TreeNode(key: "0A")..add(TreeNode(key: "0A1A")),
                TreeNode(key: "0C")
                  ..addAll(
                    <Node>[
                      TreeNode(key: "0C1A"),
                      TreeNode(key: "0C1B"),
                      TreeNode(key: "0C1C")
                        ..addAll(
                          <Node>[
                            TreeNode(key: "0C1C2A")
                              ..addAll(
                                <Node>[
                                  TreeNode(key: "0C1C2A3A"),
                                  TreeNode(key: "0C1C2A3B"),
                                  TreeNode(key: "0C1C2A3C"),
                                ],
                              ),
                          ],
                        ),
                    ],
                  ),
                TreeNode(key: "0D"),
                TreeNode(key: "0E"),
              ],
            );
        },
        onTreeReady: (controller) {
          _controller = controller;
          if (expandChildrenOnReady) controller.expandAllChildren(sampleTree);
        },
        builder: (BuildContext context, TreeNode item) {
          // return Text('aaaa');
          return Card(
            color: Colors.red.shade100,
            // color: colorMapper[item.level.clamp(0, colorMapper.length - 1)]!,
            child: ListTile(
              title: Text("Item ${item.level}-${item.key}"),
              subtitle: Text('Level ${item.level}'),
            ),
          );
        },
      ),
    );
  }
}

final sampleTree = TreeNode.root()
  ..addAll(
    <Node>[
      TreeNode(key: "0A")..add(TreeNode(key: "0A1A")),
      TreeNode(key: "0C")
        ..addAll(
          <Node>[
            TreeNode(key: "0C1A"),
            TreeNode(key: "0C1B"),
            TreeNode(key: "0C1C")
              ..addAll(
                <Node>[
                  TreeNode(key: "0C1C2A")
                    ..addAll(
                      <Node>[
                        TreeNode(key: "0C1C2A3A"),
                        TreeNode(key: "0C1C2A3B"),
                        TreeNode(key: "0C1C2A3C"),
                      ],
                    ),
                ],
              ),
          ],
        ),
      TreeNode(key: "0D"),
      TreeNode(key: "0E"),
    ],
  );
