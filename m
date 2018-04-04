From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 4 Apr 2018 16:52:19 +0800
Subject: [LTP] [PATCH] sctp/sctp_big_chunk.c: Fix compiler error
Message-ID: <1522831939-31257-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On old distros(e.g. RHEL5), Compilation failed because of redefinitions
from linux/sctp.h(including linux/in.h) and netinet/in.h, as below:
----------------------------------------------------------------------
In file included from /usr/include/linux/sctp.h:54,
                 from ../../../include/lapi/sctp.h:22,
                 from sctp_big_chunk.c:35:
/usr/include/linux/in.h:26: error: redeclaration of enumerator ‘IPPROTO_IP’
/usr/include/netinet/in.h:33: error: previous definition of ‘IPPROTO_IP’ was here
...
----------------------------------------------------------------------

1) There was a existed netinet/sctp.h based on lksctp-tools-devel package
   in LTP, so we used netinet/sctp.h to fix it as the sctp tests did.
2) We removed lapi/sctp.h and duplicated SOL_SCTP in lapi/socket.h.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac                            |  1 -
 include/lapi/sctp.h                     | 29 -----------------------------
 include/lapi/socket.h                   |  4 ----
 testcases/network/sctp/Makefile         |  2 ++
 testcases/network/sctp/sctp_big_chunk.c |  2 +-
 5 files changed, 3 insertions(+), 35 deletions(-)
 delete mode 100644 include/lapi/sctp.h

diff --git a/configure.ac b/configure.ac
index 9358064..1721ff2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -44,7 +44,6 @@ AC_CHECK_HEADERS([ \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
-    linux/sctp.h \
     mm.h \
     pthread.h \
     sys/epoll.h \
diff --git a/include/lapi/sctp.h b/include/lapi/sctp.h
deleted file mode 100644
index 69adc7a..0000000
--- a/include/lapi/sctp.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (c) 2018 Oracle and/or its affiliates.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef LAPI_SCTP_H__
-#define LAPI_SCTP_H__
-
-#ifdef HAVE_LINUX_SCTP_H
-# include <linux/sctp.h>
-#endif
-
-#ifndef SCTP_SOCKOPT_BINDX_ADD
-# define SCTP_SOCKOPT_BINDX_ADD	100
-#endif
-
-#endif	/* LAPI_SCTP_H__ */
diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index d58c460..426906f 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -45,10 +45,6 @@
 # define SOCK_CLOEXEC 02000000
 #endif
 
-#ifndef SOL_SCTP
-# define SOL_SCTP	132
-#endif
-
 #ifndef SOL_UDPLITE
 # define SOL_UDPLITE		136 /* UDP-Lite (RFC 3828) */
 #endif
diff --git a/testcases/network/sctp/Makefile b/testcases/network/sctp/Makefile
index 0fa9125..ac4a99a 100644
--- a/testcases/network/sctp/Makefile
+++ b/testcases/network/sctp/Makefile
@@ -17,6 +17,8 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CPPFLAGS		+= -I$(top_srcdir)/utils/sctp/include
+
 INSTALL_TARGETS		:= sctp01.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index 55a2969..d3288ee 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -32,7 +32,7 @@
 #include "tst_safe_stdio.h"
 #include "lapi/netinet_in.h"
 #include "lapi/socket.h"
-#include "lapi/sctp.h"
+#include "netinet/sctp.h"
 
 static int port;
 static int sfd, cfd;
-- 
1.8.3.1



