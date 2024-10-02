# <p align="center"> k8s-springapp-deploy

### kubernetes를 이용한 spring boot 애플리케이션 배포 자동화 실습

## 사용기술
![Spring](https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![k8s](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white) ![]()

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
- 작업경로에 .jar 파일 복사
- Dockerfile 생성
```
# 베이스 이미지로 OpenJDK를 사용
FROM openjdk:17-slim

# 애플리케이션 JAR 파일을 /app 디렉토리로 복사
COPY SpringApp-0.0.1-SNAPSHOT.jar /app/app.jar

# 헬스 체크 설정
HEALTHCHECK --interval=10s --timeout=30s CMD curl -f http://localhost:8999/index.html || exit 1

# 애플리케이션을 실행
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

```
<br>

## step 02 : 이미지 빌드 및 푸시
- script
```
  977  docker login
  978  docker images
  979  docker build -t springapp .
  980  docker images
  981  docker tag springapp suzyhw96/springapp:1.0
  982  docker images
  983  docker push suzyhw96/springapp:1.0
```
- docker hub
![image](https://github.com/user-attachments/assets/247319e1-d297-421d-8b1c-e3c348ede026)

<br>

## step 03 : Kubernetes 배포 구성 파일 작성 (.yml)
- sadedeploy.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: springapp-deployment
spec:
  replicas: 3  # 컨테이너 3개로 구성
  selector:
    matchLabels:
      app: springapp  # matchLabels는 Service의 selector와 일치해야 합니다.
  template:
    metadata:
      labels:
        app: springapp  # Pod의 라벨이 Service와 매칭되어야 합니다.
    spec:
      containers:
        - name: springapp-container
          image: suzyhw96/springapp:1.0
          ports:
            - containerPort: 8999  # 컨테이너 내부에서 리스닝하는 포트
---
apiVersion: v1
kind: Service
metadata:
  name: springapp-service
spec:
  selector:
    app: springapp  # Deployment의 matchLabels와 일치해야 합니다.
  ports:
    - protocol: TCP
      port: 80  # 클러스터 외부에서 접근하는 포트
      targetPort: 8999  # 컨테이너 내부 포트
  type: LoadBalancer

```
<br>

## step 04 : Kubernetes 배포 및 확인
- script
```
  992  kubectl apply -f sadeploy.yml 
  993  kubectl get deployments
  994  kubectl get pods
  995  kubectl get services
  996  minikube service springapp-service
```

- dashboard 확인

  ![image](https://github.com/user-attachments/assets/72d67bd9-c570-4883-84cd-b56d41eebd70)

- port forwarding <br>
![image](https://github.com/user-attachments/assets/92748977-a767-45f0-af87-59ddcaea93d1)

<br>

- localhost:81 확인

![image](https://github.com/user-attachments/assets/6b52bee2-5acb-4d8b-b2f3-84592e82ef90).


<br>

## 트러블슈팅 📝
- yml 정렬 오류
```
service/springapp-service created
Error from server (BadRequest): error when creating "sadeploy.yml": Deployment in version "v1" cannot be handled as a Deployment: strict decoding error: unknown field "metadata.replicas", unknown field "metadata.selector", unknown field "template"
```
<br>
