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

// 
//
//

#ifndef _GNASH_FN_CALL_H_
#define _GNASH_FN_CALL_H_

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "as_environment.h" // for inlines (arg)
#include "as_object.h" // for dtor visibility by boost::intrusive_ptr
#include "smart_ptr.h"

#include <cassert> // for inlines (arg)
#include <ostream> // for inlines (dump_args)

namespace gnash {

// Forward declarations
class as_environment;
class as_object;
class as_value;

/// \brief
/// Parameters/environment for builtin or user-defined functions
/// callable from ActionScript.
class fn_call
{
public:
	/// The as_object (or a pointer derived thereof) on which this call
	/// is taking place.
	boost::intrusive_ptr<as_object> this_ptr;

	/// Number of arguments to this ActionScript function call.
	unsigned int nargs;

public:
	fn_call(as_object* this_in,
			as_environment* env_in,
			int nargs_in, int first_in)
		:
		this_ptr(this_in),
		nargs(nargs_in),
		_env(env_in),
		_stack_offset(first_in)
	{
	}

	fn_call(boost::intrusive_ptr<as_object> this_in,
			as_environment* env_in,
			int nargs_in, int first_in)
		:
		this_ptr(this_in),
		nargs(nargs_in),
		_env(env_in),
		_stack_offset(first_in)
	{
	}

	/// Access a particular argument.
	as_value& arg(unsigned int n) const
	{
		assert(n < nargs);
		return _env->bottom(_stack_offset - n);
	}

	int offset() const
	{
		return _stack_offset;
	}

	void set_offset(int offset)
	{
		_stack_offset = offset;
	}

	as_environment& env() const
	{
		return *_env;
	}

	/// Dump arguments to given output stream
	void dump_args(std::ostream& os) const
	{
		for (unsigned int i=0; i<nargs; ++i)
		{
			if ( i ) os << ", ";
			os << arg(i).to_string();
		}
	}

private:
	/// The ActionScript environment in which the function call is taking
	/// place. This contains, among other things, the function arguments.
	as_environment* _env;

	/// The offset from the bottom of the env callstack to the first
	/// argument to our fn_call.
	unsigned int _stack_offset;
};

/// Signature of a builtin function callable from ActionScript
typedef as_value (*as_c_function_ptr)(const fn_call& fn);


} // namespace gnash


#endif // _GNASH_FN_CALL_H_


// Local Variables:
// mode: C++
// indent-tabs-mode: t
// End:
