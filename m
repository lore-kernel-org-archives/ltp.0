Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E496C54E64
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 08:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711614866; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=jhfiBRzLiN11Qb7scr0l04RBRUJ4lqbHBv2mT17qx1w=;
 b=qXCpp7no7tdfgaPUDACgbHkmvShhaNCNky0oynXU075u0kds6Y+YxnQJq3micG1488yPm
 dXd6bHfAqEtMbf9+GChHiQN9WF7krlwOWUw3/xsmYCfiC4gFTfsl0hm52eE4sTVDYoVrsxe
 gTtoTW8rhWkrfgQ8dlr+DMsagPahw+Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 462593C1AC0
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 09:34:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61EEA3C08AA
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 09:34:02 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=andestech.com (client-ip=60.248.80.70; helo=atcsqr.andestech.com;
 envelope-from=minachou@andestech.com; receiver=lists.linux.it)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0AED21B60EC8
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 09:33:58 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42S8XoJE089791
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 16:33:50 +0800 (+08)
 (envelope-from minachou@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Mar 2024 16:33:50 +0800
To: <ltp@lists.linux.it>
Date: Thu, 28 Mar 2024 16:33:44 +0800
Message-ID: <20240328083344.277502-1-minachou@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42S8XoJE089791
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/setitimer: Pass the kernel-defined struct
 __kernel_old_itimerval to sys_setitimer().
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
From: Hui Min Mina Chou via ltp <ltp@lists.linux.it>
Reply-To: Hui Min Mina Chou <minachou@andestech.com>
Cc: minachou@andestech.com, tim609@andestech.com, cynthia@andestech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The setitimer01 tests fail on RV32 due to incompatible parameter
definitions. 'value' and 'ovalue' are defined by glibc as itimerval
(64-bit time_t on RV32), while the kernel expects __kernel_old_itimerval
(32-bit time_t on RV32) for the setitimer syscall[1]. This discrepancy
leads to incorrect 'ovalue' and test failures. Thus, the kernel-defined
__kernel_old_itimerval should be used.

[1] https://sourceware.org/git/?p=glibc.git;a=commit;h=a51e03588937ad804a9f583ea3d0fc0a4d088c33
Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
---
 configure.ac                                      |  3 ++-
 include/tst_timer.h                               | 12 ++++++++++++
 testcases/kernel/syscalls/setitimer/setitimer01.c |  8 ++------
 testcases/kernel/syscalls/setitimer/setitimer02.c | 12 ++++--------
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1d7e862d88fb..8de6239a55f5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -219,7 +219,8 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
 ])
 
 AC_CHECK_TYPES([struct __kernel_old_timeval, struct __kernel_old_timespec, struct __kernel_timespec,
-                struct __kernel_old_itimerspec, struct __kernel_itimerspec],,,[#include <sys/socket.h>])
+                struct __kernel_old_itimerspec, struct __kernel_itimerspec,
+                struct __kernel_old_itimerval],,,[#include <sys/socket.h>])
 
 AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
 AC_CHECK_TYPES([struct mount_attr],,,[
diff --git a/include/tst_timer.h b/include/tst_timer.h
index 703f03294eae..6fb9400206b8 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -135,6 +135,13 @@ struct __kernel_itimerspec {
 	struct __kernel_timespec it_value;       /* timer expiration */
 };
 #endif
+
+#ifndef HAVE_STRUCT___KERNEL_OLD_ITIMERVAL
+struct __kernel_old_itimerval {
+	struct __kernel_old_timeval it_interval;	/* timer interval */
+	struct __kernel_old_timeval it_value;		/* current value */
+};
+#endif
 #endif
 
 enum tst_ts_type {
@@ -370,6 +377,11 @@ static inline int sys_timerfd_settime64(int fd, int flags, void *its,
 	return tst_syscall(__NR_timerfd_settime64, fd, flags, its, old_its);
 }
 
+static inline int sys_setitimer(int which, void *new_value, void *old_value)
+{
+	return tst_syscall(__NR_setitimer, which, new_value, old_value);
+}
+
 /*
  * Returns tst_ts seconds.
  */
diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index d12abe904f1c..94ee51c6a667 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -20,9 +20,10 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "tst_safe_clocks.h"
+#include "tst_timer.h"
 
 static struct timeval tv;
-static struct itimerval *value, *ovalue;
+static struct __kernel_old_itimerval *value, *ovalue;
 static volatile unsigned long sigcnt;
 static long time_step;
 static long time_sec;
@@ -38,11 +39,6 @@ static struct tcase {
 	{ITIMER_PROF,    "ITIMER_PROF",    SIGPROF},
 };
 
-static int sys_setitimer(int which, void *new_value, void *old_value)
-{
-	return tst_syscall(__NR_setitimer, which, new_value, old_value);
-}
-
 static void sig_routine(int signo LTP_ATTRIBUTE_UNUSED)
 {
 	sigcnt++;
diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
index b012d71fa7bd..c545f6288bbb 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer02.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
@@ -19,13 +19,9 @@
 #include <stdlib.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "tst_timer.h"
 
-static struct itimerval *value, *ovalue;
-
-static int sys_setitimer(int which, void *new_value, void *old_value)
-{
-	return tst_syscall(__NR_setitimer, which, new_value, old_value);
-}
+static struct __kernel_old_itimerval *value, *ovalue;
 
 static void verify_setitimer(unsigned int i)
 {
@@ -55,8 +51,8 @@ static struct tst_test test = {
 	.test = verify_setitimer,
 	.setup = setup,
 	.bufs = (struct tst_buffers[]) {
-		{&value,  .size = sizeof(struct itimerval)},
-		{&ovalue, .size = sizeof(struct itimerval)},
+		{&value,  .size = sizeof(struct __kernel_old_itimerval)},
+		{&ovalue, .size = sizeof(struct __kernel_old_itimerval)},
 		{}
 	}
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
