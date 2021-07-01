# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

# something remap

#define timeout for multipurpose_modmap
define_timeout(1)

#[Global modmap] 
define_modmap({
  Key.RIGHT_CTRL: Key.LEFT_ALT,
  Key.RIGHT_ALT: Key.RIGHT_META,
  Key.LEFT_META: Key.LEFT_ALT,
  Key.MUHENKAN: Key.RIGHT_ALT,
  Key.ZENKAKUHANKAKU: Key.ESC,
  Key.KATAKANAHIRAGANA: Key.LEFT_META,
})

define_keymap(None, {
  K("RM-j"): Key.LEFT,
  K("RM-i"): Key.UP,
  K("RM-k"): Key.DOWN,
  K("RM-l"): Key.RIGHT,
  K("RM-m"): Key.HOME,
  K("RM-DOT"): Key.END,
  K("RM-u"): Key.PAGE_UP,
  K("RM-o"): Key.PAGE_DOWN,
  K("RM-COMMA"): Key.KEY_APPSELECT,
  K("Super-RM-j"): K("Super-left"),
  K("Super-RM-i"): K("Super-up"),
  K("Super-RM-k"): K("Super-down"),
  K("Super-RM-l"): K("Super-right"),
  K("RM-LShift-J"): K("Shift-left"),
  K("RM-LShift-i"): K("Shift-up"),
  K("RM-LShift-k"): K("Shift-down"),
  K("RM-LShift-l"): K("Shift-right"),
  K("Shift-RM-m"): K("Shift-home"),
  K("Shift-RM-DOT"): K("Shift-end"),
  K("Shift-RM-u"): K("Shift-page_up"),
  K("Shift-RM-o"): K("Shift-page_down")
},"HHKB-like keys")


