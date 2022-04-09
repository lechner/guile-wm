#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT(guile-wm,1.1)          

AC_CONFIG_AUX_DIR([build_aux])
AM_INIT_AUTOMAKE([gnu std-options])

AC_CONFIG_FILES([
        Makefile
        module/Makefile
])

GUILE_PKG([3.0 2.0 2.2])
GUILE_SITE_DIR
GUILE_PROGS

# Will re-enable this requirement when I can figure out how to do so w/o
# breaking the build

dnl GUILE_MODULE_REQUIRED([xcb xml])
dnl GUILE_MODULE_REQUIRED([xcb xml xproto])
dnl GUILE_MODULE_REQUIRED([xcb xml struct])
dnl GUILE_MODULE_REQUIRED([xcb xml ext randr])
dnl GUILE_MODULE_REQUIRED([xcb event-loop])

AC_ARG_WITH([guile-site-dir],
        [AS_HELP_STRING([--with-guile-site-dir],
            [use the specified installation path for Guile modules]
        )],
        [guilesitedir="$withval"],
        [guilesitedir="$GUILE_SITE"]
)

AC_SUBST([guilesitedir])
AC_MSG_RESULT($guilesitedir)

AC_OUTPUT
