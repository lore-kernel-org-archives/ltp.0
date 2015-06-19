Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z5uDA-0003jC-8j
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 11:11:52 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z5uD9-0006vA-8D
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 11:11:52 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t5JBBiZN032634
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2015 11:11:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t5JBBiYT021263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2015 11:11:44 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t5JBBDvF029313
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2015 11:11:18 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 19 Jun 2015 14:14:19 +0300
Message-Id: <1434712459-21878-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] cgroup_xattr: fix test on kernels >= 3.15
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

* cgroup was converted to kernfs that supports xattr natively and
  doesn't have simple 'security.' namespace handler. So using just
  'security.' name in setxattr syscall returns EOPNOTSUPP.

Also,

* adding 'trusted.' name to the test - should be valid xattr name.

* silent warnings about comparison between signed and unsigned int.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 .../kernel/controllers/cgroup_xattr/cgroup_xattr.c |   24 +++++++++++++++-----
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index d21656f..3170879 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) 2013-2015 Oracle and/or its affiliates. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -63,8 +63,9 @@ struct tst_key {
 };
 
 /* only security.* & trusted.* are valid key names */
-static const struct tst_key tkeys[] = {
+static struct tst_key tkeys[] = {
 	{ .name = "trusted.test",	.good = 1,	},
+	{ .name = "trusted.",		.good = 1,	},
 	{ .name = "security.",		.good = 1,	},
 	{ .name = "user.",		.good = 0,	},
 	{ .name = "system.",		.good = 0,	},
@@ -152,6 +153,14 @@ void setup(int argc, char *argv[])
 			"Test must be run with kernel 3.7 or newer");
 	}
 
+	if (tst_kvercmp(3, 15, 0) >= 0) {
+		/* In kernel v3.15 cgroup was converted to kernfs
+		 * that doesn't provide simple security namespace handlers.
+		 * Setting just 'security.' should return EOPNOTSUPP.
+		 */
+		tkeys[2].good = 0;
+	}
+
 	int value_size = DEFAULT_VALUE_SIZE;
 	if (nflag) {
 		if (sscanf(narg, "%i", &value_size) != 1)
@@ -270,8 +279,11 @@ int mount_cgroup(void)
 		 * additional "xattr" option. In that case, mount will succeed,
 		 * but xattr won't be supported in the new mount anyway.
 		 * Should be removed as soon as a fix committed to upstream.
+		 *
+		 * But not applicable for kernels >= 3.15 where xattr supported
+		 * natively.
 		 */
-		if (hier != 0)
+		if (hier != 0 && tst_kvercmp(3, 15, 0) < 0)
 			continue;
 
 		int i, found = 0;
@@ -321,7 +333,7 @@ int mount_cgroup(void)
 
 static int set_xattrs(const char *file)
 {
-	int i, err, fail, res = 0;
+	unsigned int i, err, fail, res = 0;
 
 	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
 		err = setxattr(file, tkeys[i].name,
@@ -343,7 +355,7 @@ static int set_xattrs(const char *file)
 
 static int get_xattrs(const char *file)
 {
-	int i, fail, res = 0;
+	unsigned int i, fail, res = 0;
 
 	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
 		/* get value size */
@@ -366,7 +378,7 @@ static int get_xattrs(const char *file)
 				"Can't get buffer of key %s",
 				tkeys[i].name);
 		}
-		fail = val.size != size ||
+		fail = val.size != (size_t)size ||
 			strncmp(val.buf, xval, val.size) != 0;
 		res |= fail;
 
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
