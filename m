From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 15:55:04 +0200
Subject: [LTP] [COMMITTED] [PATCH 2/4] rpc-tirpc: Fix out-of-tree build
In-Reply-To: <20170329135506.23901-1-chrubis@suse.cz>
References: <20170329135506.23901-1-chrubis@suse.cz>
Message-ID: <20170329135506.23901-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Make use of $(abs_srcdir) when including Makefile.inc

* Fix typo in Makefile.inc

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/network/rpc/rpc-tirpc/tests_pack/Makefile              | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc          | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile    | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile    | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile  | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile  | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile  | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile  | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile  | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile  | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile  | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile  | 2 +-
 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile  | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
index d16e1ca..42d111f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
@@ -35,5 +35,5 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
-include ./Makefile.inc
+include $(abs_srcdir)/Makefile.inc
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
index ff6b2e0..c709335 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
@@ -21,7 +21,7 @@ LIBDIR		:= $(abs_top_builddir)/$(LIBRELDIR)
 LIBSRCDIR	:= $(abs_top_srcdir)/$(LIBRELDIR)
 LIBRPC-TIRPC	:= $(LIBDIR)/librpc-tirpc.a
 
-$(LIBDDIR):
+$(LIBDIR):
 	mkdir -p "$@"
 
 $(LIBRPC-TIRPC): $(LIBDIR)
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile
index 771888c..b5d08aa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
-include ../Makefile.inc
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.10.2

