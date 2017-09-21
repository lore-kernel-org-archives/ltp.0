From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 21 Sep 2017 15:19:34 +0800
Subject: [LTP] [PATCH] syscalls/mount: Remove obsolete test_mount from
	Makefile
Message-ID: <1505978374-2844-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mount/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/Makefile b/testcases/kernel/syscalls/mount/Makefile
index 4c6aa45..5caed98 100644
--- a/testcases/kernel/syscalls/mount/Makefile
+++ b/testcases/kernel/syscalls/mount/Makefile
@@ -27,6 +27,4 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CFLAGS			+= -D_GNU_SOURCE
 
-INSTALL_TARGETS		:= test_mount
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.8.3.1



