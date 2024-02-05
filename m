Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A78DC4828D
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 05:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707110050; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=eWyGYPCXmiH9XTfkS8GFS/JM8x97EPLb8MAV57FQRSg=;
 b=n08j4RNagmU6/jd4r+RZVzjPq1NuwbKVEX5Ob1bA8510YjTvnjEhBwIDnq1XgHgc1t1hO
 Q1NZ7wYklk8Gj3BG7BJmftAtDb8dM/kuwjFEem6tnZibdb8uyuqoIroL689ie0SRwMpVOfM
 oxikrMLMYL/LOEik7C92w/fjoojCQ0o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECEB83CE0EC
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 06:14:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19ADC3CD6E0
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 06:13:00 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6D096200A18
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 06:12:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707109980; x=1738645980;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dhhDXE27Oo+G77sH0VNgpEG5VR+4Hcnvm4d7z+yLWWE=;
 b=Ylfx9Yuso6RXpOui0bEs8PlTcWFGuyBbDluMPowrsV/7WQ6niBJ93OR2
 MdiLe+S21Iy3MJslIG+yPDAtLH1o5Fc3Vx5Np04lGD0mnkeSnEZDe5Rfi
 4aZTs6o/m/1pKZXxt7UfL51w+W6xZjP+SQyY2K6R71Ks3q2VHyq84Oq/J
 9TtGOkTFKp4wheRmbtZUGOTnhr1s6grv+tnGvhD3dkoDckS89fD3HOeu7
 K/pw1U1Ar2yNSyA7oe4WA9I1gSDgU0YQRPCImsWE4SKrhkjbEgjjZ/j8o
 rVouAHPAZFRWV5HjWU30zTlogeYYW/5GoT0Xb5nYj5eaHscGWWhRGh5Fd A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="136842501"
X-IronPort-AV: E=Sophos;i="6.05,242,1701097200"; d="scan'208";a="136842501"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2024 14:12:55 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 01A012F81F
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 14:12:54 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2321B24274A
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 14:12:48 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9F82968957
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 14:12:47 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 4D4BA1A009A;
 Mon,  5 Feb 2024 13:12:47 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon,  5 Feb 2024 00:12:29 -0500
Message-Id: <20240205051230.6272-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205051230.6272-1-xuyang2018.jy@fujitsu.com>
References: <20240205051230.6272-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28168.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28168.004
X-TMASE-Result: 10--13.074000-10.000000
X-TMASE-MatchedRID: 7q1xkhOBgdehhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkIh+
 mL+ciFCpbnRB47KLJ1QzLmfGY6iDkX5uUfhNvnKzOWUWxTQJdI8UZYubbUj2DLt4BAaULwAVJf5
 otvavOZf9vT5evMX4tJhCh8+WImJUkto8AKCDbo7X3j/lf1V8LNhQO8CvZj/XfL8fHUCAmuv1ov
 LD2i2bwoHA6IBd3vQsIvabuzhmQeA9M2SZK+EIssQ4mpKyfkqZBGvINcfHqhcli8Y5a0svLxduD
 +Mmm6Q2gC3FH2GME0bQsefS5WLXU3hh1unvIp4BqNtC2YatSIkcsx3IH4sq3MgVyTd/p+/Io6yI
 pLdrAfgD+h7g3AV/au2m4eeglpGzlTFYj5iEM4VdhZyafgPiqxgff28UuvITNAzT8I6i53BjHxr
 OWebiVEPHgqX8A7utwTWpxY8/N9Pkht9v6t8rYxQ7ky03us3D7xa8TAoa4anoTJc0BP/XCqPFjJ
 EFr+olwXCBO/GKkVqOhzOa6g8KrRqoPcm7G6PadKpharxGzDMZloh3kgNoN+05g0YPOTF9WnhRV
 zNZJ6c=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mremap03: Convert to new API
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
 testcases/kernel/syscalls/mremap/mremap03.c | 197 +++++---------------
 1 file changed, 44 insertions(+), 153 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 02b79bc47..b7497bc01 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -1,165 +1,62 @@
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
- * Test Name: mremap03
- *
- * Test Description:
- *  Verify that,
- *   mremap() fails when used to expand the existing virtual memory mapped
- *   region to the requested size, if there already exists mappings that
- *   cover the whole address space requsted or the old address specified was
- *   not mapped.
- *
- * Expected Result:
- *  mremap() should return -1 and set errno to EFAULT.
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
+/*\
+ * [Description]
  *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
+ * Test for EFAULT error.
  *
- * Usage:  <for command-line>
- *  mremap03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -p x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
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
+ * - mremap fail with mapping covering the requested entire address space already exists
+ *   or the old address specified was not mapped.
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
-char *TCID = "mremap03";
-int TST_TOTAL = 1;
 static char *bad_addr;
-static char *addr;		/* addr of memory mapped region */
-int memsize;			/* memory mapped size */
-int newsize;			/* new size of virtual memory block */
+static char *addr;              /* addr of memory mapped region */
+static int memsize;             /* memory mapped size */
+static int newsize;             /* new size of virtual memory block */
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void verify_mremap(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	errno = 0;
+	addr = mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE);
+	TST_ERR = errno;
 
-	setup();
+	/* Check for the return value of mremap() */
+	if (addr != MAP_FAILED) {
+		tst_res(TFAIL | TTERRNO,
+			"mremap returned invalid value, expected: -1");
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Attempt to expand the existing mapped
-		 * memory region (memsize) by newsize limits
-		 * using mremap() should fail as specified old
-		 * virtual address was not mapped.
-		 */
-		errno = 0;
-		addr = mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE);
-		TEST_ERRNO = errno;
-
-		/* Check for the return value of mremap() */
-		if (addr != MAP_FAILED) {
-			tst_resm(TFAIL,
-				 "mremap returned invalid value, expected: -1");
-
-			/* Unmap the mapped memory region */
-			if (munmap(addr, newsize) != 0) {
-				tst_brkm(TFAIL, cleanup, "munmap fails to "
-					 "unmap the expanded memory region, "
-					 " error=%d", errno);
-			}
-			continue;
-		}
-
-		/* Check for the expected errno */
-		if (errno == EFAULT) {
-			tst_resm(TPASS, "mremap() Fails, 'old region not "
-				 "mapped', errno %d", TEST_ERRNO);
-		} else {
-			tst_resm(TFAIL, "mremap() Fails, "
-				 "'Unexpected errno %d", TEST_ERRNO);
-		}
+		/* Unmap the mapped memory region */
+		SAFE_MUNMAP(addr, newsize);
 	}
 
-	cleanup();
-	tst_exit();
-
+	/* Check for the expected errno */
+	if (errno == EFAULT) {
+		tst_res(TPASS | TTERRNO, "mremap() Failed, 'old region not "
+				"mapped' - errno %d", TST_ERR);
+	} else {
+		tst_res(TFAIL | TTERRNO, "mremap() Failed, "
+				"'Unexpected errno %d", TST_ERR);
+	}
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- * Get system page size.
- * Set the old address point some high address which is not mapped.
- */
 void setup(void)
 {
-	int page_sz;		/* system page size */
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	int page_sz;            /* system page size */
 
-	TEST_PAUSE;
+	page_sz = getpagesize();
 
 	/* Get the system page size */
-	if ((page_sz = getpagesize()) < 0) {
-		tst_brkm(TFAIL, NULL,
-			 "getpagesize() fails to get system page size");
+	if (page_sz < 0) {
+		tst_brk(TFAIL | TTERRNO,
+			"getpagesize() fails to get system page size");
 	}
 
 	/* Get the size of virtual memory area to be mapped */
@@ -169,19 +66,13 @@ void setup(void)
 	newsize = (memsize * 2);
 
 	/*
-	 * Set the old virtual address point to some address
-	 * which is not mapped.
-	 */
-	bad_addr = tst_get_bad_addr(cleanup);
+	* Set the old virtual address point to some address
+	* which is not mapped.
+	*/
+	bad_addr = tst_get_bad_addr(NULL);
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
