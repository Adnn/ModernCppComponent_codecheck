#include <alpha/accumulate.h>
#include <alpha/is_directory.h>

#include <beta/Foo.h>

#include <cstdlib>

int main()
{
    myrepo::accumulate(5);
    myrepo::is_directory("probably_not");
    return EXIT_SUCCESS;
}
