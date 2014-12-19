Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Y1wzg-0000JV-Jy
	for ltp-list@lists.sourceforge.net; Fri, 19 Dec 2014 12:49:20 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y1wzf-0006dN-RQ
	for ltp-list@lists.sourceforge.net; Fri, 19 Dec 2014 12:49:20 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sBJCnDI7023064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 12:49:14 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	sBJCnCfQ006459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 12:49:13 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sBJCnCl3020009
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 12:49:12 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 19 Dec 2014 15:49:00 +0300
Message-Id: <1418993341-16482-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1418993341-16482-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1418993341-16482-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/3] tbio: fixes
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

* Introduce a sleep() to wait until udev creates /dev/tbio
* Fix typos
* Clean /dev/tbio after test execution, if /dev/tbio was created
  manually.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../kernel/device-drivers/tbio/tbio_user/tbio.c    |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
index 81085a3..8249054 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
@@ -75,6 +75,9 @@ void cleanup(void)
 	if (module_loaded)
 		tst_module_unload(NULL, module_name);
 
+	if ((!unlink(DEVICE_NAME)) && (errno != ENOENT))
+		tst_brkm(TBROK | TERRNO, NULL, "unlink failed");
+
 	TEST_CLEANUP;
 }
 
@@ -91,6 +94,13 @@ void setup(void)
 	tst_module_load(cleanup, module_name, NULL);
 	module_loaded = 1;
 
+	/*
+	 * Wait until udev creates the device node.
+	 * If the node is not created, we will create it manually,
+	 * see below.
+	 */
+	sleep(5);
+
 	dev_t devt;
 	struct stat st;
 
@@ -99,14 +109,14 @@ void setup(void)
 
 	devt = makedev(TBIO_MAJOR, 0);
 	/*
-	 * Check for the /dev/tbase node, and create if it does not
+	 * Check for the /dev/tbio node, and create if it does not
 	 * exist.
 	 */
 	errno = 0;
 	if (stat(DEVICE_NAME, &st)) {
 		if (errno == ENOENT) {
 			/* dev node does not exist */
-			if (mknod(DEVICE_NAME, S_IFCHR | S_IRUSR | S_IWUSR |
+			if (mknod(DEVICE_NAME, S_IFBLK | S_IRUSR | S_IWUSR |
 				S_IRGRP | S_IWGRP, devt)) {
 				tst_brkm(TBROK | TERRNO, cleanup,
 					"mknod failed at %s:%d",
@@ -118,13 +128,13 @@ void setup(void)
 		}
 	} else {
 		/*
-		 * /dev/tbio CHR device exists.  Check to make sure it is for a
+		 * /dev/tbio device exists.  Check to make sure it is for a
 		 * block device and that it has the right major and minor.
 		 */
-		if ((!(st.st_mode & S_IFCHR)) || (st.st_rdev != devt)) {
+		if ((!(st.st_mode & S_IFBLK)) || (st.st_rdev != devt)) {
 			/* Recreate the dev node */
 			if (!unlink(DEVICE_NAME)) {
-				if (mknod(DEVICE_NAME, S_IFCHR | S_IRUSR |
+				if (mknod(DEVICE_NAME, S_IFBLK | S_IRUSR |
 					S_IWUSR | S_IRGRP | S_IWGRP, devt)) {
 					tst_brkm(TBROK | TERRNO, cleanup,
 						"mknod failed at %s:%d",
-- 
1.7.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
