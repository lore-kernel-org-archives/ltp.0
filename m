Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E241C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 03:41:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD9943C9DBD
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 04:41:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D78B3C23B0
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 04:41:03 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8781F1A00346
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 04:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1644464461; i=@fujitsu.com;
 bh=GwQSD24YRgyzq0LLqQE7QjJMA5zUocS0g71FXMUb/N8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=K4AoBHOU6Lyt+EHXJdwU1a2pfQVQLARfS5ovMyHRKg6AXf4zG6u4Xyp58edSj52Qi
 U1bMVcDavh81AItsteDHYLjIaCe8/Rp6jAiLVLiKl2Dd+yrLNuIFvK7+YJ3SagYFFY
 4/loLZhH/Hf9hZFJ1O+yopGba8k2+Yr9eqT73g3jJrX+zkcnxN0BIIYHtHjfkv7ZWV
 CzeWQU83Dxc+Z+fAQ0QXc94lDc1Ge2MAXac02jsHBpPaaVQkvpvVZ03zYjsQ6iCR6J
 57hz+NQJfp4Q1cBNc54kQibiDqwfNqMtkEt5BpBFMLH7g85rb3giN7O21dljKeat6R
 6PWWjb+EhUanA==
Received: from [100.115.37.210] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id 66/A2-29321-D4984026;
 Thu, 10 Feb 2022 03:41:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRWlGSWpSXmKPExsViZ8MxRdenkyX
 J4M5HC4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNaPj4nP2gsnyFZsedTM1ML6R6mLk4hASaGKS
 mLVsKSOEs4dRYtWmFqYuRk4ONgFNiWedC5hBbBEBCYmOhrfsIDazgLrE8km/wGqEBUIktncsA
 4uzCKhKHJjVyAJi8wp4SnzrWw1mSwgoSEx5+B5sDqeAl8SKc9NYuxg5gJYlS9zdFghRLihxcu
 YTFojxEhIHX7xghmhVlLjU8Y0Rwq6QmDWrjWkCI/8sJC2zkLQsYGRaxWidVJSZnlGSm5iZo2t
 oYKBraGiqa2ysa2huqZdYpZuol1qqW55aXKJrpJdYXqyXWlysV1yZm5yTopeXWrKJERiUKcWK
 m3cwTlz5U+8QoyQHk5Ior2YbS5IQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCV6JRqCcYFFqempFW
 mYOMEJg0hIcPEoivN9bgdK8xQWJucWZ6RCpU4y6HDu3XN7LLMSSl5+XKiXO+6EdqEgApCijNA
 9uBCxaLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5lXoAJrCk5lXArfpFdARTEBHbJvOBHJ
 ESSJCSqqBiTv+8VH22C1MM5VvvLnIs1JzGkfF8bW2nstWe31/cCD8ufHs6Q3TIjddYrp1/kL2
 vSfPfF1MsljkVYuSKjl3G/Bl+E89Uxqtnc96aNKpmD4bGcM/7fXNzl0Tb3J8aP3q8aHjqXlXe
 VWZ9O72ZiuDGokYTUXjxQvUK8O69104coTr4oeAKSXpare9L039EObRLczSvtX/KpNvh02i3W
 Lp+R8DM7zX9Wze4rv+b9D0NEkFY3nRp9PW1X/nDrokY1fefZNhpV/wbI3/Xbk6zC9/1T/x5+g
 x19n1irtJ28XxVbT6wQ03Vj1jPJZ14Max84pdzcflvglZ17d0+Edd/ZarVvnZO7GQ0aJliavQ
 z71KLMUZiYZazEXFiQBcWC5sUQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-571.messagelabs.com!1644464460!43071!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 733 invoked from network); 10 Feb 2022 03:41:00 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-15.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Feb 2022 03:41:00 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 21A3erRu002560
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 03:41:00 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Thu, 10 Feb 2022 03:40:56 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 10 Feb 2022 11:41:17 +0800
Message-ID: <1644464477-16644-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644464477-16644-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YgPNWHc+xwKCRcvv@pevik>
 <1644464477-16644-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/pidfd_open04: Add new test with
 PIDFD_NONBLOCK flag
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

As pidfd_open man-page said
"PIDFD_NONBLOCK (since Linux 5.10)
Return a nonblocking file descriptor.  If the process referred to by
the file descriptor has not yet terminated, then an attempt to wait
on the file descriptor using waitid(2) will immediately  return
the error EAGAIN rather than blocking."

Test this and also test whether set NONBLOCK flag in its pidfd.

Noticed that, don't introduce lapi/pidfd.h because linux/pidfd.h uses
kernel header fcntl.h but ltp api uses libc header. so it may
exist redefinition error of 'struct flock'[1].

[1]https://github.com/golang/go/issues/48221

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/pidfd_open/.gitignore     |  1 +
 .../kernel/syscalls/pidfd_open/pidfd_open04.c | 90 +++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pidfd_open/pidfd_open04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c3e037f72..ce6f89f88 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -954,6 +954,7 @@ personality02 personality02
 pidfd_open01 pidfd_open01
 pidfd_open02 pidfd_open02
 pidfd_open03 pidfd_open03
+pidfd_open04 pidfd_open04
 
 pidfd_send_signal01 pidfd_send_signal01
 pidfd_send_signal02 pidfd_send_signal02
diff --git a/testcases/kernel/syscalls/pidfd_open/.gitignore b/testcases/kernel/syscalls/pidfd_open/.gitignore
index e0b8900c1..cebdc624d 100644
--- a/testcases/kernel/syscalls/pidfd_open/.gitignore
+++ b/testcases/kernel/syscalls/pidfd_open/.gitignore
@@ -1,3 +1,4 @@
 pidfd_open01
 pidfd_open02
 pidfd_open03
+pidfd_open04
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
new file mode 100644
index 000000000..91c7f26e1
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that the PIDFD_NONBLOCK flag works with pidfd_open() and
+ * that waitid() with a non-blocking pidfd returns EAGAIN.
+ */
+
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "lapi/pidfd_open.h"
+
+#ifndef PIDFD_NONBLOCK
+#define PIDFD_NONBLOCK O_NONBLOCK
+#endif
+
+#ifndef P_PIDFD
+#define P_PIDFD  3
+#endif
+
+static void run(void)
+{
+	int flag, pid, pidfd, ret;
+	siginfo_t info;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TST_CHECKPOINT_WAIT(0);
+		exit(EXIT_SUCCESS);
+	}
+
+	TST_EXP_FD_SILENT(pidfd_open(pid, PIDFD_NONBLOCK),
+				"pidfd_open(%d,  PIDFD_NONBLOCK)", pid);
+
+	pidfd = TST_RET;
+	flag = fcntl(pidfd, F_GETFL);
+	if (flag == -1)
+		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFL) failed");
+
+	if (!(flag & O_NONBLOCK))
+		tst_brk(TFAIL, "pidfd_open(%d, O_NONBLOCK) didn't set O_NONBLOCK flag", pid);
+
+	tst_res(TPASS, "pidfd_open(%d, O_NONBLOCK) sets O_NONBLOCK flag", pid);
+
+	TST_EXP_FAIL(waitid(P_PIDFD, pidfd, &info, WEXITED), EAGAIN,
+			"waitid(P_PIDFD,...,WEXITED)");
+
+	TST_CHECKPOINT_WAKE(0);
+
+	ret = TST_RETRY_FUNC(waitid(P_PIDFD, pidfd, &info, WEXITED), TST_RETVAL_EQ0);
+	if (ret == 0) {
+		tst_res(TPASS, "waitid(P_PIDFD) succeeded after child process terminated");
+	} else {
+		tst_res(TFAIL, "waitid(P_PIDFD) failed after child process terminated");
+		SAFE_WAIT(NULL);
+	}
+
+	SAFE_CLOSE(pidfd);
+}
+
+static void setup(void)
+{
+	pidfd_open_supported();
+
+	TEST(pidfd_open(getpid(), PIDFD_NONBLOCK));
+	if (TST_RET == -1) {
+		if (TST_ERR == EINVAL) {
+			tst_brk(TCONF, "PIDFD_NONBLOCK was supported since linux 5.10");
+			return;
+		}
+		tst_brk(TFAIL | TTERRNO,
+			"pidfd_open(getpid(),PIDFD_NONBLOCK) failed unexpectedly");
+	}
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
