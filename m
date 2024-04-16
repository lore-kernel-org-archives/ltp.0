Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA9CC4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713256637; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=vt1PKrI8uI61AWCxGeldekss0QYfZo2hTPZA0oDtW+g=;
 b=TcQI4OidalJVyjDxbA7tH9Uf344dlfSmC1c6ec7DV9SZVvxhAV0bTA0OUPd6L3Oy7WNeC
 4f87Ci7BuSnaGpU9fAJN+h4qjVmVfNiSg7+UG1tYUtsBkvxRF5qL/q/IyeBaGdjcm483M4m
 7iiN+KPZuAzgcIZGBLSiEN2Mr9FGbAQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 550183CFA9C
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 10:37:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 829A63CFA81
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:36:55 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A2251006090
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713256614; x=1744792614;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8b5JM58VuBoVJ6NJTEA6W2Q+BY+aORMm7wg+OsmC6Qw=;
 b=B5zu6vEiYZ20c/RhN3pb5tiUwLE5riOFSixrD/sopkdH6KqYcgg3hT8X
 XvA60av0tR5ZxEdhIHrwc64xK2/cUaL7kb15wiiccOYwxvMU+zoE2ZtIT
 aPjdpE9MAdy/9KMaQqfjmA+CsBvp3DdtgimaCyAfYTc6YuL4y8t+w0Txy
 wfbYHkzP2whxDK8uWJCnmyQas+zlyqiIaI2kgbeSYu17C1NweGdp0NfcB
 U28WtbljTvyeuPMho4GV5OKmXOXt62ee+v3swgH9nNTfQwMhoUCN6kaOH
 uf+QZVsKt+Ji3OrswDh2J8Wz5/hpafGPOlhIlVxDtN/nXEKr8vZXvZC0z Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="144188590"
X-IronPort-AV: E=Sophos;i="6.07,205,1708354800"; d="scan'208";a="144188590"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 17:36:52 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id CD911C690F
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 17:36:49 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 18F88E67AE
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 17:36:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9D1FC2009327E
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 17:36:48 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 29E6E1A000A;
 Tue, 16 Apr 2024 16:36:48 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 16 Apr 2024 04:02:37 -0400
Message-Id: <20240416080237.22627-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28324.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28324.006
X-TMASE-Result: 10--15.849400-10.000000
X-TMASE-MatchedRID: cSoPLjBYd51SuJfEWZSQfB1kSRHxj+Z59LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatT4xnGicftABGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoT2JuvcH3hnLLTB2jpoeDkpziy8MZTDuT0OeRRGICV9PWvaomg0i4KNmbc4hVJ/g/ld8C
 kyQrIqIxj1KnMr95tCEC9CQs9quav3FZ31mJ166IXQ/hu1OV/0lHLUcNM85dpHpEd1UrzmFdn/o
 cIR7L314vM1YF6AJbbCCfuIMF6xLSAHAopEd76vp0zU2mbiYTTPHnVwsXOkbLnHbyTAgkY8VYjE
 gPhj6saPZ/VWz7X0/g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] flock: Add negative tests for flock
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative cases for flock(), when errno is EINTR or EWOULDBLOCK

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/flock/.gitignore |  1 +
 testcases/kernel/syscalls/flock/flock07.c  | 98 ++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 testcases/kernel/syscalls/flock/flock07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9578e991a..de4f5a633 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -375,6 +375,7 @@ flock02 flock02
 flock03 flock03
 flock04 flock04
 flock06 flock06
+flock07 flock07
 
 fmtmsg01 fmtmsg01
 
diff --git a/testcases/kernel/syscalls/flock/.gitignore b/testcases/kernel/syscalls/flock/.gitignore
index c8cb0fc54..9bac582e1 100644
--- a/testcases/kernel/syscalls/flock/.gitignore
+++ b/testcases/kernel/syscalls/flock/.gitignore
@@ -3,3 +3,4 @@
 /flock03
 /flock04
 /flock06
+/flock07
diff --git a/testcases/kernel/syscalls/flock/flock07.c b/testcases/kernel/syscalls/flock/flock07.c
new file mode 100644
index 000000000..6fd650186
--- /dev/null
+++ b/testcases/kernel/syscalls/flock/flock07.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that flock(2) fails with
+ *
+ * - EINTR when waiting lock, call is interrupted by signal
+ * - EWOULDBLOCK when file is locked and LOCK_NB flag is selected
+ */
+
+#include <signal.h>
+#include <sys/file.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+
+#define TEST_INTR "test_intr"
+#define TEST_EWOULDBLOCK "test_ewouldblock"
+
+static struct test_case_t {
+	char *filename;
+	int expected_errno;
+	int child;
+	char *desc;
+} tcases[] = {
+	{TEST_INTR, EINTR, 1,
+		"while waiting lock, call is interrupted by signal"},
+	{TEST_EWOULDBLOCK, EWOULDBLOCK, 0,
+		"file is locked and LOCK_NB flag is selected"},
+};
+
+static void setup(void)
+{
+	SAFE_TOUCH(TEST_INTR, 0777, NULL);
+	SAFE_TOUCH(TEST_EWOULDBLOCK, 0777, NULL);
+}
+
+static void handler(int sig)
+{
+	switch (sig) {
+	case SIGUSR1:
+		tst_res(TINFO, "%s", "Got SIGUSR1");
+	break;
+	default:
+		tst_res(TINFO, "%s", "Got other signal");
+	break;
+	}
+}
+
+static void child_do(int fd, struct test_case_t *tc)
+{
+	struct sigaction sa;
+
+	sa.sa_handler = handler;
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+
+	TST_EXP_FAIL(flock(fd, LOCK_EX), tc->expected_errno, "%s", tc->desc);
+}
+
+static void verify_flock(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+	pid_t pid;
+	int fd1 = SAFE_OPEN(tc->filename, O_RDWR);
+	int fd2 = SAFE_OPEN(tc->filename, O_RDWR);
+
+	if (tc->child) {
+		flock(fd1, LOCK_EX);
+		pid = SAFE_FORK();
+		if (!pid) {
+			child_do(fd2, tc);
+			exit(0);
+		}
+		sleep(1);
+		SAFE_KILL(pid, SIGUSR1);
+		SAFE_WAITPID(pid, NULL, 0);
+	} else {
+		flock(fd1, LOCK_EX);
+		TST_EXP_FAIL(flock(fd2, LOCK_EX | LOCK_NB), tc->expected_errno,
+			"%s", tc->desc);
+	}
+	SAFE_CLOSE(fd1);
+	SAFE_CLOSE(fd2);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_flock,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
