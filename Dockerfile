FROM ubuntu:18.04

RUN apt update && apt install -yy gcc g++ cmake wget

# Создаем структуру папок для Hunter внутри контейнера и подкладываем локальный кэш
RUN mkdir -p /root/.hunter/_Base/Download/Toolchain/777286d/
COPY .hunter/_Base/Download/Toolchain/777286d/heavy.tar.gz /root/.hunter/_Base/Download/Toolchain/777286d/heavy.tar.gz

# Копируем остальные файлы проекта
COPY . /print
WORKDIR /print

RUN mkdir -p cmake && wget https://raw.githubusercontent.com/cpp-pm/gate/master/cmake/HunterGate.cmake -O cmake/HunterGate.cmake

RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build _build
RUN cmake --build _build --target install

ENV LOG_PATH /home/logs/log.txt
VOLUME /home/logs
WORKDIR _install/bin
ENTRYPOINT ["./demo"]

