FROM ubuntu:18.04

# Устанавливаем только нужные компиляторы
RUN apt update && apt install -yy gcc g++ cmake

# Копируем проект
COPY . /print
WORKDIR /print

# Конфигурируем и собираем стандартным путём
RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build _build
RUN cmake --build _build --target install

# Настройки запуска контейнера
ENV LOG_PATH /home/logs/log.txt
VOLUME /home/logs
WORKDIR _install/bin
ENTRYPOINT ["./demo"]
