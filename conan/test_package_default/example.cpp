#include <A/accumulate.h>
#include <A/is_directory.h>

#include <B/Foo.h>

#include <cstdlib>

int main()
{
    myrepo::accumulate(5);
    myrepo::is_directory("probably_not");
    return EXIT_SUCCESS;
}
