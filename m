From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 16 Oct 2017 13:30:49 +0800
Subject: [LTP] [PATCH] cve/cve-2017-2618: Check for file fscreate existence
Message-ID: <20171016053049.16409-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/cve/cve-2017-2618.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/cve-2017-2618.c b/testcases/cve/cve-2017-2618.c
index e6b30e8..e1e94f6 100644
--- a/testcases/cve/cve-2017-2618.c
+++ b/testcases/cve/cve-2017-2618.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2017 Fujitsu Ltd.
+ * Copyright (c) 2017 FUJITSU LIMITED
  * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  *
  * This program is free software: you can redistribute it and/or modify
@@ -35,6 +35,12 @@
 #define LOOPS	100
 #define PATH_ATTRFS	"/proc/self/attr/fscreate"
 
+static void setup(void)
+{
+	if (access(PATH_ATTRFS, F_OK))
+		tst_brk(TCONF, "%s does not exist", PATH_ATTRFS);
+}
+
 static void do_test(void)
 {
 	int i, fd;
@@ -55,5 +61,6 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.forks_child = 1,
+	.setup = setup,
 	.test_all = do_test,
 };
-- 
2.9.5



