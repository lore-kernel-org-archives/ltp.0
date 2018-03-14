From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Wed, 14 Mar 2018 14:33:48 +0800
Subject: [LTP] [PATCH] cve/cve-2017-16939.c: Fix compilation without
	CLONE_NEWUSER and CLONE_NEWNET
Message-ID: <1521009228-2202-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed on some older distributions due to undefined CLONE_NEWUSER
and CLONE_NEWNET, so we include lapi/namespaces_constants.h to fix it.

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/cve/cve-2017-16939.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index a49499c..223ca83 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -36,6 +36,7 @@
 #include "tst_res_flags.h"
 #include "tst_safe_macros.h"
 #include "tst_safe_net.h"
+#include "lapi/namespaces_constants.h"
 
 #define BUFSIZE 2048
 
-- 
1.8.3.1



