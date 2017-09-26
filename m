From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 26 Sep 2017 17:29:50 +0800
Subject: [LTP] [PATCH 2/2] commands/file: Compile in.c with -no-pie
In-Reply-To: <20170926092950.10856-1-fenggw-fnst@cn.fujitsu.com>
References: <20170926092950.10856-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170926092950.10856-2-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On newer gcc, --enable-default-pie is enabled by default,
thus in.c is compiled as position independent executable
file, which leads to test failure unexpectedly.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Signed-off-by: Fei Jie <feij.fnst@cn.fujitsu.com>
---
 testcases/commands/file/datafiles/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/commands/file/datafiles/Makefile b/testcases/commands/file/datafiles/Makefile
index d3cb847..b26ce5b 100644
--- a/testcases/commands/file/datafiles/Makefile
+++ b/testcases/commands/file/datafiles/Makefile
@@ -14,6 +14,7 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
+CFLAGS			+= $(NOPIEFLAGS)
 INSTALL_DIR		:= testcases/data/file01
 INSTALL_TARGETS		:= in*
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.9.5



