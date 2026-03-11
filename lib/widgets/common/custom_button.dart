import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final double? width;
  final double height;
  final Color? color;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.width,
    this.height = 50,
    this.color,
  });

  @override
  Widget build(BuildContext context) {

    final buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Visibility(
          visible: icon != null && !isLoading,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(icon, size: 20),
          ),
        ),

        Visibility(
          visible: !isLoading,
          child: Text(text),
        ),

        Visibility(
          visible: isLoading,
          child: const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
        )

      ],
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: isOutlined
          ? OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: buttonChild,
      )
          : ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: buttonChild,
      ),
    );
  }

}