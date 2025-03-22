#include "my_maths/my_maths.hpp"

#include <exception>
#include <fstream>
#include <iostream>
#include <string>

auto main(int /*argc*/, char* /*argv*/[]) -> int
{
    try
    {
        std::ifstream myfile("resources/some_data.txt");
        if (myfile.is_open())
        {
            std::string line;
            while (std::getline(myfile, line))
            {
                std::cout << line << '\n';
            }
            myfile.close();
        }
        std::cout << "1 + 1 = " << my_maths::add_two_numbers(1, 1) << '\n';
        return 0;
    }
    catch (const std::exception& e)
    {
        std::cerr << e.what() << '\n';
        return 1;
    }
}