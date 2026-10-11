FROM ubuntu:22.04

# جلوگیری از خطاهای تعاملی هنگام نصب
ENV DEBIAN_FRONTEND=noninteractive

# نصب سرور SSH و sudo
RUN apt-get update && apt-get install -y openssh-server sudo && \
    rm -rf /var/lib/apt/lists/*

# ایجاد پوشه مورد نیاز برای اجرای SSH
RUN mkdir /var/run/sshd

# تنظیم یک رمز عبور برای کاربر root (حتماً این رمز را تغییر دهید!)
RUN echo 'root:MyStrongPassword123' | chpasswd

# اجازه دادن به کاربر root برای لاگین با رمز عبور
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# راه‌اندازی مجدد سرویس SSH برای اعمال تغییرات
RUN service ssh restart

# باز کردن پورت 22 در داخل کانتینر
EXPOSE 22

# اجرای سرور SSH به عنوان پردازش اصلی
CMD ["/usr/sbin/sshd", "-D"]
