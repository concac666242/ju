#Base Ubuntu image
FROM ubuntu:24.04

#Tắt prompt cài đặt
ARG DEBIAN_FRONTEND=noninteractive

#Cập nhật và cài đặt các tool cần thiết
RUN apt update && apt install -y \
    python3 python3-pip \
    curl wget git htop nano unzip \
    net-tools iputils-ping \
    tmux screen neofetch \
    && apt clean

#Cài đặt Jupyter Notebook
RUN pip3 install --upgrade pip

#Copy source code nếu có
COPY . /app
WORKDIR /app

#Tạo thư mục cho Jupyter notebook (nếu cần)
RUN mkdir -p /app/notebooks

#Mặc định mở cổng 8888 cho Jupyter
EXPOSE 8888

#Khởi chạy Jupyter Notebook khi container start, sử dụng token mặc định
CMD ["bash", "-c", "neofetch && jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]
