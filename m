From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 15:55:05 +0200
Subject: [LTP] [COMMITTED] [PATCH 3/4] commands: Fix out-of-tree datafiles
	installation
In-Reply-To: <20170329135506.23901-1-chrubis@suse.cz>
References: <20170329135506.23901-1-chrubis@suse.cz>
Message-ID: <20170329135506.23901-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The INSTALL_TARGETS are prefixed with $(abs_srcdir) in the test library
hence we cannot do the wildcard expansion in the Makefile in case of
out-of-tree build and we have to leave that to the build system instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/ar/datafiles/Makefile   | 2 +-
 testcases/commands/file/datafiles/Makefile | 2 +-
 testcases/commands/ld/datafiles/Makefile   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/commands/ar/datafiles/Makefile b/testcases/commands/ar/datafiles/Makefile
index 09dc029..ef99bca 100644
--- a/testcases/commands/ar/datafiles/Makefile
+++ b/testcases/commands/ar/datafiles/Makefile
@@ -15,5 +15,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 INSTALL_DIR		:= testcases/data/ar01
-INSTALL_TARGETS		:= $(wildcard file*)
+INSTALL_TARGETS		:= file*
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/file/datafiles/Makefile b/testcases/commands/file/datafiles/Makefile
index 6769fc6..d3cb847 100644
--- a/testcases/commands/file/datafiles/Makefile
+++ b/testcases/commands/file/datafiles/Makefile
@@ -15,5 +15,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 INSTALL_DIR		:= testcases/data/file01
-INSTALL_TARGETS		:= $(wildcard in*)
+INSTALL_TARGETS		:= in*
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ld/datafiles/Makefile b/testcases/commands/ld/datafiles/Makefile
index 7b19207..4eb64ad 100644
--- a/testcases/commands/ld/datafiles/Makefile
+++ b/testcases/commands/ld/datafiles/Makefile
@@ -17,6 +17,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_DIR		:= testcases/data/ld01
 MAKE_TARGETS		:=
-INSTALL_TARGETS		:= $(wildcard *.c)
+INSTALL_TARGETS		:= *.c
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.10.2

