FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# نصب tmate و ابزارهای ضروری
RUN apt-get update && apt-get install -y tmate curl openssh-client sudo && \
    rm -rf /var/lib/apt/lists/*

# اجرای tmate و چاپ آدرس اتصال در لاگ‌های Railway
CMD tmate -F & sleep 10 && tmate display | grep "ssh"
