Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEC9C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 08:41:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D24F3CA193
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 09:41:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F418E3CA18D
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:15 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D788010008F5
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645519273; i=@fujitsu.com;
 bh=z99TKJgnvEYtOnfJRMFcjtaLKM2PDDVWoXuKI0Fw5u4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=mjTzqjuz3EnzJ1uuLyVT10SBwG5Ssa9EepV9r8hxa7LUUsgZDxS8LmuX1htV07F5T
 M3N0h7MAv2MclhQuu2R4aDPo6dDVa83Z6AEYCugzCsS0v24NcGoFUJLAUm1UHBkZht
 H+GSlBlkmw63SWfNvNq8LtBvPQvtL/sKMj3FMLFU9rsntCftHYlS05Yr2bRlwOopQA
 rJwSV/4kaSfBjmg3ZNFs1W5FzIovn9VZiWP3varV2WcSQFE1WSEa+mu09J2PHbY+Ri
 z/0HP2hbjqJLlEy4b3D4rDRJnUFicDaxpL7DaTqPgWycmEiR/uueG7n0dJTY0xxdOg
 rANaWF/prR6wA==
Received: from [100.115.7.206] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id 2F/27-21232-9A1A4126;
 Tue, 22 Feb 2022 08:41:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8ORqLtyoUi
 SwYnX8hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8a2z6sYC75IVpx48p2lgfGmaBcjF4eQwFlG
 ifMfW5kgnJ1MEo87/7BDOHsYJb5M+s7SxcjJwSagKfGscwEziC0iICHR0fCWHcRmFlCXWD7pF
 xOILSzgLTFjwR5WEJtFQFViw/rljF2MHBy8Ah4Sr6+ogoQlBBQkpjx8DzaGU8BT4sm8e2C2EF
 DJk2O/wWxeAUGJkzOfsECMl5A4+OIFM0SvosSljm+MEHaFxKxZbUwQtprE1XObmCcwCs5C0j4
 LSfsCRqZVjJZJRZnpGSW5iZk5uoYGBrqGhqa6hrqmlnqJVbqJeqmluuWpxSW6hnqJ5cV6qcXF
 esWVuck5KXp5qSWbGIEhnFLMaL2DsaPvp94hRkkOJiVR3q9TRJKE+JLyUyozEosz4otKc1KLD
 zHKcHAoSfAunQeUEyxKTU+tSMvMAcYTTFqCg0dJhHfLbKA0b3FBYm5xZjpE6hSjopQ4r8ACoI
 QASCKjNA+uDRbDlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ84bNB5rCk5lXAjf9FdBiJqD
 FU7KEQBaXJCKkpBqYluW1Fav97Dy/X1e0aEVWSWrPR4u5zd59HuGizYzTsjPu1Ow/Pz/x5cZl
 e07Efl+06s+ZqIn71cX09lx5ubvG8MKpiYt7vUN1Pu3ndl/WWaChW6z17BjH3hOnzZdlVe1xe
 N895bdt3qqvwvJe5u2eTDF/vNjnscz6/yM9jbHA4f8DPcs8zycpc67yXj0wI3BbjVXXOtU9YS
 5GO4U8V2/ddvvCFZZjHZL1zvvCkl+ytEm2bGioePXUL+3QpMv3/Pln8U3IYlu7dueexynhi0P
 9F1snPq9PffhAWtbf5e+JGYGubZWmoY4ZMmujC/3VE1y/xvjrnL/LZndWdfl3jpz/tjd2Nuyf
 rLt0xq3jnuWvlFiKMxINtZiLihMBLPtGrVwDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-587.messagelabs.com!1645519273!49874!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14077 invoked from network); 22 Feb 2022 08:41:13 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-9.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Feb 2022 08:41:13 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 0445C10019B
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:41:13 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id E602A100199
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:41:12 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 08:40:59 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 22 Feb 2022 16:41:07 +0800
Message-ID: <1645519272-2733-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/7] syscalls/pidfd_send_signal: Add docparse
 formatting
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../pidfd_send_signal/pidfd_send_signal01.c   |  5 +++-
 .../pidfd_send_signal/pidfd_send_signal02.c   | 25 +++++++++----------
 .../pidfd_send_signal/pidfd_send_signal03.c   |  7 +++++-
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
index 3d201aa9d..471585025 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
@@ -3,7 +3,10 @@
  * Copyright (c) 2019 SUSE LLC
  * Author: Christian Amann <camann@suse.com>
  */
-/*
+
+/*\
+ * [Description]
+ *
  * Tests if the pidfd_send_signal syscall behaves
  * like rt_sigqueueinfo when a pointer to a siginfo_t
  * struct is passed.
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
index 9600fc2f9..a3bf994f9 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
@@ -3,22 +3,21 @@
  * Copyright (c) 2019 SUSE LLC
  * Author: Christian Amann <camann@suse.com>
  */
-/*
+
+/*\
+ * [Description]
+ *
  * Tests basic error handling of the pidfd_send_signal
  * system call.
  *
- * 1) Pass invalid flag value to syscall (value chosen
- *    to be unlikely to collide with future extensions)
- *    -> EINVAL
- * 2) Pass a file descriptor that is corresponding to a
- *    regular file instead of a pid directory
- *    -> EBADF
- * 3) Pass a signal that is different from the one used
- *    to initialize the siginfo_t struct
- *    -> EINVAL
- * 4) Try to send signal to other process (init) with
- *    missing privileges
- *    -> EPERM
+ * - EINVAL Pass invalid flag value to syscall (value chosen
+ *   to be unlikely to collide with future extensions)
+ * - EBADF Pass a file descriptor that is corresponding to a
+ *   regular file instead of a pid directory
+ * - EINVAL Pass a signal that is different from the one used
+ *   to initialize the siginfo_t struct
+ * - EPERM Try to send signal to other process (init) with
+ *   missing privileges
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
index fb61516d7..20d96b118 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
@@ -3,13 +3,18 @@
  * Copyright (c) 2019 SUSE LLC
  * Author: Christian Amann <camann@suse.com>
  */
-/*
+
+/*\
+ * [Description]
+ *
  * This test checks if the pidfd_send_signal syscall wrongfully sends
  * a signal to a new process which inherited the PID of the actual
  * target process.
+ *
  * In order to do so it is necessary to start a process with a pre-
  * determined PID. This is accomplished by writing to the
  * /proc/sys/kernel/ns_last_pid file.
+ *
  * By utilizing this, this test forks two children with the same PID.
  * It is then checked, if the syscall will send a signal to the second
  * child using the pidfd of the first one.
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
