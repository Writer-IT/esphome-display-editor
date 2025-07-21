import 'package:esphome_display_editor/interpreter/parsed_display_object.dart';
import 'package:esphome_display_editor/objects/display_object.dart';
import 'package:esphome_display_editor/objects/display_object_types.dart';
import 'package:esphome_display_editor/utils/parsing_helpers.dart';
import 'package:flutter/material.dart';

/// A vertical line to be drawn.
class VerticalLine extends DisplayObject {
  /// Create a line from y to y + height at width x.
  VerticalLine(this.x, this.y, this.height, {Color color = Colors.black}) {
    paint = Paint()..color = color;
  }

  /// Converts an [ParsedDisplayObject] to a [VerticalLine].
  VerticalLine.fromParsedDisplayObject(
    ParsedDisplayObject parsedDisplayObject,
    Map<String, Object> variableToObjectMapping,
  ) {
    if (parsedDisplayObject.type == DisplayObjectTypes.verticalLine) {
      final variables = parsedDisplayObject.variables;
      if (variables.length < 3 || variables.length > 4) {
        throw FormatException(
          'A vertical line requires 3 or 4 variables, provided: '
          '${variables.length}',
        );
      }
      x = parseNumValue(
        valueObject: variables[0],
        variableToValueMapping: variableToObjectMapping,
      );
      y = parseNumValue(
        valueObject: variables[1],
        variableToValueMapping: variableToObjectMapping,
      );
      height = parseNumValue(
        valueObject: variables[2],
        variableToValueMapping: variableToObjectMapping,
      );
      var color = Colors.black;
      if (variables.length == 4) {
        color = variables[3] as Color;
      }
      paint = Paint()..color = color;
    } else {
      throw FormatException(
        'This is not a vertical line, this is a: ${parsedDisplayObject.type}',
      );
    }
  }

  /// Start position of the line on x.
  late double x;

  /// Start position of the line on y.
  late double y;

  /// Height of the vertical line.
  late double height;

  /// Paint of the line.
  late Paint paint;
  @override
  void renderOnCanvas(Canvas canvas) {
    canvas.drawLine(Offset(x, y), Offset(x, y + height), paint);
  }
}
