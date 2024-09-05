import 'package:esphome_display_editor/interpreter/parsed_display_object.dart';
import 'package:esphome_display_editor/objects/display_object.dart';
import 'package:esphome_display_editor/objects/display_object_types.dart';
import 'package:flutter/material.dart';

/// Draws a circle, think that makes sense.
class Circle extends DisplayObject {
  /// Creates a circle object that can be drawn on our canvas.
  /// Starts at position ([x], [y]) with [radius]. Optionally define the
  /// [color], default is black. And if the circle should be filled with the
  /// color by setting [fill] to true, defaults to false.
  Circle(
    int x,
    int y,
    int radius, {
    Color color = Colors.black,
    bool fill = false,
  }) {
    center = Offset(x.toDouble(), y.toDouble());
    this.radius = radius.toDouble();
    paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke;
  }

  /// Converts an [ParsedDisplayObject] to a [Circle].
  Circle.fromParsedDisplayObject(
    ParsedDisplayObject parsedDisplayObject,
  ) {
    if (parsedDisplayObject.type == DisplayObjectTypes.circle) {
      final variables = parsedDisplayObject.variables;
      if (variables.length < 2 || variables.length > 4) {
        throw FormatException(
          'Circle requires 3 or 4 variables, provided: ${variables.length}',
        );
      }
      if (variables.length >= 3) {
        center = Offset(
          double.parse(variables[0] as String),
          double.parse(variables[1] as String),
        );
        radius = double.parse(variables[2] as String);
      }
      if (variables.length == 4) {
        final color = variables[3] as Color;
        paint = Paint()..color = color;
      }
    } else {
      throw FormatException(
        'This is not a circle type, this is a: ${parsedDisplayObject.type}',
      );
    }
  }

  /// Center of the circle.
  late Offset center;

  /// Radius of the circle.
  late double radius;

  /// Paint style;
  late Paint paint;

  @override
  void renderOnCanvas(Canvas canvas) {
    canvas.drawCircle(center, radius, paint);
  }
}
