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
  late int currentTabIndex;
  double primaryContainerHeight = 0.0;
  double primaryContainerWidth = 0.0;
  double elementContainerWidth = 0.0;

  @override
  void initState() {
    currentTabIndex = widget.startTabIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.primaryContainerWidth == null ||
          widget.primaryContainerWidth! <= MediaQuery.sizeOf(context).width,
      'Primary container width cannot be greater than screen width, max finite or max infinite',
    );
    determineElementSizes();
    return Container(
      height: primaryContainerHeight,
      width: primaryContainerWidth,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: const Color(0xFFF0F0F8),
          width: borderWidth,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
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
                    borderRadius: borderRadius,
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

  int get numberOfElements => widget.elements.length;
  double get borderWidth => 1;
  BorderRadius get borderRadius => BorderRadius.circular(200);

  double getPrimaryContainerWidth(Size size) =>
      widget.primaryContainerWidth ?? size.width * .6;
  double getPrimaryContainerHeight(Size size) =>
      widget.primaryContainerHeight ?? size.height * .07;

  double getElementContainerWidth() {
    double paddingValue = primaryContainerWidth / numberOfElements;
    if (currentTabIndex == numberOfElements - 1) {
      paddingValue -= borderWidth;
    }
    return paddingValue;
  }

  void changeTab(int tabIndex) {
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

  void determineElementSizes() {
    Size screenSize = MediaQuery.sizeOf(context);
    primaryContainerWidth = getPrimaryContainerWidth(screenSize);
    primaryContainerHeight = getPrimaryContainerHeight(screenSize);
    elementContainerWidth = getElementContainerWidth();
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
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
