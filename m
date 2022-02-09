Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B25C433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:42:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161673C9B72
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:42:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 778403C6912
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:42:36 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BECC81000965
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1644399755; i=@fujitsu.com;
 bh=hHfNWXPVq+x4XViCZbj6xMlWdmenKWvxmThYmRJxcJ8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=L215YmqySF5MdBoqWKHhNI5q6r/jc20kqDCbjRvoUjyC7ml2YSYG8V8ZWV+a1D1cB
 tTX+qI3l+101aFgwOVRWcRiZQQf+mFfWai6Q8Aw1UPhCotp+HlM6P1nlcZ+om8mBXl
 XtrBoAC/kj2aAlGwzZCnpgkpzdQprAk7YE/0ckyN7NnV/dUq3ZxVEvSYWNmuuYyieY
 bg4upH+AYUQ43jy+cBRsXh8m+T6rlrusNMN6WahlBLt0TWHy4pcFlb47MJFnK+LWxW
 iJ3GBNu+KgDyv7X1rm1lNANNETEY4qdDBVCs8jYN7QPLjX4xHpD0IqrB8mAuUov2jb
 e8zvtyboAv2JA==
Received: from [100.115.69.41] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-central-1.aws.ess.symcld.net id EA/6B-24566-B8C83026;
 Wed, 09 Feb 2022 09:42:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsViZ8MxSberhzn
 JYFaLocWK7zsYHRg99v1exxrAGMWamZeUX5HAmjG94SxjwRKZilmN7awNjJskuhi5OIQEzjJK
 7Dr6gLGLkRPI2ckk8WGTDERiN6PE7T97wBJsApoSzzoXMIPYIgISEh0Nb9lBbGYBdYnlk34xg
 djCAoESP6Z/AKrn4GARUJGYsssYxOQV8JD49kEHpEJCQEFiysP3YFM4BTwljh89xApSIgRUsq
 qpACTMKyAocXLmExaI4RISB1+8YIZoVZS41PGNEcKukJg1q40JwlaTuHpuE/MERsFZSNpnIWl
 fwMi0itEuqSgzPaMkNzEzR9fQwEDX0NBU18xM18jIQi+xSjdRL7VUNzk1r6QoESitl1herJda
 XKxXXJmbnJOil5dasokRGMYpxU5PdjC+7vupd4hRkoNJSZS3fyZTkhBfUn5KZUZicUZ8UWlOa
 vEhRhkODiUJ3s0VzElCgkWp6akVaZk5wJiCSUtw8CiJ8E7pBkrzFhck5hZnpkOkTjHqcrxu+b
 mDWYglLz8vVUqcdy1IkQBIUUZpHtwIWHxfYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTM21I
 LNIUnM68EbtMroCOYgI7YNp0J5IiSRISUVAPT3UhGZmXTzX1rPv4/MD3hceJbmeuyLVILntQu
 F3RaYmZpVOsaaVvCcb2WSXC75dr+azvemawyyit6d/Xlv8JHp/sO3Tu7UuPyVu8N8jcOSd1b9
 /6ie8Meryo/7fTJT2yVbBnXe1ucLrZKub1tT2HG/6jeX0flDFjXCLuEa9jzhdsevXZ7m4iD81
 TdA3wc/u3zFv+zsH4Z0K9/SGiBV9qhkL8zg83enNiSVWp5eiZnlIW9g6TZtx+e57IUri035tr
 8Mmvy26tbTn7ZfzroLg+D2Oe+DeK2POGztOYYLrhkG/PK49nld2vWNIf8rj6fExnxXLHIoetD
 6vZFWlvSnxfuCUj8eEdxVcuCkPLiqkoJJZbijERDLeai4kQA7M5l7WoDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-528.messagelabs.com!1644399754!15600!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30677 invoked from network); 9 Feb 2022 09:42:34 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-4.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Feb 2022 09:42:34 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 5174C10033A
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:42:34 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 451781000FB
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:42:34 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Wed, 9 Feb 2022 09:42:12 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 9 Feb 2022 17:42:18 +0800
Message-ID: <1644399738-2155-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/pidfd_open04: Add new test with
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
 .../kernel/syscalls/pidfd_open/pidfd_open04.c | 78 +++++++++++++++++++
 3 files changed, 80 insertions(+)
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
index 000000000..436351f23
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
@@ -0,0 +1,78 @@
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
+	int flag, pid, pidfd;
+	siginfo_t info;
+
+	pid = SAFE_FORK();
+	if (!pid)
+		pause();
+
+	TST_EXP_PID_SILENT(pidfd_open(pid, PIDFD_NONBLOCK),
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
+	SAFE_KILL(pid, SIGTERM);
+	SAFE_WAIT(NULL);
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
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
