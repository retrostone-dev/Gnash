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
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

// Original author: Mike Carlson - June 19th, 2006

rcsid="$Id: String.as,v 1.19 2007/07/01 10:54:40 bjacques Exp $";

#include "check.as"

var a;
a = new String("wallawallawashinGTON");
check_equals ( a.charCodeAt(0), 119 );
check_equals ( a.charCodeAt(1), 97 );
check_equals ( a.charCodeAt(2), 108 );
check_equals ( a.charCodeAt(3), 108 );
check_equals ( a.charCodeAt(4), 97 );
check_equals ( a.charAt(0), "w" );
check_equals ( a.charAt(1), "a" );
check_equals ( a.charAt(2), "l" );
check_equals ( a.charAt(3), "l" );
check_equals ( a.charAt(4), "a" );
isNaN ( a.charAt(-1) );
isNaN (a.charAt(21) );
check_equals ( a.indexOf("lawa"), 3 );
check_equals ( a.lastIndexOf("lawa"), 8);
check_equals ( a.indexOf("lawas"), 8 );
check_equals ( a.indexOf("hinG"), 13 );
check_equals ( a.indexOf("hing"), -1 );

//----------------------------------------
// Check String.split
//-----------------------------------------

check_equals ( typeof(a.split), 'function' );
check ( ! a.hasOwnProperty('split') );
#if OUTPUT_VERSION > 5
check ( a.__proto__.hasOwnProperty('split') );
check ( a.__proto__ == String.prototype );
#endif

check_equals ( a.split()[0], "wallawallawashinGTON" );
check_equals ( a.split().length, 1 );
check ( a.split() instanceof Array );
check_equals ( a.split("w").length, 4);
check_equals ( a.split("  w").length, 1);

#if OUTPUT_VERSION > 5
check_equals ( a.split("")[0], "w" );
check_equals ( a.split("")[19], "N" );
check_equals ( a.split("la")[0], "wal" );
check_equals ( a.split("la")[1], "wal" );
check_equals ( a.split("la")[2], "washinGTON" );
check_equals ( a.split("la").length, 3 );
#else
// empty delimiter doesn't have a special meaning in SWF5
check_equals ( a.split("")[0], "wallawallawashinGTON" );
check_equals ( a.split("")[19], undefined );
// mulit-char delimiter doesn't work in SWF5
check_equals ( a.split("la")[0], "wallawallawashinGTON" );
check_equals ( a.split("la")[1], undefined );
check_equals ( a.split("la")[2], undefined );
check_equals ( a.split("la").length, 1 );
#endif


// This is the correct usage pattern
var b = String.fromCharCode(97,98,99,100);
check_equals ( b, "abcd" );

check_equals ( a.toUpperCase(), "WALLAWALLAWASHINGTON" );
check_equals ( a.toLowerCase(), "wallawallawashington" );
a = new String("abcdefghijklmnopqrstuvwxyz");
check_equals ( a.substr(5,2), "fg" );
check_equals ( a.substr(5,7), "fghijkl" );
check_equals ( a.substr(-1,1), "z" );
check_equals ( a.substr(-2,3), "yz" );
check_equals ( a.substr(-3,2), "xy" );
check_equals ( a.slice(-5,-3), "vw" );
#if OUTPUT_VERSION > 5
check_equals ( a.slice.call(a, -5, -3), "vw" );
check_equals ( String.prototype.slice.call(a, -5, -3), "vw" );
#else
// There was no 'call' or 'apply' thing up to SWF5
// Actually, there was no Function interface at all!
check_equals ( a.slice.call(a, -5, -3), undefined );
check_equals ( String.prototype.slice.call(a, -5, -3), undefined );
#endif
check_equals ( a.slice(-4), "wxyz" );
check_equals ( a.substring(5,2), "cde" );
check_equals ( a.substring(5,7), "fg" );
check_equals ( a.substring(3,3), "" );
check_equals ( a.length, 26 );
check_equals ( a.concat("sir ","william",15), "abcdefghijklmnopqrstuvwxyzsir william15");
var b = new String("1234");
check_equals ( b.substring(3, 6), "4");
check_equals ( b.substr(3, 6), "4");

// see check.as
#ifdef MING_SUPPORTS_ASM

// We need ming-0.4.0beta2 or later for this to work...
// This is the only way to generate an SWFACTION_SUBSTRING
// tag (the calls above generate a CALLMETHOD tag)
//
asm {
	push "b"
	push "ciao"
	push "2"
	push "10" // size is bigger then string length,
	          // we expect the interpreter to adjust it
	substring
	setvariable
};
check_equals( b, "iao");
asm {
	push "b"
	push "boowa"
	push "2"
	push "-1" // size is bigger then string length,
	          // we expect the interpreter to adjust it
	substring
	setvariable
};
check_equals( b, "oowa");
asm {
	push "b"
	push "ciao"
	push "-2" // negative base should be interpreted as 1
	push "1" 
	substring
	setvariable
};
check_equals( b, "c");
asm {
	push "b"
	push "ciao"
	push "-2" // negative base should be interpreted as 1
	push "10" // long size reduced 
	substring
	setvariable
};
check_equals( b, "ciao");
asm {
	push "b"
	push "ciao"
	push "0" // zero base is invalid, but taken as 1
	push "1" 
	substring
	setvariable
};
check_equals( b, "c");
asm {
	push "b"
	push "ciao"
	push "10" // too large base ...
	push "1" 
	substring
	setvariable
};
check_equals( b, "");
asm {
	push "b"
	push "all"
	push "3" // base is 1-based!
	push "1" 
	substring
	setvariable
};
check_equals( b, "l");
#endif


// Test inheritance with built-in functions
var stringInstance = new String();
check (stringInstance.__proto__ != undefined);
check (stringInstance.__proto__ == String.prototype);
check_equals (typeOf(String.prototype.constructor), 'function');
check (String.prototype.constructor == String);
check (stringInstance.__proto__.constructor == String);

// Test the instanceof operator
check ( stringInstance instanceof String );
check ( ! "literal string" instanceof String );

// Test automatic cast of string values to String objects
// this should happen automatically when invoking methods
// on a primitive string type
var a_string = "a_string";
check_equals(typeof(a_string), "string");
check_equals (a_string.substring(0, 4), "a_st");
check_equals (a_string.substring(-3, 4), "a_st");
check_equals (a_string.substring(0, -1), "");
check_equals (a_string.substring(4), "ring");
check_equals (a_string.substring(16), "");
check_equals (a_string.substring(-16), "a_string");
check_equals (a_string.toUpperCase(), "A_STRING");
check_equals (a_string.indexOf("hing"), -1 );
check_equals (a_string.indexOf("string"), 2 );
check_equals (a_string.charCodeAt(0), 97 );

// Test String.length not being overridable
a_string = "1234567890";
check_equals(a_string.length, 10);
a_string.length = 4;
check_equals(a_string.length, 10);
check_equals(a_string, "1234567890");


//----------------------------------------------------
// Test automatic string conversion when adding stuff
//-----------------------------------------------------
a = "one";
b = "two";
check_equals(a+b, "onetwo");
c = new Object();

check_equals(b+c, "two[object Object]");

// check that calls to toString() use the current environment
c.toString = function() { return a; };
prevToStringFunc = c.toString;
check_equals(b+c, "twoone");

// this won't be used as a valid toString method !
c.toString = function() { return 4; };
#if OUTPUT_VERSION >= 6
check(c.toString != prevToStringFunc);
#endif
check_equals(b+c, "two[type Object]");

Object.prototype.toString = undefined;
check_equals(typeof(c.toString), 'function');
check_equals(b+c, "two[type Object]");

c.toString = undefined;
check_equals(typeof(c.toString), 'undefined');
check_equals(b+c, "two[type Object]");

stringObject = new String("1234");
check_equals(typeof(stringObject.valueOf), 'function');
check_equals(stringObject.valueOf, String.prototype.valueOf);

#if OUTPUT_VERSION > 5
check(stringObject.valueOf != Object.prototype.valueOf);
check(String.prototype.hasOwnProperty('valueOf'));
#endif

check_equals(typeof(stringObject.valueOf()), 'string');
check_equals(stringObject, "1234");
check_equals(stringObject, 1234);
check_equals(1234, stringObject);
numberObject = new Number(1234);
#if OUTPUT_VERSION >= 6
check(stringObject != numberObject);
#else
xcheck_equals(stringObject, numberObject); // SWF5 always converts to string !!
#endif
check_equals(numberObject.toString(), stringObject);
check_equals(numberObject.toString(), stringObject.toString());
