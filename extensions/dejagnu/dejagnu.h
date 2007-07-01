// 
//   Copyright (C) 2005, 2006, 2007 Free Software Foundation, Inc.
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

#ifndef __DEJAGNU_PLUGIN_H__
#define __DEJAGNU_PLUGIN_H__

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <memory> // for auto_ptr
#include "as_object.h"

namespace gnash
{

class DejaGnu {
public:
    DejaGnu();
    ~DejaGnu();
    const char *pass (const char *msg);
    const char *fail (const char *msg);
    const char *xpass (const char *msg);
    const char *xfail (const char *msg);
    void totals ();
private:
    int passed;
    int failed;
    int xpassed;
    int xfailed;
};

extern "C" {
    void dejagnu_class_init(as_object &obj);  
    /// Return an  instance
}

std::auto_ptr<as_object> init_dejagnu_instance();

} // end of gnash namespace

// __DEJAGNU_PLUGIN_H__
#endif

// Local Variables:
// mode: C++
// indent-tabs-mode: t
// End:
