FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y openssh-server sudo && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

# ================= خط جدید ===============
# ساخت کلیدهای امنیتی SSH برای جلوگیری از کرش شدن
RUN ssh-keygen -A
# ==========================================

RUN echo 'root:MyStrongPassword123' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
