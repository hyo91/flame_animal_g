// foreground.dart
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/painting.dart';

class Foreground extends ParallaxComponent {
  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      [
        ParallaxImageData(
          'background/parallax-mountain-foreground-trees.png',
        ), // 가까운 숲
        ParallaxImageData('background/parallax-mountain-trees.png'), // 가장 앞의 잔디
      ],
      baseVelocity: Vector2(30, 0), // Background보다 빠르게
      velocityMultiplierDelta: Vector2(1.5, 0),
      repeat: ImageRepeat.repeatX,
    );
  }
}
