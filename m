From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 May 2020 14:33:57 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] rpc-tirpc: Fix building TI-RPC code
Message-ID: <20200513123357.13005-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

TIRPC_LIBS variable requires including include/mk/env_pre.mk.

(Not included in Makefile.inc, because all it's users include
env_pre.mk themselves).

Fixes: c7d2a7458 ("rpc-tirpc: Detect libtirpc with pkg-config")
Fixes: 60b20c428 ("rpc: Enable and fix build basic RPC tests with glibc SunRPC")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile   | 2 ++
 .../network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile
index c559153ae..253706e71 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile
@@ -3,6 +3,8 @@
 
 top_srcdir		?= ../../../../../..
 
+include	$(top_srcdir)/include/mk/env_pre.mk
+
 ifeq ($(TIRPC_LIBS),)
 FILTER_OUT_DIRS	+= tirpc
 endif
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile
index 0cbf4e504..95516cd29 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile
@@ -3,6 +3,8 @@
 
 top_srcdir		?= ../../../../../../..
 
+include	$(top_srcdir)/include/mk/env_pre.mk
+
 ifeq ($(TIRPC_LIBS),)
 # glibc does not define registerrpc() in <rpc/rpc.h>
 # registerrpc() is deprecated in libtirpc, it should be replaced by rpc_reg()
-- 
2.26.2

