Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6D6C48291
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 08:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707122318; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=y10UWVBIcSec5FQQ9UkU2b/kGQ/TDjm561bhqCZ6VRQ=;
 b=K+cZxV1GxCCQr/O5Vzee+czN1UkwmkGLNNbjX1QqnccF2z7VMG213kiDiygvu6atnwmXZ
 MhZP9LN5yA430GNzzY+4W7bWWKdA1/9FtXM2eH6rR0YC1s3UGJ0PEq8XTDhJf5HeZnKTpXe
 yQSYQuuUV1lRZm2QQb0Qf+Ry43MT8wM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 809773C90CF
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 09:38:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94F733C90CF
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 09:38:16 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 766B9140123D
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 09:38:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707122296; x=1738658296;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=25VegtwNlIeqgRTP1Zd99x8gkbg4EKsQku3yy5a3cUw=;
 b=JjYn4ilcstQ4mVTHwmBGppJEPZXUEd2SfZ9JZdxn7RxsX0Ic7ysLMP6a
 pzvB+zo1rVOws8w4hV1hFzb/zABTzBdh4rlC/lPED8BTpwj1Hwe223piL
 1Wp71Ggx+w3GNuYRdPrG1YRhcrOCFMOb40AAKlxshvAOHQSU9ff3ncfNw
 yjiz1OK+jccm6IfY19mmkQuHXtjRDTkALJlhMQDBmr5k7ojDhYZm4LZL5
 QVPGJ7B2of9vrAZgKDL1SDXb+41JZ85hiYvPW6/vyDQ9a3KwLCb6q0vr4
 edzwYjrWbALGUMKsipoS4MLfauOPcWbWO5+KkF/Cv7trP+f1jHNUuXUkw g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="127814328"
X-IronPort-AV: E=Sophos;i="6.05,242,1701097200"; d="scan'208";a="127814328"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2024 17:38:13 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D317D6270
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 17:38:10 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 70FCD49058
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 17:38:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 09E5A20098983
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 17:38:09 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8F4FF1A006B;
 Mon,  5 Feb 2024 16:38:08 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon,  5 Feb 2024 03:38:05 -0500
Message-Id: <20240205083805.6713-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28168.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28168.006
X-TMASE-Result: 10--16.995300-10.000000
X-TMASE-MatchedRID: wplI/emIzpfyq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxUL4q
 7wkSW5bKbnRB47KLJ1QzLmfGY6iDkYF+91Q/EzGtN70wXhI0DX4yhLY8urUHvmvlGb+24NaZuJE
 UmdYPGSW9o2p3dj0RfAeWR71HtRmwaEsmopAJRAldhZyafgPiqxeN9Hd3TB5Gg1CUneBzTgvzWM
 gQWjC6I0nY0BEsuOT25rJNazxTXPIr7jXWQYK2DxlxrtI3TxRklKvhkP88iXTMB0kPsl40w9H8F
 nB4FvBYMPDOmTHabb9qGk75BUN9yFWcCzOjQR80Ss47mbT7SAR+tO36GYDlsvRHUPIiGLuAZYH0
 5m0z0gAMf7Ce+LIFdiEGacf+qdGsEtsR9kNMgSyL3n8qdYJTdH0tCKdnhB589yM15V5aWpj6C0e
 Ps7A07QKmARN5PTKc
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] munlockall01: Convert to new API
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
 .../kernel/syscalls/munlockall/munlockall01.c | 140 ++----------------
 1 file changed, 15 insertions(+), 125 deletions(-)

diff --git a/testcases/kernel/syscalls/munlockall/munlockall01.c b/testcases/kernel/syscalls/munlockall/munlockall01.c
index 51f731b65..f265e574f 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall01.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall01.c
@@ -1,134 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * Copyright (c) Linux Test Project, 2002-2024
  */
-/**************************************************************************
- *
- *    TEST IDENTIFIER	: munlockall01
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Basic test for munlockall(2)
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: sowmya adiga<sowmya.adiga@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a phase I test for the munlockall(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *        Execute system call
- *	  Check return code, if system call failed (return=-1)
- *	  Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  munlockall01 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *		where,		-c n : Run n copies concurrently
- *	               		-e   : Turn on errno logging.
- *				-h   : Show this help screen
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *                      	-P x : Pause for x seconds between iterations.
- *                       	 t   : Turn on syscall timing.
- *
- * RESTRICTIONS
- * Must be root/superuser to run it.
- *****************************************************************************/
-#include <errno.h>
-#include <sys/mman.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "munlockall01";
-int TST_TOTAL = 1;
-
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
 
-	setup();
-
-	/* check looping state */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(munlockall());
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "munlockall() Failed with"
-				 " return=%ld", TEST_RETURN);
-		} else {
-			tst_resm(TPASS, "munlockall() passed with"
-				 " return=%ld ", TEST_RETURN);
-
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
-}
-
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
+/*
+ * [Description]
+ *
+ * Check the basic function of munlockall(2) system call.
+ */
 
-#endif /* if !defined(UCLINUX) */
+#include <sys/mman.h>
+#include "tst_test.h"
 
-/* setup() - performs all ONE TIME setup for this test. */
-void setup(void)
+static void verify_munlockall(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	TST_EXP_PASS(munlockall());
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.test_all  = verify_munlockall,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
