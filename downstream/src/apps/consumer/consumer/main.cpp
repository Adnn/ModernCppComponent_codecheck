#include <alpha/accumulate.h>
#include <alpha/FooBar.h>
#include <alpha/is_directory.h>

#include <iostream>

int main(int argc, char * argv[])
{
    int value = 3;
    std::cout << "Accumulation of " << value << ": "
              << myrepo::accumulate(value)
              << std::endl;

    if (argc >= 2)
    {
        std::cout << "Is first argument '" << argv[1] << "' a directory? "
                  << std::boolalpha
                  << myrepo::is_directory(argv[1])
                  << std::endl;
    }

    myrepo::FooBar fb{1, 2};

    exit(EXIT_SUCCESS);
}
