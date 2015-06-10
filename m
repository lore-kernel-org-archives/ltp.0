Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Z2djL-000418-QJ
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:59:35 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2djK-0002xF-PY
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:59:35 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t5AAxSio031789
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 10:59:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t5AAxRnE029760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 10:59:28 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t5AAxRN7014509
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 10:59:27 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 10 Jun 2015 13:59:22 +0300
Message-Id: <1433933962-739-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2] detach_device: Wait until the kernel frees the
	loop device
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

On systems employing the "lazy loop device removal",
commit a1ecac3b0656 ("loop: Make explicit loop device destruction lazy"),
ioctl(LOOP_CLR_FD) may return 0 when the loop device is in use,
for example by udev.

Therefore, there is a chance that a quick attach/detach may not
give udev enough time to complete, like this:

open("file.img", O_RDWR)           = 4
ioctl(3, LOOP_SET_FD, 0x4)         = 0
close(3)                           = 0
close(4)                           = 0
open("/dev/loop0", O_RDONLY)       = 3
ioctl(3, LOOP_CLR_FD, 0)           = 0
close(3)                           = 0
open("/dev/loop0", O_RDWR)         = 3
open("file.img", O_RDWR)           = 4
ioctl(3, LOOP_SET_FD, 0x4)         = -1 EBUSY (Device or resource busy)

So let's wait until the kernel frees the loop device, i.e.
when ioctl(LOOP_CLR_FD) starts failing with ENXIO.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 lib/tst_device.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 3bded53..4725570 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -150,30 +150,32 @@ static void attach_device(void (*cleanup_fn)(void),
 
 static void detach_device(void (*cleanup_fn)(void), const char *dev)
 {
-	int dev_fd, err, i;
+	int dev_fd, ret, i;
 
 	dev_fd = SAFE_OPEN(cleanup_fn, dev, O_RDONLY);
 
-	/* keep trying to clear LOOPDEV fd if EBUSY, a quick succession
+	/* keep trying to clear LOOPDEV until we get ENXIO, a quick succession
 	 * of attach/detach might not give udev enough time to complete */
 	for (i = 0; i < 40; i++) {
-		if (ioctl(dev_fd, LOOP_CLR_FD, 0) == 0) {
+		ret = ioctl(dev_fd, LOOP_CLR_FD, 0);
+
+		if (ret && (errno == ENXIO)) {
 			close(dev_fd);
 			return;
 		}
-		if (errno != EBUSY) {
-			err = errno;
-			close(dev_fd);
-			tst_brkm(TBROK, cleanup_fn,
-				"ioctl(%s, LOOP_CLR_FD, 0) failed: %s",
-				dev, tst_strerrno(err));
+
+		if (ret && (errno != EBUSY)) {
+			tst_resm(TWARN,
+				 "ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
+				 dev, tst_strerrno(errno));
 		}
+
 		usleep(50000);
 	}
 
 	close(dev_fd);
 	tst_brkm(TBROK, cleanup_fn,
-		"ioctl(%s, LOOP_CLR_FD, 0) EBUSY for too long",	dev);
+		"ioctl(%s, LOOP_CLR_FD, 0) no ENXIO for too long", dev);
 }
 
 const char *tst_acquire_device(void (cleanup_fn)(void))
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
