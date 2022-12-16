Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CE9C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 04:01:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B448C3CBCD0
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 05:01:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90F3C3CBCEF
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:01:09 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 48565200C0E
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:01:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671163267; i=@fujitsu.com;
 bh=ySZYtbWXgYAXipNDhFRn70Smz9io5SXqv7QqEr0zqK8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=CqZatg94OEtEe6FfqTrxQP53yZ0LW5KHUhJoeg7WgAHtG580uPeA4/l+eQ6AcqeLu
 bGJrOQyPBgNhnNbPXuabtrCThOvnbruBAMJgaWlbnQVWSd/ROXYOLjdWuaniqkEaUY
 WXhmTtS3Q0MfnV3seak8VeNIP7a+at/lZ1aNUegGCCwLYu0YRA4MMmQmpUiFe9Rv8e
 zdlOh3k0Cti8NLSQQSZHw3vs5yRYAU9zFKOQnXDDKXYxH6CK8wBNdohH8ttTEEtJEF
 v0a2hzOZ8nNEiBdBORkd88IDYrxa7e2aBMogVC29pOK8NgXpxsumZPp3KV5AWuGHAu
 zPZ/j30VRYQ1Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8MxSbfp7ex
 kg/bzxhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bfc4/ZCrYZViz9fZ+9gfGvVhcjJ4eQwFlG
 iVdTbLsYuYDsA0wS835eZIVw9jBKnD17nx2kik1AU+JZ5wJmEFtEQEKio+EtWJxZQF1i+aRfT
 CC2sICHxOUbr8HiLAKqEg371rCA2Lwg8W0P2EBsCQEFiSkP3wPN4eDgFPCUeHzMGcQUAip596
 8eolpQ4uTMJywQ0yUkDr54wQzRqShxqeMbI4RdITFrVhsThK0mcfXcJuYJjIKzkLTPQtK+gJF
 pFaNpcWpRWWqRrrFeUlFmekZJbmJmjl5ilW6iXmqpbnlqcYmuoV5iebFeanGxXnFlbnJOil5e
 askmRmDYphSzVe9gfLv0j94hRkkOJiVRXv3ls5OF+JLyUyozEosz4otKc1KLDzHKcHAoSfBWv
 gbKCRalpqdWpGXmAGMIJi3BwaMkwrvlAlCat7ggMbc4Mx0idYrRmGNtw4G9zBxTZ//bzyzEkp
 eflyolzrvyFVCpAEhpRmke3CBYbF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMx74SXQFJ7
 MvBK4fa+ATmECOkXm3kyQU0oSEVJSDUzLhRuWfYqqMGRLO1DiWrLlypH09+vbJtWY8ccwrF/L
 8/Rl4gmzmxV+ZibLZ9r0TmqvcuWf0vhXVNV6U1ZmydZdAb1P5Cx3cjd7msosvv43VWXfpoxbD
 146blw18wg325KJgYeUpLLvsqjHBwfO3bj9iU9Fx+kNMxcliW0uM7crzdh09tf86Rvd85LOTP
 6kw2y1z+3123eN609t1H5gnVYaesol+voUs1ZhBvnyPtEuF8sz6bZbwjN2uKywOui6eVf9tg2
 iBuxOTV95djoc5Sra2FycmWPCqaLakVTCUH3nq9zEJeIR7Y+WXH2s5lJvEvfpiU+Hq55tTp41
 +5ImX0PZTPfPv93+8yt9Z09QUWIpzkg01GIuKk4EAMsV4LhoAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-585.messagelabs.com!1671163266!71896!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6326 invoked from network); 16 Dec 2022 04:01:06 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-20.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Dec 2022 04:01:06 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 734391000E7
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:01:06 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 65F991000D5
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:01:06 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 16 Dec 2022 04:01:04 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 16 Dec 2022 13:01:59 +0800
Message-ID: <1671166923-2173-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/7] cgroup_regression_test.sh: Remove obselte
 test_6
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

test_6 is a test case when kernel version is less than 3.0.
Since the oldest supported kernel version is 3.0, so the case
is useless. Remove it.

Also rename test9 to test6. modify TST_CNT.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/controllers/cgroup/.gitignore      |  1 -
 .../cgroup/cgroup_regression_6_1.sh           |  4 +-
 .../cgroup/cgroup_regression_6_2.c            | 36 ------------
 ...ession_9_2.sh => cgroup_regression_6_2.sh} |  0
 .../cgroup/cgroup_regression_9_1.sh           | 12 ----
 .../cgroup/cgroup_regression_test.sh          | 56 ++++---------------
 6 files changed, 12 insertions(+), 97 deletions(-)
 delete mode 100644 testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c
 rename testcases/kernel/controllers/cgroup/{cgroup_regression_9_2.sh => cgroup_regression_6_2.sh} (100%)
 delete mode 100755 testcases/kernel/controllers/cgroup/cgroup_regression_9_1.sh

diff --git a/testcases/kernel/controllers/cgroup/.gitignore b/testcases/kernel/controllers/cgroup/.gitignore
index 012aedcca..8deae77da 100644
--- a/testcases/kernel/controllers/cgroup/.gitignore
+++ b/testcases/kernel/controllers/cgroup/.gitignore
@@ -1,5 +1,4 @@
 /cgroup_regression_fork_processes
 /cgroup_regression_getdelays
-/cgroup_regression_6_2
 /cgroup_core01
 /cgroup_core02
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_6_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_6_1.sh
index 822d630a5..d5a3fa933 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_6_1.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_6_1.sh
@@ -6,7 +6,7 @@
 trap exit USR1
 
 while true; do
-	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
-	rmdir cgroup/[1-9]* > /dev/null 2>&1
+	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
+	cat cgroup/release_agent > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
 done
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c b/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c
deleted file mode 100644
index b79b93730..000000000
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2009 FUJITSU LIMITED
- * Author: Li Zefan <lizf@cn.fujitsu.com>
- */
-
-#define _GNU_SOURCE
-
-#include <sched.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include "test.h"
-
-#define DEFAULT_USEC	30000
-
-int foo(void __attribute__ ((unused)) * arg)
-{
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	int usec;
-
-	if (argc == 2)
-		usec = atoi(argv[1]);
-	else
-		usec = DEFAULT_USEC;
-
-	while (1) {
-		usleep(usec);
-		ltp_clone_quick(CLONE_NEWNS, foo, NULL);
-	}
-
-	tst_exit();
-}
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_9_2.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.sh
similarity index 100%
rename from testcases/kernel/controllers/cgroup/cgroup_regression_9_2.sh
rename to testcases/kernel/controllers/cgroup/cgroup_regression_6_2.sh
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_9_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_9_1.sh
deleted file mode 100755
index d5a3fa933..000000000
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_9_1.sh
+++ /dev/null
@@ -1,12 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2009 FUJITSU LIMITED
-# Author: Li Zefan <lizf@cn.fujitsu.com>
-
-trap exit USR1
-
-while true; do
-	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
-	cat cgroup/release_agent > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-done
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 436145788..c241a5c4f 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -7,7 +7,7 @@
 TST_TESTFUNC=test
 TST_SETUP=do_setup
 TST_CLEANUP=do_cleanup
-TST_CNT=9
+TST_CNT=8
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="awk dmesg find mountpoint rmdir"
@@ -244,38 +244,26 @@ test5()
 }
 
 #---------------------------------------------------------------------------
-# Bug:    There was a race between cgroup_clone and umount
-# Kernel: 2.6.24 - 2.6.28, 2.6.29-rcX
-# Links:  http://lkml.org/lkml/2008/12/24/124
-# Fix:    commit 7b574b7b0124ed344911f5d581e9bc2d83bbeb19
+# Bug:    When running 2 concurrent mount/umount threads, lockdep warning
+#         may be triggered, it's a false positive, and it's VFS' issue but
+#         not cgroup.
+# Kernel: 2.6.24 - 2.6.29-rcX
+# Links:  http://lkml.org/lkml/2009/1/4/352
+# Fix:    commit ada723dcd681e2dffd7d73345cc8fda0eb0df9bd
 #---------------------------------------------------------------------------
 test6()
 {
-	if tst_kvcmp -ge "3.0"; then
-		tst_res TCONF "CONFIG_CGROUP_NS is NOT supported in Kernels >= 3.0"
-		return
-	fi
-
-	if ! grep -q -w "ns" /proc/cgroups; then
-		tst_res TCONF "CONFIG_CGROUP_NS is NOT enabled"
-		return
-	fi
-
 	cgroup_regression_6_1.sh &
 	local pid1=$!
-	cgroup_regression_6_2 &
+	cgroup_regression_6_2.sh &
 	local pid2=$!
 
-	tst_res TINFO "run test for 30 sec"
 	sleep 30
-	kill -USR1 $pid1
-	kill -TERM $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1 2>/dev/null
 	wait $pid2 2>/dev/null
 
-	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
-	rmdir cgroup/[1-9]* > /dev/null 2>&1
-	tst_umount $PWD/cgroup
+	umount cgroup/ 2> /dev/null
 	check_kernel_bug
 }
 
@@ -396,29 +384,5 @@ test8()
 	check_kernel_bug
 }
 
-#---------------------------------------------------------------------------
-# Bug:    When running 2 concurrent mount/umount threads, lockdep warning
-#         may be triggered, it's a false positive, and it's VFS' issue but
-#         not cgroup.
-# Kernel: 2.6.24 - 2.6.29-rcX
-# Links:  http://lkml.org/lkml/2009/1/4/352
-# Fix:    commit ada723dcd681e2dffd7d73345cc8fda0eb0df9bd
-#---------------------------------------------------------------------------
-test9()
-{
-	cgroup_regression_9_1.sh &
-	local pid1=$!
-	cgroup_regression_9_2.sh &
-	local pid2=$!
-
-	sleep 30
-	kill -USR1 $pid1 $pid2
-	wait $pid1 2>/dev/null
-	wait $pid2 2>/dev/null
-
-	umount cgroup/ 2> /dev/null
-	check_kernel_bug
-}
-
 . cgroup_lib.sh
 tst_run
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
