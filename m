Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95CBC25B78
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717057525; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=asXHqPfyl13oCFyK41qS5TO/UMl2DZZN/w2JAX3U7go=;
 b=cbQiajjaMyoPYeu8DP/tZifKff8a9nrNbKhlsTFYqzjsGrK3jO0Nr43Xv3dEpn+JsqoYD
 aJu+upv6hBnKdreLwn+BmFCACB3Ws2wBjXZboAuuHO2HyK+7W2rOhj77vmOt/PFUPUJLGWW
 gJiCWAbVh8isADLTOk3W5T1BaJ/d5zk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D09B3D067F
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 10:25:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE68F3C885D
 for <ltp@lists.linux.it>; Thu, 30 May 2024 10:25:01 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B3D54600FC1
 for <ltp@lists.linux.it>; Thu, 30 May 2024 10:24:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1717057499; x=1748593499;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bCQcfZtMMbQ/hj//0fzgdmC9puxf+4qZpL7+vl7eUDs=;
 b=QEa0weC21oea9/lJ+crDctr56l90wjR6AMzwjSy00w3DdWk2WWKlJAHz
 S81xFm1oOLlffFQ1q5mBma/b2oc56lqkpTSy69t0Y3xNxZCvG4YhkfnBa
 icdtLnEYcaAiHABdsITGTQCYlkU5ClSFIr9c2UM7BH1idQJ1I7is318RF
 RxY03kbd2DUyE2TYyHbMTYExT3rZFg1YOq/FHFeJIhf2BQxBEFtqNvw/k
 HuplyUmQ3sQ2fYs6pzaUu+zkVXqbeQ/pV3TGgLOz4Yyzn9ZdEjnDtogdA
 zm4ThMZbu/rt8ylTlJYoxg42SiYDr8Pfzaptjb4VxuBaWUw9bazEa3NB9 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="148198814"
X-IronPort-AV: E=Sophos;i="6.08,199,1712588400"; d="scan'208";a="148198814"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 17:24:56 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0BB18D8058
 for <ltp@lists.linux.it>; Thu, 30 May 2024 17:24:55 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 34A0C39FC1
 for <ltp@lists.linux.it>; Thu, 30 May 2024 17:24:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A3602220B79
 for <ltp@lists.linux.it>; Thu, 30 May 2024 17:24:53 +0900 (JST)
Received: from G08FNSTD200053.g08.fujitsu.local (unknown [10.167.226.137])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 39FE51A000A;
 Thu, 30 May 2024 16:24:53 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 30 May 2024 16:23:59 +0800
Message-Id: <20240530082358.2450-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.1.windows.1
In-Reply-To: <6c329528-6181-4229-a121-194233bbb8a4@suse.com>
References: <6c329528-6181-4229-a121-194233bbb8a4@suse.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28418.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28418.006
X-TMASE-Result: 10--12.043100-10.000000
X-TMASE-MatchedRID: v1GvEW1fSUBaSb0pBpxm6Ivefyp1glN0RealVAhocE/fUZT83lbkED13
 GoPFA1HFIvrftAIhWmLP85tlrdTfE0m+H8mpR1DUypiC33/79mcL//VMxXlyE97p0Ru8jKvF/9T
 DS4zEk/zv3R81Uj/6vMjhLggtE8XmxB13Y/+OC6ap3Btb1bH20Gvaomg0i4KN/5o9BPVzGUYQzv
 W+/DZ4kUDji1Vz/pS9M5ojAfE2AMU/QMF1B4qVfaUl1aQUvopW5+bxXj2veqBk3qVhd1+rL4a9w
 WwvhITIDZFIu8KLdap2CbccKtd0j2JHJG/db0P+VV4ZZmbE3Yw/xRB6OGnb2hA/fTf6RpCKysx/
 ZixtIIrRVO9DC1SsM12WVzVdeoHbjq1D5vTzVFLl+SMjDa6LT30tCKdnhB589yM15V5aWpj6C0e
 Ps7A07QsfaqMZktsdPqwJyliI8yAdJrVMNKXB4zMEvYrcY6SCy6EpGow1Wjo=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] signalfd01: Refactor old case with new API
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

signalfd01 is written in old API and some code seems unreachable. It needs
to be refactored with new API to simplify the logic.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../kernel/syscalls/signalfd/signalfd01.c     | 327 +++---------------
 1 file changed, 49 insertions(+), 278 deletions(-)

diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index 8fb16800f..f0ef4a378 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -1,302 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) Red Hat Inc., 2008
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) Red Hat Inc., 2008
+ * Copyright (c) Linux Test Project, 2006-2024
  */
 
-/*
- * NAME
- *	signalfd01.c
- *
- * DESCRIPTION
- *	Check signalfd can receive signals
- *
- * USAGE
- * 	signalfd01
+/*\
+ * [Description]
  *
- * HISTORY
- *	9/2008 Initial version by Masatake YAMATO <yamato@redhat.com>
+ * Verify that signalfd() works as expected.
+ * 1. signalfd() can create fd, and fd can receive signal.
+ * 2. signalfd() can reassign fd, and fd can receive signal.
  *
- * RESTRICTIONS
- * 	None
  */
-#define _GNU_SOURCE
 
-#include "config.h"
-
-#include "test.h"
-
-#include <errno.h>
-#include <signal.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include "ltp_signal.h"
-
-TCID_DEFINE(signalfd01);
-int TST_TOTAL = 1;
-
-#ifndef HAVE_SIGNALFD
-#define  USE_STUB
-#endif
-
-#if defined HAVE_SYS_SIGNALFD_H
 #include <sys/signalfd.h>
-#elif defined HAVE_LINUX_SIGNALFD_H
-#include <linux/signalfd.h>
-#define USE_OWNIMPL
-#else
-#define  USE_STUB
-#endif
+#include "tst_test.h"
 
-#ifndef HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO
-#define USE_STUB
-#endif
+static int fd_signal = -1;
+static sigset_t mask1;
+static sigset_t mask2;
 
-#ifdef USE_STUB
-int main(void)
+static void check_signal(int fd, uint32_t signal)
 {
-	tst_brkm(TCONF, NULL, "System doesn't support execution of the test");
+	pid_t pid = getpid();
+	ssize_t bytes;
+	struct signalfd_siginfo siginfo;
+
+	SAFE_KILL(pid, signal);
+	bytes = SAFE_READ(0, fd, &siginfo, sizeof(siginfo));
+	TST_EXP_EQ_LI(bytes, sizeof(siginfo));
+	TST_EXP_EQ_LI(siginfo.ssi_signo, signal);
 }
 
-#else
-#if defined USE_OWNIMPL
-#include "lapi/syscalls.h"
-int signalfd(int fd, const sigset_t * mask, int flags)
+static void setup(void)
 {
-	/* Taken from GLIBC. */
-	return tst_syscall(__NR_signalfd, fd, mask, SIGSETSIZE);
+	SAFE_SIGEMPTYSET(&mask1);
+	SAFE_SIGADDSET(&mask1, SIGUSR1);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &mask1, NULL);
+	SAFE_SIGEMPTYSET(&mask2);
+	SAFE_SIGADDSET(&mask2, SIGUSR2);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &mask2, NULL);
 }
-#endif
-
-void cleanup(void);
-void setup(void);
 
-int do_test1(uint32_t sig)
+static void cleanup(void)
 {
-	int sfd_for_next;
-	int sfd;
-	sigset_t mask;
-	pid_t pid;
-	struct signalfd_siginfo fdsi;
-	ssize_t s;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, sig);
-	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "sigprocmask() Failed: errno=%d : %s",
-			 errno, strerror(errno));
-	}
-
-	TEST(signalfd(-1, &mask, 0));
-
-	if ((sfd = TEST_RETURN) == -1) {
-		tst_resm(TFAIL,
-			 "signalfd() Failed, errno=%d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
-		sfd_for_next = -1;
-		return sfd_for_next;
-
-	} else {
-		tst_resm(TPASS, "signalfd is created successfully");
-		sfd_for_next = sfd;
-		goto out;
-	}
-
-	if (fcntl(sfd, F_SETFL, O_NONBLOCK) == -1) {
-		close(sfd);
-		tst_brkm(TBROK, cleanup,
-			 "setting signalfd nonblocking mode failed: errno=%d : %s",
-			 errno, strerror(errno));
-	}
-
-	pid = getpid();
-	if (kill(pid, sig) == -1) {
-		close(sfd);
-		tst_brkm(TBROK, cleanup,
-			 "kill(self, %s) failed: errno=%d : %s",
-			 strsignal(sig), errno, strerror(errno));
-	}
-
-	s = read(sfd, &fdsi, sizeof(struct signalfd_siginfo));
-	if ((s > 0) && (s != sizeof(struct signalfd_siginfo))) {
-		tst_resm(TFAIL,
-			 "getting incomplete signalfd_siginfo data: "
-			 "actual-size=%zd, expected-size=%zu",
-			 s, sizeof(struct signalfd_siginfo));
-		sfd_for_next = -1;
-		close(sfd);
-		goto out;
-	} else if (s < 0) {
-		if (errno == EAGAIN) {
-			tst_resm(TFAIL,
-				 "signalfd_siginfo data is not delivered yet");
-			sfd_for_next = -1;
-			close(sfd);
-			goto out;
-		} else {
-			close(sfd);
-			tst_brkm(TBROK, cleanup,
-				 "read signalfd_siginfo data failed: errno=%d : %s",
-				 errno, strerror(errno));
-		}
-	} else if (s == 0) {
-		tst_resm(TFAIL, "got EOF unexpectedly");
-		sfd_for_next = -1;
-		close(sfd);
-		goto out;
-	}
-
-	if (fdsi.ssi_signo == sig) {
-		tst_resm(TPASS, "got expected signal");
-		sfd_for_next = sfd;
-		goto out;
-	} else {
-		tst_resm(TFAIL, "got unexpected signal: signal=%d : %s",
-			 fdsi.ssi_signo, strsignal(fdsi.ssi_signo));
-		sfd_for_next = -1;
-		close(sfd);
-		goto out;
-	}
-
-out:
-	return sfd_for_next;
+	if (fd_signal > 0)
+		SAFE_CLOSE(fd_signal);
 }
 
-void do_test2(int fd, uint32_t sig)
+static void verify_signalfd(void)
 {
-	int sfd;
-	sigset_t mask;
-	pid_t pid;
-	struct signalfd_siginfo fdsi;
-	ssize_t s;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, sig);
-	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
-		close(fd);
-		tst_brkm(TBROK, cleanup,
-			 "sigprocmask() Failed: errno=%d : %s",
-			 errno, strerror(errno));
-	}
-
-	TEST(signalfd(fd, &mask, 0));
-
-	if ((sfd = TEST_RETURN) == -1) {
-		tst_resm(TFAIL,
-			 "reassignment the file descriptor by signalfd() failed, errno=%d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
+	/* create fd */
+	TST_EXP_FD(signalfd(fd_signal, &mask1, 0),
+		"%s", "signalfd() create fd");
+	if (TST_RET == -1)
 		return;
-	} else if (sfd != fd) {
-		tst_resm(TFAIL,
-			 "different fd is returned in reassignment: expected-fd=%d, actual-fd=%d",
-			 fd, sfd);
-		close(sfd);
+	fd_signal = TST_RET;
+	check_signal(fd_signal, SIGUSR1);
+	/* reassign fd */
+	TST_EXP_FD(signalfd(fd_signal, &mask2, 0), "%s",
+		"signalfd() reassign fd");
+	if (TST_RET == -1)
 		return;
-
-	} else {
-		tst_resm(TPASS, "signalfd is successfully reassigned");
-		goto out;
-	}
-
-	pid = getpid();
-	if (kill(pid, sig) == -1) {
-		close(sfd);
-		tst_brkm(TBROK, cleanup,
-			 "kill(self, %s) failed: errno=%d : %s",
-			 strsignal(sig), errno, strerror(errno));
-	}
-
-	s = read(sfd, &fdsi, sizeof(struct signalfd_siginfo));
-	if ((s > 0) && (s != sizeof(struct signalfd_siginfo))) {
-		tst_resm(TFAIL,
-			 "getting incomplete signalfd_siginfo data: "
-			 "actual-size=%zd, expected-size= %zu",
-			 s, sizeof(struct signalfd_siginfo));
-		goto out;
-	} else if (s < 0) {
-		if (errno == EAGAIN) {
-			tst_resm(TFAIL,
-				 "signalfd_siginfo data is not delivered yet");
-			goto out;
-		} else {
-			close(sfd);
-			tst_brkm(TBROK, cleanup,
-				 "read signalfd_siginfo data failed: errno=%d : %s",
-				 errno, strerror(errno));
-		}
-	} else if (s == 0) {
-		tst_resm(TFAIL, "got EOF unexpectedly");
-		goto out;
-	}
-
-	if (fdsi.ssi_signo == sig) {
-		tst_resm(TPASS, "got expected signal");
-		goto out;
-	} else {
-		tst_resm(TFAIL, "got unexpected signal: signal=%d : %s",
-			 fdsi.ssi_signo, strsignal(fdsi.ssi_signo));
-		goto out;
-	}
-
-out:
-	return;
-}
-
-int main(int argc, char **argv)
-{
-	int lc;
-	int sfd;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		sfd = do_test1(SIGUSR1);
-		if (sfd < 0)
-			continue;
-
-		do_test2(sfd, SIGUSR2);
-		close(sfd);
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	TEST_PAUSE;
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
+	TST_EXP_EQ_LI(TST_RET, fd_signal);
+	check_signal(fd_signal, SIGUSR2);
 }
 
-#endif
+static struct tst_test test = {
+	.test_all = verify_signalfd,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
