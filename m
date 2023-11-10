Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C4CC4332F
	for <ltp@archiver.kernel.org>; Fri, 10 Nov 2023 10:10:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F13C3CE76D
	for <ltp@archiver.kernel.org>; Fri, 10 Nov 2023 11:10:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A3443CC48A
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 11:10:05 +0100 (CET)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A4F7B1000AFF
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 11:10:02 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="139260760"
X-IronPort-AV: E=Sophos;i="6.03,291,1694703600"; d="scan'208";a="139260760"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2023 19:09:59 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4526BD4F60
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 19:09:55 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7CAD8C4A15
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 19:09:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id F326520050183
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 19:09:53 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id AF7501A0071;
 Fri, 10 Nov 2023 18:09:53 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 10 Nov 2023 05:09:38 -0500
Message-Id: <20231110100938.210473-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27988.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27988.006
X-TMASE-Result: 10--9.535600-10.000000
X-TMASE-MatchedRID: cWsSYyeVwqZguZOjaKSsWBIRh9wkXSlF9LMB0hXFSeiY5nVpihxiw5Uh
 t+myr0XMUh5maKIJAx/mn3xyPJAJoh2P280ZiGmRGYJhRh6ssesYH39vFLryExbFEWXNUC8aWLm
 v5Mq0iysA57RVVGDG0FZMEB4qppf1Kl7ih+SW4+yq6D28gDZY4N2+i8ybXdyVw98l9TS0w4XheC
 SEXkVMIfNu/eY5p/OINA4DKA/0OZ3S+yMxmEfqz9odT+kwNKQb2aGwk4OLNSy+eGAmqR+bQH0mm
 lU2RvUrF4UQtGZvPERjTXyQP0YA4cENE306GyFRRbmVr90wE0gxVUWGXs3C811OAfq6beiuF24P
 4yabpDb93kA1ImA+YEej3sxQoy96/r2K6wdIm98APmNKDWsW0H607foZgOWyEbdRL8jlwNFbK2q
 mKUaX1kQD9vOU9UhOm11lBSAav6kfE8yM4pjsD2vfiVSqJzu3SnQ4MjwaO9cqtq5d3cxkNSAHE7
 ojdqqQnJf6reGgSfshcaZvSiCyLT0XgZuUEX2AGOmIJiZ0VaM=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/link03: Remove this case
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

I've noticed that the test objectives of link03 and link05
are very similar. Therefore, i think we can simply remove link03.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/link/.gitignore |   1 -
 testcases/kernel/syscalls/link/link03.c   | 167 ----------------------
 3 files changed, 169 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/link/link03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1851752cf..be55f3f87 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -694,7 +694,6 @@ lgetxattr02 lgetxattr02
 
 link01 symlink01 -T link01
 link02 link02
-link03 link03
 link04 link04
 link05 link05
 link08 link08
diff --git a/testcases/kernel/syscalls/link/.gitignore b/testcases/kernel/syscalls/link/.gitignore
index e5d7f1bbc..b2b9db632 100644
--- a/testcases/kernel/syscalls/link/.gitignore
+++ b/testcases/kernel/syscalls/link/.gitignore
@@ -1,5 +1,4 @@
 /link02
-/link03
 /link04
 /link05
 /link08
diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
deleted file mode 100644
index 1f45240ae..000000000
--- a/testcases/kernel/syscalls/link/link03.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *  AUTHOR		: Richard Logan
- *  CO-PILOT		: William Roske
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
-
- /*
-  * Tests that link(2) succeds with creating n links.
-  */
-
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void help(void);
-static void cleanup(void);
-
-char *TCID = "link03";
-int TST_TOTAL = 2;
-
-#define BASENAME	"lkfile"
-
-static char fname[255];
-static int nlinks = 0;
-static char *links_arg;
-
-option_t options[] = {
-	{"N:", NULL, &links_arg},
-	{NULL, NULL, NULL}
-};
-
-int main(int ac, char **av)
-{
-	int lc;
-	struct stat buf;
-	int i, links;
-	char lname[255];
-
-	tst_parse_opts(ac, av, options, &help);
-
-	if (links_arg) {
-		nlinks = atoi(links_arg);
-
-		if (nlinks == 0) {
-			tst_brkm(TBROK, NULL,
-			         "nlinks is not a positive number");
-		}
-
-		if (nlinks > 1000) {
-			tst_resm(TINFO,
-				 "nlinks > 1000 - may get errno:%d (EMLINK)",
-				 EMLINK);
-		}
-	}
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if (nlinks)
-			links = nlinks;
-		else
-			links = (lc % 90) + 10;
-
-		/* Create links - 1 hardlinks so that the st_nlink == links */
-		for (i = 1; i < links; i++) {
-			sprintf(lname, "%s%d", fname, i);
-			TEST(link(fname, lname));
-
-			if (TEST_RETURN == -1) {
-				tst_brkm(TFAIL | TTERRNO, cleanup,
-					 "link(%s, %s) Failed", fname, lname);
-			}
-		}
-
-		SAFE_STAT(cleanup, fname, &buf);
-
-		if (buf.st_nlink != (nlink_t)links) {
-			tst_resm(TFAIL, "Wrong number of links for "
-			         "'%s' have %i, should be %i",
-				 fname, (int)buf.st_nlink, links);
-			goto unlink;
-		}
-
-		for (i = 1; i < links; i++) {
-			sprintf(lname, "%s%d", fname, i);
-			SAFE_STAT(cleanup, lname, &buf);
-			if (buf.st_nlink != (nlink_t)links) {
-				tst_resm(TFAIL,
-				         "Wrong number of links for "
-					 "'%s' have %i, should be %i",
-					 lname, (int)buf.st_nlink, links);
-				goto unlink;
-			}
-		}
-
-		tst_resm(TPASS, "link() passed and linkcounts=%d match", links);
-
-unlink:
-		for (i = 1; i < links; i++) {
-			sprintf(lname, "%s%d", fname, i);
-			SAFE_UNLINK(cleanup, lname);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void help(void)
-{
-	printf("  -N #links : create #links hard links every iteration\n");
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "%s_%d", BASENAME, getpid());
-	SAFE_TOUCH(cleanup, fname, 0700, NULL);
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
