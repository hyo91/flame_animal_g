import 'package:flame/components.dart';

class Obstacle1 extends SpriteComponent with HasGameRef {
  Obstacle1({required Vector2 position, Vector2? size})
    : super(position: position, size: size ?? Vector2.all(100));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('obstacle/obstacle1.png');
  }
}
