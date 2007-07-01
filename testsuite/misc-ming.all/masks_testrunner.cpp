/* 
 *   Copyright (C) 2005, 2006, 2007 Free Software Foundation, Inc.
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 *
 */ 

#define INPUT_FILENAME "masks_test.swf"

#include "MovieTester.h"
#include "sprite_instance.h"
#include "character.h"
#include "dlist.h"
#include "container.h"
#include "log.h"

#include "check.h"
#include <string>
#include <cassert>

using namespace gnash;
using namespace std;

int
main(int /*argc*/, char** /*argv*/)
{
	typedef gnash::geometry::SnappingRanges2d<int> Ranges;
	typedef gnash::geometry::Range2d<int> Bounds;

	string filename = string(TGTDIR) + string("/") + string(INPUT_FILENAME);
	MovieTester tester(filename);

	gnash::LogFile& dbglogfile = gnash::LogFile::getDefaultInstance();
	dbglogfile.setVerbosity(1);

	Ranges invalidated;
	sprite_instance* root = tester.getRootMovie();
	assert(root);

	// FRAME 1 (start)

	check_equals(root->get_frame_count(), 4);
	check_equals(root->get_play_state(), sprite_instance::PLAY);
	check_equals(root->get_current_frame(), 0);
	check_equals(root->getDisplayList().size(), 1);  // dejagnu clip
	invalidated = tester.getInvalidatedRanges();
	check( invalidated.contains(76, 4) ); // the "-xtrace enabled-" label...

	tester.advance(); // FRAME 2
	
	check_equals(root->get_play_state(), sprite_instance::PLAY);
	check_equals(root->get_current_frame(), 1);
	check_equals(root->getDisplayList().size(), 9);
	root->getDisplayList().dump();
	check( tester.findDisplayItemByName(*root, "staticmc2") );
	check( tester.findDisplayItemByName(*root, "staticmc3") );
	check( tester.findDisplayItemByName(*root, "staticmc4") );
	check( tester.findDisplayItemByName(*root, "staticmc5") );
	check( tester.findDisplayItemByName(*root, "dynamicmc2") );
	check( tester.findDisplayItemByName(*root, "dynamicmc3") );
	check( tester.findDisplayItemByName(*root, "dynamicmc4") );
	check( tester.findDisplayItemByName(*root, "dynamicmc5") );
	invalidated = tester.getInvalidatedRanges();

	rgba red(255,0,0,255);
	rgba green(0,255,0,255);
	rgba blue(0,255,0,255);
	rgba yellow(255,255,0,255);
	rgba cyan(0,255,255,255);
	rgba violet(255,0,255,255);
	rgba dark_green(0,128,0,255);
	rgba light_blue(0,0,128,255);

	// 14,232 = red
	check( invalidated.contains(14, 232) );
	check_pixel(14,232, 2, red, 2);
	// 48,232 = yellow (red behind)
	check( invalidated.contains(48, 232) );
	check_pixel(48,232, 2, yellow, 2);
	// 80,232 = yellow
	check( invalidated.contains(80, 232) );
	check_pixel(80,232, 2, yellow, 2);

	// 214,232 = green
	check( invalidated.contains(214, 232) );
	check_pixel(214,232, 2, green, 2);
	// 248,232 = cyan (green behind)
	check( invalidated.contains(248, 232) );
	check_pixel(248,232, 2, cyan, 2);
	// 276,232 = cyan
	check( invalidated.contains(276, 232) );
	check_pixel(276,232, 2, cyan, 2);

	// 14,331 = blue
	check( invalidated.contains(14, 331) );
	xcheck_pixel(14,331, 2, blue, 2);
	// 48,331 = violet (blue behind)
	check( invalidated.contains(48, 331) );
	check_pixel(48,331, 2, violet, 2);
	// 80,331 = violet
	check( invalidated.contains(80, 331) );
	check_pixel(80,331, 2, violet, 2);

	// 214,331 = dark_green
	check( invalidated.contains(214, 331) );
	check_pixel(214,331, 2, dark_green, 2);
	// 248,331 = light_blue (dark_green behind)
	check( invalidated.contains(248, 331) );
	xcheck_pixel(248,331, 2, light_blue, 2);
	// 276,331 = light_blue
	check( invalidated.contains(276, 331) );
	xcheck_pixel(276,331, 2, light_blue, 2);


}

