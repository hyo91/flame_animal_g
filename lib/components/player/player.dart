import 'package:flame/components.dart';

import '../../maingame.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, HasGameRef<MainGame> {
  Player({required Vector2 position})
    : super(position: position, size: Vector2.all(562), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 개별 PNG 파일들을 스프라이트 애니메이션으로 만들기
    animation = SpriteAnimation.spriteList(
      [
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_1.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_2.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_3.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_4.png')),
      ],
      stepTime: 0.12,
      loop: true,
    );
  }

  // 게임 오브젝트가 업데이트 될 때마다 호출됨.
  @override
  void update(double dt) {
    // 스프라이트 애니메이션 업데이트
    super.update(dt);
  }
}
