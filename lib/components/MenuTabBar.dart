import 'package:flutter/material.dart';

class MenuTabBar extends StatefulWidget {
  final Color background;
  final List<IconButton> iconButtons;
  final Column child;

  MenuTabBar({
    Key? key,
    this.background = Colors.blue,
    required this.iconButtons,
    required this.child,
  })  : assert(iconButtons.length == 3),
        super(key: key);

  @override
  _MenuTabBarState createState() => _MenuTabBarState();
}

class _MenuTabBarState extends State<MenuTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: widget.background,
          child: TabBar(
            controller: _tabController,
            tabs: widget.iconButtons
                .map((iconButton) => Tab(icon: iconButton.icon))
                .toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.child.children!,
          ),
        )
      ],
    );
  }
}