import 'package:flame/components.dart';

class Obstacle1 extends SpriteComponent with HasGameReference {
  Obstacle1({required Vector2 position, Vector2? size})
    : super(
        position: position,
        size: size ?? Vector2.all(100),
        anchor: Anchor.bottomLeft, // 바닥 기준으로 배치
      );

  // 장애물 이동 속도 (배경과 비슷한 속도)
  final double moveSpeed = -200; // 음수는 왼쪽으로 이동

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('obstacle/obstacle1.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    // 왼쪽으로 이동
    position.x += moveSpeed * dt;

    // 화면 왼쪽 밖으로 나가면 오른쪽에서 다시 나타나게
    if (position.x + size.x < 0) {
      position.x = game.size.x + size.x;
    }
  }
}
