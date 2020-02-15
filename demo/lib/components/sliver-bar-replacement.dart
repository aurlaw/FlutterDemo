import 'package:flutter/material.dart';

class SliverBarReplacement extends StatefulWidget {
  final Function(BuildContext, bool, double) builder;
  const SliverBarReplacement({
    Key key,
    @required this.builder,
  }) : super(key: key);
  @override
  _SliverBarReplacementState createState() {
    return new _SliverBarReplacementState();
  }
}

class _SliverBarReplacementState extends State<SliverBarReplacement> {
  ScrollPosition _position;
  bool _visible;
  double _currentExtent;
  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent + 15;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
    setState(() {
      _currentExtent = settings.currentExtent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _visible, _currentExtent);
  }
}
