From: Wenzhong Sun <wenzhong.sun@intel.com>
Date: Thu,  1 Dec 2016 14:42:31 +0800
Subject: [LTP] [PATCH] delete runtest/nw_under_ns
Message-ID: <1480574551-27210-1-git-send-email-wenzhong.sun@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

nw_under_ns.sh test was rewritten and moved to runtest/containers scenario file

Signed-off-by: Wenzhong Sun <wenzhong.sun@intel.com>
---
 runtest/nw_under_ns | 2 --
 1 file changed, 2 deletions(-)
 delete mode 100644 runtest/nw_under_ns

diff --git a/runtest/nw_under_ns b/runtest/nw_under_ns
deleted file mode 100644
index 54217a6..0000000
--- a/runtest/nw_under_ns
+++ /dev/null
@@ -1,2 +0,0 @@
-# Network testcases under containers
-network_namespace	nw_under_ns.sh
-- 
2.7.4

