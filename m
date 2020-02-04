From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  4 Feb 2020 16:24:28 +0100
Subject: [LTP] [RFC PATCH v2 2/4] rpc: Fix build under glibc only TI-RPC
 implementation
In-Reply-To: <20200204152430.10935-1-pvorel@suse.cz>
References: <20200204152430.10935-1-pvorel@suse.cz>
Message-ID: <20200204152430.10935-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and keep basic rpc tests when there are glibc RPC headers (glibc build
with --enable-obsolete-rpc).

Motivation for it is that nfs-utils allows compiling with glibc headers
only. We still need to restrict TI-RPC tests (testcases/network/rpc/rpc-tirpc/)
to libtirpc tests as they use libtirpc only API (svc_reg, svc_unreg,
pmap_unset, clnt_dg_create).

NOTE: IMHO from long term perspective these tests should be cleaned and
moved to upstream (libtirpc and ntirpc) and glibc testing probably
abandoned.

Fixes: 7fe1a8bf8 ("rpc: Use libtirpc for all RPC tests + detect headers location")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/mk/config.mk.in                       |  1 +
 m4/ltp-tirpc.m4                               | 14 ++++++++++
 testcases/network/Makefile                    | 24 +++--------------
 .../rpc/basic_tests/rpc01/rpc_server.c        |  2 +-
 .../network/rpc/rpc-tirpc/tests_pack/Makefile | 26 +++++++------------
 .../rpc/rpc-tirpc/tests_pack/include/rpc.h    |  6 +++++
 .../rpc/rpc-tirpc/tests_pack/rpc_cleaner.c    |  2 +-
 .../tests_pack/rpc_suite/rpc/Makefile         | 25 ++++++------------
 .../rpc_pmap_getport.c                        |  2 +-
 .../rpc_pmap_rmtcall.c                        |  2 +-
 .../rpc_pmap_rmtcall_performance.c            |  2 +-
 .../rpc_pmap_rmtcall_stress.c                 |  2 +-
 .../rpc_addrmanagmt_pmap_set/rpc_pmap_set.c   |  2 +-
 .../rpc_pmap_unset.c                          |  2 +-
 .../rpc_clnt_broadcast.c                      |  2 +-
 .../rpc_clnt_broadcast_complex.c              |  3 +--
 .../rpc_clnt_broadcast_dataint.c              |  2 +-
 .../rpc_clnt_broadcast_performance.c          |  2 +-
 .../rpc_clnt_broadcast_scalability.c          |  2 +-
 .../rpc_clnt_broadcast_stress.c               |  2 +-
 .../rpc_registerrpc.c                         |  2 +-
 .../rpc_svc_register.c                        |  2 +-
 .../rpc_svc_unregister.c                      |  2 +-
 .../rpc_svc_freeargs_svc.c                    |  2 +-
 .../rpc_stdcall_svc_getargs/rpc_svc_getargs.c |  2 +-
 .../rpc_svc_sendreply.c                       |  2 +-
 .../tests_pack/rpc_svc_1/rpc_svc_1.c          |  2 +-
 .../tests_pack/rpc_svc_2/rpc_svc_2.c          |  2 +-
 28 files changed, 63 insertions(+), 78 deletions(-)

diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 99e62f848..5526cfea1 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -38,6 +38,7 @@ CRYPTO_LIBS		:= @CRYPTO_LIBS@
 LEXLIB			:= @LEXLIB@
 NUMA_LIBS		:= @NUMA_LIBS@
 SELINUX_LIBS		:= @SELINUX_LIBS@
+HAVE_RPC		:= @HAVE_RPC@
 TIRPC_CFLAGS		:= @TIRPC_CFLAGS@
 TIRPC_LIBS		:= @TIRPC_LIBS@
 KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
diff --git a/m4/ltp-tirpc.m4 b/m4/ltp-tirpc.m4
index 61121efdd..2878c5b4a 100644
--- a/m4/ltp-tirpc.m4
+++ b/m4/ltp-tirpc.m4
@@ -5,10 +5,24 @@ dnl Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
 AC_DEFUN([LTP_CHECK_TIRPC], [
 	dnl libtirpc library and headers
 	PKG_CHECK_MODULES([LIBTIRPC], [libtirpc], [
+		have_libtirpc=yes
 		TIRPC_CFLAGS=$LIBTIRPC_CFLAGS
 		TIRPC_LIBS=$LIBTIRPC_LIBS
 	], [have_libtirpc=no])
 
+	dnl TI-RPC headers (in glibc, since 2.26 installed only when configured
+	dnl with --enable-obsolete-rpc)
+	dnl NOTE: To port tests for ntirpc would require use non-deprecated
+	dnl functions as it does not have the deprecated ones any more (e.g. use
+	dnl rpc_broadcast() instead of clnt_broadcast()), but glibc implementation
+	dnl does not have the new ones. We could either provide the deprecated
+	dnl functions (copy from libtirpc src/rpc_soc.c) or drop glibc tests.
+	AC_CHECK_HEADERS([rpc/rpc.h], [have_rpc_headers=yes])
+
+	if test "x$have_libtirpc" = "xyes" -o "x$have_rpc_headers" = "xyes"; then
+		AC_SUBST(HAVE_RPC, 1)
+	fi
+
 	dnl fix for old pkg-config (< 0.24)
 	dnl https://autotools.io/pkgconfig/pkg_check_modules.html
 	AC_SUBST(TIRPC_CFLAGS)
diff --git a/testcases/network/Makefile b/testcases/network/Makefile
index f7097e164..7b42614ba 100644
--- a/testcases/network/Makefile
+++ b/testcases/network/Makefile
@@ -1,24 +1,6 @@
-#
-#    network test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# Copyright (C) 2009, Cisco Systems Inc.
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 # Ngie Cooper, July 2009
-#
 
 top_srcdir		?= ../..
 
@@ -39,7 +21,7 @@ ifeq ($(ANDROID),1)
 FILTER_OUT_DIRS		+= lib6 rpc sockets
 endif
 
-ifeq ($(TIRPC_LIBS),)
+ifeq ($(HAVE_RPC),)
 FILTER_OUT_DIRS		+= rpc
 endif
 
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
index 21a45ffeb..383c3d132 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
@@ -6,7 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 #include "librpc01.h"
 
 int debug = 0;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
index 42d111f9b..8b29a192d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
@@ -1,20 +1,5 @@
-#
-#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 
 top_srcdir		?= ../../../../..
 
@@ -24,6 +9,13 @@ LIBDIR			:= lib
 FILTER_OUT_DIRS		:= $(LIBDIR)
 LIB			:= $(LIBDIR)/librpc-tirpc.a
 
+# keep only rpc_*
+ifeq ($(TIRPC_LIBS),)
+FILTER_OUT_MAKE_TARGETS	+= tirpc_cleaner
+FILTER_OUT_DIRS	+= tirpc_svc_1 tirpc_svc_2 tirpc_svc_3 tirpc_svc_4 tirpc_svc_5 tirpc_svc_6 tirpc_svc_7 tirpc_svc_8 tirpc_svc_9 tirpc_svc_11
+endif
+
+
 $(LIBDIR):
 	mkdir -p "$@"
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h b/testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h
index 7cb999658..b6db0d316 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h
@@ -13,4 +13,10 @@
 #include <rpc/xdr.h>
 #include <rpc/svc.h>
 
+/*
+ * For pmap_unset() and clnt_broadcast().
+ * Needed for glibc, which does not include <rpc/pmap_clnt.h> in <rpc/rpc.h>.
+ */
+#include <rpc/pmap_clnt.h>
+
 #endif	/* RPC_H__ */
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_cleaner.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_cleaner.c
index e17430fb4..9ce603672 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_cleaner.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_cleaner.c
@@ -18,7 +18,7 @@
  */
 
 #include <stdio.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 #define VERSNUM 1 /* Default version used in the test binaries */
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile
index 45bc8a67a..0cbf4e504 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile
@@ -1,22 +1,13 @@
-#
-#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 
 top_srcdir		?= ../../../../../../..
 
+ifeq ($(TIRPC_LIBS),)
+# glibc does not define registerrpc() in <rpc/rpc.h>
+# registerrpc() is deprecated in libtirpc, it should be replaced by rpc_reg()
+FILTER_OUT_DIRS	+= rpc_regunreg_registerrpc
+endif
+
 include	$(top_srcdir)/include/mk/env_pre.mk
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/rpc_pmap_getport.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/rpc_pmap_getport.c
index 67f1e6e02..fa51f899a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/rpc_pmap_getport.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/rpc_pmap_getport.c
@@ -29,8 +29,8 @@
 #include <stdio.h>
 #include <rpc/rpc.h>
 #include <netinet/in.h>
-#include <rpc/pmap_clnt.h>
 #include <netdb.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
index e98a76b09..91f51701c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
@@ -27,9 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <rpc/rpc.h>
 #include <errno.h>
 #include <netdb.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_performance.c
index 80952618f..be4c26754 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_performance.c
@@ -28,9 +28,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <rpc/rpc.h>
 #include <errno.h>
 #include <netdb.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_stress.c
index 4d19b7f56..fe3cf68ac 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_stress.c
@@ -27,9 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <rpc/rpc.h>
 #include <errno.h>
 #include <netdb.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/rpc_pmap_set.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/rpc_pmap_set.c
index 4601154d7..01e75e5ed 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/rpc_pmap_set.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/rpc_pmap_set.c
@@ -27,7 +27,7 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/rpc_pmap_unset.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/rpc_pmap_unset.c
index 1f71f67de..535742ef3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/rpc_pmap_unset.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/rpc_pmap_unset.c
@@ -27,7 +27,7 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast.c
index e4b9efe45..5f024f113 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_complex.c
index 348df868e..c6e55cd81 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_complex.c
@@ -28,10 +28,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <rpc/rpc.h>
 #include <sys/socket.h>
 #include <netdb.h>
-#include <rpc/pmap_clnt.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c
index 17b960651..fdf1e31a2 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define INTPROCNUM 1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_performance.c
index d958149b6..11ba64fab 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_scalability.c
index 89646aa9d..57ea25349 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_scalability.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_stress.c
index da85b86ea..d5d7d85d1 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_stress.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
index 3778f36bc..3becf4600 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
@@ -28,10 +28,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <utmp.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register.c
index 99129cf7d..4b1331b82 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register.c
@@ -28,9 +28,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister.c
index 8f0b6de68..0e7145a6f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister.c
@@ -28,9 +28,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc.c
index cdec0c081..68c84ac60 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c
index c4860a500..4d52fe4d3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c
index e32582364..342476de9 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include <rpc/rpc.h>
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/rpc_svc_1.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/rpc_svc_1.c
index 275774923..d1c4df97f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/rpc_svc_1.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/rpc_svc_1.c
@@ -27,8 +27,8 @@
 
 #include <stdio.h>
 #include <string.h>
-#include <rpc/rpc.h>
 #include <utmp.h>
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/rpc_svc_2.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/rpc_svc_2.c
index a2d18cc43..66a8444b2 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/rpc_svc_2.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/rpc_svc_2.c
@@ -27,8 +27,8 @@
 
 #include <stdio.h>
 #include <string.h>
-#include <rpc/rpc.h>
 #include <utmp.h>
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
-- 
2.24.1

