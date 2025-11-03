import 'package:flame/components.dart';

class Background1 extends SpriteComponent with HasGameRef {
  Background1({required Vector2 gameSize})
    : super(size: gameSize, position: Vector2.zero(), priority: 0);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('background/parallax-mountain-bg.png');
    ;

    sprite = await gameRef.loadSprite(
      'background/parallax-mountain-foreground-trees.png',
    );
    sprite = await gameRef.loadSprite(
      'background/parallax-mountain-montain-far.png',
    );
  }
}

// 사용:
// add(Background1(gameSize: size));
