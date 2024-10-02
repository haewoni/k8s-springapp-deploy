# <p align="center"> k8s-springapp-deploy
### kubernetes를 이용한 spring boot 애플리케이션 배포 자동화 실습


<br>

## 프로젝트 목적 🌷
**애플리케이션의 확장성과 고가용성**을 고려하여, 실제 운영 환경에서 자주 발생하는 <br>
트래픽 증가나 서버 장애 상황에서도 서비스가 원활하게 유지되도록 설계할 수 있는 방법을 탐구했습니다. <br><br>

또한, Kubernetes의 자동화된 배포 및 관리 기능을 이용해 <br>
**DevOps 환경에서 보다 효율적인 CI/CD 파이프라인을 구축**하고 운영 복잡성을 줄여<br>
비즈니스 연속성을 보장할 수 있는 방안을 모색하는 데 중점을 두었습니다. <br>

<br>

## 실습 개요 :star:

- step 01 : Spring boot 애플리케이션을 Docker 이미지로 만들기
- step 02 : 이미지 빌드 및 푸시
- step 03 : Kubernetes 배포 구성 파일 작성 (.yml)
- step 04 : Kubernetes 배포 및 확인

<br>

## 실습 과정 :mag_right:

## step 01 : Spring boot 애플리케이션을 Docker 이미지로 만들기

<br>

## step 02 : 이미지 빌드 및 푸시
<br>

## step 03 : Kubernetes 배포 구성 파일 작성 (.yml)

<br>

## step 04 : Kubernetes 배포 및 확인


<br>

## 트러블슈팅 📝
- yml 정렬 오류
```
service/springapp-service created
Error from server (BadRequest): error when creating "sadeploy.yml": Deployment in version "v1" cannot be handled as a Deployment: strict decoding error: unknown field "metadata.replicas", unknown field "metadata.selector", unknown field "template"
```
<br>
