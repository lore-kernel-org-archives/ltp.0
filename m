Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B143C77B6E
	for <ltp@archiver.kernel.org>; Mon, 10 Apr 2023 02:02:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BD203CC68F
	for <ltp@archiver.kernel.org>; Mon, 10 Apr 2023 04:02:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DD613CA33C
 for <ltp@lists.linux.it>; Mon, 10 Apr 2023 04:02:37 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BEECB1000376
 for <ltp@lists.linux.it>; Mon, 10 Apr 2023 04:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1681092155; i=@fujitsu.com;
 bh=C8FIm8Bj9QgEwoCCb06gN9JLaNcowfSAwUthF+XK2hI=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=oJRa8bjEI+W/pcq9RKlMPAPMJjUBB1sWJ1vvQX6M9oCxVEOS7X8QAExS4gt9BCTBU
 5x8o03pidOILjcOpaVHCiepJwAY7Xsn6OBvfO8KnVDK4C0Qqg+L8F4A8o9XJdeSaqz
 awATUnh+dkM+MAU6xT+O41KsgmjcTMnJcXp4p+ZXl2bKzo1EOBh4KfIOQMuxKVpxZg
 +jKrBocPs/GfEG7cmaJrVVZYTZZFmtAzWUexUfhq+Qy4QiFfEXWk7JLdXkqFN5oYPw
 cC0EaC8kpSNAe6Il8tEEuA6gpX9V9BXId2z10aOcKfIwMZuOex+q8u+Z5q5JVrWDi5
 idWWB7I2svdyw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRWlGSWpSXmKPExsViZ8ORpGuVZ5x
 icPWhmcWK7zsYHRg99v1exxrAGMWamZeUX5HAmnHh70nGgmXaFRvudbA3MN5V7mLk4hASOMUo
 8aZ1AyOEs5dJ4uvCp0AOJ4jDKNHSbQ1iswloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6xdTFy
 MEhLOAs0XMpGSTMIqAq8WrqTBYQm1fAU+LrujesILaEgILElIfvmSHighInZz5hgRgjIXHwxQ
 tmiBolibbWK1D1FRKN0w8xQdhqElfPbWKewMg/C0n7LCTtCxiZVjGaFqcWlaUW6ZrqJRVlpme
 U5CZm5uglVukm6qWW6panFpfoGuollhfrpRYX6xVX5ibnpOjlpZZsYgQGYkoxi9kOxva+v3qH
 GCU5mJREebu4jFOE+JLyUyozEosz4otKc1KLDzHKcHAoSfCuzAbKCRalpqdWpGXmAKMCJi3Bw
 aMkwnspFijNW1yQmFucmQ6ROsWoy7FpX9cBZiGWvPy8VClx3oocoCIBkKKM0jy4EbAIvcQoKy
 XMy8jAwCDEU5BalJtZgir/ilGcg1FJmHcyyBSezLwSuE2vgI5gAjqCy8UA5IiSRISUVANTaOx
 vQw7TG+sjX4j++nV+xmeeG+ITvblWXrv0+KDVzxZh33upqfctj+8+Vr7vJ+e79OMX8hJzc+99
 WHFmxf8+K5maYr7DpiknBD5uK47rm1DWWTet41lHh/3+wsvPTQpzbyb9l1xU/6swiNvkI2+9U
 Jz2z+0rDT9ZJW83Tf4s3vtwqm1Sk1iTmUnpFf2l11p0G3wcdbp6eW153y7IumfZuaAvP5FZNK
 vgRcuvu3enzZib48p4SrvOa7vPnaP8ersPXT3L+1+DlTP06LGKDQ+WHn+lzqL4bPa6CxsWBrS
 bl6R+XCE4xZBbSS6qduPePxIaiV/zNJNz7scEe91g3O+rcKrcKqJ/u+cSD4n357OVWIozEg21
 mIuKEwHVS2ewSwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-591.messagelabs.com!1681092154!361840!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24412 invoked from network); 10 Apr 2023 02:02:34 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-6.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Apr 2023 02:02:34 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 775791BE
 for <ltp@lists.linux.it>; Mon, 10 Apr 2023 03:02:34 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 6B7201B4
 for <ltp@lists.linux.it>; Mon, 10 Apr 2023 03:02:34 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 10 Apr 2023 03:02:33 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 10 Apr 2023 10:02:13 +0800
Message-ID: <1681092133-28614-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fcntl06: Remove R_GETLK/R_SETLK test case
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

linux never implement R_GETLK/R_SETLK facility, so this case
is useless.

A twenty years old email[1] also mentioned that we should remove
this case but leave a bad gap number.

R_GETLK/R_SETLK facility only exists in the IRIXones.

IRIX says this pair of arguments are for use by NFS lockd and really
doesn't go into much detail.

Fixes:#1029
[1]https://sourceforge.net/p/ltp/mailman/message/7574937/
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                           |   2 -
 testcases/kernel/syscalls/fcntl/.gitignore |   2 -
 testcases/kernel/syscalls/fcntl/fcntl06.c  | 165 ---------------------
 3 files changed, 169 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/fcntl/fcntl06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8b002e989..ed5a6481a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -271,8 +271,6 @@ fcntl04 fcntl04
 fcntl04_64 fcntl04_64
 fcntl05 fcntl05
 fcntl05_64 fcntl05_64
-fcntl06 fcntl06
-fcntl06_64 fcntl06_64
 fcntl07 fcntl07
 fcntl07_64 fcntl07_64
 fcntl08 fcntl08
diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
index 48b36ec34..10cb0995f 100644
--- a/testcases/kernel/syscalls/fcntl/.gitignore
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -8,8 +8,6 @@
 /fcntl04_64
 /fcntl05
 /fcntl05_64
-/fcntl06
-/fcntl06_64
 /fcntl07
 /fcntl07_64
 /fcntl08
diff --git a/testcases/kernel/syscalls/fcntl/fcntl06.c b/testcases/kernel/syscalls/fcntl/fcntl06.c
deleted file mode 100644
index 8dcc04866..000000000
--- a/testcases/kernel/syscalls/fcntl/fcntl06.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
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
- */
-
-/*
- * NAME
- *	fcntl06.c
- *
- * DESCRIPTION
- *	Error checking conditions for remote locking of regions of a file.
- *
- * CALLS
- *	open(2), write(2), fcntl(2)
- *
- * ALGORITHM
- *	Test unlocking sections around a write lock using remote Lock/Unlock
- *	call which should all fail.
- *
- * USAGE
- *	fcntl06
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	Currently Linux kernel doesn't implement R_GETLK/R_SETLK facility,
- *	but this facility seems to be present in other standard flavours of
- *	Unix. Currently this program has all the testing done under
- *	"#ifdef LINUX_FILE_REGION_LOCK", when Linux implements the regions
- *	locking then, this testcase should be recompiled accordingly with the
- *	"ifdef" removed.
- */
-
-#include <fcntl.h>
-#include <errno.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "test.h"
-
-#define F_RGETLK 10		/* kludge code */
-#define F_RSETLK 11		/* kludge code */
-
-char *TCID = "fcntl06";
-int TST_TOTAL = 1;
-
-void setup();
-void cleanup();
-
-#define STRINGSIZE	27
-#define	STRING		"abcdefghijklmnopqrstuvwxyz\n"
-
-int fd;
-void unlock_file();
-int do_lock(int, short, short, int, int);
-
-int main(int ac, char **av)
-{
-	int fail = 0;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	fail = 0;
-
-#ifdef LINUX_FILE_REGION_LOCK
-	if (fcntl(fd, F_RGETLK, &tl) == -1) {
-		if (errno == EINVAL)
-			tst_brkm(TCONF, cleanup,
-				 "fcntl remote locking feature not implemented in "
-				 "the kernel");
-		else {
-			/*
-			 * FIXME (garrcoop): having it always pass on
-			 * non-EINVAL is a bad test.
-			 */
-			tst_resm(TPASS, "fcntl on file failed");
-		}
-	}
-
-	/*
-	 * Add a write lock to the middle of the file and unlock a section
-	 * just before the lock
-	 */
-	if (do_lock(F_RSETLK, F_WRLCK, 0, 10, 5) == -1)
-		tst_resm(TFAIL, "F_RSETLK WRLCK failed");
-
-	if (do_lock(F_RSETLK, F_UNLCK, 0, 5, 5) == -1)
-		tst_resm(TFAIL | TERRNO, "F_RSETLK UNLOCK failed");
-
-	unlock_file();
-#else
-	tst_resm(TCONF, "system doesn't have LINUX_LOCK_FILE_REGION support");
-#endif
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	char *buf = STRING;
-	char template[PATH_MAX];
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	umask(0);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	snprintf(template, PATH_MAX, "fcntl06XXXXXX");
-
-	if ((fd = mkstemp(template)) == -1)
-		tst_resm(TBROK | TERRNO, "mkstemp failed");
-
-	if (write(fd, buf, STRINGSIZE) == -1)
-		tst_resm(TBROK | TERRNO, "write failed");
-}
-
-int do_lock(int cmd, short type, short whence, int start, int len)
-{
-	struct flock fl;
-
-	fl.l_type = type;
-	fl.l_whence = whence;
-	fl.l_start = start;
-	fl.l_len = len;
-	return (fcntl(fd, cmd, &fl));
-}
-
-void unlock_file(void)
-{
-	if (do_lock(F_RSETLK, (short)F_UNLCK, (short)0, 0, 0) == -1) {
-		/* Same as FIXME comment above. */
-		tst_resm(TPASS | TERRNO, "fcntl on file failed");
-	}
-}
-
-void cleanup(void)
-{
-
-	if (close(fd) == -1)
-		tst_resm(TWARN | TERRNO, "close failed");
-
-	tst_rmdir();
-
-}
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
