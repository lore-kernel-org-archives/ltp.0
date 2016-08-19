From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Fri, 19 Aug 2016 14:30:23 +0300
Subject: [LTP] [PATCH v2] network/nfs05_make_tree: Define _GNU_SOURCE to
	enable O_DIRECTORY
Message-ID: <1471606223-28776-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test uses O_DIRECTORY macro and in some standard libraries it
may be defined only if _GNU_SOURCE is enabled.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/network/nfs/nfs_stress/nfs05_make_tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index 9f5e7a6..05eae4d 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -46,6 +46,9 @@
  *
  */
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
-- 
2.7.4


