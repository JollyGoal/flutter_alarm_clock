import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/screens/screens.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final Map<String, Widget> _screens = {
    'Clock': ClockScreen(key: PageStorageKey('clockScreen')),
    'Alarm': AlarmScreen(key: PageStorageKey('alarmScreen')),
    'Stopwatch': StopwatchScreen(key: PageStorageKey('stopwatchScreen')),
    'Timer': TimerScreen(key: PageStorageKey('timerScreen')),
  };
  final _tabBarKey = GlobalKey();

  get keys => _screens.keys.toList();

  String _activePage;
  ScrollController _scrollController;
  PageController _pageController;

  void handleChangePage(int index, double tabScrollOffset) {
    _scrollController.animateTo(
      tabScrollOffset,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 200),
    );

    /// Change page with animation
    _pageController.animateToPage(
      index,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 200),
    );

    /// Change page without animation
    // _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    _activePage = keys[0];
    _scrollController = ScrollController(keepScrollOffset: true);
    _pageController = PageController(keepPage: true, initialPage: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackground,
      appBar: buildCustomAppBar(),
      body: PageView.builder(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _screens.length,
        itemBuilder: (BuildContext context, int index) {
          return _screens[keys[index]];
        },
      ),
    );
  }

  PreferredSize buildCustomAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 126),
      child: Container(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 14,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      iconSize: 30,
                      onPressed: () {},
                      icon: Icon(
                        Icons.equalizer_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
                child: ListView.builder(
                  key: _tabBarKey,
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _screens.length,
                  itemBuilder: (BuildContext context, int index) {
                    final label = keys[index];
                    final _tabKey = GlobalKey();
                    return Padding(
                      key: _tabKey,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: FlatButton(
                        onPressed: () {
                          final RenderBox _childContext =
                              _tabKey.currentContext.findRenderObject();
                          final RenderSliverList _parentObject =
                              context.findRenderObject();

                          handleChangePage(
                              index,
                              _childContext
                                      .localToGlobal(Offset(
                                          _parentObject
                                              .constraints.scrollOffset,
                                          0))
                                      .dx -
                                  _childContext.size.width);
                          setState(() {
                            _activePage = keys[index];
                          });
                        },
                        child: Text(
                          label,
                          style: TextStyle(
                            color: _activePage == label
                                ? Palette.primaryFont
                                : Palette.tertiaryFont,
                            fontSize: 15,
                            fontWeight: _activePage == label
                                ? FontWeight.w600
                                : FontWeight.w400,
                            letterSpacing: 0.2,
                          ),
                        ),
                        color: Palette.tertiaryButton
                            .withOpacity(label == _activePage ? 1 : 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
