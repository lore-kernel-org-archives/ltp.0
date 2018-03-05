From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Mar 2018 21:58:04 +0100
Subject: [LTP] [RFC PATCH 1/1] rpc: Use libtirpc instead of Sun RPC from glib
Message-ID: <20180305205804.20720-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sun RPC was removed from glibc 2.27, we need to use libtirpc and headers
from it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

openSUSE recently moved /usr/include/tirpc to /usr/include as part of
upgrade to glibc 2.27 [1]. Fedora is planning something similar [2].
Not sure if this is the best approach, but fixes the situation.

Kind regards,
Petr

[1] https://build.opensuse.org/package/view_file/Base:System/libtirpc/libtirpc.changes?expand=1
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1537432
---
 include/lapi/rpc.h                                 | 39 ++++++++++++++++++++++
 m4/ltp-tirpc.m4                                    |  2 +-
 testcases/network/Makefile                         |  4 +++
 testcases/network/rpc/Makefile                     |  5 +--
 testcases/network/rpc/basic_tests/rpc01/Makefile   |  1 +
 .../network/rpc/basic_tests/rpc01/lib/Makefile     |  1 +
 .../network/rpc/basic_tests/rpc01/lib/librpc01.c   |  2 +-
 .../network/rpc/basic_tests/rpc01/lib/librpc01.h   |  2 +-
 .../rpc_stdcall_clnt_call/rpc_clnt_call_complex.c  |  4 +--
 .../tirpc_rpcb_getaddr.c                           |  4 +--
 .../tirpc_rpcb_getaddr_limits.c                    |  2 +-
 .../tirpc_rpcb_getmaps.c                           |  4 +--
 .../tirpc_authdes_create.c                         |  2 +-
 .../tirpc_authdes_seccreate.c                      |  2 +-
 .../tirpc_authnone_create.c                        |  2 +-
 .../tirpc_authsys_create.c                         |  2 +-
 .../tirpc_authsys_create_default.c                 |  2 +-
 .../tirpc_bottomlevel_clnt_call.c                  |  4 +--
 .../tirpc_bottomlevel_clnt_call_complex.c          |  6 +---
 .../tirpc_bottomlevel_clnt_call_dataint.c          |  2 +-
 .../tirpc_bottomlevel_clnt_call_mt.c               |  6 +---
 .../tirpc_bottomlevel_clnt_call_performance.c      |  2 +-
 .../tirpc_bottomlevel_clnt_call_scalability.c      |  6 +---
 .../tirpc_bottomlevel_clnt_call_stress.c           |  4 +--
 .../tirpc_clnt_dg_create.c                         |  4 +--
 .../tirpc_clnt_dg_create_limits.c                  |  2 +-
 .../tirpc_clnt_vc_create.c                         |  4 +--
 .../tirpc_clnt_vc_create_limits.c                  |  2 +-
 .../tirpc_svc_dg_create.c                          |  4 +--
 .../tirpc_svc_dg_create_limits.c                   |  2 +-
 .../tirpc_svc_vc_create.c                          |  4 +--
 .../tirpc_svc_vc_create_limits.c                   |  2 +-
 .../tirpc_clnt_pcreateerror.c                      |  4 +--
 .../tirpc_err_clnt_perrno/tirpc_clnt_perrno.c      |  6 +---
 .../tirpc_clnt_perrno_complex.c                    |  6 +---
 .../tirpc_err_clnt_perror/tirpc_clnt_perror.c      |  6 +---
 .../tirpc_clnt_perror_complex.c                    |  6 +---
 .../tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c  |  4 +--
 .../tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c  |  4 +--
 .../tirpc_svcerr_progvers.c                        |  4 +--
 .../tirpc_svcerr_systemerr.c                       |  4 +--
 .../tirpc_svcerr_weakauth.c                        |  4 +--
 .../tirpc_expertlevel_clnt_call.c                  |  4 +--
 .../tirpc_expertlevel_clnt_call_complex.c          |  6 +---
 .../tirpc_expertlevel_clnt_call_dataint.c          |  2 +-
 .../tirpc_expertlevel_clnt_call_mt.c               |  6 +---
 .../tirpc_expertlevel_clnt_call_performance.c      |  2 +-
 .../tirpc_expertlevel_clnt_call_scalability.c      |  6 +---
 .../tirpc_expertlevel_clnt_call_stress.c           |  4 +--
 .../tirpc_clnt_tli_create.c                        |  4 +--
 .../tirpc_clnt_tli_create_limits.c                 |  2 +-
 .../tirpc_rpcb_rmtcall.c                           |  4 +--
 .../tirpc_rpcb_rmtcall_complex.c                   |  6 +---
 .../tirpc_rpcb_rmtcall_dataint.c                   |  2 +-
 .../tirpc_rpcb_rmtcall_mt.c                        |  6 +---
 .../tirpc_rpcb_rmtcall_performance.c               |  2 +-
 .../tirpc_rpcb_rmtcall_scalability.c               |  6 +---
 .../tirpc_rpcb_rmtcall_stress.c                    |  4 +--
 .../tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c    |  4 +--
 .../tirpc_rpcb_unset.c                             |  4 +--
 .../tirpc_expertlevel_svc_reg/tirpc_svc_reg.c      |  4 +--
 .../tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c   |  6 +---
 .../tirpc_svc_reg_stress.c                         |  4 +--
 .../tirpc_svc_tli_create.c                         |  4 +--
 .../tirpc_svc_tli_create_limits.c                  |  2 +-
 .../tirpc_expertlevel_svc_unreg/tirpc_svc_unreg.c  |  4 +--
 .../tirpc_svc_unreg_mt.c                           |  6 +---
 .../tirpc_svc_unreg_stress.c                       |  4 +--
 .../tirpc_interlevel_clnt_call.c                   |  6 +---
 .../tirpc_interlevel_clnt_call_complex.c           |  6 +---
 .../tirpc_interlevel_clnt_call_dataint.c           |  2 +-
 .../tirpc_interlevel_clnt_call_mt.c                |  6 +---
 .../tirpc_interlevel_clnt_call_performance.c       |  2 +-
 .../tirpc_interlevel_clnt_call_scalability.c       |  6 +---
 .../tirpc_interlevel_clnt_call_stress.c            |  6 +---
 .../tirpc_clnt_control.c                           |  7 +---
 .../tirpc_clnt_control_limits.c                    |  2 +-
 .../tirpc_clnt_tp_create.c                         |  7 +---
 .../tirpc_clnt_tp_create_timed.c                   |  6 +---
 .../tirpc_clnt_tp_create_timed_limits.c            |  2 +-
 .../tirpc_svc_tp_create.c                          |  6 +---
 .../tirpc_rpc_broadcast.c                          |  6 +---
 .../tirpc_rpc_broadcast_complex.c                  |  2 +-
 .../tirpc_rpc_broadcast_dataint.c                  |  2 +-
 .../tirpc_rpc_broadcast_mt.c                       |  6 +---
 .../tirpc_rpc_broadcast_performance.c              |  2 +-
 .../tirpc_rpc_broadcast_scalability.c              |  6 +---
 .../tirpc_rpc_broadcast_stress.c                   |  6 +---
 .../tirpc_rpc_broadcast_exp.c                      |  6 +---
 .../tirpc_rpc_broadcast_exp_complex.c              |  2 +-
 .../tirpc_rpc_broadcast_exp_dataint.c              |  2 +-
 .../tirpc_rpc_broadcast_exp_limits.c               |  2 +-
 .../tirpc_rpc_broadcast_exp_mt.c                   |  6 +---
 .../tirpc_rpc_broadcast_exp_performance.c          |  2 +-
 .../tirpc_rpc_broadcast_exp_scalability.c          |  6 +---
 .../tirpc_rpc_broadcast_exp_stress.c               |  6 +---
 .../tirpc/tirpc_simple_rpc_call/tirpc_rpc_call.c   |  6 +---
 .../tirpc_simple_rpc_call/tirpc_rpc_call_complex.c |  6 +---
 .../tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c |  2 +-
 .../tirpc_simple_rpc_call/tirpc_rpc_call_mt.c      |  6 +---
 .../tirpc_rpc_call_performance.c                   |  2 +-
 .../tirpc_rpc_call_scalability.c                   |  6 +---
 .../tirpc_simple_rpc_call/tirpc_rpc_call_stress.c  |  6 +---
 .../tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg.c     |  6 +---
 .../tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c  |  6 +---
 .../tirpc_simple_rpc_reg/tirpc_rpc_reg_stress.c    |  6 +---
 .../tirpc_toplevel_clnt_call.c                     |  6 +---
 .../tirpc_toplevel_clnt_call_complex.c             |  6 +---
 .../tirpc_toplevel_clnt_call_dataint.c             |  2 +-
 .../tirpc_toplevel_clnt_call_mt.c                  |  6 +---
 .../tirpc_toplevel_clnt_call_performance.c         |  2 +-
 .../tirpc_toplevel_clnt_call_scalability.c         |  6 +---
 .../tirpc_toplevel_clnt_call_stress.c              |  6 +---
 .../tirpc_toplevel_clnt_create/tirpc_clnt_create.c |  6 +---
 .../tirpc_clnt_create_timed.c                      |  6 +---
 .../tirpc_clnt_create_timed_limits.c               |  2 +-
 .../tirpc_clnt_destroy.c                           |  6 +---
 .../tirpc_toplevel_svc_create/tirpc_svc_create.c   |  6 +---
 .../tirpc_toplevel_svc_destroy/tirpc_svc_destroy.c |  6 +---
 .../rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c       |  6 +---
 .../rpc-tirpc/tests_pack/tirpc_svc_1/tirpc_svc_1.c |  6 +---
 .../tests_pack/tirpc_svc_11/tirpc_svc_11.c         |  6 +---
 .../rpc-tirpc/tests_pack/tirpc_svc_2/tirpc_svc_2.c |  6 +---
 .../rpc-tirpc/tests_pack/tirpc_svc_3/tirpc_svc_3.c |  6 +---
 .../rpc-tirpc/tests_pack/tirpc_svc_4/tirpc_svc_4.c |  6 +---
 .../rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c |  6 +---
 .../rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c |  6 +---
 .../rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c |  6 +---
 .../rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c |  6 +---
 .../rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c |  6 +---
 130 files changed, 171 insertions(+), 429 deletions(-)
 create mode 100644 include/lapi/rpc.h

diff --git a/include/lapi/rpc.h b/include/lapi/rpc.h
new file mode 100644
index 000000000..a779a6dcd
--- /dev/null
+++ b/include/lapi/rpc.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef LAPI_RPC_H__
+#define LAPI_RPC_H__
+
+#include "config.h"
+
+#ifdef HAVE_NETCONFIG_H
+# include <netconfig.h>
+# include <rpc/rpc.h>
+# include <rpc/types.h>
+# include <rpc/xdr.h>
+# include <rpc/svc.h>
+#elif defined(HAVE_TIRPC_NETCONFIG_H)
+# include <tirpc/netconfig.h>
+# include <tirpc/rpc/rpc.h>
+# include <tirpc/rpc/types.h>
+# include <tirpc/rpc/xdr.h>
+# include <tirpc/rpc/svc.h>
+#else
+# error Missing rpc headers!
+#endif
+
+#endif	/* LAPI_RPC_H__ */
diff --git a/m4/ltp-tirpc.m4 b/m4/ltp-tirpc.m4
index d9b4e61cb..707c3733b 100644
--- a/m4/ltp-tirpc.m4
+++ b/m4/ltp-tirpc.m4
@@ -24,7 +24,7 @@ AC_DEFUN([LTP_CHECK_TIRPC],[
 	TIRPC_CPPFLAGS=""
 	TIRPC_LIBS=""
 
-	AC_CHECK_HEADER(tirpc/netconfig.h,[
+	AC_CHECK_HEADERS([tirpc/netconfig.h netconfig.h], [
 		TIRPC_CPPFLAGS="-I${SYSROOT}/usr/include/tirpc"
 		AC_DEFINE(HAVE_LIBTIRPC, 1, [Define to 1 if you have libtirpc headers installed])
 		AC_CHECK_LIB(tirpc, rpcb_set, [TIRPC_LIBS="-ltirpc"])])
diff --git a/testcases/network/Makefile b/testcases/network/Makefile
index 69901a718..f7097e164 100644
--- a/testcases/network/Makefile
+++ b/testcases/network/Makefile
@@ -39,6 +39,10 @@ ifeq ($(ANDROID),1)
 FILTER_OUT_DIRS		+= lib6 rpc sockets
 endif
 
+ifeq ($(TIRPC_LIBS),)
+FILTER_OUT_DIRS		+= rpc
+endif
+
 $(INSTALL_TARGETS): | generate
 
 .PHONY: generate
diff --git a/testcases/network/rpc/Makefile b/testcases/network/rpc/Makefile
index e6c377736..ea36f8ad3 100644
--- a/testcases/network/rpc/Makefile
+++ b/testcases/network/rpc/Makefile
@@ -25,9 +25,6 @@ top_srcdir		?= ../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= *.sh
-
-ifeq ($(TIRPC_LIBS),)
-FILTER_OUT_DIRS		+= rpc-tirpc
-endif
+LDLIBS		+= $(TIRPC_LIBS)
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/Makefile b/testcases/network/rpc/basic_tests/rpc01/Makefile
index 953b21a9a..bbf5b9cc0 100644
--- a/testcases/network/rpc/basic_tests/rpc01/Makefile
+++ b/testcases/network/rpc/basic_tests/rpc01/Makefile
@@ -49,3 +49,4 @@ MAKE_TARGETS		:= rpc1 rpc_server
 MAKE_DEPS		:= $(LIB)
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
+include $(top_srcdir)/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
diff --git a/testcases/network/rpc/basic_tests/rpc01/lib/Makefile b/testcases/network/rpc/basic_tests/rpc01/lib/Makefile
index 387b5dc47..12d951aff 100644
--- a/testcases/network/rpc/basic_tests/rpc01/lib/Makefile
+++ b/testcases/network/rpc/basic_tests/rpc01/lib/Makefile
@@ -22,4 +22,5 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 INTERNAL_LIB		:= librpc01.a
 
+include $(top_srcdir)/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
 include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.c b/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.c
index ba7257621..7a292dece 100644
--- a/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.c
+++ b/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.c
@@ -16,7 +16,7 @@
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <rpc/xdr.h>
+#include "lapi/rpc.h"
 #include "librpc01.h"
 
 bool_t xdr_receive_data(XDR *xdrs, struct data **buffer)
diff --git a/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.h b/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.h
index 0fa7969ef..76bc3d882 100644
--- a/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.h
+++ b/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.h
@@ -19,7 +19,7 @@
 #ifndef __LIBRPC_H__
 #define __LIBRPC_H__
 
-#include <rpc/xdr.h>
+#include "lapi/rpc.h"
 
 struct data {
 	long address;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_complex.c
index ab0bc1155..1f81d1dbf 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_complex.c
@@ -28,9 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <rpc/rpc.h>
-#include <rpc/types.h>
-#include <rpc/xdr.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define CALCPROC 10000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr.c
index db368756e..05faaf5be 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr_limits.c
index 6fa11d9be..b1a31d95f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/tirpc_rpcb_getmaps.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/tirpc_rpcb_getmaps.c
index 68e2fc474..32220d1cb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/tirpc_rpcb_getmaps.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/tirpc_rpcb_getmaps.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/tirpc_authdes_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/tirpc_authdes_create.c
index 395a8125c..bd52f5c0f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/tirpc_authdes_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/tirpc_authdes_create.c
@@ -28,8 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
 #include <netdb.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/tirpc_authdes_seccreate.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/tirpc_authdes_seccreate.c
index c9e3d488f..87b07ec54 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/tirpc_authdes_seccreate.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/tirpc_authdes_seccreate.c
@@ -28,8 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
 #include <netdb.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/tirpc_authnone_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/tirpc_authnone_create.c
index 1daf2adcc..fe96218ab 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/tirpc_authnone_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/tirpc_authnone_create.c
@@ -28,8 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
 #include <netdb.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/tirpc_authsys_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/tirpc_authsys_create.c
index fe1e433bb..c7cbb4c57 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/tirpc_authsys_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/tirpc_authsys_create.c
@@ -29,8 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <unistd.h>
-#include <tirpc/rpc/rpc.h>
 #include <netdb.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/tirpc_authsys_create_default.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/tirpc_authsys_create_default.c
index 7d961fbf9..f4f98b8bf 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/tirpc_authsys_create_default.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/tirpc_authsys_create_default.c
@@ -28,8 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
 #include <netdb.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
index d46aa9e79..47875c60b 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
@@ -27,13 +27,11 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
+#include "lapi/rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_complex.c
index 80bb51c1c..11af0296d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_complex.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c
index e52c993e7..22d9098ca 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c
index 85bff1610..708f8c3bb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_performance.c
index 1b9ecdb56..8614eba01 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c
index 70fc1c836..361ce5508 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_stress.c
index 97d64e63e..b91cc6a4b 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_stress.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
index dd557be15..51be072ea 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
@@ -27,13 +27,11 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
+#include "lapi/rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create_limits.c
index 0dead8fac..e47d2fc05 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
index 3187b67ed..63ed92e83 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
@@ -27,13 +27,11 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create_limits.c
index 8feeb8610..75d80c166 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
index 955c9c652..91f9663c9 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
@@ -27,13 +27,11 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
+#include "lapi/rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create_limits.c
index 54cb5b955..8d9e1bc98 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
index b4857da9a..d7e9882e6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
@@ -27,13 +27,11 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
+#include "lapi/rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create_limits.c
index 2718026d4..ba84f987c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c
index a49e4b55b..01eee329a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c
index 276213b65..836fffb52 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno_complex.c
index a817ffcb1..d63b60a85 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno_complex.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c
index 5d04fe1ee..d18f56fbe 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c
index e9a78e7a7..ac5484e4b 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c
index 51efcf56f..02ac04067 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 667
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c
index e81a9fe15..ef630b00f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c
index 945d8c319..cc057a1d5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c
index e43b84f21..6fde3607f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c
index 8b924abc5..1d21c3ac5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 100
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c
index d10e4bc63..6436021f8 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c
index c5fad5e15..fb2dbe0f0 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c
index 0c02e9ef7..913732484 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c
index 13b5ce005..bdce52329 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_performance.c
index fbd606dd7..5aa0f9260 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c
index e8c4cb2f6..6c17e70c4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_stress.c
index a02d7dc1d..2fcc64702 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_stress.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create.c
index dca18300b..f068143b6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create_limits.c
index 6f599e512..ee3d4b58f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
index f084ab363..25638bd7f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c
index 311b1c0ff..c25cec133 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c
index db151b6da..a0c5471b2 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c
index 6f5b397ea..f61a33bce 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_performance.c
index a57d9690f..bc7ed1785 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c
index 2b5207c42..447c7169f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_stress.c
index b2cf41c1b..5381db5a1 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_stress.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
index e2611b0d1..de65165b3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
index 2cbdb4289..ab4ddd5ba 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg.c
index 622b2f8fa..7ba2ac18a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c
index 657908b52..167890c96 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_stress.c
index 7690aedd5..862387e6f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_stress.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create.c
index 304e68f9c..342071704 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create_limits.c
index de60013a0..d20ffbb28 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg.c
index be83185cf..721e41406 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c
index 3f5aef562..d812509bb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_stress.c
index 03b7db6d0..6871c87c2 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_stress.c
@@ -27,11 +27,9 @@
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/netconfig.h>
 #include <netinet/in.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call.c
index 29d812464..5bb86ed50 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c
index 8f094aa1d..945557a76 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c
index 36cbd60c2..8b9ea2e8c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c
index dce0823a7..f960d04d2 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_performance.c
index e750ba606..27a4509f7 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c
index 60b0d72a7..e7cca3ca3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_stress.c
index 1a6a2c8a3..2a12df325 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_stress.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control.c
index cfa2e8d34..f6b4bd418 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control.c
@@ -28,13 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
-#include <tirpc/netconfig.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control_limits.c
index bcac16361..6b34aa7ab 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/tirpc_clnt_tp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/tirpc_clnt_tp_create.c
index 498877000..b98f99304 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/tirpc_clnt_tp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/tirpc_clnt_tp_create.c
@@ -28,13 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
-#include <tirpc/netconfig.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed.c
index dea54b9d5..a3103bada 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed_limits.c
index bec53eab5..f626d02ee 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/tirpc_svc_tp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/tirpc_svc_tp_create.c
index a5acf0c50..8a00a3104 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/tirpc_svc_tp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/tirpc_svc_tp_create.c
@@ -26,13 +26,9 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast.c
index df1845458..767860993 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c
index 6b017e58c..fb19a0af2 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c
@@ -28,9 +28,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
 #include <sys/socket.h>
 #include <netdb.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PINGPROC 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c
index 61db86203..f8a9ea135 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c
index 546cd1d51..3cd02e593 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_performance.c
index e473eb409..3e06d58f4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c
index d42f7564d..c6a6e2d59 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_stress.c
index 6cc48d453..7edde968c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_stress.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp.c
index df44800d2..a4da3a53a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_complex.c
index 06a86de36..10e24af3f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_complex.c
@@ -28,9 +28,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
 #include <sys/socket.h>
 #include <netdb.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PINGPROC 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c
index 2e51920f7..bd574b154 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c
@@ -26,9 +26,9 @@
 */
 
 #include <stdio.h>
-#include <tirpc/rpc/rpc.h>
 #include <stdlib.h>
 #include <time.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_limits.c
index f1103f7c0..e077bb6ae 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c
index 6c4c13db4..0a461279a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_performance.c
index 79bd12550..2a6925bb3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c
index a503c033d..a40c2aa33 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_stress.c
index cee249c78..8338310dd 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_stress.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call.c
index 0ae82d439..257b108cc 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c
index 6af9e084d..6276f2fc7 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c
index c9b511a29..780f5a0f4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c
index 8e6fd991a..376ac0fd2 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_performance.c
index c2f8527c9..357d9d18d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c
index 2395368ac..73118cbf3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_stress.c
index 54f3cc60b..56b5ddb57 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_stress.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg.c
index e6f204455..248dbdb17 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c
index 63493877e..6b6d500de 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_stress.c
index c70f31ede..4d54b0974 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_stress.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call.c
index 509525af5..7143e3133 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c
index f147f92e2..9ffb0ba73 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define CALCTHREADPROC	1000
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c
index 5dc8a8b8e..e88663af4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define INTPROCNUM 10
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c
index dedd65b51..6f333ac3e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_performance.c
index 73ad66a1e..264d65bc0 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_performance.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c
index b891dd607..d2352b33f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c
@@ -29,12 +29,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_stress.c
index 9e4fc434b..25f626ce3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_stress.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c
index 25e9c936e..d6584ac09 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c
index 66265d8f5..c671649fb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed_limits.c
index ffcdac142..238267be3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed_limits.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/rpc/rpc.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
index f0d6aa0d9..becd6a46c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/tirpc_svc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/tirpc_svc_create.c
index 83d8bec67..519aa4ef4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/tirpc_svc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/tirpc_svc_create.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/tirpc_svc_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/tirpc_svc_destroy.c
index 679d1f120..102660b5d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/tirpc_svc_destroy.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/tirpc_svc_destroy.c
@@ -28,12 +28,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <tirpc/netconfig.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c
index a23d37824..a938aec22 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c
@@ -26,13 +26,9 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/tirpc_svc_1.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/tirpc_svc_1.c
index 4f05f10ff..231f671a5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/tirpc_svc_1.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/tirpc_svc_1.c
@@ -26,13 +26,9 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/tirpc_svc_11.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/tirpc_svc_11.c
index d3b9388d3..a93e831d0 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/tirpc_svc_11.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/tirpc_svc_11.c
@@ -26,14 +26,10 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <netinet/in.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/tirpc_svc_2.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/tirpc_svc_2.c
index 49b1dc555..7a4667ef6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/tirpc_svc_2.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/tirpc_svc_2.c
@@ -26,13 +26,9 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/tirpc_svc_3.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/tirpc_svc_3.c
index fd3787fd7..e20b9b4bb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/tirpc_svc_3.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/tirpc_svc_3.c
@@ -26,13 +26,9 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/tirpc_svc_4.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/tirpc_svc_4.c
index ad33540e6..02d745c6a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/tirpc_svc_4.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/tirpc_svc_4.c
@@ -26,13 +26,9 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
index c899d0f39..36003cb4f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
@@ -27,16 +27,12 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <netinet/in.h>
 #include <unistd.h>
 #include "librpc-tirpc.h"
+#include "lapi/rpc.h"
 
 #define VERSNUM 1
 #define PROCSIMPLEPING	1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c
index 16c658af5..71a475373 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c
@@ -26,15 +26,11 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <pthread.h>
 #include <netinet/in.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c
index 0399ddd85..ea141f4ef 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c
@@ -26,14 +26,10 @@
 */
 
 #include <stdio.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <netinet/in.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c
index cd945ce9d..6c1c37bac 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c
@@ -27,14 +27,10 @@
 
 #include <stdio.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <netinet/in.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c
index 6cead1bde..a000ba265 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c
@@ -27,14 +27,10 @@
 
 #include <stdio.h>
 #include <pthread.h>
-#include <tirpc/netconfig.h>
 #include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <netinet/in.h>
+#include "lapi/rpc.h"
 
 //Standard define
 #define VERSNUM 1
-- 
2.16.2

