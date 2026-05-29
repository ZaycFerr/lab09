cmake_minimum_required(VERSION 3.10)
project(print_server)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Собираем библиотеку из твоих исходников (корректируй имена файлов, если они другие)
add_library(print STATIC sources/print.cpp)
target_include_directories(print PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

# Собираем исполняемый файл (демо/сервер)
add_executable(demo sources/main.cpp)
target_link_libraries(demo print)

# Правила установки, чтобы Docker нашёл бинарник
install(TARGETS demo DESTINATION bin)


