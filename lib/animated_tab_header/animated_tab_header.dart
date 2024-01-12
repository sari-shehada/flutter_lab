import 'package:flutter/material.dart';

class AnimatedTabHeader extends StatefulWidget {
  const AnimatedTabHeader({
    super.key,
    required this.elements,
    required this.onElementTap,
    this.startTabIndex = 0,
    this.primaryContainerWidth,
    this.primaryContainerHeight,
  });

  final List<String> elements;
  final void Function(int elementIndex) onElementTap;
  final double? primaryContainerWidth;
  final double? primaryContainerHeight;
  final int startTabIndex;

  @override
  State<AnimatedTabHeader> createState() => _AnimatedTabHeaderState();
}

class _AnimatedTabHeaderState extends State<AnimatedTabHeader> {
  late final double primaryContainerWidth;
  late final double primaryContainerHeight;
  late final double elementContainerWidth;
  late int currentTabIndex;

  @override
  void initState() {
    currentTabIndex = widget.startTabIndex;
    final mediaQuery = (context
            .getElementForInheritedWidgetOfExactType<MediaQuery>()!
            .widget as MediaQuery)
        .data;
    // final physicalSize = mediaQuery.size * mediaQuery.devicePixelRatio;
    final screenSize = mediaQuery.size;
    // Size screenSize = MediaQuery.sizeOf(context);
    primaryContainerWidth =
        widget.primaryContainerWidth ?? screenSize.width * .6;

    primaryContainerHeight =
        widget.primaryContainerHeight ?? screenSize.height * .07;

    elementContainerWidth = (primaryContainerWidth) / widget.elements.length;
    super.initState();
  }

  double get borderWidth => 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: primaryContainerHeight,
      width: primaryContainerWidth + (2 * borderWidth),
      decoration: BoxDecoration(
        // color: Colors.red.withOpacity(.2),
        borderRadius: BorderRadius.circular(200),
        border: Border.all(
          color: const Color(0xFFF0F0F8),
          width: borderWidth,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: AlignmentDirectional.centerStart,
        children: [
          SizedBox(
            width: primaryContainerWidth,
            child: Row(
              children: [
                AnimatedContainer(
                  width: elementContainerWidth,
                  margin: EdgeInsetsDirectional.only(
                    start: currentTabIndex * elementContainerWidth,
                  ),
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  decoration: BoxDecoration(
                    //TODO:
                    borderRadius: BorderRadius.circular(200),
                    color: const Color(0xFF4552CB),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(
              widget.elements.length,
              (index) => AnimatedTabHeaderItem(
                title: widget.elements[index],
                onTap: () => changeTab(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeTab(int tabIndex) {
    print(primaryContainerWidth);
    print(elementContainerWidth);
    print(elementContainerWidth * tabIndex);
    widget.onElementTap(tabIndex);
    if (currentTabIndex == tabIndex) {
      return;
    }
    setState(
      () {
        currentTabIndex = tabIndex;
      },
    );
  }
}

class AnimatedTabHeaderItem extends StatelessWidget {
  const AnimatedTabHeaderItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
