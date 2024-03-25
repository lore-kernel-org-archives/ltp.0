Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D11FC54E58
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 06:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711346573; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=adsh0tYlCEjmZUUQEU7DknP+MGQZAE+AVKu6Ofk1a+o=;
 b=EcZZeRY/q37BfUHB9y6tGTnEkxy0f+hK2g6rzzCpgZGMRvVyUInFO4yEhdjobWTE0NVU7
 W4z1SvuOAxE/ThgqOrYz0nAoFFownN8OZ46SFillUTfKoQWsmMCKL7BH/jaR3FidoVkX+dT
 12jc2AMYerdsmpYSbU9FGYIiSTAfTQU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 842023CFB41
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 07:02:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0ACA3CD929
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 07:02:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1F48E1A00E63
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 07:02:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711346549; x=1742882549;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jMVwNm77PrDkoLKBsAayNFyCZqCUXtOKaCnnUCHPNzQ=;
 b=WPIIFwmUAXJk/iNqsN/nRufauVzQmU9vZJ0+MKi3q9eTjj/64bN+fHpF
 aXES8wdh83G9cQ/cWVh7TAei3uH+VkLFNRsd1mRxsTZt56euhFpMElAin
 xYUM7g3913f3ulwvKJ5MJNINV2UxIs1y5SkR0TYxSzDRTYTs231EKbXV6
 WgaOg4Td49a1/rjEXStI//B8ejLkjCiK864QCHAgt0GP0GVhGfHDvhZC5
 Zediv0eyU1npNn75h1MNzWJyr/Z/0xVZGQNRqGn4l4yEDKHZ7YV3vIpFz
 XETyCdLOPCz3LQwDK0TcsfLKiTt8/FV2zZuufd5QqUV4sRtdUDH07wKpz g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="141226055"
X-IronPort-AV: E=Sophos;i="6.07,152,1708354800"; d="scan'208";a="141226055"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 15:02:27 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 93AB3C6828
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 15:02:25 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id A84F8CFA5C
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 15:02:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 23CBE6B4C7
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 15:02:24 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8CEB41A006C;
 Mon, 25 Mar 2024 14:02:23 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 25 Mar 2024 02:01:10 -0400
Message-Id: <20240325060110.2278-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28272.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28272.005
X-TMASE-Result: 10--12.214200-10.000000
X-TMASE-MatchedRID: V4kZyBpe9RM+RdTI1lgp+grcxrzwsv5u9LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatS01VXlcjcCUtw+xHnsmQjNSJwEFeNPAEf+aPQT1cxlGVvB
 81KWQR0pudEHjsosnVDMuZ8ZjqIORfm5R+E2+crM5ZRbFNAl0jxRli5ttSPYMu3gEBpQvABUl/m
 i29q85l/29Pl68xfi0P6Cg6XciWTS6dpS6QxcQWxMxKDqgAFSzNoSDavyLMJR/O89o908FMRskA
 daEfeQKC1dAGS6ThH7HFK9wPwWae3yAL08NM00elRdhw/BBzadMVCcj56k8hkM6trnYZWLjF+jA
 V5A5r0O9CBwBZco6FwkzzxpFMTuNNrsgG44+2ERdhZyafgPiqx+KaaVwAG43CM0aiAVpASztA5t
 34rpKTrx1FZnDV3+Ir8186pfsJcbIW5a7efE77eadXXcOleEbyJTy9ZwCrCOMltxkB8Rw030nA7
 bbhJ+d/I+yd0mcY0W310iilwWxWkkjllSXrjtQFEUknJ/kEl7dB/CxWTRRu25FeHtsUoHuZLHaw
 NhKAWV5M6EejXR4MgXzm0OM6sllaYMexsUq6HZoBmTSwRxjXg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] linkat01: Split into 2 cases and convert to new API
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

Currently linkat01 includes both positive cases and failure cases. The logic
contains many if-else statement and is a little complex.

Now linkat01 will be split into 2 cases: linkat01 and linkat03. The positive
cases remain in linkat01 case, and failure cases move to linkat03 case. With
new api TST_EXP_PASS() and TST_EXP_FAIL(), the logic is also simplified.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/linkat/.gitignore |   1 +
 testcases/kernel/syscalls/linkat/linkat01.c | 385 ++++++--------------
 testcases/kernel/syscalls/linkat/linkat03.c | 120 ++++++
 4 files changed, 240 insertions(+), 267 deletions(-)
 create mode 100644 testcases/kernel/syscalls/linkat/linkat03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4ed2b5602..771d654c8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -701,6 +701,7 @@ link08 link08
 #linkat test cases
 linkat01 linkat01
 linkat02 linkat02
+linkat03 linkat03
 
 listen01 listen01
 
diff --git a/testcases/kernel/syscalls/linkat/.gitignore b/testcases/kernel/syscalls/linkat/.gitignore
index 1b307c9df..52b019e25 100644
--- a/testcases/kernel/syscalls/linkat/.gitignore
+++ b/testcases/kernel/syscalls/linkat/.gitignore
@@ -1,2 +1,3 @@
 /linkat01
 /linkat02
+/linkat03
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index 57cfbcfc6..1e77898d6 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -1,93 +1,44 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2006-2024
+ */
+
+/*\
+ * [Description]
  *
- *   Copyright (c) International Business Machines  Corp., 2006
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
- *
- * NAME
- *      linkat01.c
- *
- * DESCRIPTION
- *	This test case will verify basic function of linkat
- *	added by kernel 2.6.16 or up.
- *
- * USAGE:  <for command-line>
- * linkat01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
- * where:
- *      -c n : Run n copies simultaneously.
- *      -e   : Turn on errno logging.
- *      -i n : Execute test n times.
- *      -I x : Execute test for x seconds.
- *      -p   : Pause for SIGUSR1 before starting
- *      -P x : Pause for x seconds between iterations.
- *      -t   : Turn on syscall timing.
- *
- * Author
- *	Yi Yang <yyangcdl@cn.ibm.com>
- *
- * History
- *      08/25/2006      Created first by Yi Yang <yyangcdl@cn.ibm.com>
- *
- *****************************************************************************/
+ * Check the basic function of linkat that normally returns.
+ */
 
 #define _GNU_SOURCE
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/time.h>
-#include <fcntl.h>
-#include <unistd.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <inttypes.h>
-#include <limits.h>
-#include "test.h"
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
-
-#ifndef AT_FDCWD
-#define AT_FDCWD -100
-#endif
-#ifndef AT_SYMLINK_FOLLOW
-#define AT_SYMLINK_FOLLOW 0x400
-#endif
-
-struct test_struct;
-static void setup();
-static void cleanup();
-static void setup_every_copy();
-static void mylinkat_test(struct test_struct *desc);
+#include "lapi/fcntl.h"
 
 #define TEST_DIR1 "olddir"
 #define TEST_DIR2 "newdir"
 #define TEST_DIR3 "deldir"
 #define TEST_FILE1 "oldfile"
-#define TEST_FILE2 "newfile"
-#define TEST_FIFO "fifo"
 
-#define DPATHNAME_FMT	"%s/" TEST_DIR2 "/" TEST_FILE1
-#define SPATHNAME_FMT	"%s/" TEST_DIR1 "/" TEST_FILE1
+#define DPATHNAME_FMT "%s/" TEST_DIR2 "/" TEST_FILE1
+#define SPATHNAME_FMT "%s/" TEST_DIR1 "/" TEST_FILE1
 
 static char dpathname[PATH_MAX];
 static char spathname[PATH_MAX];
-static int olddirfd, newdirfd = -1, cwd_fd = AT_FDCWD, stdinfd = 0, badfd =
-    -1, deldirfd;
-
-struct test_struct {
+static int olddirfd;
+static int newdirfd = -1;
+static int cwd_fd = AT_FDCWD;
+static int stdinfd;
+static int badfd = -1;
+static int deldirfd;
+
+static struct tcase {
 	int *oldfd;
 	const char *oldfn;
 	int *newfd;
@@ -95,222 +46,122 @@ struct test_struct {
 	int flags;
 	const char *referencefn1;
 	const char *referencefn2;
-	int expected_errno;
-} test_desc[] = {
+} tcases[] = {
 	/* 1. relative paths */
-	{
-	&olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 0,
-		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* 2. abs path at source */
-	{
-	&olddirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
-	    /* 3. abs path at dst */
-	{
-	&olddirfd, TEST_FILE1, &newdirfd, dpathname, 0,
-		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* 4. relative paths to cwd */
-	{
-	&cwd_fd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
-		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* 5. relative paths to cwd */
-	{
-	&olddirfd, TEST_FILE1, &cwd_fd, TEST_DIR2 "/" TEST_FILE1, 0,
-		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* 6. abs path at source */
-	{
-	&cwd_fd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
-	    /* 7. abs path at dst */
-	{
-	&olddirfd, TEST_FILE1, &cwd_fd, dpathname, 0,
-		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* 8. relative paths to invalid */
-	{
-	&stdinfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
-		    0, 0, ENOTDIR},
-	    /* 9. relative paths to invalid */
-	{
-	&olddirfd, TEST_FILE1, &stdinfd, TEST_DIR2 "/" TEST_FILE1, 0,
-		    0, 0, ENOTDIR},
-	    /* 10. abs path at source */
-	{
-	&stdinfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
-	    /* 11. abs path at dst */
-	{
-	&olddirfd, TEST_FILE1, &stdinfd, dpathname, 0,
-		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* 12. relative paths to bad */
-	{
-	&badfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
-		    0, 0, EBADF},
-	    /* 13. relative paths to bad */
-	{
-	&olddirfd, TEST_FILE1, &badfd, TEST_DIR2 "/" TEST_FILE1, 0,
-		    0, 0, EBADF},
-	    /* 14. abs path at source */
-	{
-	&badfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
-	    /* 15. abs path at dst */
-	{
-	&olddirfd, TEST_FILE1, &badfd, dpathname, 0,
-		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* 16. relative paths to deleted */
-	{
-	&deldirfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
-		    0, 0, ENOENT},
-	    /* 17. relative paths to deleted */
-	{
-	&olddirfd, TEST_FILE1, &deldirfd, TEST_DIR2 "/" TEST_FILE1, 0,
-		    0, 0, ENOENT},
-	    /* 18. abs path at source */
-	{
-	&deldirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0},
-	    /* 19. abs path at dst */
-	{
-	&olddirfd, TEST_FILE1, &deldirfd, dpathname, 0,
-		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* 20. x-device link */
-	{
-	&cwd_fd, "/proc/cpuinfo", &newdirfd, TEST_FILE1, 0, 0, 0, EXDEV},
-	    /* 21. directory link */
-	{
-	&olddirfd, ".", &newdirfd, TEST_FILE1, 0, 0, 0, EPERM},
-	    /* 22. invalid flag */
-	{
-	&olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 1, 0, 0, EINVAL},
-	    /* 23. fifo link */
-	    /* XXX (garrcoop): Removed because it hangs the overall test. Need to
-	     * find a legitimate means to exercise this functionality, if in fact
-	     * it's a valid testcase -- which it should be.
-	     */
-	    /* { &olddirfd, TEST_FIFO, &newdirfd, TEST_FILE1, 0,
-	       TEST_DIR1"/"TEST_FIFO, TEST_DIR2"/"TEST_FILE1, 0 } */
+	{&olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 0,
+		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
+	/* 2. absolution path at source */
+	{&olddirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
+	/* 3. absolution path at destination */
+	{&olddirfd, TEST_FILE1, &newdirfd, dpathname, 0,
+		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
+	/* 4. relative paths to cwd */
+	{&cwd_fd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
+		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
+	/* 5. cwd to relative paths */
+	{&olddirfd, TEST_FILE1, &cwd_fd, TEST_DIR2 "/" TEST_FILE1, 0,
+		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
+	/* 6. cwd to absolution paths */
+	{&cwd_fd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
+	/* 7. absolution paths to cwd */
+	{&olddirfd, TEST_FILE1, &cwd_fd, dpathname, 0,
+		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
+	/* 8. invalid directory to absolution paths */
+	{&stdinfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
+	/* 9. absolution paths to invalid directory */
+	{&olddirfd, TEST_FILE1, &stdinfd, dpathname, 0,
+		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
+	/* 10. bad fd to absolution paths */
+	{&badfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
+	/* 11. absolution paths to bad fd */
+	{&olddirfd, TEST_FILE1, &badfd, dpathname, 0,
+		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
+	/* 12. deleted to absolution paths */
+	{&deldirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0},
+	/* 13. absolution paths to deleted */
+	{&olddirfd, TEST_FILE1, &deldirfd, dpathname, 0,
+		TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1},
 };
 
-char *TCID = "linkat01";
-int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
-
-static int mylinkat(int olddirfd, const char *oldfilename, int newdirfd,
-		    const char *newfilename, int flags)
+static void setup(void)
 {
-	return tst_syscall(__NR_linkat, olddirfd, oldfilename, newdirfd,
-		       newfilename, flags);
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	char *cwd;
+	int fd;
 
-		tst_count = 0;
+	cwd = get_current_dir_name();
+	if (cwd == NULL) {
+		tst_brk(TFAIL | TERRNO,
+			"Failed to get current working directory.");
+	}
 
-		for (i = 0; i < TST_TOTAL; i++) {
-			setup_every_copy();
-			mylinkat_test(&test_desc[i]);
-		}
+	SAFE_MKDIR(TEST_DIR1, 0700);
+	SAFE_MKDIR(TEST_DIR3, 0700);
+	olddirfd = SAFE_OPEN(TEST_DIR1, O_DIRECTORY);
+	deldirfd = SAFE_OPEN(TEST_DIR3, O_DIRECTORY);
+	fd = SAFE_OPEN(TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
+	SAFE_CLOSE(fd);
 
-	}
+	snprintf(dpathname, sizeof(dpathname), DPATHNAME_FMT, cwd);
+	snprintf(spathname, sizeof(spathname), SPATHNAME_FMT, cwd);
 
-	cleanup();
-	tst_exit();
+	free(cwd);
 }
 
-static void setup_every_copy(void)
+static void setup_every_case(void)
 {
 	close(newdirfd);
 	unlink(dpathname);
 	rmdir(TEST_DIR2);
 
-	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
-	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
+	SAFE_MKDIR(TEST_DIR2, 0700);
+	newdirfd = SAFE_OPEN(TEST_DIR2, O_DIRECTORY);
 }
 
-static void mylinkat_test(struct test_struct *desc)
+static void verify_linkat(unsigned int i)
 {
-	int fd;
-
-	TEST(mylinkat
-	     (*desc->oldfd, desc->oldfn, *desc->newfd, desc->newfn,
-	      desc->flags));
-
-	if (TEST_ERRNO == desc->expected_errno) {
-		if (TEST_RETURN == 0 && desc->referencefn1 != NULL) {
-			int tnum = rand(), vnum = ~tnum;
-			fd = SAFE_OPEN(cleanup, desc->referencefn1,
-				       O_RDWR);
-			SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, &tnum,
-				sizeof(tnum));
-			SAFE_CLOSE(cleanup, fd);
+	struct tcase *tc = &tcases[i];
 
-			fd = SAFE_OPEN(cleanup, desc->referencefn2,
-				       O_RDONLY);
-			SAFE_READ(cleanup, 1, fd, &vnum, sizeof(vnum));
-			SAFE_CLOSE(cleanup, fd);
+	int fd;
 
-			if (tnum == vnum)
-				tst_resm(TPASS,
-					 "linkat is functionality correct");
-			else {
-				tst_resm(TFAIL,
-					 "The link file's content isn't "
-					 "as same as the original file's "
-					 "although linkat returned 0");
+	setup_every_case();
+
+	if (tc->referencefn1 != NULL) {
+		TST_EXP_PASS_SILENT(linkat(*tc->oldfd, tc->oldfn,
+			*tc->newfd, tc->newfn, tc->flags));
+		if (TST_PASS) {
+			int tnum = rand();
+			int vnum = ~tnum;
+
+			fd = SAFE_OPEN(tc->referencefn1, O_RDWR);
+			SAFE_WRITE(SAFE_WRITE_ALL, fd, &tnum, sizeof(tnum));
+			SAFE_CLOSE(fd);
+
+			fd = SAFE_OPEN(tc->referencefn2, O_RDONLY);
+			SAFE_READ(1, fd, &vnum, sizeof(vnum));
+			SAFE_CLOSE(fd);
+
+			if (tnum == vnum) {
+				tst_res(TPASS,
+					"linkat is functionality correct");
+			} else {
+				tst_res(TFAIL,
+					"The link file's content isn't "
+					"as same as the original file's "
+					"although linkat returned 0");
 			}
 		} else {
-			if (TEST_RETURN == 0)
-				tst_resm(TPASS,
-					 "linkat succeeded as expected");
-			else
-				tst_resm(TPASS | TTERRNO,
-					 "linkat failed as expected");
+			tst_res(TFAIL, "linkat failed");
 		}
 	} else {
-		if (TEST_RETURN == 0)
-			tst_resm(TFAIL, "linkat succeeded unexpectedly");
-		else
-			tst_resm(TFAIL | TTERRNO,
-				 "linkat failed unexpectedly; expected %d - %s",
-				 desc->expected_errno,
-				 strerror(desc->expected_errno));
-	}
-}
-
-void setup(void)
-{
-	char *cwd;
-	int fd;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	cwd = get_current_dir_name();
-	if (cwd == NULL) {
-		tst_brkm(TFAIL | TERRNO, cleanup,
-			 "Failed to get current working directory");
+		TST_EXP_PASS(linkat(*tc->oldfd, tc->oldfn,
+			*tc->newfd, tc->newfn, tc->flags),
+			"linkat");
 	}
-
-	SAFE_MKDIR(cleanup, TEST_DIR1, 0700);
-	SAFE_MKDIR(cleanup, TEST_DIR3, 0700);
-	olddirfd = SAFE_OPEN(cleanup, TEST_DIR1, O_DIRECTORY);
-	deldirfd = SAFE_OPEN(cleanup, TEST_DIR3, O_DIRECTORY);
-	SAFE_RMDIR(cleanup, TEST_DIR3);
-	fd = SAFE_OPEN(cleanup, TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
-	SAFE_CLOSE(cleanup, fd);
-	SAFE_MKFIFO(cleanup, TEST_DIR1 "/" TEST_FIFO, 0600);
-
-	snprintf(dpathname, sizeof(dpathname), DPATHNAME_FMT, cwd);
-	snprintf(spathname, sizeof(spathname), SPATHNAME_FMT, cwd);
-
-	free(cwd);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.test = verify_linkat,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/linkat/linkat03.c b/testcases/kernel/syscalls/linkat/linkat03.c
new file mode 100644
index 000000000..4ee25106e
--- /dev/null
+++ b/testcases/kernel/syscalls/linkat/linkat03.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2006-2024
+ */
+
+/*\
+ * [Description]
+ *
+ * Check the basic function of linkat that returns error.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/syscalls.h"
+#include "lapi/fcntl.h"
+
+#define TEST_DIR1 "olddir"
+#define TEST_DIR2 "newdir"
+#define TEST_DIR3 "deldir"
+#define TEST_FILE1 "oldfile"
+
+static int olddirfd;
+static int newdirfd = -1;
+static int cwd_fd = AT_FDCWD;
+static int stdinfd;
+static int badfd = -1;
+static int deldirfd;
+
+static struct tcase {
+	int *oldfd;
+	const char *oldfn;
+	int *newfd;
+	const char *newfn;
+	int flags;
+	const char *referencefn1;
+	const char *referencefn2;
+	int expected_errno;
+} tcases[] = {
+	/* 1. invalid directory to relative paths */
+	{&stdinfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
+		0, 0, ENOTDIR},
+	/* 2. relative paths to invalid directory */
+	{&olddirfd, TEST_FILE1, &stdinfd, TEST_DIR2 "/" TEST_FILE1, 0,
+		0, 0, ENOTDIR},
+	/* 3. bad fd to relative paths */
+	{&badfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
+		0, 0, EBADF},
+	/* 4. relative paths to bad fd */
+	{&olddirfd, TEST_FILE1, &badfd, TEST_DIR2 "/" TEST_FILE1, 0,
+		0, 0, EBADF},
+	/* 5. deleted to relative paths */
+	{&deldirfd, TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1, 0,
+		0, 0, ENOENT},
+	/* 6. relative paths to deleted */
+	{&olddirfd, TEST_FILE1, &deldirfd, TEST_DIR2 "/" TEST_FILE1, 0,
+		0, 0, ENOENT},
+	/* 7. x-device link */
+	{&cwd_fd, "/proc/cpuinfo", &newdirfd, TEST_FILE1, 0, 0, 0, EXDEV},
+	/* 8. directory link */
+	{&olddirfd, ".", &newdirfd, TEST_FILE1, 0, 0, 0, EPERM},
+	/* 9. invalid flag */
+	{&olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 1, 0, 0, EINVAL},
+};
+
+static void setup(void)
+{
+	char *cwd;
+	int fd;
+
+	cwd = get_current_dir_name();
+	if (cwd == NULL) {
+		tst_brk(TFAIL | TERRNO,
+			"Failed to get current working directory.");
+	}
+
+	SAFE_MKDIR(TEST_DIR1, 0700);
+	SAFE_MKDIR(TEST_DIR3, 0700);
+	olddirfd = SAFE_OPEN(TEST_DIR1, O_DIRECTORY);
+	deldirfd = SAFE_OPEN(TEST_DIR3, O_DIRECTORY);
+	SAFE_RMDIR(TEST_DIR3);
+	fd = SAFE_OPEN(TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
+	SAFE_CLOSE(fd);
+
+	free(cwd);
+}
+
+static void setup_every_case(void)
+{
+	close(newdirfd);
+	rmdir(TEST_DIR2);
+
+	SAFE_MKDIR(TEST_DIR2, 0700);
+	newdirfd = SAFE_OPEN(TEST_DIR2, O_DIRECTORY);
+}
+
+static void verify_linkat(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	setup_every_case();
+
+	TST_EXP_FAIL(linkat(*tc->oldfd, tc->oldfn, *tc->newfd,
+		tc->newfn, tc->flags),
+		tc->expected_errno,
+		"linkat failed as expected");
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.test = verify_linkat,
+	.needs_tmpdir = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
