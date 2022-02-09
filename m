Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B70C433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 07:40:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 246A73C9B61
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 08:40:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBD983C9A8D
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 08:39:51 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B163F1000D45
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 08:39:48 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JtsBm2KsgzdZTd
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 15:36:32 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 15:39:43 +0800
To: <ltp@lists.linux.it>
Date: Wed, 9 Feb 2022 15:39:43 +0800
Message-ID: <20220209073943.162782-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify/fanotify04: Bugfix for running with option
 of "-i 500"
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When we running the testcase with option of "-i 500", the test
will fail:
...
fanotify04.c:163: TPASS: No event as expected
fanotify04.c:71: TPASS: fanotify_mark (3, FAN_MARK_ADD | 0, FAN_OPEN, AT_FDCWD, 'symlink_160172') succeeded
fanotify04.c:127: TPASS: event generated properly for type 100000
fanotify04.c:113: TBROK: read(3,0x55c783185280,0) failed, returned -1: EINVAL (22)
...

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../kernel/syscalls/fanotify/fanotify04.c      | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index b23d7a9a3..8dedcf34a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -24,11 +24,8 @@
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"

-#define EVENT_MAX 1024
 /* size of the event structure, not counting name */
 #define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
-/* reasonable guess as to size of 1024 events */
-#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)

 #define BUF_SIZE 256
 #define TST_TOTAL 9
@@ -39,7 +36,7 @@ static char dir[BUF_SIZE];
 static int fd_notify;

 static int len;
-static char event_buf[EVENT_BUF_LEN];
+static char event_buf[EVENT_SIZE];

 static char *expect_str_fail(int expect)
 {
@@ -109,11 +106,8 @@ static void verify_event(int mask)
 	struct stat st;

 	/* Read the event */
-	ret = SAFE_READ(0, fd_notify, event_buf + len,
-			EVENT_BUF_LEN - len);
-	event = (struct fanotify_event_metadata *)&event_buf[len];
-	len += ret;
-
+	ret = SAFE_READ(0, fd_notify, event_buf, EVENT_SIZE);
+	event = (struct fanotify_event_metadata *)&event_buf;
 	if (event->mask != FAN_OPEN) {
 		tst_res(TFAIL, "got unexpected event %llx",
 			(unsigned long long)event->mask);
@@ -146,11 +140,11 @@ static void verify_no_event(void)
 {
 	int ret;

-	ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+	ret = read(fd_notify, event_buf, EVENT_SIZE);
 	if (ret != -1) {
 		struct fanotify_event_metadata *event;

-		event = (struct fanotify_event_metadata *)&event_buf[len];
+		event = (struct fanotify_event_metadata *)&event_buf;
 		tst_res(TFAIL, "seen unexpected event (mask %llx)",
 			(unsigned long long)event->mask);
 		/* Cleanup fd from the event */
@@ -158,7 +152,7 @@ static void verify_no_event(void)
 			SAFE_CLOSE(event->fd);
 	} else if (errno != EAGAIN) {
 		tst_res(TFAIL | TERRNO, "read(%d, buf, %zu) failed", fd_notify,
-			EVENT_BUF_LEN);
+			EVENT_SIZE);
 	} else {
 		tst_res(TPASS, "No event as expected");
 	}
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
