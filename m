From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 24 Aug 2018 18:24:02 +0800
Subject: [LTP] [PATCH] controllers/memcg_test_3: Remove sensitive
	information from comments
Message-ID: <20180824102402.24999-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 .../controllers/memcg/regression/memcg_test_3.c     | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
index 3b25f84..9df4389 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
@@ -1,6 +1,6 @@
 /*
- * Copyright (c) 2017 Fujitsu Ltd.
- *  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ * Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -18,24 +18,9 @@
 
 /*
  * This is a regression test for a crash caused by memcg function
- * reentrant on RHEL6.  When doing rmdir(), a pending signal can
+ * reentrant on buggy kernel.  When doing rmdir(), a pending signal can
  * interrupt the execution and lead to cgroup_clear_css_refs()
  * being entered repeatedly, this results in a BUG_ON().
- *
- * This bug was introduced by following RHEL6 patch on 2.6.32-488.el6:
- *
- *  [mm] memcg: fix race condition between memcg teardown and swapin
- *  Link: https://bugzilla.redhat.com/show_bug.cgi?id=1001197
- *  Patch: ftp://partners.redhat.com/1c5d859a/de6aafa8185ed8fd934f2debc72b79eb/kernel-individual-patch/rhel6/v2.6.32-to-kernel-2.6.32-488.el6.tar.bz2
- *         31675-mm-memcg-fix-race-condition-between-memcg-teardown-.patch
- *
- * This test can crash the buggy kernel on RHEL6.6GA, and the bug
- * was fixed by following patch on 2.6.32-536.el6:
- *
- *  [mm] memcg: fix crash in re-entrant cgroup_clear_css_refs()
- *  Link: https://bugzilla.redhat.com/show_bug.cgi?id=1168185
- *  Patch: ftp://partners.redhat.com/1c5d859a/de6aafa8185ed8fd934f2debc72b79eb/kernel-individual-patch/rhel6/v2.6.32-to-kernel-2.6.32-536.el6.tar.bz2
- *         35944-mm-memcg-fix-crash-in-re-entrant-cgroup_clear_css_r.patch
  */
 
 #include <errno.h>
-- 
2.9.5



