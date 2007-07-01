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

#ifndef _PROTOCOL_H_
#define _PROTOCOL_H_

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <string>
#include "network.h"

class Protocol : public gnash::Network {
public:
    Protocol() { };
    virtual ~Protocol() { };
    
    virtual bool handShakeWait() = 0;
    virtual bool handShakeRequest() = 0;
    virtual bool handShakeResponse() = 0;
    virtual bool clientFinish() = 0;
    virtual bool serverFinish() = 0;
    virtual bool packetRequest() = 0;
    virtual bool packetSend() = 0;
    virtual bool packetRead() = 0;
    void resetBytesOut() { _outbytes = 0; };
    int getBytesOut() { return _outbytes; };
    void resetBytesIn() { _inbytes = 0; };
    int getBytesIn() { return _inbytes; };
private:
    std::string _name;
protected:
    int         _inbytes;
    int         _outbytes;
};  

// end of _PROTOCOL_H_
#endif

// local Variables:
// mode: C++
// indent-tabs-mode: t
// End:
