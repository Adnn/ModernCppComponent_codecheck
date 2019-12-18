#include <A/accumulate.h>

#include <iostream>

int main()
{
    int value = 3;
    std::cout << "Accumulation of " << value << ": "
              << myrepo::accumulate(value)
              << std::endl;

    exit(EXIT_SUCCESS);
}
