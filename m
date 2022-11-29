Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C63AC433FE
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 05:40:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 286A83CC598
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 06:40:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1053D3CC590
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 06:40:29 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 015E41A004A2
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 06:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1669700428; i=@fujitsu.com;
 bh=DrtN8maQo3PLrZhrGW/XISQN/lqwjKfP46PLacRyAoc=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=SMMbOAxn4hy1OGUkYAQ9WwXCZs/nyjFDsL/d9aJFHGYXoATglDOcKV+yid+mCJAN8
 uj/Y+mZKMab1r+jxyPVaKQgFDmxjOo7c58YGqOME3K3ohxFBataZ9FCXWv4e0mtKtY
 gDK8J0LQs7wLKakk29bjjUIm9bJTQ87kzENyz8A0njtwP5d6+WsN5PAuW4kcn9Hv6F
 x4rdlq3uGCMriGKeX1XxUucKEp8PK9llkfTOHSo3fjg2uTKDdb0qxOPvpn1aiQo0es
 kzv4n3sMuZR6vQCPoRGtr6yUHMWIl658i1lQW2Bga70ZeTvkboXuxNxw7lr0Bm3kyD
 I/FSEX6WBnzaA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsViZ8OxWdd7dmu
 ywe4DKhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8afKUeZCnrNKh69OczYwLhWv4uRi0NI4BSj
 RM/z+4wQzh4midcvprJCOYwSx68dY+5i5ORgE9CUeNa5AMwWEZCQ6Gh4yw5iMwuoSyyf9IsJx
 BYW8JRYvbSdBcRmEVCVWNLyFayGV8BD4tiv+2A1EgIKElMevgeaw8HBCVR//A1YiRBQSddakL
 0g5YISJ2c+YYEYLyFx8MULZohWRYlLHd8YIewKiVmz2qBGqklcPbeJeQKj4Cwk7bOQtC9gZFr
 FaFqcWlSWWqRropdUlJmeUZKbmJmjl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOil5da
 sokRGLopxWw+Oxj/Lf2jd4hRkoNJSZT3RUVrshBfUn5KZUZicUZ8UWlOavEhRhkODiUJXsUZQ
 DnBotT01Iq0zBxgHMGkJTh4lER47SqB0rzFBYm5xZnpEKlTjMYcU2f/28/MsWlf1wFmIZa8/L
 xUKXHenFlApQIgpRmleXCDYPF9iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iwb/B0oCk8mXk
 lcPteAZ3CBHTKJsUmkFNKEhFSUg1MQb8EVxxR9PzsPWPN3X0HJvrfnF2nb3xuw8k1lXt2PAyR
 cfV7F2Q/I/tqzUEXzZeuBzd4tsqEXnl2ltfyZ+N+K76vQSdEYr53v4v91KRxNXtG/8fFjw+W6
 69L+HbtsMvNhm3vY+y5txQsyO9k509o1Z8ip2HnUp7JOOWR1VFnBV5rhq+1S6097hqduXXwk3
 7UgRxr5daZS5bPYP9g42IrK6hl2OHqb22m+bb86softnoyz07+kztlcJFbVeVN8TS3pQIBJTH
 BZ3KMjzGn8Zy1tW24f++s2arz0yvU52godqtnH4lcxd8X+e162W2b2qnmMoU/W/P2nD725eqK
 jzM9P31as25WtN634EU11vuFlViKMxINtZiLihMBBk1vnWoDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-18.tower-585.messagelabs.com!1669700427!321743!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1764 invoked from network); 29 Nov 2022 05:40:27 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-18.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 29 Nov 2022 05:40:27 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 38D25152
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 05:40:27 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 2B2C373
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 05:40:27 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 29 Nov 2022 05:40:25 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 29 Nov 2022 14:41:00 +0800
Message-ID: <1669704060-5635-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] include/lapi/sched.h: Move lapi/clone.h into
 here
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

Like namespaces_constants.h, kernel doesn't have
clone.h header. We can also move it into here.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
This patch has been verified on my ltp fork[1].
[1]https://github.com/xuyang0410/ltp/actions/runs/3571298308/jobs/6003048080
 include/lapi/clone.h                          | 56 -------------------
 include/lapi/sched.h                          | 31 ++++++++++
 lib/tst_clone.c                               |  2 +-
 testcases/kernel/containers/pidns/pidns13.c   |  2 +-
 testcases/kernel/containers/userns/userns08.c |  2 +-
 testcases/kernel/syscalls/clone3/clone301.c   |  2 +-
 testcases/kernel/syscalls/clone3/clone302.c   |  2 +-
 .../syscalls/close_range/close_range01.c      |  2 +-
 .../syscalls/close_range/close_range02.c      |  2 +-
 9 files changed, 38 insertions(+), 63 deletions(-)
 delete mode 100644 include/lapi/clone.h

diff --git a/include/lapi/clone.h b/include/lapi/clone.h
deleted file mode 100644
index 437d1376f..000000000
--- a/include/lapi/clone.h
+++ /dev/null
@@ -1,56 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2020 Linaro Limited. All rights reserved.
- * Author: Viresh Kumar <viresh.kumar@linaro.org>
- */
-
-#ifndef LAPI_CLONE_H__
-#define LAPI_CLONE_H__
-
-#include <sys/syscall.h>
-#include <linux/types.h>
-#include <sched.h>
-#include <stdint.h>
-
-#include "config.h"
-#include "lapi/syscalls.h"
-
-#ifndef HAVE_CLONE3
-struct clone_args {
-	uint64_t __attribute__((aligned(8))) flags;
-	uint64_t __attribute__((aligned(8))) pidfd;
-	uint64_t __attribute__((aligned(8))) child_tid;
-	uint64_t __attribute__((aligned(8))) parent_tid;
-	uint64_t __attribute__((aligned(8))) exit_signal;
-	uint64_t __attribute__((aligned(8))) stack;
-	uint64_t __attribute__((aligned(8))) stack_size;
-	uint64_t __attribute__((aligned(8))) tls;
-};
-
-static inline int clone3(struct clone_args *args, size_t size)
-{
-	return tst_syscall(__NR_clone3, args, size);
-}
-#endif
-
-#ifndef CLONE_PIDFD
-#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in parent */
-#endif
-
-#ifndef CLONE_NEWUSER
-# define CLONE_NEWUSER	0x10000000
-#endif
-
-static inline void clone3_supported_by_kernel(void)
-{
-	long ret;
-
-	if ((tst_kvercmp(5, 3, 0)) < 0) {
-		/* Check if the syscall is backported on an older kernel */
-		ret = syscall(__NR_clone3, NULL, 0);
-		if (ret == -1 && errno == ENOSYS)
-			tst_brk(TCONF, "Test not supported on kernel version < v5.3");
-	}
-}
-
-#endif /* LAPI_CLONE_H__ */
diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 3b0b4be31..1d22a9d7e 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <stdint.h>
 #include <inttypes.h>
+#include "config.h"
 #include "lapi/syscalls.h"
 
 struct sched_attr {
@@ -43,6 +44,32 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
 	return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }
 
+#ifndef HAVE_CLONE3
+struct clone_args {
+	uint64_t __attribute__((aligned(8))) flags;
+	uint64_t __attribute__((aligned(8))) pidfd;
+	uint64_t __attribute__((aligned(8))) child_tid;
+	uint64_t __attribute__((aligned(8))) parent_tid;
+	uint64_t __attribute__((aligned(8))) exit_signal;
+	uint64_t __attribute__((aligned(8))) stack;
+	uint64_t __attribute__((aligned(8))) stack_size;
+	uint64_t __attribute__((aligned(8))) tls;
+};
+
+static inline int clone3(struct clone_args *args, size_t size)
+{
+	return tst_syscall(__NR_clone3, args, size);
+}
+#endif
+
+static inline void clone3_supported_by_kernel(void)
+{
+	if ((tst_kvercmp(5, 3, 0)) < 0) {
+		/* Check if the syscall is backported on an older kernel */
+		tst_syscall(__NR_clone3, NULL, 0);
+	}
+}
+
 #ifndef SCHED_DEADLINE
 # define SCHED_DEADLINE	6
 #endif
@@ -55,6 +82,10 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
 # define CLONE_FS	0x00000200
 #endif
 
+#ifndef CLONE_PIDFD
+# define CLONE_PIDFD	0x00001000
+#endif
+
 #ifndef CLONE_NEWNS
 # define CLONE_NEWNS	0x00020000
 #endif
diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index 07e7f0767..ecc84408c 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -8,7 +8,7 @@
 #include <stddef.h>
 
 #include "tst_test.h"
-#include "lapi/clone.h"
+#include "lapi/sched.h"
 
 pid_t tst_clone(const struct tst_clone_args *tst_args)
 {
diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 39fd6df7f..6a155027c 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -31,7 +31,7 @@
 
 #include "tst_test.h"
 #include "tst_clone.h"
-#include "lapi/clone.h"
+#include "lapi/sched.h"
 
 static int pipe_fd[2];
 
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index afdad6cad..2697d874b 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -25,7 +25,7 @@
 
 #include "tst_test.h"
 #include "tst_clone.h"
-#include "lapi/clone.h"
+#include "lapi/sched.h"
 #include "tst_safe_file_at.h"
 
 static pid_t clone_newuser(void)
diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
index f7ef0b2d7..d0fadbc5d 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -15,7 +15,7 @@
 #include <sys/wait.h>
 
 #include "tst_test.h"
-#include "lapi/clone.h"
+#include "lapi/sched.h"
 #include "lapi/pidfd.h"
 
 #define CHILD_SIGNAL	SIGUSR1
diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
index 08d6417ce..b1b4ccebb 100644
--- a/testcases/kernel/syscalls/clone3/clone302.c
+++ b/testcases/kernel/syscalls/clone3/clone302.c
@@ -14,7 +14,7 @@
 #include <stdlib.h>
 
 #include "tst_test.h"
-#include "lapi/clone.h"
+#include "lapi/sched.h"
 
 static struct clone_args *valid_args, *invalid_args;
 unsigned long stack;
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
index 5e2de4d1e..30bb600b6 100644
--- a/testcases/kernel/syscalls/close_range/close_range01.c
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -28,7 +28,7 @@
 #include "tst_test.h"
 #include "tst_clone.h"
 
-#include "lapi/clone.h"
+#include "lapi/sched.h"
 #include "lapi/close_range.h"
 
 static int fd[3];
diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testcases/kernel/syscalls/close_range/close_range02.c
index bd46936bb..aec899261 100644
--- a/testcases/kernel/syscalls/close_range/close_range02.c
+++ b/testcases/kernel/syscalls/close_range/close_range02.c
@@ -18,7 +18,7 @@
 #include "tst_clone.h"
 #include "lapi/fcntl.h"
 #include "lapi/close_range.h"
-#include "lapi/clone.h"
+#include "lapi/sched.h"
 
 static int try_close_range(int fd, int flags)
 {
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
