#include "accumulate.h"

// Same component, inclusion via compiler's include path
#include <A/sum.h>

namespace myrepo {

int accumulate(int aFrom)
{
    return aFrom > 0 ? sum(aFrom, accumulate(aFrom-1))
                     : 0;
}

} // namespace myrepo
