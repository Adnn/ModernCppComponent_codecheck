#pragma once

// Appearing in a public header, boost filesystem is a usage requirement
#include <boost/filesystem.hpp>

namespace myrepo {

inline bool is_directory(const std::string &aPath)
{
    return boost::filesystem::is_directory(aPath);
}

} // namespace myrepo
