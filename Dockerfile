# 1. Берем базовый образ старой доброй Ubuntu 18.04
FROM ubuntu:18.04

# 2. Обновляем пакеты и устанавливаем компиляторы GCC/C++, CMake и wget
RUN apt update && apt install -yy gcc g++ cmake wget

# 3. Копируем файлы нашего проекта внутрь контейнера
COPY . /print
WORKDIR /print

# Скачиваем HunterGate напрямую, чтобы не зависеть от пустых подмодулей git
RUN mkdir -p cmake && wget https://raw.githubusercontent.com/cpp-pm/gate/master/cmake/HunterGate.cmake -O cmake/HunterGate.cmake

# 4. Собираем проект с помощью CMake внутри контейнера
RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build _build
RUN cmake --build _build --target install

# 5. Настраиваем переменную окружения для логов
ENV LOG_PATH /home/logs/log.txt

# 6. Объявляем точку монтирования для сохранения логов на реальном компьютере
VOLUME /home/logs

# 7. Переходим в папку со скомпилированным бинарником
WORKDIR _install/bin

# 8. Указываем команду, которая запустится при старте контейнера
ENTRYPOINT ["./demo"]

