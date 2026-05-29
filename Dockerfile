FROM ubuntu:18.04

# Устанавливаем компиляторы
RUN apt update && apt install -yy gcc g++ cmake wget

# Копируем файлы проекта
COPY . /print
WORKDIR /print

# Принудительно отключаем Hunter, чтобы CMake собирал проект напрямую через стандартный GCC
RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install -DHUNTER_ENABLED=OFF

# Собираем и устанавливаем
RUN cmake --build _build
RUN cmake --build _build --target install

ENV LOG_PATH /home/logs/log.txt
VOLUME /home/logs
WORKDIR _install/bin
ENTRYPOINT ["./demo"]

