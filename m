From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2017 17:41:54 +0200
Subject: [LTP] [PATCH v4 03/14] m4: Fix libkeyutils detection on 32-bit
	cross build
In-Reply-To: <20171016154205.4814-1-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
Message-ID: <20171016154205.4814-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac          | 1 +
 include/lapi/keyctl.h | 6 ++++--
 m4/ltp-keyutils.m4    | 9 ++++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 78d9da680..2356531cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,6 +32,7 @@ AC_PREFIX_DEFAULT(/opt/ltp)
 
 AC_CHECK_HEADERS([ \
     ifaddrs.h \
+    keyutils.h \
     libaio.h \
     linux/can.h \
     linux/genetlink.h \
diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 07c6a6dce..8e6beac0e 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -19,12 +19,14 @@
 #define KEYCTL_H__
 
 #include "config.h"
-#ifdef HAVE_KEYUTILS_H
+
+#if defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS)
 # include <keyutils.h>
 #else
 # ifdef HAVE_LINUX_KEYCTL_H
 #  include <linux/keyctl.h>
 # endif /* HAVE_LINUX_KEYCTL_H */
+
 # include <stdarg.h>
 # include <stdint.h>
 # include "lapi/syscalls.h"
@@ -63,7 +65,7 @@ static inline long keyctl(int cmd, ...)
 
 	return tst_syscall(__NR_keyctl, cmd, arg2, arg3, arg4, arg5);
 }
-#endif /* HAVE_KEYUTILS_H */
+#endif /* defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS) */
 
 /* special process keyring shortcut IDs */
 #ifndef KEY_SPEC_THREAD_KEYRING
diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
index 74b7d3249..f63c44592 100644
--- a/m4/ltp-keyutils.m4
+++ b/m4/ltp-keyutils.m4
@@ -1,5 +1,7 @@
 dnl
 dnl Copyright (c) 2016 Fujitsu Ltd.
+dnl Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+dnl
 dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 dnl
 dnl This program is free software; you can redistribute it and/or modify it
@@ -18,7 +20,8 @@ dnl
 dnl LTP_CHECK_KEYUTILS_SUPPORT
 dnl ----------------------------
 dnl
-AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT],[
-AC_CHECK_HEADERS([keyutils.h], [keyutils_libs="-lkeyutils"])
-AC_SUBST([KEYUTILS_LIBS], [$keyutils_libs])
+AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
+	AC_CHECK_LIB([keyutils], [add_key],
+	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.]),
+	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
 ])
-- 
2.14.2

