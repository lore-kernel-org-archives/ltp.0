Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z72RF-0001rU-SW
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 14:11:05 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z72RD-0006kH-Sc
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 14:11:05 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t5MEAvNj027235
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:10:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t5MEAvHR025031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:10:57 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t5MEAv6Q012982
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:10:57 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 22 Jun 2015 17:14:05 +0300
Message-Id: <1434982445-19876-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2] cgroup_xattr: fix test on kernels >= 3.15
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
v2: rearrange keys in tkeys[], move 'security.' to the top;
    use strcmp() to find 'security.' in setup.

 .../kernel/controllers/cgroup_xattr/cgroup_xattr.c |   32 +++++++++++++++----
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index d21656f..5951198 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) 2013-2015 Oracle and/or its affiliates. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -63,9 +63,10 @@ struct tst_key {
 };
 
 /* only security.* & trusted.* are valid key names */
-static const struct tst_key tkeys[] = {
-	{ .name = "trusted.test",	.good = 1,	},
+static struct tst_key tkeys[] = {
 	{ .name = "security.",		.good = 1,	},
+	{ .name = "trusted.test",	.good = 1,	},
+	{ .name = "trusted.",		.good = 1,	},
 	{ .name = "user.",		.good = 0,	},
 	{ .name = "system.",		.good = 0,	},
 };
@@ -152,6 +153,20 @@ void setup(int argc, char *argv[])
 			"Test must be run with kernel 3.7 or newer");
 	}
 
+	if (tst_kvercmp(3, 15, 0) >= 0) {
+		/* In kernel v3.15 cgroup was converted to kernfs
+		 * that doesn't provide simple security namespace handlers.
+		 * Setting just 'security.' should return EOPNOTSUPP.
+		 */
+		unsigned int i;
+		for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
+			if (!strcmp(tkeys[i].name, "security.")) {
+				tkeys[i].good = 0;
+				break;
+			}
+		}
+	}
+
 	int value_size = DEFAULT_VALUE_SIZE;
 	if (nflag) {
 		if (sscanf(narg, "%i", &value_size) != 1)
@@ -270,8 +285,11 @@ int mount_cgroup(void)
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
@@ -321,7 +339,7 @@ int mount_cgroup(void)
 
 static int set_xattrs(const char *file)
 {
-	int i, err, fail, res = 0;
+	unsigned int i, err, fail, res = 0;
 
 	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
 		err = setxattr(file, tkeys[i].name,
@@ -343,7 +361,7 @@ static int set_xattrs(const char *file)
 
 static int get_xattrs(const char *file)
 {
-	int i, fail, res = 0;
+	unsigned int i, fail, res = 0;
 
 	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
 		/* get value size */
@@ -366,7 +384,7 @@ static int get_xattrs(const char *file)
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
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
