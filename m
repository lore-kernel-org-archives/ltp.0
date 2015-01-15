Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YBhqJ-0002kO-98
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 10:39:59 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YBhqG-0007yE-RG
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 10:39:59 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0FAdoxH004819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Jan 2015 10:39:51 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t0FAdnsf006052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Jan 2015 10:39:50 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0FAdn63001834
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Jan 2015 10:39:49 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 15 Jan 2015 13:39:44 +0300
Message-Id: <1421318384-17500-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20150115095301.GA12643@rei>
References: <20150115095301.GA12643@rei>
Subject: [LTP] [PATCH V3 2/2] tbio: fixes
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

* Wait until udev creates /dev/tbio. If udev can not create
  the node file in a defined timeout, create it manually.
* Clean /dev/tbio after test execution, if /dev/tbio was created
  manually.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V2:

* Check for the file ten times a second.


 .../kernel/device-drivers/tbio/tbio_user/tbio.c    |   66 ++++++++++----------
 1 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
index 81085a3..b27f709 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
@@ -75,12 +75,19 @@ void cleanup(void)
 	if (module_loaded)
 		tst_module_unload(NULL, module_name);
 
+	if (unlink(DEVICE_NAME) && (errno != ENOENT))
+		tst_brkm(TBROK | TERRNO, NULL, "unlink failed");
+
 	TEST_CLEANUP;
 }
 
 
 void setup(void)
 {
+	dev_t devt;
+	struct stat st;
+	unsigned int i, valid_node_created;
+
 	tst_require_root(NULL);
 
 	if (tst_kvercmp(2, 6, 0) < 0) {
@@ -91,50 +98,41 @@ void setup(void)
 	tst_module_load(cleanup, module_name, NULL);
 	module_loaded = 1;
 
-	dev_t devt;
-	struct stat st;
-
 	SAFE_FILE_SCANF(cleanup, "/sys/class/block/tbio/dev",
 		"%d:0", &TBIO_MAJOR);
 
 	devt = makedev(TBIO_MAJOR, 0);
+
 	/*
-	 * Check for the /dev/tbase node, and create if it does not
-	 * exist.
+	 * Wait until udev creates the device node.
+	 * If the node is not created or invalid, create it manually.
 	 */
-	errno = 0;
-	if (stat(DEVICE_NAME, &st)) {
-		if (errno == ENOENT) {
-			/* dev node does not exist */
-			if (mknod(DEVICE_NAME, S_IFCHR | S_IRUSR | S_IWUSR |
-				S_IRGRP | S_IWGRP, devt)) {
+	valid_node_created = 0;
+	for (i = 0; i < 50; i++) {
+		if (stat(DEVICE_NAME, &st)) {
+			if (errno != ENOENT)
 				tst_brkm(TBROK | TERRNO, cleanup,
-					"mknod failed at %s:%d",
-					__FILE__, __LINE__);
-			}
+					 "stat() failed");
 		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				"problem with tbase device node directory");
-		}
-	} else {
-		/*
-		 * /dev/tbio CHR device exists.  Check to make sure it is for a
-		 * block device and that it has the right major and minor.
-		 */
-		if ((!(st.st_mode & S_IFCHR)) || (st.st_rdev != devt)) {
-			/* Recreate the dev node */
-			if (!unlink(DEVICE_NAME)) {
-				if (mknod(DEVICE_NAME, S_IFCHR | S_IRUSR |
-					S_IWUSR | S_IRGRP | S_IWGRP, devt)) {
-					tst_brkm(TBROK | TERRNO, cleanup,
-						"mknod failed at %s:%d",
-						__FILE__, __LINE__);
-				}
-			} else {
-				tst_brkm(TBROK | TERRNO, cleanup,
-					"unlink failed");
+			if ((st.st_mode & S_IFBLK) && (st.st_rdev == devt)) {
+				valid_node_created = 1;
+				break;
 			}
 		}
+
+		usleep(100000);
+	}
+
+	if (!valid_node_created) {
+		tst_resm(TINFO,
+			 "The device file was not created by udev, "
+			 "proceeding with manual creation");
+
+		if (unlink(DEVICE_NAME) && (errno != ENOENT))
+			tst_brkm(TBROK | TERRNO, cleanup, "unlink() failed");
+		if (mknod(DEVICE_NAME, S_IFBLK | S_IRUSR | S_IWUSR |
+			  S_IRGRP | S_IWGRP, devt))
+			tst_brkm(TBROK | TERRNO, cleanup, "mknod() failed");
 	}
 
 	tbio_fd = open(DEVICE_NAME, O_RDWR);
-- 
1.7.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
