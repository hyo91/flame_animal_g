import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import '../../maingame.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, HasGameRef<MainGame> {
  Player({required Vector2 position, Vector2? size})
    : super(
        position: position,
        size: size ?? Vector2.all(562),
        anchor: Anchor.center,
      );

  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 300;

  bool isJumping = false;
  bool isFalling = false;

  final double jumpSpeed = -500;
  final double gravity = 1000;

  int horizontalDirection = 0;

  // 애니메이션들을 저장할 변수
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation runAnimation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Idle 애니메이션
    idleAnimation = SpriteAnimation.spriteList(
      [
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_1.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_2.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_3.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_4.png')),
      ],
      stepTime: 0.12,
      loop: true,
    );

    // Jump 애니메이션
    jumpAnimation = SpriteAnimation.spriteList(
      [
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_jump_1.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_jump_2.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_jump_3.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_jump_4.png')),
      ],
      stepTime: 0.12,
      loop: true,
    );

    // run 애니메이션
    runAnimation = SpriteAnimation.spriteList(
      [
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_run_1.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_run_2.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_run_3.png')),
      ],
      stepTime: 0.12,
      loop: true, // 점프는 반복하지 않음
    );
  }

  void jump() {
    if (isJumping || isFalling) return;

    isJumping = true;
    velocity.y = jumpSpeed;

    // 점프 애니메이션으로 전환
    animation = jumpAnimation;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      horizontalDirection += -1;
      animation = runAnimation;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      horizontalDirection += 1;
      animation = runAnimation;
    }

    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.arrowUp)) {
      jump();
    }

    return true;
  }

  @override
  void update(double dt) {
    velocity.x = horizontalDirection * moveSpeed;

    if (isJumping) {
      velocity.y += gravity * dt;
      if (velocity.y >= 0) {
        isJumping = false;
        isFalling = true;
      }
    } else if (isFalling) {
      velocity.y += gravity * dt;

      final ground = gameRef.size.y - (size.y / 2);
      if (position.y >= ground) {
        isFalling = false;
        velocity.y = 0;
        position.y = ground;

        // 착지하면 Idle 애니메이션으로 복귀
        animation = idleAnimation;
      }
    }

    position += velocity * dt;

    final halfWidth = size.x / 2;
    if (position.x - halfWidth < 0) {
      position.x = halfWidth;
      velocity.x = 0;
    } else if (position.x + halfWidth > gameRef.size.x) {
      position.x = gameRef.size.x - halfWidth;
      velocity.x = 0;
    }

    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }

    super.update(dt);
  }
}
