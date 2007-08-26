// 
//   Copyright (C) 2007 Free Software Foundation, Inc.
// 
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

/* $Id: filter_factory.h,v 1.1 2007/08/26 15:14:13 cmusick Exp $ */

#ifndef GNASH_FILTER_FACTORY_H
#define GNASH_FILTER_FACTORY_H

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <vector>
#include "BitmapFilter.h"

namespace gnash {

class stream;

typedef std::vector<Filter> Filters;

class filter_factory
{
public:
    /// \brief Read one, possibly multiple filters from the stream,
    /// and push them into the vector store. Returns the number read.
    /// If read_multiple is true, the first byte of the stream is
    /// expected to contain the number of filters to be read.
    static int const read(stream* in, int movie_version, bool read_multiple,
        Filters* store);
};

} // Namespace gnash

#endif // GNASH_FILTER_FACTORY_H
