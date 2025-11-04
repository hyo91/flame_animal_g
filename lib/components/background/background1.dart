import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/painting.dart';

class Background1 extends ParallaxComponent {
  Background1({required Vector2 gameSize})
    : super(size: gameSize, position: Vector2.zero(), priority: 0);

  @override
  Future<void> onLoad() async {
    parallax = await Parallax.load(
      [
        ParallaxImageData('background/parallax-mountain-bg.png'), // 제일 멀리
        ParallaxImageData('background/parallax-mountain-montain-far.png'), // 중간
        ParallaxImageData('background/parallax-mountain-mountains.png'), // 중간
      ],
      baseVelocity: Vector2(10, 0), // 기본 이동 속도
      velocityMultiplierDelta: Vector2(1.2, 0), // 앞 레이어일수록 약간 빠르게
      repeat: ImageRepeat.repeatX, // 가로로 반복
    );
  }
}
