// TextField_as.hx:  ActionScript 3 "TextField" class, for Gnash.
//
// Generated on: 20090608 by "bnaugle". Remove this
// after any hand editing loosing changes.
//
//   Copyright (C) 2009 Free Software Foundation, Inc.
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

// This test case must be processed by CPP before compiling to include the
//  DejaGnu.hx header file for the testing framework support.

#if flash9
import flash.text.TextField;
import flash.text.AntiAliasType;
import flash.display.MovieClip;
import flash.text.TextFormat;
import flash.text.StyleSheet;
#else
import flash.TextField;
import flash.MovieClip;
import flash.text.StyleSheet;
#end
import flash.Lib;
import Type;
import Std;

// import our testing API
import DejaGnu;

// Class must be named with the _as suffix, as that's the same name as the file.
class TextField_as {
    static function main() {
#if !(flash6 || flash7)
#if flash9
        var x1:TextField = new TextField();
#else
		var x1:TextField = flash.Lib.current.createTextField("",10,0,0,300,300);
#end
        // Make sure we actually get a valid class        
        if (Std.is(x1, TextField)) {
            DejaGnu.pass("TextField class exists");
        } else {
            DejaGnu.fail("TextField class doesn't exist");
        }
// Tests to see if all the properties exist. All these do is test for
// existance of a property, and don't test the functionality at all. This
// is primarily useful only to test completeness of the API implementation.
#if flash9
	if (Type.typeof(x1.alwaysShowSelection) == TBool) {
	    DejaGnu.pass("TextField.alwaysShowSelection property exists");
	} else {
	    DejaGnu.fail("TextField.alwaysShowSelection property doesn't exist");
	}
#end
	if (Std.is(x1.autoSize,String) ) {
	    DejaGnu.pass("TextField.autoSize property exists");
	} else {
	    DejaGnu.fail("TextField.autoSize property doesn't exist");
	}
	if (Type.typeof(x1.background) == TBool) {
	    DejaGnu.pass("TextField.background property exists");
	} else {
	    DejaGnu.fail("TextField.background property doesn't exist");
	}
	if (Std.is(x1.backgroundColor,Int) ) {
	    DejaGnu.pass("TextField.backgroundColor property exists");
	} else {
	    DejaGnu.fail("TextField.backgroundColor property doesn't exist");
	}
	if (Type.typeof(x1.border) == TBool) {
	    DejaGnu.pass("TextField.border property exists");
	} else {
	    DejaGnu.fail("TextField.border property doesn't exist");
	}
	if (Std.is(x1.borderColor,Float) ) {
	    DejaGnu.pass("TextField.borderColor property exists");
	} else {
	    DejaGnu.fail("TextField.borderColor property doesn't exist");
	}
#if flash9
	if (Std.is(x1.bottomScrollV,Float) ) {
	    DejaGnu.pass("TextField.bottomScrollV property exists");
	} else {
	    DejaGnu.fail("TextField.bottomScrollV property doesn't exist");
	}
	if (Std.is(x1.caretIndex,Int) ) {
	    DejaGnu.pass("TextField.caretIndex property exists");
	} else {
	    DejaGnu.fail("TextField.caretIndex property doesn't exist");
	}
	if (Std.is(x1.defaultTextFormat,TextFormat) ) {
	    DejaGnu.pass("TextField.defaultTextFormat property exists");
	} else {
	    DejaGnu.fail("TextField.defaultTextFormat property doesn't exist");
	}
	if (Type.typeof(x1.displayAsPassword) == TBool) {
	    DejaGnu.pass("TextField.displayAsPassword property exists");
	} else {
	    DejaGnu.fail("TextField.displayAsPassword property doesn't exist");
	}
	if (Std.is(x1.htmlText,String) ) {
	    DejaGnu.pass("TextField.htmlText property exists");
	} else {
	    DejaGnu.fail("TextField.htmlText property doesn't exist");
	}
	if (Std.is(x1.maxScrollH,Int) ) {
	    DejaGnu.pass("TextField.maxScrollH property exists");
	} else {
	    DejaGnu.fail("TextField.maxScrollH property doesn't exist");
	}
	if (Std.is(x1.maxScrollV,Int) ) {
	    DejaGnu.pass("TextField.maxScrollV property exists");
	} else {
	    DejaGnu.fail("TextField.maxScrollV property doesn't exist");
	}
	if (Std.is(x1.scrollH,Int) ) {
	    DejaGnu.pass("TextField.scrollH property exists");
	} else {
	    DejaGnu.fail("TextField.scrollH property doesn't exist");
	}
	if (Std.is(x1.scrollV,Int) ) {
	    DejaGnu.pass("TextField.scrollV property exists");
	} else {
	    DejaGnu.fail("TextField.scrollV property doesn't exist");
	}
	if (Std.is(x1.numLines,Int) ) {
	    DejaGnu.pass("TextField.numLines property exists");
	} else {
	    DejaGnu.fail("TextField.numLines property doesn't exist");
	}
	if (Std.is(x1.selectionBeginIndex,Int) ) {
	    DejaGnu.pass("TextField.selectionBeginIndex property exists");
	} else {
	    DejaGnu.fail("TextField.selectionBeginIndex property doesn't exist");
	}
	if (Std.is(x1.selectionEndIndex,Int) ) {
	    DejaGnu.pass("TextField.selectionEndIndex property exists");
	} else {
	    DejaGnu.fail("TextField.selectionEndIndex property doesn't exist");
	}
	if (Type.typeof(x1.useRichTextClipboard) == TBool) {
	    DejaGnu.pass("TextField.useRichTextClipboard property exists");
	} else {
	    DejaGnu.fail("TextField.useRichTextClipboard property doesn't exist");
	}
#else
	if (Type.typeof(x1.password) == TBool) {
	    DejaGnu.pass("TextField.password property exists");
	} else {
	    DejaGnu.fail("TextField.password property doesn't exist");
	}
	if (Std.is(x1.bottomScroll,Float) ) {
	    DejaGnu.pass("TextField.bottomScroll property exists");
	} else {
	    DejaGnu.fail("TextField.bottomScroll property doesn't exist");
	}
	if (Std.is(x1.maxhscroll,Int) ) {
	    DejaGnu.pass("TextField.maxhscroll property exists");
	} else {
	    DejaGnu.fail("TextField.maxhscroll property doesn't exist");
	}
	if (Std.is(x1.maxscroll,Int) ) {
	    DejaGnu.pass("TextField.maxscroll property exists");
	} else {
	    DejaGnu.fail("TextField.maxscroll property doesn't exist");
	}
	if (Std.is(x1.scroll,Int) ) {
	    DejaGnu.pass("TextField.scroll property exists");
	} else {
	    DejaGnu.fail("TextField.scroll property doesn't exist");
	}
	if (Std.is(x1.html,Bool) ) {
	    DejaGnu.pass("TextField.html property exists");
	} else {
	    DejaGnu.fail("TextField.html property doesn't exist");
	}
#end
#if (flash9 || flash8)
	if (Std.is(x1.antiAliasType,String) ) {
	    DejaGnu.pass("TextField.antiAliasType property exists");
	} else {
	    DejaGnu.fail("TextField.antiAliasType property doesn't exist");
	}
	if (Std.is(x1.sharpness,Float) ) {
	    DejaGnu.pass("TextField.sharpness property exists");
	} else {
	    DejaGnu.fail("TextField.sharpness property doesn't exist");
	}
	if (Std.is(x1.gridFitType,String) ) {
	    DejaGnu.pass("TextField.gridFitType property exists");
	} else {
	    DejaGnu.fail("TextField.gridFitType property doesn't exist");
	}
	if (Std.is(x1.thickness,Float) ){
	    DejaGnu.pass("TextField.thickness property exists");
	} else {
	    DejaGnu.fail("TextField.thickness property doesn't exist");
	}
#end
	if (Type.typeof(x1.condenseWhite)== TBool) {
	    DejaGnu.pass("TextField.condenseWhite property exists");
	} else {
	    DejaGnu.fail("TextField.condenseWhite property doesn't exist");
	}
	if (Type.typeof(x1.embedFonts) == TBool) {
	    DejaGnu.pass("TextField.embedFonts property exists");
	} else {
	    DejaGnu.fail("TextField.embedFonts property doesn't exist");
	}
	if (Std.is(x1.length,Int) ) {
	    DejaGnu.pass("TextField.length property exists");
	} else {
	    DejaGnu.fail("TextField.length property doesn't exist");
	}
	if (Std.is(x1.maxChars,Int) ) {
	    DejaGnu.pass("TextField.maxChars property exists");
	} else {
	    DejaGnu.fail("TextField.maxChars property doesn't exist");
	}
	if (Type.typeof(x1.mouseWheelEnabled) == TBool) {
	    DejaGnu.pass("TextField.mouseWheelEnabled property exists");
	} else {
	    DejaGnu.fail("TextField.mouseWheelEnabled property doesn't exist");
	}
	if (Type.typeof(x1.multiline)==TBool ) {
	    DejaGnu.pass("TextField.multiline property exists");
	} else {
	    DejaGnu.fail("TextField.multiline property doesn't exist");
	}
//	if (Std.is(x1.restrict,String) ) {
//	    DejaGnu.pass("TextField.restrict property exists");
//	} else {
//	    DejaGnu.fail("TextField.restrict property doesn't exist");
//	}

	
	if (Type.typeof(x1.selectable)==TBool ) {
	    DejaGnu.pass("TextField.selectable property exists");
	} else {
	    DejaGnu.fail("TextField.selectable property doesn't exist");
	}

//Si:
//I initialized the StylsSheet at first
//Then check the type of it.
//It works fine now!
//	DejaGnu.note("TYPE " + Type.typeof(x1.styleSheet));
	var newStyle:StyleSheet = new StyleSheet();
	x1.styleSheet=newStyle;
	if (Std.is(x1.styleSheet,StyleSheet) ) {
	    DejaGnu.pass("TextField.styleSheet property exists");
	} else {
	    DejaGnu.fail("TextField.styleSheet property doesn't exist");
	}
	if (Std.is(x1.text,String) ) {
	    DejaGnu.pass("TextField.text property exists");
	} else {
	    DejaGnu.fail("TextField.text property doesn't exist");
	}
	if (Std.is(x1.textColor,Int) ) {
	    DejaGnu.pass("TextField.textColor property exists");
	} else {
	    DejaGnu.fail("TextField.textColor property doesn't exist");
	}
	if (Std.is(x1.textHeight,Float) ) {
	    DejaGnu.pass("TextField.textHeight property exists");
	} else {
	    DejaGnu.fail("TextField.textHeight property doesn't exist");
	}
	if (Std.is(x1.textWidth,Float) ) {
	    DejaGnu.pass("TextField.textWidth property exists");
	} else {
	    DejaGnu.fail("TextField.textWidth property doesn't exist");
	}
	if (Std.is(x1.type,String) ) {
	    DejaGnu.pass("TextField.type property exists");
	} else {
	    DejaGnu.fail("TextField.type property doesn't exist");
	}
	if (Type.typeof(x1.wordWrap)== TBool) {
	    DejaGnu.pass("TextField.wordWrap property exists");
	} else {
	    DejaGnu.fail("TextField.wordWrap property doesn't exist");
	}

//Si:
//This one is not defined in Haxe

//	if (x1.contextMenu == NativeMenu) {
//	    DejaGnu.pass("TextField.contextMenu property exists");
//	} else {
//	    DejaGnu.fail("TextField.contextMenu property doesn't exist");
//	}

// Tests to see if all the methods exist. All these do is test for
// existance of a method, and don't test the functionality at all. This
// is primarily useful only to test completeness of the API implementation.
#if flash9
	if (Type.typeof(x1.appendText)==TFunction) {
	    DejaGnu.pass("TextField::appendText() method exists");
	} else {
	    DejaGnu.fail("TextField::appendText() method doesn't exist");
	}
	if (Type.typeof(x1.getCharBoundaries )==TFunction) {
	    DejaGnu.pass("TextField::getCharBoundaries() method exists");
	} else {
	    DejaGnu.fail("TextField::getCharBoundaries() method doesn't exist");
	}
	if (Type.typeof(x1.getCharIndexAtPoint)==TFunction) {
	    DejaGnu.pass("TextField::getCharIndexAtPoint() method exists");
	} else {
	    DejaGnu.fail("TextField::getCharIndexAtPoint() method doesn't exist");
	}
	if (Type.typeof(x1.getFirstCharInParagraph)==TFunction) {
	    DejaGnu.pass("TextField::getFirstCharInParagraph() method exists");
	} else {
	    DejaGnu.fail("TextField::getFirstCharInParagraph() method doesn't exist");
	}
	if (Type.typeof(x1.getImageReference )==TFunction) {
	    DejaGnu.pass("TextField::getImageReference() method exists");
	} else {
	    DejaGnu.fail("TextField::getImageReference() method doesn't exist");
	}
	if (Type.typeof(x1.getLineIndexAtPoint )==TFunction) {
	    DejaGnu.pass("TextField::getLineIndexAtPoint() method exists");
	} else {
	    DejaGnu.fail("TextField::getLineIndexAtPoint() method doesn't exist");
	}
	if (Type.typeof(x1.getLineIndexOfChar)==TFunction) {
	    DejaGnu.pass("TextField::getLineIndexOfChar() method exists");
	} else {
	    DejaGnu.fail("TextField::getLineIndexOfChar() method doesn't exist");
	}
	if (Type.typeof(x1.getLineLength)==TFunction) {
	    DejaGnu.pass("TextField::getLineLength() method exists");
	} else {
	    DejaGnu.fail("TextField::getLineLength() method doesn't exist");
	}
	if (Type.typeof(x1.getLineMetrics)==TFunction) {
	    DejaGnu.pass("TextField::getLineMetrics() method exists");
	} else {
	    DejaGnu.fail("TextField::getLineMetrics() method doesn't exist");
	}
	if (Type.typeof(x1.getLineOffset)==TFunction) {
	    DejaGnu.pass("TextField::getLineOffset() method exists");
	} else {
	    DejaGnu.fail("TextField::getLineOffset() method doesn't exist");
	}
	if (Type.typeof(x1.getLineText)==TFunction) {
	    DejaGnu.pass("TextField::getLineText() method exists");
	} else {
	    DejaGnu.fail("TextField::getLineText() method doesn't exist");
	}
	if (Type.typeof(x1.getParagraphLength)==TFunction) {
	    DejaGnu.pass("TextField::getParagraphLength() method exists");
	} else {
	    DejaGnu.fail("TextField::getParagraphLength() method doesn't exist");
	}
	if (Type.typeof(x1.getRawText )==TFunction) {
	    DejaGnu.pass("TextField::getRawText() method exists");
	} else {
	    DejaGnu.fail("TextField::getRawText() method doesn't exist");
	}
	if (Type.typeof(x1.getTextFormat )==TFunction) {
	    DejaGnu.pass("TextField::getTextFormat() method exists");
	} else {
	    DejaGnu.fail("TextField::getTextFormat() method doesn't exist");
	}
	if (Type.typeof(x1.getTextRuns )==TFunction) {
	    DejaGnu.pass("TextField::getTextRuns() method exists");
	} else {
	    DejaGnu.fail("TextField::getTexRuns() method doesn't exist");
	}
	if (Type.typeof(x1.getXMLText )==TFunction) {
	    DejaGnu.pass("TextField::getXMLText() method exists");
	} else {
	    DejaGnu.fail("TextField::getXMLText() method doesn't exist");
	}
	if (Type.typeof(x1.insertXMLText )==TFunction) {
	    DejaGnu.pass("TextField::insertXMLText() method exists");
	} else {
	    DejaGnu.fail("TextField::insertXMLText() method doesn't exist");
	}	
	if (Type.typeof(x1.replaceSelectedText )==TFunction) {
	    DejaGnu.pass("TextField::replaceSelectedText() method exists");
	} else {
	    DejaGnu.fail("TextField::replaceSelectedText() method doesn't exist");
	}
	if (Type.typeof(x1.setSelection )==TFunction) {
	    DejaGnu.pass("TextField::setSelection() method exists");
	} else {
	    DejaGnu.fail("TextField::setSelection() method doesn't exist");
	}
#else
	
#end
	if (Type.typeof(x1.replaceText)==TFunction) {
	    DejaGnu.pass("TextField::replaceText() method exists");
	} else {
	    DejaGnu.fail("TextField::replaceText() method doesn't exist");
	}
	if (Type.typeof(x1.setTextFormat )==TFunction) {
	    DejaGnu.pass("TextField::setTextFormat() method exists");
	} else {
	    DejaGnu.fail("TextField::setTextFormat() method doesn't exist");
	}
#end
        // Call this after finishing all tests. It prints out the totals.
        DejaGnu.done();
    }
}

// local Variables:
// mode: C++
// indent-tabs-mode: t
// End:
