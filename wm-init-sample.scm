;; -*- scheme -*-

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

;;; Sample user init file for Guile-WM

;; You can include built-in modules using this shorthand syntax. Each
;; line that contains a comment and the prefix "wm-modules:" will be
;; read as a list of modules to load from (guile-wm module ...)

;; wm-modules: cursor root-keymap
;; wm-modules: minibuffer repl randr fullscreen 
;; wm-modules: menu message window-menu time simple-reparent
;; wm-modules: simple-focus window-cycle tinywm
;; wm-modules: tiling

;; Command helpers
(define-command (emacs) (shell-command "emacs"))
(define-command (conkeror) (shell-command "firefox"))

;; Multi-monitor setup.
;; (set-resolution! "VGA-0" 1680 1050)
;; (set-resolution! "DVI-0" 1920 1200)
;; (set-offset! "DVI-0" 1680 0)

;; Root key binding
;; Default root key is C-t
(shell-command "xmodmap -e 'clear mod4'")
(shell-command "xmodmap -e 'clear mod5'")
(shell-command "xmodmap -e 'keycode 133 = F20'")
(set! (root-key) 'F20)

;; simple-focus simply draws a thin border around the focused window

;; Color of window border when focused/unfocused
(set! (simple-focus-color) 'light-steel-blue)
(set! (simple-unfocus-color) 'black)

;; Set the cursor and the keymap cursor
(set-cursor! 'x-cursor)
(set! (keymap-cursor) 'draped-box)

;; Set fonts
(let ((terminus "-xos4-terminus-medium-r-normal--12*"))
  (set! minibuffer-font terminus)
  (set! menu-font terminus)
  (set! message-font terminus))

;; Start repl server on the default port
(start-wm-repl)

;; Root keymap
(bind-key-commands root-keymap prompt-for-additional-arg
  (semicolon "prompt-for-command")
  (colon "prompt-for-eval")
  (bang "prompt-for-shell-command")
  (C-q "quit")
  (f "firefox")
  (F "fullscreen")
  (e "emacs")
  (w "select-window")
  (T "show-time")
  (n "window-cycle")
  (tab "visible-window-cycle")
  (c "shell-command xterm -e telnet localhost 37146")
  (t "shell-command alacritty"))

;; Startup programs
(shell-command "emacs")
(shell-command (format #f "xterm -e 'tail /tmp/guile-wm.log -f'"))
