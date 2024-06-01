import 'package:flutter/material.dart';
import 'package:medi_mate/constants.dart';

class CustomElevatedLoadingButton extends StatelessWidget {
  const CustomElevatedLoadingButton({
    super.key,
    this.isLoading = false,
    this.loadingWidget,
    this.loaderColor,
    this.child,
    this.onPressed,
    this.width,
    this.height = 10.0,
    this.color = kPrimaryColor,
    this.disabledColor,
    this.borderRadius = 10.0,
    this.shouldFill = true,
    this.elevation = 0.0,
    this.isDisabled = false,
    this.text,
    this.padding = 8.0,
    this.textStyle,
    this.shouldRemoveBackgroundOnLoading = false,
    this.duration = 250,
    this.shouldMakeLoadingRound = false,
    this.border,
  }) : assert(
          child != null || text != null,
          'child or text must not be null',
        );

  final bool isLoading;
  final Widget? child;
  final Widget? loadingWidget;
  final Color? loaderColor;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? disabledColor;
  final Color color;
  final double borderRadius;
  final bool shouldFill;
  final double elevation;
  final bool isDisabled;
  final String? text;
  final double padding;
  final TextStyle? textStyle;
  final bool shouldRemoveBackgroundOnLoading;
  final int duration;
  final bool shouldMakeLoadingRound;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: duration),
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          axis: Axis.horizontal,
          child: child,
        );
      },
      child: !isLoading
          ? Material(
              color: shouldFill ? color : Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius),
              elevation: elevation,
              child: InkWell(
                onTap: isLoading || isDisabled ? null : onPressed,
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  width: width,
                  height: height,
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    border: border,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      child ??
                          Text(
                            text!,
                            style: textStyle ??
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: isDisabled
                                          ? disabledColor
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: shouldRemoveBackgroundOnLoading
                    ? Colors.transparent
                    : color,
                borderRadius: BorderRadius.circular(
                    shouldMakeLoadingRound ? 100 : borderRadius),
              ),
              height: loadingWidget != null ? null : height,
              width: loadingWidget != null ? null : height,
              padding: EdgeInsets.all(padding),
              child: loadingWidget ??
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      loaderColor ?? Colors.white,
                    ),
                  ),
            ),
    );
  }
}
