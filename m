From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  6 Sep 2017 15:16:59 +0200
Subject: [LTP] [PATCH 1/1] configure: Remove checks for unused headers
Message-ID: <20170906131659.6223-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

dmapi.h and sys/jfsdmapi.h were both added in ef7725396 (in 2009)

dmapi.h was never used, sys/jfsdmapi.h was used in
testcases/kernel/fs/dmapi/dm_test.h, which was removed in
80c8fac51 ("testcases: Remove dmapi")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac             | 2 --
 include/config.h.default | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 23e583dd8..458a5b13f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -31,7 +31,6 @@ AC_PROG_YACC
 AC_PREFIX_DEFAULT(/opt/ltp)
 
 AC_CHECK_HEADERS([ \
-    dmapi.h \
     ifaddrs.h \
     libaio.h \
     mm.h \
@@ -44,7 +43,6 @@ AC_CHECK_HEADERS([ \
     sys/epoll.h \
     sys/inotify.h \
     sys/fanotify.h \
-    sys/jfsdmapi.h \
     sys/prctl.h \
 ])
 
diff --git a/include/config.h.default b/include/config.h.default
index dc38e5cc0..ef6a3d55f 100644
--- a/include/config.h.default
+++ b/include/config.h.default
@@ -77,9 +77,6 @@
    you don't. */
 #undef HAVE_DECL_PTRACE_SETOPTIONS
 
-/* Define to 1 if you have the <dmapi.h> header file. */
-#undef HAVE_DMAPI_H
-
 /* Define to 1 if you have the <ifaddrs.h> header file. */
 #define HAVE_IFADDRS_H 1
 
@@ -200,9 +197,6 @@
 /* Define to 1 if you have the <sys/inotify.h> header file. */
 #define HAVE_SYS_INOTIFY_H 1
 
-/* Define to 1 if you have the <sys/jfsdmapi.h> header file. */
-#undef HAVE_SYS_JFSDMAPI_H
-
 /* Define to 1 if you have the <sys/prctl.h> header file. */
 #undef HAVE_SYS_PRCTL_H
 
-- 
2.14.0

