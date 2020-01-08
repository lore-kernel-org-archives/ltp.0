From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Jan 2020 11:34:10 +0100
Subject: [LTP] [PATCH 1/4] rpc-tirpc: Detect libtirpc with pkg-config
In-Reply-To: <20200108103413.29096-1-pvorel@suse.cz>
References: <20200108103413.29096-1-pvorel@suse.cz>
Message-ID: <20200108103413.29096-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using pkg-config is more reliable way than detecting presence of
libtirpc shared library with headers. As it does not require use $SYSROOT,
which is not defined everywhere (at least SDKs built in YOCTO as they
use nonstandard $SDKTARGETSYSROOT, see [1]).
Fixes: a86d71fe5 ("Implemented autoconf check for libtirpc")

+ use only <rpc/*.h> includes, <tirpc/rpc/*.h> removed as not needed
(pkg-config detects -I/usr/include/tirpc when needed). Therefore rpc.h
moved out of lapi.
Fixes: 7fe1a8bf8 ("rpc: Use libtirpc for all RPC tests + detect headers location")

+ use CFLAGS instead of CPPFLAGS in
testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc (C source).

[1] https://github.com/linux-test-project/ltp/pull/628

Closes: #628

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/rpc.h                            | 27 -------------------
 include/mk/config.mk.in                       |  4 +--
 m4/ltp-tirpc.m4                               | 18 ++++++-------
 testcases/network/Makefile                    |  2 +-
 .../rpc/rpc-tirpc/tests_pack/Makefile.inc     |  4 +--
 .../rpc/rpc-tirpc/tests_pack/include/rpc.h    | 17 ++++++++++++
 .../rpc_clnt_call_complex.c                   |  2 +-
 .../tirpc_rpcb_getaddr.c                      |  2 +-
 .../tirpc_rpcb_getaddr_limits.c               |  2 +-
 .../tirpc_rpcb_getmaps.c                      |  2 +-
 .../tirpc_authdes_create.c                    |  2 +-
 .../tirpc_authdes_seccreate.c                 |  2 +-
 .../tirpc_authnone_create.c                   |  2 +-
 .../tirpc_authsys_create.c                    |  2 +-
 .../tirpc_authsys_create_default.c            |  2 +-
 .../tirpc_bottomlevel_clnt_call.c             |  2 +-
 .../tirpc_bottomlevel_clnt_call_complex.c     |  2 +-
 .../tirpc_bottomlevel_clnt_call_dataint.c     |  2 +-
 .../tirpc_bottomlevel_clnt_call_mt.c          |  2 +-
 .../tirpc_bottomlevel_clnt_call_performance.c |  2 +-
 .../tirpc_bottomlevel_clnt_call_scalability.c |  2 +-
 .../tirpc_bottomlevel_clnt_call_stress.c      |  2 +-
 .../tirpc_clnt_dg_create.c                    |  2 +-
 .../tirpc_clnt_dg_create_limits.c             |  2 +-
 .../tirpc_clnt_vc_create.c                    |  2 +-
 .../tirpc_clnt_vc_create_limits.c             |  2 +-
 .../tirpc_svc_dg_create.c                     |  2 +-
 .../tirpc_svc_dg_create_limits.c              |  2 +-
 .../tirpc_svc_vc_create.c                     |  2 +-
 .../tirpc_svc_vc_create_limits.c              |  2 +-
 .../tirpc_clnt_pcreateerror.c                 |  2 +-
 .../tirpc_err_clnt_perrno/tirpc_clnt_perrno.c |  2 +-
 .../tirpc_clnt_perrno_complex.c               |  2 +-
 .../tirpc_err_clnt_perror/tirpc_clnt_perror.c |  2 +-
 .../tirpc_clnt_perror_complex.c               |  2 +-
 .../tirpc_svcerr_noproc.c                     |  2 +-
 .../tirpc_svcerr_noprog.c                     |  2 +-
 .../tirpc_svcerr_progvers.c                   |  2 +-
 .../tirpc_svcerr_systemerr.c                  |  2 +-
 .../tirpc_svcerr_weakauth.c                   |  2 +-
 .../tirpc_expertlevel_clnt_call.c             |  2 +-
 .../tirpc_expertlevel_clnt_call_complex.c     |  2 +-
 .../tirpc_expertlevel_clnt_call_dataint.c     |  2 +-
 .../tirpc_expertlevel_clnt_call_mt.c          |  2 +-
 .../tirpc_expertlevel_clnt_call_performance.c |  2 +-
 .../tirpc_expertlevel_clnt_call_scalability.c |  2 +-
 .../tirpc_expertlevel_clnt_call_stress.c      |  2 +-
 .../tirpc_clnt_tli_create.c                   |  2 +-
 .../tirpc_clnt_tli_create_limits.c            |  2 +-
 .../tirpc_rpcb_rmtcall.c                      |  2 +-
 .../tirpc_rpcb_rmtcall_complex.c              |  2 +-
 .../tirpc_rpcb_rmtcall_dataint.c              |  2 +-
 .../tirpc_rpcb_rmtcall_mt.c                   |  2 +-
 .../tirpc_rpcb_rmtcall_performance.c          |  2 +-
 .../tirpc_rpcb_rmtcall_scalability.c          |  2 +-
 .../tirpc_rpcb_rmtcall_stress.c               |  2 +-
 .../tirpc_rpcb_set.c                          |  2 +-
 .../tirpc_rpcb_unset.c                        |  2 +-
 .../tirpc_expertlevel_svc_reg/tirpc_svc_reg.c |  2 +-
 .../tirpc_svc_reg_mt.c                        |  2 +-
 .../tirpc_svc_reg_stress.c                    |  2 +-
 .../tirpc_svc_tli_create.c                    |  2 +-
 .../tirpc_svc_tli_create_limits.c             |  2 +-
 .../tirpc_svc_unreg.c                         |  2 +-
 .../tirpc_svc_unreg_mt.c                      |  2 +-
 .../tirpc_svc_unreg_stress.c                  |  2 +-
 .../tirpc_interlevel_clnt_call.c              |  2 +-
 .../tirpc_interlevel_clnt_call_complex.c      |  2 +-
 .../tirpc_interlevel_clnt_call_dataint.c      |  2 +-
 .../tirpc_interlevel_clnt_call_mt.c           |  2 +-
 .../tirpc_interlevel_clnt_call_performance.c  |  2 +-
 .../tirpc_interlevel_clnt_call_scalability.c  |  2 +-
 .../tirpc_interlevel_clnt_call_stress.c       |  2 +-
 .../tirpc_clnt_control.c                      |  2 +-
 .../tirpc_clnt_control_limits.c               |  2 +-
 .../tirpc_clnt_tp_create.c                    |  2 +-
 .../tirpc_clnt_tp_create_timed.c              |  2 +-
 .../tirpc_clnt_tp_create_timed_limits.c       |  2 +-
 .../tirpc_svc_tp_create.c                     |  2 +-
 .../tirpc_rpc_broadcast.c                     |  2 +-
 .../tirpc_rpc_broadcast_complex.c             |  2 +-
 .../tirpc_rpc_broadcast_dataint.c             |  2 +-
 .../tirpc_rpc_broadcast_mt.c                  |  2 +-
 .../tirpc_rpc_broadcast_performance.c         |  2 +-
 .../tirpc_rpc_broadcast_scalability.c         |  2 +-
 .../tirpc_rpc_broadcast_stress.c              |  2 +-
 .../tirpc_rpc_broadcast_exp.c                 |  2 +-
 .../tirpc_rpc_broadcast_exp_complex.c         |  2 +-
 .../tirpc_rpc_broadcast_exp_dataint.c         |  2 +-
 .../tirpc_rpc_broadcast_exp_limits.c          |  2 +-
 .../tirpc_rpc_broadcast_exp_mt.c              |  2 +-
 .../tirpc_rpc_broadcast_exp_performance.c     |  2 +-
 .../tirpc_rpc_broadcast_exp_scalability.c     |  2 +-
 .../tirpc_rpc_broadcast_exp_stress.c          |  2 +-
 .../tirpc_simple_rpc_call/tirpc_rpc_call.c    |  2 +-
 .../tirpc_rpc_call_complex.c                  |  2 +-
 .../tirpc_rpc_call_dataint.c                  |  2 +-
 .../tirpc_simple_rpc_call/tirpc_rpc_call_mt.c |  2 +-
 .../tirpc_rpc_call_performance.c              |  2 +-
 .../tirpc_rpc_call_scalability.c              |  2 +-
 .../tirpc_rpc_call_stress.c                   |  2 +-
 .../tirpc_simple_rpc_reg/tirpc_rpc_reg.c      |  2 +-
 .../tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c   |  2 +-
 .../tirpc_rpc_reg_stress.c                    |  2 +-
 .../tirpc_toplevel_clnt_call.c                |  2 +-
 .../tirpc_toplevel_clnt_call_complex.c        |  2 +-
 .../tirpc_toplevel_clnt_call_dataint.c        |  2 +-
 .../tirpc_toplevel_clnt_call_mt.c             |  2 +-
 .../tirpc_toplevel_clnt_call_performance.c    |  2 +-
 .../tirpc_toplevel_clnt_call_scalability.c    |  2 +-
 .../tirpc_toplevel_clnt_call_stress.c         |  2 +-
 .../tirpc_clnt_create.c                       |  2 +-
 .../tirpc_clnt_create_timed.c                 |  2 +-
 .../tirpc_clnt_create_timed_limits.c          |  2 +-
 .../tirpc_clnt_destroy.c                      |  2 +-
 .../tirpc_svc_create.c                        |  2 +-
 .../tirpc_svc_destroy.c                       |  2 +-
 .../rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c  |  2 +-
 .../tests_pack/tirpc_svc_1/tirpc_svc_1.c      |  2 +-
 .../tests_pack/tirpc_svc_11/tirpc_svc_11.c    |  2 +-
 .../tests_pack/tirpc_svc_2/tirpc_svc_2.c      |  2 +-
 .../tests_pack/tirpc_svc_3/tirpc_svc_3.c      |  2 +-
 .../tests_pack/tirpc_svc_4/tirpc_svc_4.c      |  2 +-
 .../tests_pack/tirpc_svc_5/tirpc_svc_5.c      |  2 +-
 .../tests_pack/tirpc_svc_6/tirpc_svc_6.c      |  2 +-
 .../tests_pack/tirpc_svc_7/tirpc_svc_7.c      |  2 +-
 .../tests_pack/tirpc_svc_8/tirpc_svc_8.c      |  2 +-
 .../tests_pack/tirpc_svc_9/tirpc_svc_9.c      |  2 +-
 travis/debian.cross-compile.aarch64.sh        |  8 ++++--
 travis/debian.cross-compile.ppc64le.sh        |  8 ++++--
 travis/debian.i386.sh                         |  5 ++--
 travis/debian.sh                              |  5 ++--
 travis/fedora.sh                              |  5 +++-
 travis/tumbleweed.sh                          |  5 ++--
 134 files changed, 178 insertions(+), 174 deletions(-)
 delete mode 100644 include/lapi/rpc.h
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h

diff --git a/include/lapi/rpc.h b/include/lapi/rpc.h
deleted file mode 100644
index c20a95beb..000000000
--- a/include/lapi/rpc.h
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
- */
-
-#ifndef LAPI_RPC_H__
-#define LAPI_RPC_H__
-
-#include "config.h"
-
-#ifdef HAVE_NETCONFIG_H
-# include <netconfig.h>
-# include <rpc/rpc.h>
-# include <rpc/types.h>
-# include <rpc/xdr.h>
-# include <rpc/svc.h>
-#elif defined(HAVE_TIRPC_NETCONFIG_H)
-# include <tirpc/netconfig.h>
-# include <tirpc/rpc/rpc.h>
-# include <tirpc/rpc/types.h>
-# include <tirpc/rpc/xdr.h>
-# include <tirpc/rpc/svc.h>
-#else
-# error Missing rpc headers!
-#endif
-
-#endif	/* LAPI_RPC_H__ */
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 0bc59887a..0be478de4 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -43,8 +43,8 @@ CRYPTO_LIBS		:= @CRYPTO_LIBS@
 LEXLIB			:= @LEXLIB@
 NUMA_LIBS		:= @NUMA_LIBS@
 SELINUX_LIBS		:= @SELINUX_LIBS@
-TIRPC_CPPFLAGS		:= @TIRPC_CPPFLAGS@
-TIRPC_LIBS		:= @TIRPC_LIBS@
+LIBTIRPC_CPPFLAGS	:= @LIBTIRPC_CPPFLAGS@
+LIBTIRPC_LIBS		:= @LIBTIRPC_LIBS@
 KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
 HAVE_FTS_H		:= @HAVE_FTS_H@
 
diff --git a/m4/ltp-tirpc.m4 b/m4/ltp-tirpc.m4
index baa5239dc..3f23b1a17 100644
--- a/m4/ltp-tirpc.m4
+++ b/m4/ltp-tirpc.m4
@@ -1,15 +1,15 @@
 dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 dnl Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
 
-AC_DEFUN([LTP_CHECK_TIRPC],[
-	TIRPC_CPPFLAGS=""
-	TIRPC_LIBS=""
+AC_DEFUN([LTP_CHECK_TIRPC], [
+	dnl libtirpc library and headers
+	PKG_CHECK_MODULES([LIBTIRPC], [libtirpc], [have_libtirpc=yes], [have_libtirpc=no])
 
-	AC_CHECK_HEADERS([tirpc/netconfig.h netconfig.h], [
-		TIRPC_CPPFLAGS="-I${SYSROOT}/usr/include/tirpc"
-		AC_DEFINE(HAVE_LIBTIRPC, 1, [Define to 1 if you have libtirpc headers installed])
-		AC_CHECK_LIB(tirpc, rpcb_set, [TIRPC_LIBS="-ltirpc"])])
+	dnl TI-RPC headers (in glibc, since 2.26 installed only when configured with --enable-obsolete-rpc)
+	AC_CHECK_HEADERS([rpc/rpc.h], [have_rpc_headers=yes])
 
-	AC_SUBST(TIRPC_CPPFLAGS)
-	AC_SUBST(TIRPC_LIBS)
+	if test "x$have_libtirpc" = "xyes" -o "x$have_rpc_headers" = "xyes"; then
+		AC_DEFINE([HAVE_TIRPC], [1], [Define to 1 if you have libtirpc library and headers or glibc with TI-RPC support])
+	fi
 ])
diff --git a/testcases/network/Makefile b/testcases/network/Makefile
index f7097e164..71e0ae6b3 100644
--- a/testcases/network/Makefile
+++ b/testcases/network/Makefile
@@ -39,7 +39,7 @@ ifeq ($(ANDROID),1)
 FILTER_OUT_DIRS		+= lib6 rpc sockets
 endif
 
-ifeq ($(TIRPC_LIBS),)
+ifeq ($(HAVE_TIRPC),)
 FILTER_OUT_DIRS		+= rpc
 endif
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
index c7093352a..6234c2d29 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
@@ -30,5 +30,5 @@ $(LIBRPC-TIRPC): $(LIBDIR)
 MAKE_DEPS	+= $(LIBRPC-TIRPC)
 
 LDFLAGS		+= -L$(LIBDIR)
-LDLIBS		+= $(TIRPC_LIBS) -lrpc-tirpc
-CPPFLAGS	+= $(TIRPC_CPPFLAGS) -I$(LIBSRCDIR) -pthread
+LDLIBS		+= $(LIBTIRPC_LIBS) -lrpc-tirpc
+CFLAGS	+= $(LIBTIRPC_CFLAGS) -I$(LIBSRCDIR) -I$(LIBSRCDIR)/../include -pthread
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h b/testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h
new file mode 100644
index 000000000..b2434626b
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+ */
+
+#ifndef LAPI_RPC_H__
+#define LAPI_RPC_H__
+
+#include "config.h"
+
+#include <netconfig.h>
+#include <rpc/rpc.h>
+#include <rpc/types.h>
+#include <rpc/xdr.h>
+#include <rpc/svc.h>
+
+#endif	/* LAPI_RPC_H__ */
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_complex.c
index 1f81d1dbf..f95934567 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_complex.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define CALCPROC 10000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr.c
index 05faaf5be..8211b010e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr_limits.c
index b1a31d95f..9bfed452e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/tirpc_rpcb_getmaps.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/tirpc_rpcb_getmaps.c
index 32220d1cb..cf9494770 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/tirpc_rpcb_getmaps.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/tirpc_rpcb_getmaps.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/tirpc_authdes_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/tirpc_authdes_create.c
index bd52f5c0f..84c8479e9 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/tirpc_authdes_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/tirpc_authdes_create.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <netdb.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/tirpc_authdes_seccreate.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/tirpc_authdes_seccreate.c
index 87b07ec54..d8d5f8181 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/tirpc_authdes_seccreate.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/tirpc_authdes_seccreate.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <netdb.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/tirpc_authnone_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/tirpc_authnone_create.c
index fe96218ab..2b80c46fe 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/tirpc_authnone_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/tirpc_authnone_create.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <netdb.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/tirpc_authsys_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/tirpc_authsys_create.c
index c7cbb4c57..951856ee0 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/tirpc_authsys_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/tirpc_authsys_create.c
@@ -30,7 +30,7 @@
 #include <time.h>
 #include <unistd.h>
 #include <netdb.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/tirpc_authsys_create_default.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/tirpc_authsys_create_default.c
index f4f98b8bf..88de398fb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/tirpc_authsys_create_default.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/tirpc_authsys_create_default.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <netdb.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
index 47875c60b..f62bdff36 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
@@ -31,7 +31,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_complex.c
index 11af0296d..f2e120af6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_complex.c
@@ -30,7 +30,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c
index 514c34588..0311cd29d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c
index 7c41734f6..85eda63f5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_performance.c
index 8614eba01..72268817f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c
index 05d25ab04..dc3c29b1b 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c
@@ -31,7 +31,7 @@
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_stress.c
index b91cc6a4b..35feb51b7 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_stress.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
index 51be072ea..6178e219c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
@@ -31,7 +31,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create_limits.c
index e47d2fc05..9192ee70b 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
index 63ed92e83..ec41ae55d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
@@ -31,7 +31,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create_limits.c
index 75d80c166..47a095155 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
index 91f9663c9..5a61aa70e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
@@ -31,7 +31,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create_limits.c
index 8d9e1bc98..71a75bffd 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
index d7e9882e6..cfe55be18 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
@@ -31,7 +31,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create_limits.c
index ba84f987c..1ca25debf 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c
index 01eee329a..029d158ff 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c
index 836fffb52..a1b16416a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno_complex.c
index d63b60a85..d48932206 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno_complex.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c
index d18f56fbe..445ecfd32 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c
index ac5484e4b..e363e00b9 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c
index 02ac04067..fc00e9eca 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 667
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c
index ef630b00f..8f71f6bae 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c
index cc057a1d5..fcd67a465 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c
index 6fde3607f..04cba96e4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c
index 1d21c3ac5..f135d001f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 100
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c
index 6436021f8..8cec8bf74 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c
index 114682768..480a8c122 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c
index 26644e25e..284bdc051 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c
index 040f0809a..7404b9434 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_performance.c
index 5aa0f9260..ddac940a6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c
index ceedc1901..fbc10edc7 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c
@@ -31,7 +31,7 @@
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_stress.c
index 2fcc64702..4855a31ba 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_stress.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create.c
index f068143b6..b6f70e43d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create_limits.c
index ee3d4b58f..ead9a1983 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
index 25638bd7f..512fad057 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c
index d0d1091b4..e22ed098e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c
index ecb8d3ccd..0bbf87740 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c
index 8cbe5b992..7cf9f4725 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_performance.c
index bc7ed1785..aa55bdb82 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c
index 405f9c283..9fd403e13 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c
@@ -31,7 +31,7 @@
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_stress.c
index 5381db5a1..0a6eb5591 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_stress.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
index de65165b3..15dfa5074 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
index ab4ddd5ba..f0816c816 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg.c
index 7ba2ac18a..721085cea 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c
index 8473c0414..b9d058517 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_stress.c
index 862387e6f..b2a4b4a10 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_stress.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create.c
index 342071704..a3ee981cd 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create_limits.c
index d20ffbb28..dbe152e9f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg.c
index 721e41406..5ec21f672 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c
index 00bcc881e..6aad7fb2e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_stress.c
index 6871c87c2..2c6c14069 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_stress.c
@@ -29,7 +29,7 @@
 #include <stdio.h>
 #include <netinet/in.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call.c
index 5bb86ed50..ecd1f0d4a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c
index 3464ff23d..62ebd8a98 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c
index b9ed6dafa..8adca4547 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c
index 8e8bbc2e6..06fcd4abf 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_performance.c
index 27a4509f7..924d177f0 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c
index c40be764c..f21e2866f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c
@@ -31,7 +31,7 @@
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_stress.c
index 2a12df325..7aa055342 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_stress.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control.c
index f6b4bd418..0dd7d26ec 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control_limits.c
index 6b34aa7ab..1b2c4b273 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/tirpc_clnt_tp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/tirpc_clnt_tp_create.c
index b98f99304..7c7e5adab 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/tirpc_clnt_tp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/tirpc_clnt_tp_create.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed.c
index a3103bada..ccdfa21fb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed_limits.c
index f626d02ee..68211b607 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/tirpc_svc_tp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/tirpc_svc_tp_create.c
index 8a00a3104..91a34a0bd 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/tirpc_svc_tp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/tirpc_svc_tp_create.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <sys/socket.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast.c
index 767860993..e31a93535 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c
index fb19a0af2..9bf1ff993 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c
@@ -30,7 +30,7 @@
 #include <time.h>
 #include <sys/socket.h>
 #include <netdb.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PINGPROC 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c
index 30ffd931a..1a9e4914c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c
index 1e773a1b5..cc39c8572 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_performance.c
index 3e06d58f4..69e8f8bd6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c
index 372f7420b..3a3ee94d7 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c
@@ -31,7 +31,7 @@
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_stress.c
index 7edde968c..5e0d12e57 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_stress.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp.c
index a4da3a53a..f633e277c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_complex.c
index 10e24af3f..45ccdf1d8 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_complex.c
@@ -30,7 +30,7 @@
 #include <time.h>
 #include <sys/socket.h>
 #include <netdb.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PINGPROC 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c
index b358af532..02876d02f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_limits.c
index e077bb6ae..2e3334240 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c
index 65189fad3..849b7d493 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_performance.c
index 2a6925bb3..e09166080 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c
index dea6d82cc..4817a05db 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c
@@ -31,7 +31,7 @@
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_stress.c
index 8338310dd..38b1df9c3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_stress.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call.c
index 1dc533d0c..783cc65ac 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call.c
@@ -30,7 +30,7 @@
 #include <string.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c
index 5a44bf42f..0f0f3d869 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c
index 6ff385175..b61ea1306 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c
index 06ffdd2f4..c5a7554c5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_performance.c
index 1a609751a..45a2dae49 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_performance.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c
index 4641da752..707446122 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c
@@ -31,7 +31,7 @@
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_stress.c
index 264e24c45..d5c1f0204 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_stress.c
@@ -30,7 +30,7 @@
 #include <string.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg.c
index 248dbdb17..54c3cc887 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c
index b1eb8433d..b3b68a7b7 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_stress.c
index 4d54b0974..dab536f93 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_stress.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call.c
index 7143e3133..27718b627 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c
index 2f965e534..a9fa73fe9 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c
index e94f2037d..52092a61a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c
index 2ffaa8219..7d2f3b945 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c
@@ -31,7 +31,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_performance.c
index 264d65bc0..4d1264edc 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c
index 12664fca8..4d2ef26b6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c
@@ -31,7 +31,7 @@
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_stress.c
index 25f626ce3..2ecff3ede 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_stress.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c
index d6584ac09..eaca14747 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c
index c671649fb..43df4d95f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed_limits.c
index 238267be3..3b7475c1b 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
index becd6a46c..939ff3e4a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/tirpc_svc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/tirpc_svc_create.c
index 519aa4ef4..448a1b1d0 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/tirpc_svc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/tirpc_svc_create.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/tirpc_svc_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/tirpc_svc_destroy.c
index 102660b5d..49cff80ad 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/tirpc_svc_destroy.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/tirpc_svc_destroy.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c
index a938aec22..6303528c3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <sys/socket.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/tirpc_svc_1.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/tirpc_svc_1.c
index 231f671a5..1acf927c4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/tirpc_svc_1.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/tirpc_svc_1.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <sys/socket.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/tirpc_svc_11.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/tirpc_svc_11.c
index 121ae97e8..73715d65d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/tirpc_svc_11.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/tirpc_svc_11.c
@@ -30,7 +30,7 @@
 #include <sys/socket.h>
 #include <errno.h>
 #include <netinet/in.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/tirpc_svc_2.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/tirpc_svc_2.c
index 7a4667ef6..ba36bf26e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/tirpc_svc_2.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/tirpc_svc_2.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <sys/socket.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/tirpc_svc_3.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/tirpc_svc_3.c
index c28f412fc..ea762f728 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/tirpc_svc_3.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/tirpc_svc_3.c
@@ -29,7 +29,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/tirpc_svc_4.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/tirpc_svc_4.c
index 566b6fcf6..315182b7d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/tirpc_svc_4.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/tirpc_svc_4.c
@@ -29,7 +29,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <errno.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
index ebf577717..53f48a741 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
@@ -33,7 +33,7 @@
 #include <netinet/in.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 #define VERSNUM 1
 #define PROCSIMPLEPING	1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c
index 1dd421e1c..1cc274431 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c
@@ -31,7 +31,7 @@
 #include <errno.h>
 #include <pthread.h>
 #include <netinet/in.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c
index 559ef7f97..962787e6a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c
@@ -30,7 +30,7 @@
 #include <sys/socket.h>
 #include <errno.h>
 #include <netinet/in.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c
index fd516e4dd..3137c5014 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c
@@ -31,7 +31,7 @@
 #include <sys/socket.h>
 #include <errno.h>
 #include <netinet/in.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c
index 2fd9b4fc9..75f1254a5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c
@@ -31,7 +31,7 @@
 #include <sys/socket.h>
 #include <errno.h>
 #include <netinet/in.h>
-#include "lapi/rpc.h"
+#include "rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/travis/debian.cross-compile.aarch64.sh b/travis/debian.cross-compile.aarch64.sh
index 4b07f186f..cc1eda5b5 100755
--- a/travis/debian.cross-compile.aarch64.sh
+++ b/travis/debian.cross-compile.aarch64.sh
@@ -1,7 +1,11 @@
 #!/bin/sh
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -e
 
+dpkg --add-architecture arm64
+apt update
+
 apt install -y --no-install-recommends \
 	gcc-aarch64-linux-gnu \
-	libc6-dev-arm64-cross
+	libc6-dev-arm64-cross \
+	libtirpc-dev:arm64
diff --git a/travis/debian.cross-compile.ppc64le.sh b/travis/debian.cross-compile.ppc64le.sh
index d8431bd52..671867d31 100755
--- a/travis/debian.cross-compile.ppc64le.sh
+++ b/travis/debian.cross-compile.ppc64le.sh
@@ -1,7 +1,11 @@
 #!/bin/sh
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -e
 
+dpkg --add-architecture ppc64el
+apt update
+
 apt install -y --no-install-recommends \
 	gcc-powerpc64le-linux-gnu \
-	libc6-dev-ppc64el-cross
+	libc6-dev-ppc64el-cross \
+	libtirpc-dev:ppc64el
diff --git a/travis/debian.i386.sh b/travis/debian.i386.sh
index 51a77e11d..cd96cb7b0 100755
--- a/travis/debian.i386.sh
+++ b/travis/debian.i386.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -e
 
 dpkg --add-architecture i386
@@ -16,4 +16,5 @@ apt install -y --no-install-recommends \
 	libkeyutils1:i386 \
 	libnuma1:i386 \
 	libssl-dev:i386 \
-	libtirpc-dev:i386
+	libtirpc-dev:i386 \
+	pkg-config:i386
diff --git a/travis/debian.sh b/travis/debian.sh
index e1be4bb05..c8ec9429c 100755
--- a/travis/debian.sh
+++ b/travis/debian.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2018-2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -e
 
 # workaround for missing oldstable-updates repository
@@ -35,4 +35,5 @@ apt install -y --no-install-recommends \
 	libssl-dev \
 	libtirpc-dev \
 	linux-libc-dev \
-	lsb-release
+	lsb-release \
+	pkg-config
diff --git a/travis/fedora.sh b/travis/fedora.sh
index a4633333e..768aec762 100755
--- a/travis/fedora.sh
+++ b/travis/fedora.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -e
 
 yum -y install \
@@ -9,4 +9,7 @@ yum -y install \
 	clang \
 	gcc \
 	findutils \
+	libtirpc \
+	libtirpc-devel \
+	pkg-config \
 	redhat-lsb-core
diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
index c57257120..e73fa9a95 100755
--- a/travis/tumbleweed.sh
+++ b/travis/tumbleweed.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -e
 
 zypper --non-interactive install --no-recommends \
@@ -19,4 +19,5 @@ zypper --non-interactive install --no-recommends \
 	libselinux-devel \
 	libtirpc-devel \
 	linux-glibc-devel \
-	lsb-release
+	lsb-release \
+	pkg-config
-- 
2.24.1

