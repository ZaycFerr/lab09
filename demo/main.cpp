#include <print.hpp>
#include <cstdlib>
#include <iostream>
#include <fstream>

int main(int argc, char* argv[])
{
    const char* log_path = std::getenv("LOG_PATH");
    if (log_path == nullptr)
    {
        std::cerr << "undefined environment variable: LOG_PATH" << std::endl;
        return 1;
    }
    
    std::string text;
    while (std::cin >> text)
    {
        std::ofstream out{log_path, std::ios_base::app};
        // Перенаправляем вывод библиотеки в наш файл лога
        std::streambuf* stream_buffer_cout = std::cout.rdbuf();
        std::cout.rdbuf(out.rdbuf());
        
        print(text);
        
        // Возвращаем вывод в исходное состояние
        std::cout.rdbuf(stream_buffer_cout);
    }
}

