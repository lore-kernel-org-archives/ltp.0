Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Y1wzg-0000JO-1o
	for ltp-list@lists.sourceforge.net; Fri, 19 Dec 2014 12:49:20 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y1wzf-0006dL-7c
	for ltp-list@lists.sourceforge.net; Fri, 19 Dec 2014 12:49:20 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sBJCnCsY023060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 12:49:13 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	sBJCnBEG006430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 12:49:12 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sBJCnBUi019810
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 12:49:11 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 19 Dec 2014 15:48:59 +0300
Message-Id: <1418993341-16482-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1418993341-16482-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1418993341-16482-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/3] ltp_tbio.c: fix a possible kernel panic
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

In some environments an attempt to load ltp_tbio.ko module will
result in a kernel panic.

It happens, because after the module is loaded (add_disk(tbio_dev.gd) in
tbio_init() is executed), one or more ioctl() calls are issued to the newly
created block device. However, when ioctl() is called, there is no (yet) file
/dev/tbio created. Therefore, in tbio_ioctl():

  tbio_dev.bdev = blkdev_get_by_path(
              DEVICE_NAME, FMODE_READ | FMODE_WRITE, NULL);

returns -ENODEV, i.e. tbio_dev.bdev == -ENODEV, and it produces a kernel panic at:

  blkdev_put(tbio_dev.bdev, FMODE_READ | FMODE_WRITE);

We could introduce error checking here like this:

  if (IS_ERR(tbio_dev.bdev))
      return PTR_ERR(tbio_dev.bdev);

but I assume it would be better to return the previous logic, before commit
69d3b32681 "device-drivers: tbio: fixes", i.e. where tbio_dev.bdev is assigned
in tbio_open().

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../device-drivers/tbio/tbio_kernel/ltp_tbio.c     |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
index 5198b82..4e38fe7 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
@@ -376,14 +376,11 @@ static int tbio_ioctl(struct block_device *blk, fmode_t mode,
 {
 	int err = 0;
 
-	tbio_dev.bdev = blkdev_get_by_path(
-		DEVICE_NAME, FMODE_READ | FMODE_WRITE, NULL);
-
 	switch (cmd) {
 	case LTP_TBIO_DO_IO:
 		prk_info("TEST-CASE: LTP_TBIO_DO_IO:");
 		err = tbio_io(tbio_dev.bdev, (struct tbio_interface *)arg);
-	break;
+		break;
 	case LTP_TBIO_CLONE:
 		prk_info("TEST-CASE: LTP_TBIO_CLONE:");
 		err = test_bio_clone();
@@ -412,7 +409,6 @@ static int tbio_ioctl(struct block_device *blk, fmode_t mode,
 	}
 
 	prk_info("TEST-CASE DONE");
-	blkdev_put(tbio_dev.bdev, FMODE_READ | FMODE_WRITE);
 	return err;
 }
 
@@ -475,6 +471,8 @@ static void tbio_request(struct request_queue *q)
 
 static int tbio_open(struct block_device *blk, fmode_t mode)
 {
+	tbio_dev.bdev = blk;
+
 	return 0;
 }
 
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
