Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F3BC25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716892427; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=PbvY0bdVDRHHbUlQfGpB4+ycFfvno5T0WoaSfWJiqcU=;
 b=Cu5NlhIfDBBsawWzPKUuscxoXeXmDudZnb/oyD6ejpxQ9oVR5//udOpbkc/JHjhjHwGh0
 Bg8MLuimbmvc+I4G/aOYzAHHAyqYoqoAkYTJpjeD6jpMeBA6oGRlGgRYZGnPWOw68VilynK
 e/04apKooda8b9jv84YmVgwRLDwRcFw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1CC83D0537
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 12:33:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03D573C2B89
 for <ltp@lists.linux.it>; Tue, 28 May 2024 12:33:25 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D6CFD1000A4F
 for <ltp@lists.linux.it>; Tue, 28 May 2024 12:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1716892404; x=1748428404;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iq8rxi5ilPLNTjpT1LpNLWfiHdFdooXsSeCkQhy1cZU=;
 b=odOvS9WijBDAxQBc7lIzkYMWbZfRcctAl+2hSMPL6YNlPWtbeh0fI5Zu
 UuTpYIRpwfKtSXVQBe0HyXMoHHg28ZYJNrE7FqC1Da7Ovq0mxvDIbAv6H
 0UApZSs8g4fOoSsEnr4il8pDQ/M2IvDawqcxULB7ZwjLxwuYSdZOWtC5w
 o5rJqhbtqhAjRzMVjcdc7yPnUA2fW7rCALvEtfx/2a53mxTTHp8EJnP+G
 4009DHZZZenXAqIKQJCexPhiwyFl8ZwjAEGd9K1P1el9uLZGq9t/052Eu
 wN9in2eoZMGuQ2PCwdRt0xBgNTCTq3bpYvrMDN3vNJzgqfytBD/XvAOaU g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="160667527"
X-IronPort-AV: E=Sophos;i="6.08,195,1712588400"; d="scan'208";a="160667527"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 19:33:22 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 302F8C68E7
 for <ltp@lists.linux.it>; Tue, 28 May 2024 19:33:20 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F802CF7F7
 for <ltp@lists.linux.it>; Tue, 28 May 2024 19:33:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id F0CC5200501B6
 for <ltp@lists.linux.it>; Tue, 28 May 2024 19:33:18 +0900 (JST)
Received: from G08FNSTD200053.g08.fujitsu.local (unknown [10.167.226.137])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8599E1A000A;
 Tue, 28 May 2024 18:33:18 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 28 May 2024 18:32:58 +0800
Message-Id: <20240528103258.2390-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.1.windows.1
In-Reply-To: <20240528103114.2311-1-maxj.fnst@fujitsu.com>
References: <20240528103114.2311-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28414.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28414.007
X-TMASE-Result: 10--13.637100-10.000000
X-TMASE-MatchedRID: 3Ln5EF1zzeJaSb0pBpxm6Ivefyp1glN0RealVAhocE/fUZT83lbkED13
 GoPFA1HFIvrftAIhWmLP85tlrdTfE0m+H8mpR1DUypiC33/79mcL//VMxXlyE97p0Ru8jKvF/9T
 DS4zEk/zv3R81Uj/6vMjhLggtE8XmxB13Y/+OC6ap3Btb1bH20Gvaomg0i4KN/5o9BPVzGUYQzv
 W+/DZ4kUDji1Vz/pS9sxNSNugZwuiZM6WWqZv0HL0dPFETpBAHQ87zUhFYnkU8zUakDfUiKxFEt
 97pQ+C8EYiHR3xQ5cAmE42irklNTxz05QxMvMVL8Jb881FGn9mOVGny5q72hl/8lGqVstJXjFK/
 NcS7G4m9moBdGNmJG2dvI/P36X69ZVVMdQndnIxdhZyafgPiq3607foZgOWynLZzoC1zZV1t/jh
 B4GQZ++LzNWBegCW2wgn7iDBesS0gBwKKRHe+r++2fgCC9//FOr3w5XhZ/s1S3872DSzICXPWE2
 cWEjeJ2ejyZnNv7xg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] signalfd01: Refactor old case with new API
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
 .../kernel/syscalls/signalfd/signalfd01.c     | 350 +++++-------------
 1 file changed, 96 insertions(+), 254 deletions(-)

diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index 8fb16800f..f3c305194 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -1,302 +1,144 @@
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
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	Check signalfd can receive signals
+ * Verify that signalfd() can receive signals
  *
- * USAGE
- * 	signalfd01
- *
- * HISTORY
- *	9/2008 Initial version by Masatake YAMATO <yamato@redhat.com>
- *
- * RESTRICTIONS
- * 	None
  */
-#define _GNU_SOURCE
-
-#include "config.h"
 
-#include "test.h"
+#define _GNU_SOURCE
 
-#include <errno.h>
 #include <signal.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include "ltp_signal.h"
-
-TCID_DEFINE(signalfd01);
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "config.h"
 
 #ifndef HAVE_SIGNALFD
-#define  USE_STUB
+#define USE_STUB
 #endif
 
-#if defined HAVE_SYS_SIGNALFD_H
+#ifdef HAVE_SYS_SIGNALFD_H
 #include <sys/signalfd.h>
 #elif defined HAVE_LINUX_SIGNALFD_H
 #include <linux/signalfd.h>
 #define USE_OWNIMPL
 #else
-#define  USE_STUB
-#endif
+#define USE_STUB
+#endif /* HAVE_SYS_SIGNALFD_H */
 
 #ifndef HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO
 #define USE_STUB
-#endif
+#endif /* HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO */
 
 #ifdef USE_STUB
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "System doesn't support execution of the test");
-}
-
-#else
+TST_TEST_TCONF("This system does not support signalfd()");
+#else /* USE_STUB */
 #if defined USE_OWNIMPL
 #include "lapi/syscalls.h"
-int signalfd(int fd, const sigset_t * mask, int flags)
+int signalfd(int fd, const sigset_t *mask, int flags)
 {
-	/* Taken from GLIBC. */
-	return tst_syscall(__NR_signalfd, fd, mask, SIGSETSIZE);
+	return tst_syscall(__NR_signalfd, fd, mask, flags);
 }
-#endif
+#endif /* USE_OWNIMPL */
 
-void cleanup(void);
-void setup(void);
+static int fd_signal = -1;
+static sigset_t mask1;
+static sigset_t mask2;
 
-int do_test1(uint32_t sig)
+static int check_signal(int fd, uint32_t signal)
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
+	pid_t pid = getpid();
+	ssize_t bytes;
+	struct signalfd_siginfo siginfo;
+	int ret = -1;
+
+	SAFE_KILL(pid, signal);
+	bytes = read(fd, &siginfo, sizeof(siginfo));
+	if (bytes < 0) {
+		if (errno == EAGAIN)
+			tst_res(TFAIL | TERRNO, "%s",
+				"signal has not been received yet");
+		else
+			tst_res(TFAIL | TERRNO, "%s",
+				"error occured during reading signal");
 	} else {
-		tst_resm(TFAIL, "got unexpected signal: signal=%d : %s",
-			 fdsi.ssi_signo, strsignal(fdsi.ssi_signo));
-		sfd_for_next = -1;
-		close(sfd);
-		goto out;
+		if (bytes != sizeof(siginfo))
+			tst_res(TFAIL | TERRNO, "%s",
+				"signal received is not completed");
+		else
+			if (siginfo.ssi_signo != signal)
+				tst_res(TFAIL | TERRNO,
+					"unexpected signal <%s>(%d) received",
+					strsignal(siginfo.ssi_signo),
+					siginfo.ssi_signo);
+			else
+				ret = 0;
 	}
-
-out:
-	return sfd_for_next;
+	return ret;
 }
 
-void do_test2(int fd, uint32_t sig)
+static void setup(void)
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
-		return;
-	} else if (sfd != fd) {
-		tst_resm(TFAIL,
-			 "different fd is returned in reassignment: expected-fd=%d, actual-fd=%d",
-			 fd, sfd);
-		close(sfd);
-		return;
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
+	SAFE_SIGEMPTYSET(&mask1);
+	SAFE_SIGADDSET(&mask1, SIGUSR1);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &mask1, NULL);
+	SAFE_SIGEMPTYSET(&mask2);
+	SAFE_SIGADDSET(&mask2, SIGUSR2);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &mask2, NULL);
 }
 
-int main(int argc, char **argv)
+static void cleanup(void)
 {
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
+	if (fd_signal > 0)
+		SAFE_CLOSE(fd_signal);
+}
 
-		do_test2(sfd, SIGUSR2);
-		close(sfd);
+static void do_create(void)
+{
+	TST_EXP_FD_SILENT(signalfd(fd_signal, &mask1, 0),
+		"%s", "signalfd() create fd");
+	if (TST_RET > 0) {
+		fd_signal = TST_RET;
+		if (!check_signal(fd_signal, SIGUSR1))
+			tst_res(TPASS, "%s",
+				"signalfd() created fd successfully");
 	}
-
-	cleanup();
-
-	tst_exit();
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void do_reassign(void)
 {
-
-	TEST_PAUSE;
+	if (fd_signal < 0)
+		tst_brk(TBROK, "%s", "Invalid fd. Skip reassign");
+
+	TST_EXP_FD_SILENT(signalfd(fd_signal, &mask2, 0), "%s",
+		"signalfd() reassign fd");
+	if (TST_RET > 0) {
+		if (TST_RET == fd_signal) {
+			if (!check_signal(fd_signal, SIGUSR2))
+				tst_res(TPASS, "%s",
+					"signalfd() reassigned fd "
+					"successfully");
+		} else {
+			tst_res(TFAIL | TERRNO, "%s",
+				"fd changed unexpectedly during signalfd()");
+		}
+	}
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void verify_signalfd(void)
 {
-
+	do_create();
+	do_reassign();
 }
 
-#endif
+static struct tst_test test = {
+	.test_all = verify_signalfd,
+	.setup = setup,
+	.cleanup = cleanup,
+};
+
+#endif /* USE_STUB */
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
