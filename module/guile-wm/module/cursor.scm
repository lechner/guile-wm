;; This file is part of Guile-WM.

;;    Guile-WM is free software: you can redistribute it and/or modify
;;    it under the terms of the GNU General Public License as published by
;;    the Free Software Foundation, either version 3 of the License, or
;;    (at your option) any later version.

;;    Guile-WM is distributed in the hope that it will be useful,
;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;    GNU General Public License for more details.

;;    You should have received a copy of the GNU General Public License
;;    along with Guile-WM.  If not, see <http://www.gnu.org/licenses/>.

(define-module (guile-wm module cursor)
  #:use-module (guile-wm shared)
  #:use-module (guile-wm log)
  #:use-module (guile-wm draw)
  #:use-module (guile-wm command)
  #:use-module (xcb event-loop)
  #:use-module (xcb xml)
  #:use-module (xcb xml xproto))

(define-public x-cursors
  '((x-cursor . 0)
    (arrow . 2)
    (based-arrow-down . 4)
    (based-arrow-up . 6)
    (boat . 8)
    (bogosity . 10)
    (bottom-left-corner . 12)
    (bottom-right-corner . 14)
    (bottom-side . 16)
    (bottom-tee . 18)
    (box-spiral . 20)
    (center-ptr . 22)
    (circle . 24)
    (clock . 26)
    (coffee-mug . 28)
    (cross . 30)
    (cross-reverse . 32)
    (crosshair . 34)
    (diamond-cross . 36)
    (dot . 38)
    (dotbox . 40)
    (double-arrow . 42)
    (draft-large . 44)
    (draft-small . 46)
    (draped-box . 48)
    (exchange . 50)
    (fleur . 52)
    (gobbler . 54)
    (gumby . 56)
    (hand1 . 58)
    (hand2 . 60)
    (heart . 62)
    (icon . 64)
    (iron-cross . 66)
    (left-ptr . 68)
    (left-side . 70)
    (left-tee . 72)
    (leftbutton . 74)
    (ll-angle . 76)
    (lr-angle . 78)
    (man . 80)
    (middlebutton . 82)
    (mouse . 84)
    (pencil . 86)
    (pirate . 88)
    (plus . 90)
    (question-arrow . 92)
    (right-ptr . 94)
    (right-side . 96)
    (right-tee . 98)
    (rightbutton . 100)
    (rtl-logo . 102)
    (sailboat . 104)
    (sb-down-arrow . 106)
    (sb-h-double-arrow . 108)
    (sb-left-arrow . 110)
    (sb-right-arrow . 112)
    (sb-up-arrow . 114)
    (sb-v-double-arrow . 116)
    (shuttle . 118)
    (sizing . 120)
    (spider . 122)
    (spraycan . 124)
    (star . 126)
    (target . 128)
    (tcross . 130)
    (top-left-arrow . 132)
    (top-left-corner . 134)
    (top-right-corner . 136)
    (top-side . 138)
    (top-tee . 140)
    (trek . 142)
    (ul-angle . 144)
    (umbrella . 146)
    (ur-angle . 148)
    (watch . 150)
    (xterm . 152)))

(define-public (make-cursor glyph)
  (define cursor (make-new-xid xcursor))
  (define glyph-num (assq-ref x-cursors glyph))
  (with-font ("cursor" font)
    (create-glyph-cursor
     cursor font font glyph-num (+ 1 glyph-num) 0 0 0 #xFFFF #xFFFF #xFFFF))
  cursor)

(define-command (set-cursor! (cursor #:symbol))
  (change-window-attributes (current-root) #:cursor (make-cursor cursor)))
