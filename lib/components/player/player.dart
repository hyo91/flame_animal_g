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

  // Player의 X축 속도 및 이동속도 지정
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 300;

  // Player의 y축(점프) 속도 및 여부 확인
  bool isJumping = false;
  bool isFalling = false;

  final double jumpSpeed = -500;
  final double gravity = 1000;

  // Player의 좌, 우 이동방향 저장
  int horizontalDirection = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 개별 PNG 파일들을 스프라이트 애니메이션으로 만들기
    animation = SpriteAnimation.spriteList(
      [
        // 기본 모션
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_1.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_2.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_3.png')),
        Sprite(gameRef.images.fromCache('otter_sprite_pack/otter_idle_4.png')),
        // 달리기 모션
        // 점프 모션
      ],
      stepTime: 0.12,
      loop: true,
    );
  }

  // 점프 기능 추가
  void jump() {
    // 점프 중이거나 떨어지는 중인 경우, return
    if (isJumping || isFalling) return;

    isJumping = true;
    velocity.y = jumpSpeed;
  }

  // 키보드 이벤트 처리 (새로운 KeyEvent API 사용)
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // 방향 초기화
    horizontalDirection = 0;

    // 좌 화살표가 눌린 경우 horizontalDirection -1
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      horizontalDirection -= 1;
    }
    // 우 화살표가 눌린 경우 horizontalDirection +1
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      horizontalDirection += 1;
    }

    // 스페이스바나 위 화살표로 점프 (키가 눌렸을 때만)
    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.arrowUp)) {
      jump();
    }

    return true;
  }

  // 게임 오브젝트가 업데이트 될 때마다 호출됨
  @override
  void update(double dt) {
    // 방향 * 이동속도
    velocity.x = horizontalDirection * moveSpeed;

    // 점프/낙하 물리 처리
    if (isJumping) {
      velocity.y += gravity * dt;
      if (velocity.y >= 0) {
        isJumping = false;
        isFalling = true;
      }
    } else if (isFalling) {
      velocity.y += gravity * dt;

      // 플레이어가 바닥에 닿았을 때
      // Anchor.center이므로 position.y는 캐릭터 중심
      final ground = gameRef.size.y - (size.y / 2);
      if (position.y >= ground) {
        isFalling = false;
        velocity.y = 0;
        position.y = ground;
      }
    }

    // 플레이어 이동 (dt는 마지막 프레임으로부터 경과된 시간[초])
    position += velocity * dt;

    // 좌우 벽 충돌 처리 (위치만 제한, 방향은 건드리지 않음)
    final halfWidth = size.x / 2;
    if (position.x - halfWidth < 0) {
      position.x = halfWidth;
      velocity.x = 0;
    } else if (position.x + halfWidth > gameRef.size.x) {
      position.x = gameRef.size.x - halfWidth;
      velocity.x = 0;
    }

    // horizontalDirection에 따라 스프라이트를 좌/우 반전
    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }

    // 스프라이트 애니메이션 업데이트
    super.update(dt);
  }
}
