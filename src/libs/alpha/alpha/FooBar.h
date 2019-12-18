#pragma once

#include <beta/Foo.h>

namespace myrepo {

struct FooBar: public Foo
{
    FooBar(int aFoo, int aBar) :
        Foo(aFoo),
        mBarvalue(aBar)
    {}

    int mBarvalue;
};

} // namespace myrepo
