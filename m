Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E519C00140
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 08:17:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 171AA3CA409
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 10:17:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06C083CA346
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 10:17:45 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A4CEA60087F
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 10:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1661329063; i=@fujitsu.com;
 bh=L981LaKFkef0JsYAL06oLpCueQmtT0QxJkH/mBoxA7c=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=jPW5ITr3iRh1zk4eMKVwKt2LuBfVT7snkzJKYgpQo6ZWf03hYmPAejVc7OqZMdCGU
 nnetgLfoDjcUHRdoxhPvxQcTw+rLuV1UkkP3UI+vpe4FI0FeHtMuLUZ9436tRzHIEN
 xx/h1vQ6yVRYptQ6OpHUkKcE7HPwHgSBckT/ylYr/hbfmX4oSTQhejgY3OsuY30e+i
 /gMj4kAEXJ+eiTXR5An9sWNgRUrUKg1hE/j/WyY6kFAebOK09EI4fw68JpwVwFuBwN
 ggIzmGdYkdLo5WCBxtQKRWYcx20NtG/0LXPpSx9ND+LI6Nkh3uibv1u1svH1LSaELv
 8zTCad0yl7Zyg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRWlGSWpSXmKPExsViZ8ORpLv8Hmu
 yQWsHh8WK7zsYHRg99v1exxrAGMWamZeUX5HAmrF0wxSWgqdiFYeXTmRtYPwr1MXIxSEkcIpR
 4vaGdSwQzj4miXMTTzNDODsYJW40LQNyODnYBLQl7vTMYASxRQQkJDoa3rKD2MwCmhL3rhwGi
 wsLmEs82/UEyObgYBFQlZj7QQkkzCvgKtFxZwobiC0hoCAx5eF7Zoi4oMTJmU9YIMZISBx88Y
 IZokZR4urpvawgYyQEKiVuPE6FCKtJXD23iXkCI/8sJN2zkHQvYGRaxWiTVJSZnlGSm5iZo2t
 oYKBraGgKpA11jQ30Eqt0E/VSS3Xz8otKMnQN9RLLi/VSi4v1iitzk3NS9PJSSzYxAsMypThV
 bgfjgX2/9A4xSnIwKYny3jzDmizEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgjfwLlBOsCg1PbUiL
 TMHGCMwaQkOHiURXgmQVt7igsTc4sx0iNQpRkUpcd7FIH0CIImM0jy4NlhcXmKUlRLmZWRgYB
 DiKUgtys0sQZV/xSjOwagkzFtzB2gKT2ZeCdz0V0CLmYAWB+1mBllckoiQkmpgml1+61QYu7r
 G50r7H9e4djRnrG+cdDgu+oLe/otMrpeO/n5g6z7Raj+TdP77D0eZHdnSD0pzeE22vfkvcn2p
 urWhjacMc0/mvgX+LNyv/NKi+P532oUyzlPxMTgpeLZp8teu229k1s7xeh+yunPaiqDXi2b4/
 Nv+t3rX+8KX1r/UnL3ifTb8Pb/nsf6u4rv78zbcCZm0W/bbr0m/nin9sfufOe1toDR/Hve/kI
 lG/pM9NxQdC1OczL+w7s1cv+Bv+648iHOpeFSX0GE7i6n0nvn+9i+7TGLff/a2uxI55VlawZk
 PQdf5DnTzZ5YXmZvYxF27l/CTQerCdK5XDFO//f74bVrI0W+71rTV5G5S7VFiKc5INNRiLipO
 BAAhMLyTRgMAAA==
X-Env-Sender: liaohj.jy@fujitsu.com
X-Msg-Ref: server-16.tower-728.messagelabs.com!1661329062!126751!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13144 invoked from network); 24 Aug 2022 08:17:43 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-16.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 24 Aug 2022 08:17:43 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 83A931AF
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 09:17:42 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 7829F1AE
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 09:17:42 +0100 (BST)
Received: from rhel-server--7.5 (10.167.215.42) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 24 Aug 2022 09:17:40 +0100
From: Liao Huangjie <liaohj.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 24 Aug 2022 16:17:29 +0800
Message-ID: <1661329049-14309-1-git-send-email-liaohj.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.42]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/read04:add multiple read size
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Huangjie Liao <liaohj.jy@fujitsu.com>

Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
---
 testcases/kernel/syscalls/read/read04.c | 59 ++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/read/read04.c b/testcases/kernel/syscalls/read/read04.c
index 47875c0..37c670f 100644
--- a/testcases/kernel/syscalls/read/read04.c
+++ b/testcases/kernel/syscalls/read/read04.c
@@ -6,36 +6,49 @@
 /*\
  * [Description]
  *
- * Testcase to check if read() returns the number of bytes read correctly.
+ * Testcase to check if read() returns the correct number of bytes 
+ * when using multip sizes [0, 1/2*page_size, 3/2*page_size, 2*page_size].
  */
 
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <stdio.h>
 #include <fcntl.h>
+#include <unistd.h>
 #include "tst_test.h"
 
+#define MNT_POINT "mntpoint"
+static int page_size;
 static const char *fname = "test_file";
-static const char palfa[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
-#define PALFA_LEN (sizeof(palfa)-1)
+static char *write_buf[2], *read_buf;
 
-static void verify_read(void)
+static void verify_read(unsigned int n)
 {
 	int fd;
-	char prbuf[BUFSIZ];
-
+	int size = n * page_size / 2;
 	fd = SAFE_OPEN(fname, O_RDONLY);
-	TEST(read(fd, prbuf, BUFSIZ));
+	TEST(read(fd, read_buf, size));
 
-	if (TST_RET != PALFA_LEN) {
-		tst_res(TFAIL, "Bad read count - got %ld - expected %zu",
-				TST_RET, PALFA_LEN);
+	if (TST_RET != size) {
+		tst_res(TFAIL, "Bad read count - got %ld - expected %d",
+				TST_RET, size);
 		goto out;
 	}
 
-	if (memcmp(palfa, prbuf, PALFA_LEN)) {
-		tst_res(TFAIL, "read buffer not equal to write buffer");
-		goto out;
+	if (n <= 2) {
+		if (memcmp(read_buf, write_buf[0], size)) {
+			tst_res(TFAIL, "read buffer not equal to write buffer1");
+			goto out;
+		}
+	} else {
+		if (memcmp(read_buf, write_buf[0], page_size)) {
+			tst_res(TFAIL, "read buffer not equal to write buffer2");
+			goto out;
+		}
+		if (memcmp(read_buf + page_size, write_buf[1], size - page_size)) {
+			tst_res(TFAIL, "read buffer not equal to write buffer3");
+			goto out;
+		}
 	}
 
 	tst_res(TPASS, "read() data correctly");
@@ -48,13 +61,27 @@ static void setup(void)
 {
 	int fd;
 
+	page_size = getpagesize();
+	write_buf[0] = tst_alloc(page_size);
+	write_buf[1] = tst_alloc(page_size);
+	read_buf = tst_alloc(2 * page_size);
+
+	memset(write_buf[0], 'A', page_size);
+	memset(write_buf[1], 'B', page_size);
+	memset(read_buf, 0, 2 * page_size);
+	
 	fd = SAFE_CREAT(fname, 0777);
-	SAFE_WRITE(1, fd, palfa, PALFA_LEN);
+	SAFE_WRITE(1, fd, write_buf[0], page_size);
+	SAFE_WRITE(1, fd, write_buf[1], page_size);
 	SAFE_CLOSE(fd);
+	
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.setup = setup,
-	.test_all = verify_read,
+	.test = verify_read,
+	.tcnt = 5,
+	.mount_device = 1,
+	.mntpoint = MNT_POINT,
+	.all_filesystems = 1,
 };
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
