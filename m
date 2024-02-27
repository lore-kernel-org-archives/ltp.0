Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A2AC54798
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709023429; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=IBQcmtaMa4KZdnxfL2GAraK6RhtiDvElW6wJVNGUal8=;
 b=kNOTI9kyBJEl1hmCT82FdqzfMq2xR5rVgubMsLug6C77t60G1oGoPOzN5cKSIic7ytsap
 iphA5/3DgnMtSWysEpJRamHyygNBMTxvc/eAOWu7I9rWW97CSmdgGIme4QmAZn0SRtk7gjL
 7Q9+6AJQCqG91yshFsf/gUiBgzNyRgk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BFDC3CEF40
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 09:43:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC0CB3CEF3C
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 09:43:07 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E261A1401634
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 09:43:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1709023386; x=1740559386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c0yG5V5TUt1t2F3hiNeEEdffiRzedhWp/89WwB7angc=;
 b=nwFj/UerplAxrMvJ68UMIW7+/KwCuQZnvrXqxIbxNGO2C9zA5f1xSHLs
 A3HxF2kB9WrV3sC0PfMo6WaC86Alqe/PaZSZ/4na+Apf56vLFoAAnK6Et
 kHEZWYf3b/l95jjjuaQ7tKd90sD1lPNwVO/dCT5C6ya0lpTJvEH5GFGhl
 YubtDAt0ec3i0Elcw5DSX7b5zdnUHPYwMTSDDKPbTh3blxxBzNgsWCV2S
 Tvjgu+OlnhNSvIOyBZhMhM2xJgYshc5nkc5ISoM1l73JzjrI/nGBTdJt6
 3fK8eBNbysqloOlO+qXfNByDN2kiSxHz1p+FMQT233XdcLI9Lppct2mgZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="129838175"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; d="scan'208";a="129838175"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 17:43:04 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 04A062A0DEF
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:43:02 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 40AA9D7B6F
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:43:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C1E602008FF84
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:43:00 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 406D91A006A;
 Tue, 27 Feb 2024 16:43:00 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 27 Feb 2024 03:42:43 -0500
Message-Id: <20240227084244.33662-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
References: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28216.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28216.006
X-TMASE-Result: 10--13.074000-10.000000
X-TMASE-MatchedRID: 7q1xkhOBgdehhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkIh+
 mL+ciFCpbnRB47KLJ1QzLmfGY6iDkX5uUfhNvnKzOWUWxTQJdI8UZYubbUj2DLt4BAaULwAVJf5
 otvavOZf9vT5evMX4tJhCh8+WImJUkto8AKCDbo7X3j/lf1V8LNhQO8CvZj/XfL8fHUCAmuv1ov
 LD2i2bwoHA6IBd3vQsIvabuzhmQeA9M2SZK+EIssQ4mpKyfkqZBGvINcfHqhcli8Y5a0svLxduD
 +Mmm6Q2gC3FH2GME0bQsefS5WLXU3hh1unvIp4BqNtC2YatSIkcsx3IH4sq3MgVyTd/p+/Io6yI
 pLdrAfgD+h7g3AV/au2m4eeglpGzlTFYj5iEM4VdhZyafgPiqx+KaaVwAG43JLfQYoCQHFYTSjx
 b4ZTfMJ6QSKvJTnodwTWpxY8/N9Pkht9v6t8rYxQ7ky03us3D7xa8TAoa4anoTJc0BP/XCqPFjJ
 EFr+olwXCBO/GKkVqOhzOa6g8KrcN5HKs2rTzbbc80XJECKYhsJrgG9oG6nF4RRubAjLXFYluQl
 3unzhQ=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] mremap03: Convert to new API
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
 testcases/kernel/syscalls/mremap/mremap03.c | 201 ++++----------------
 1 file changed, 39 insertions(+), 162 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 02b79bc47..4e55dbda6 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -1,187 +1,64 @@
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
+ * 07/2001 Ported by Wayne Boyer
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
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
+/*\
+ * [Description]
  *
- * Usage:  <for command-line>
- *  mremap03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -p x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
+ * Test for EFAULT error.
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
+ * - mremap fail with the old address specified was not mapped.
  */
-#define _GNU_SOURCE
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
 
-#include "test.h"
+#define _GNU_SOURCE
+#include "tst_test.h"
 
-char *TCID = "mremap03";
-int TST_TOTAL = 1;
 static char *bad_addr;
-static char *addr;		/* addr of memory mapped region */
-int memsize;			/* memory mapped size */
-int newsize;			/* new size of virtual memory block */
+static char *addr;
+static int memsize;
+static int newsize;
 
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
-
-		tst_count = 0;
+	errno = 0;
+	addr = mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE);
+	TST_ERR = errno;
 
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
+	if (addr != MAP_FAILED) {
+		tst_res(TFAIL | TTERRNO,
+			"mremap returned invalid value, expected: -1");
 	}
 
-	cleanup();
-	tst_exit();
-
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
-
-	TEST_PAUSE;
+	int page_sz;
 
-	/* Get the system page size */
-	if ((page_sz = getpagesize()) < 0) {
-		tst_brkm(TFAIL, NULL,
-			 "getpagesize() fails to get system page size");
-	}
-
-	/* Get the size of virtual memory area to be mapped */
+	page_sz = SAFE_SYSCONF(_SC_PAGESIZE);
 	memsize = (1000 * page_sz);
-
-	/* Get the New size of virtual memory block after resize */
 	newsize = (memsize * 2);
-
-	/*
-	 * Set the old virtual address point to some address
-	 * which is not mapped.
-	 */
-	bad_addr = tst_get_bad_addr(cleanup);
+	bad_addr = tst_get_bad_addr(NULL);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	/* Exit the program */
-
+	if (addr != MAP_FAILED)
+		SAFE_MUNMAP(addr, newsize);
 }
+
+static struct tst_test test = {
+	.test_all = verify_mremap,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
