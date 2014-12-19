Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Y1wzh-0000In-Ir
	for ltp-list@lists.sourceforge.net; Fri, 19 Dec 2014 12:49:21 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y1wzg-0006dO-JP
	for ltp-list@lists.sourceforge.net; Fri, 19 Dec 2014 12:49:21 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sBJCnE58028852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 12:49:14 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	sBJCnD1U006523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 12:49:14 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sBJCnDlP019944
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 12:49:13 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 19 Dec 2014 15:49:01 +0300
Message-Id: <1418993341-16482-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1418993341-16482-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1418993341-16482-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/3] tbio: fix cmd_len handling
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

sizeof(rq->cmd) does not return the size of cmd buffer in rq,
it will return the size of the pointer, i.e. 4 - on 32-bit systems,
and 8 - on 64-bit systems. This happens, because cmd is a pointer to
__cmd[BLK_MAX_CDB] in struct request in the kernel (see linux/blkdev.h):

        unsigned char __cmd[BLK_MAX_CDB];
        unsigned char *cmd;
        unsigned short cmd_len;

and is not a static buffer by itself.

Therefore on 32-bit systems 'sizeof(rq->cmd) - inter->cmd_len)' will be
'4 - 6', and this is not what we want.

Corrected this, so now we rely on inter->cmd containing  a null-terminated string,
and inter->cmd_len containing the exact number of bytes to store this string.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../device-drivers/tbio/tbio_kernel/ltp_tbio.c     |   11 ++++++++---
 .../kernel/device-drivers/tbio/tbio_kernel/tbio.h  |    2 +-
 .../kernel/device-drivers/tbio/tbio_user/tbio.c    |    4 ++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
index 4e38fe7..48cc588 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
@@ -85,14 +85,19 @@ static int send_request(struct request_queue *q, struct bio *bio,
 		return -EFAULT;
 	}
 
+	if ((!inter->cmd_len) || (inter->cmd_len > rq->cmd_len)) {
+		prk_err("invalid inter->cmd_len");
+		return -EFAULT;
+	}
+
 	rq->cmd_len = inter->cmd_len;
 
 	if (copy_from_user(rq->cmd, inter->cmd, inter->cmd_len))
 		goto out_request;
 
-	if (sizeof(rq->cmd) != inter->cmd_len) {
-		memset(rq->cmd + inter->cmd_len, 0,
-			sizeof(rq->cmd) - inter->cmd_len);
+	if (*(rq->cmd + rq->cmd_len - 1)) {
+		prk_err("rq->cmd is not null-terminated");
+		return -EFAULT;
 	}
 
 	rq->__sector = bio->bi_sector;
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h b/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
index cf6df73..4cf0f46 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
@@ -66,6 +66,6 @@ struct tbio_interface {
 	int data_len;	/* input data length */
 	int direction;	/* read or write form DEV */
 	char *cmd;	/* read or write */
-	int cmd_len;	/* length of cmd */
+	unsigned short cmd_len;	/* length of cmd */
 };
 typedef struct tbio_interface tbio_interface_t;
diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
index 8249054..80c2665 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
@@ -212,14 +212,14 @@ int tbio_from_dev(int fd, int flag)
 
 	bif.data_len = 1024;
 	bif.direction = TBIO_FROM_DEV;
-	bif.cmd = SAFE_MALLOC(cleanup, 6);
+	bif.cmd = SAFE_MALLOC(cleanup, 5);
 	if (bif.cmd == NULL) {
 		tst_resm(TINFO, "malloc cmd space failed");
 		free(bif.data);
 		return -1;
 	}
 	strcpy(bif.cmd, "READ");
-	bif.cmd_len = 6;
+	bif.cmd_len = 5;
 
 	rc = ioctl(fd, flag, &bif);
 	if (rc) {
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
