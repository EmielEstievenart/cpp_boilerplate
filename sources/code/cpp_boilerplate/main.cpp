#include "my_maths/my_maths.hpp"

#include <fstream>
#include <iostream>
#include <string>

int main(int argc, char* argv[])
{
    std::ifstream myfile("resources/some_data.txt");
    if (myfile.is_open())
    {
        std::string line;
        while (std::getline(myfile, line))
        {
            std::cout << line << std::endl;
        }
        myfile.close();
    }
    std::cout << "1 + 1 = " << my_maths::add_two_numbers(1, 1) << std::endl;
    return 0;
}