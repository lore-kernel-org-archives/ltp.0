Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68086C48291
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 05:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707109996; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=AsfIykIC49hqo4FjdLBJxhgv5Ky92YZkf+AyydGZtxs=;
 b=YORhkxqiDTiMZl+bWU4WyQdD3YNGQE4JKkrcEOdlQS2pHqPfzL/stCzduvbNFcDSytQOm
 ZFoSDCrUj1JnBYRUzWF1Ytan1eiZ/DTXMGVlCe0CjmmczK5xl9Tq5nkM/hNwscFYLvFsrxS
 HZcbpR8kesPcNMelWbuohrOVidwlWWo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25CBB3CE057
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 06:13:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F5C53C90CF
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 06:12:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6D2D31001F2B
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 06:12:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707109973; x=1738645973;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=z+x1XHYBhlFkX/mOMwlQzpzR0KAMlQHVrkONCgtepxk=;
 b=D99+jqnnuFkOxkcwqHl846+gdr+FoA0BU8fpWyi26LhN7UK8KDs1hw8l
 xfNr3EdCDO1Ro8RREIkOFaa3t2tlBWHGy7zyGeGF6n15PE+kDOVRXB7HG
 rgbLuNerdbWi6aSJ+cAVuv3lEEgIeJoG90QI5RQncX+DeMlGM0fdZDtjG
 z7es5Zb+nvSXNOj1Ayqas1QFurBG2We+7cNDoae4wMHeH/DTcY2tWo5lD
 LNQep/TmFV8/3IgJY8pgWSMEju7ksVG7aLDjTWpRUdXi3rjBBVVDD+ZHI
 lPUyETWmxxi5VLBsrl8f+jZJeN17+MNQwSXZFo17NPOLOtt5LdizKoeas g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="147868664"
X-IronPort-AV: E=Sophos;i="6.05,242,1701097200"; d="scan'208";a="147868664"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2024 14:12:49 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DE904124101
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 14:12:46 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2AACDD9681
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 14:12:46 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E1A1200983C2
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 14:12:45 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1F0981A009A;
 Mon,  5 Feb 2024 13:12:45 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon,  5 Feb 2024 00:12:28 -0500
Message-Id: <20240205051230.6272-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28168.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28168.005
X-TMASE-Result: 10--11.316000-10.000000
X-TMASE-MatchedRID: rP3/tz83A4WhhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkIh+
 mL+ciFCpbnRB47KLJ1QzLmfGY6iDkX5uUfhNvnKzOWUWxTQJdI8UZYubbUj2DLt4BAaULwAVJf5
 otvavOZf9vT5evMX4tJhCh8+WImJUkto8AKCDbo7X3j/lf1V8LNhQO8CvZj/XfL8fHUCAmuv1ov
 LD2i2bwoHA6IBd3vQswTgwAtrOMM4O9fZKTjt+zzz6L+U/pejxfb+ZO7kHlEgyiHqxwIX2MVOkR
 ICTn8kKUjFinMvpgsNmlbstSGDENWULhS/RYteO3nHtGkYl/VpIvK4LrXs1aZsgafD1fXNh+03a
 +MQ8RE1Zms6w/rdLbtCPpguQSWAlZ2OZE/lyQ29KzjuZtPtIBH607foZgOWyNAzT8I6i53DDRve
 w35mZexdx1aMGhJ7URzLfMkqkPSlccQ8eam5EfRRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7nWGv6
 KQdMpgzuQswPkhxDg3cYBcqBDyW4OMtU7OH3k7aAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] mremap02: Convert to new API
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mremap/mremap02.c | 186 ++++----------------
 1 file changed, 37 insertions(+), 149 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap02.c b/testcases/kernel/syscalls/mremap/mremap02.c
index 2dabc6847..ff46462d9 100644
--- a/testcases/kernel/syscalls/mremap/mremap02.c
+++ b/testcases/kernel/syscalls/mremap/mremap02.c
@@ -1,162 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) Linux Test Project, 2001-2024
  */
 
-/*
- * Test Name: mremap02
- *
- * Test Description:
- *  Verify that,
- *   mremap() fails when used to expand the existing virtual memory mapped
- *   region to the requested size, if the virtual memory area previously
- *   mapped was not page aligned or invalid argument specified.
- *
- * Expected Result:
- *  mremap() should return -1 and set errno to EINVAL.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *	if errno set == expected errno
- *		Issue sys call fails with expected return value and errno.
- *	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
+/*\
+ * [Description]
  *
- * Usage:  <for command-line>
- *  mremap02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *	       -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -p x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
+ * Test for EINVAL error.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- *      11/09/2001 Manoj Iyer (manjo@austin.ibm.com)
- *      Modified.
- *      - #include <linux/mman.h> should not be included as per man page for
- *        mremap, #include <sys/mman.h> alone should do the job. But inorder
- *        to include definition of MREMAP_MAYMOVE defined in bits/mman.h
- *        (included by sys/mman.h) __USE_GNU needs to be defined.
- *        There may be a more elegant way of doing this...
- *
- *
- * RESTRICTIONS:
- *  None.
+ * - mremap fail with virtual memory area previously mapped was not page aligned
+ *   or invalid argument specified.
  */
+
 #define _GNU_SOURCE
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <sys/mman.h>
+#include "tst_test.h"
 
-#include "test.h"
-
-char *TCID = "mremap02";
-int TST_TOTAL = 1;
-char *addr;			/* addr of memory mapped region */
-int memsize;			/* memory mapped size */
-int newsize;			/* new size of virtual memory block */
+static char *addr;			/* addr of memory mapped region */
+static int memsize;			/* memory mapped size */
+static int newsize;			/* new size of virtual memory block */
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void verify_mremap(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	errno = 0;
+	addr = mremap(addr, memsize, newsize, MREMAP_MAYMOVE);
+	TST_ERR = errno;
 
-		tst_count = 0;
+	/* Check for the return value of mremap() */
+	if (addr != MAP_FAILED) {
+		tst_res(TFAIL | TTERRNO,
+			 "mremap returned invalid value, expected: -1");
 
-		/*
-		 * Attempt to expand the existing mapped
-		 * memory region (memsize) by newsize limits using
-		 * mremap() should fail as old virtual address is not
-		 * page aligned.
-		 */
-		errno = 0;
-		addr = mremap(addr, memsize, newsize, MREMAP_MAYMOVE);
-		TEST_ERRNO = errno;
-
-		/* Check for the return value of mremap() */
-		if (addr != MAP_FAILED) {
-			tst_resm(TFAIL,
-				 "mremap returned invalid value, expected: -1");
-
-			/* Unmap the mapped memory region */
-			if (munmap(addr, newsize) != 0) {
-				tst_brkm(TBROK, cleanup, "munmap fails to "
-					 "unmap the expanded memory region, "
-					 "error=%d", errno);
-			}
-			continue;
-		}
-
-		if (errno == EINVAL) {
-			tst_resm(TPASS, "mremap() Failed, 'invalid argument "
-				 "specified' - errno %d", TEST_ERRNO);
-		} else {
-			tst_resm(TFAIL, "mremap() Failed, "
-				 "'Unexpected errno %d", TEST_ERRNO);
-		}
+		/* Unmap the mapped memory region */
+		SAFE_MUNMAP(addr, newsize);
 	}
 
-	cleanup();
-	tst_exit();
-
+	if (errno == EINVAL) {
+		tst_res(TPASS | TTERRNO, "mremap() Failed, 'invalid argument "
+			 "specified' - errno %d", TST_ERR);
+	} else {
+		tst_res(TFAIL | TTERRNO, "mremap() Failed, "
+			 "'Unexpected errno %d", TST_ERR);
+	}
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- * Get system page size, Set the size of virtual memory area and the
- * new size after resize, Set the virtual memory address such that it
- * is not aligned.
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
 
+static void setup(void)
+{
 	/* Get the system page size */
 	if ((memsize = getpagesize()) < 0) {
-		tst_brkm(TFAIL, NULL,
-			 "getpagesize() fails to get system page size");
+		tst_brk(TBROK | TTERRNO, "getpagesize() fails to get system page size");
 	}
 
 	/* Get the New size of virtual memory block after resize */
@@ -166,13 +60,7 @@ void setup(void)
 	addr = (char *)(addr + (memsize - 1));
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-
-	/* Exit the program */
-
-}
+static struct tst_test test = {
+	.test_all = verify_mremap,
+	.setup = setup,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
