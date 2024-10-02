# 베이스 이미지로 OpenJDK를 사용
FROM openjdk:17-slim

# 애플리케이션 JAR 파일을 /app 디렉토리로 복사
COPY SpringApp-0.0.1-SNAPSHOT.jar /app/app.jar

# 헬스 체크 설정
HEALTHCHECK --interval=10s --timeout=30s CMD curl -f http://localhost:8999/index.html || exit 1

# 애플리케이션을 실행
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
