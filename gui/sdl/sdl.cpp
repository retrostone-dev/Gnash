// 
//   Copyright (C) 2005, 2006, 2007, 2008, 2009, 2010,
//   2011 Free Software Foundation, Inc
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


#ifdef HAVE_CONFIG_H
#include "gnashconfig.h"
#endif

#include <cstdio>

#include "log.h"
#include "sdlsup.h"
#include "Range2d.h" // for Intersection of inv bounds
#include "Renderer.h" // for setInvalidatedRegions
#include "RunResources.h"

extern int internal_width, internal_height, hw_width, hw_height;
int mouse_mode = 0;
int mouse_x = 0, mouse_y = 0;

using namespace std;

namespace gnash 
{

SDLGui::SDLGui(unsigned long xid, float scale, bool loop, RunResources& r)
 : Gui(xid, scale, loop, r),
   _timeout(0),
   _core_trap(true)
{
}

SDLGui::~SDLGui()
{
}


bool
SDLGui::run()
{
    int x_old = -1;
    int y_old = -1;
    int button_state_old = -1;
    Uint32 movie_time = 0;// SDL_GetTicks(); // what time it should be in the movie
    Uint8 *keystate;




    SDL_Event   event;
    while (true)
    {
        if (_timeout && SDL_GetTicks() >= _timeout)
        {
            break;
        }

	keystate = SDL_GetKeyState(NULL);
		
	if (mouse_mode == 1)
	{
		if (keystate[SDLK_UP]) mouse_y = mouse_y - 4;
		else if (keystate[SDLK_DOWN]) mouse_y = mouse_y + 4;
		if (keystate[SDLK_LEFT])  mouse_x = mouse_x - 4;
		else if (keystate[SDLK_RIGHT]) mouse_x = mouse_x + 4;
			
		if (mouse_x > hw_width) mouse_x = hw_width;
		if (mouse_y > hw_height) mouse_y = hw_height;
		if (mouse_x < 0) mouse_x = 0;
		if (mouse_y < 0) mouse_y = 0;

		x_old = mouse_x * ((float)internal_width / (float)hw_width);
		y_old = mouse_y * ((float)internal_height / (float)hw_height);
		notifyMouseMove(x_old, y_old);
		_glue.render(0,0,0,0);
	}

        while (SDL_PollEvent(&event))
        {
            switch (event.type)
            {
            case SDL_MOUSEMOTION:
				if (mouse_mode == 0)
				{
					mouse_x = event.motion.x * ((float)internal_width / (float)hw_width);
					mouse_y = event.motion.y * ((float)internal_height / (float)hw_height);
					// SDL can generate MOUSEMOTION events even without mouse movement
					if (mouse_x == x_old && mouse_y == y_old) { break; }
					x_old = mouse_x;
					y_old = mouse_y;
					notifyMouseMove(x_old, y_old);
				}
                break;

            case SDL_MOUSEBUTTONDOWN:
            case SDL_MOUSEBUTTONUP:
            {
                if (event.button.state == SDL_PRESSED) {
                    // multiple events will be fired while the mouse is held down
                    // we are interested only in a change in the mouse state:
                    if (event.button.button == button_state_old) { break; }
                    notifyMouseClick(true);
                    button_state_old = event.button.button;
                } else {
                    notifyMouseClick(false);
                    button_state_old = -1;
                }
                break;
            }
            case SDL_KEYDOWN:
            {
				if (mouse_mode == 0)
				{
					if (event.key.keysym.sym == SDLK_TAB)
					{
						mouse_mode = 1;
						mouse_x = hw_width/2;
						mouse_y = hw_height/2;
					}
					else if (event.key.keysym.sym == SDLK_END || event.key.keysym.sym == SDLK_HOME)
					{
						return true;
					}
					else
						key_event(&event.key, true);
				}
				else
				{
					if (event.key.keysym.sym == SDLK_TAB)
					{
						mouse_mode = 0;
					}
					else if (event.key.keysym.sym == SDLK_LCTRL || event.key.keysym.sym == SDLK_BACKSPACE)
					{
						notifyMouseClick(true);
					}
				}
                break;
            }
            case SDL_KEYUP:
            {
				if (mouse_mode == 1)
				{
					if (event.key.keysym.sym == SDLK_LCTRL || event.key.keysym.sym == SDLK_BACKSPACE)
					{
						notifyMouseClick(false);
					}
				}
                key_event(&event.key, false);       
                break;
            }
            case SDL_VIDEORESIZE:
                resize_event();
                break;

            case SDL_VIDEOEXPOSE:
                expose_event();
                break;

            case SDL_QUIT:
                return true;
                break;
            }
        }

        // Wait until real time catches up with movie time.
        int delay = movie_time - SDL_GetTicks();
        if (delay > 0)
        {
            SDL_Delay(delay);
        }

        advanceMovie();
        movie_time += _interval;        // Time next frame should be displayed
    }
    return false;
}


void
SDLGui::setTimeout(unsigned int timeout)
{
    _timeout = timeout;
}

bool
SDLGui::init(int argc, char **argv[])
{

    disableCoreTrap();

    if (_xid) {
        char SDL_windowhack[32];
        snprintf (SDL_windowhack, sizeof(SDL_windowhack), "SDL_WINDOWID=%ld", _xid);
        putenv (SDL_windowhack);
    }

    // Initialize the SDL subsystems we're using. Linux
    // and Darwin use Pthreads for SDL threads, Win32
    // doesn't. Otherwise the SDL event loop just polls.
    if (SDL_Init(SDL_INIT_VIDEO)) {
        fprintf(stderr, "Unable to init SDL: %s\n", SDL_GetError());
        exit(EXIT_FAILURE);
    }

    atexit(SDL_Quit);

    SDL_EnableKeyRepeat(250, 33);

    _glue.init(argc, argv);

    _renderer.reset(_glue.createRenderHandler(32));
    if ( ! _renderer ) return false;

    return true;
}


bool
SDLGui::createWindow(const char *title, int width, int height,
                     int /*xPosition*/, int /*yPosition*/)
{
    _width = width;
    _height = height;

    std::uint32_t sdl_flags = 0;

    if (!_core_trap) {
        sdl_flags |= SDL_INIT_NOPARACHUTE;
    }

    if (_xid) {
        sdl_flags |= SDL_NOFRAME;
    }

    _glue.prepDrawingArea(_width, _height, sdl_flags);

    _runResources.setRenderer(_renderer);

    SDL_WM_SetCaption( title, title);

    return false;
}

void
SDLGui::disableCoreTrap()
{
    _core_trap = false;
}

/* public, overridden */
void
SDLGui::setInvalidatedRegions(const InvalidatedRanges& ranges)
{
    _glue.setInvalidatedRegions(ranges);
}

void
SDLGui::renderBuffer()
{
    _glue.render();
}

void
SDLGui::setInterval(unsigned int interval)
{
    _interval = interval;
}

bool
SDLGui::createMenu()
{
    return false;
}

bool
SDLGui::setupEvents()
{
    return false;
}

#define RS97 1

key::code
SDLGui::sdl_to_gnash_key(SDL_KeyboardEvent * key)
{
  gnash::key::code c(gnash::key::INVALID);
  
  // TODO: take care of CAPS_LOCK and NUM_LOCK and SHIFT
  // int mod = key->keysym.mod;
  int code = key->keysym.sym;

    switch(code) {
#ifdef RS97
		case SDLK_UP:       c = gnash::key::UP;       break;
		case SDLK_DOWN:     c = gnash::key::DOWN;     break;
		case SDLK_RIGHT:    c = gnash::key::RIGHT;    break;
		case SDLK_LEFT:     c = gnash::key::LEFT;     break;
		case SDLK_LCTRL:   c = gnash::key::A;   break;
		case SDLK_LALT:   c = gnash::key::S;   break;
		case SDLK_SPACE:   c = gnash::key::SPACE;   break;
		case SDLK_LSHIFT:   c = gnash::key::SHIFT;   break;
		case SDLK_TAB:   c = gnash::key::X;   break;
		case SDLK_BACKSPACE:   c = gnash::key::ENTER;   break;
		case SDLK_RETURN:   c = gnash::key::ENTER;   break;
		case SDLK_ESCAPE:   c = gnash::key::END;   break;
		case SDLK_HOME:   c = gnash::key::END;   break;
#else
      case SDLK_UP:       c = gnash::key::UP;       break;
      case SDLK_DOWN:     c = gnash::key::DOWN;     break;
      case SDLK_RIGHT:    c = gnash::key::RIGHT;    break;
      case SDLK_LEFT:     c = gnash::key::LEFT;     break;
      case SDLK_INSERT:   c = gnash::key::INSERT;   break;
      case SDLK_HOME:     c = gnash::key::HOME;     break;
      case SDLK_END:      c = gnash::key::END;      break;
      case SDLK_PAGEUP:   c = gnash::key::PGUP;     break;
      case SDLK_PAGEDOWN: c = gnash::key::PGDN;     break;
      case SDLK_RSHIFT:
      case SDLK_LSHIFT:   c = gnash::key::SHIFT;    break;
      case SDLK_RCTRL:
      case SDLK_LCTRL:    c = gnash::key::CONTROL;  break;
      case SDLK_RALT:
      case SDLK_LALT:     c = gnash::key::ALT;      break;
#endif
      default: c = gnash::key::INVALID; break;
    }
	/*if(code>= 32 && code <= 127) 
	{
		c = (gnash::key::code)(code);
	}
	else
	if(code >= SDLK_KP0 && code <= SDLK_KP9) 
	{
		c = (gnash::key::code)(code - SDLK_KP0 + gnash::key::KP_0);
	}
	else if(code >= SDLK_F1 && code <= SDLK_F15)
	{
		c = (gnash::key::code)(code - SDLK_F1 + gnash::key::F1);
	}
	else
	{
		c = gnash::key::INVALID;
	}*/
  

  return c;
}

int 
SDLGui::sdl_to_gnash_modifier(int state)
{
  int modifier = gnash::key::GNASH_MOD_NONE;
  
  if (state & KMOD_SHIFT) {
      modifier = modifier | gnash::key::GNASH_MOD_SHIFT;
    }
    if (state & KMOD_CTRL) {
      modifier = modifier | gnash::key::GNASH_MOD_CONTROL;
    }
    if (state & KMOD_ALT) {
      modifier = modifier | gnash::key::GNASH_MOD_ALT;
    }

    return modifier;
}

void SDLGui::key_event(SDL_KeyboardEvent* key, bool down)
// For forwarding SDL key events.
{
    gnash::key::code c = sdl_to_gnash_key(key);  

    if (c != gnash::key::INVALID)
    {
        int mod = sdl_to_gnash_modifier(key->keysym.mod);

        notify_key_event(c, mod, down);
    }
}

void
SDLGui::resize_event()
{
    log_debug("got resize_event ");
}

void
SDLGui::expose_event()
{
    // TODO: implement and use setInvalidatedRegion instead?
    renderBuffer();
}

} // namespace gnash

