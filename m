Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E57C54798
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709012556; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=RNCVbDszthOnL/bd7S5OWKwShc+zQbWmfrxKtP2458k=;
 b=H39spaKuKchVnrU5PKXr8PKYp68M7OKSgzppymbidzuPS2ophHGYoo+ixiuF2nLtyROit
 5gejYKSn9fhALI/MnILD8HOBVpPBxSADslcWh/u65QshtloCxJaDm/luvG1WVZt7/jKVcUq
 vs3wDFkpDbzopb2aN6iRB3CXkum8aWQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B687B3CD8BF
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 06:42:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66CDF3CB504
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 06:42:13 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 24C8A1400981
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 06:42:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1709012531; x=1740548531;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NsxFA0hA/DKPFTWk8MLggZQ4Rg6lbeVp/mdBw+aIf30=;
 b=d3rdl9JsJ5O7nM/4SjPMPlK9w32uEI74UDfwwc52bdNZTUz6tNKlexhM
 NgA/V0VlCaAzsE7qUU0rAO8CKYWpq7VcRiueGNjF61jsiR0auP6iyXrmy
 XUCzeIEwac55OcSJTv9ipp88q7wRqkdhOw4HiqDU7A064Ul+kZnFbGEQj
 E13z/3HrXDjcitiySis+E74MJjZkz23sI3+f96aB8rbvQ55whMuBH4tMU
 NccYHUL1jA4Ohn0HxqWbaQeMv+fidfMvifYhhUYlRYbqL5yX5cPff7nnJ
 G7Km0X8GxPYXCBJ96nEi6fYFsDcywYcQcmfC6RiUot1WbNIvk2aP2iDmE w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="138521643"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; d="scan'208";a="138521643"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 14:42:08 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id A98341590F8
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 14:42:06 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D8667D41B0
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 14:42:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A2EB2008FF8F
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 14:42:05 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 179A61A006A;
 Tue, 27 Feb 2024 13:42:04 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 27 Feb 2024 00:41:44 -0500
Message-Id: <20240227054144.27013-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28216.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28216.005
X-TMASE-Result: 10--16.995300-10.000000
X-TMASE-MatchedRID: wplI/emIzpfyq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxUL4q
 7wkSW5bKbnRB47KLJ1QzLmfGY6iDkYF+91Q/EzGtN70wXhI0DX4yhLY8urUHvmvlGb+24NaZuJE
 UmdYPGSW9o2p3dj0RfAeWR71HtRmwaEsmopAJRAldhZyafgPiqxeN9Hd3TB5Gg1CUneBzTgvzWM
 gQWjC6I0nY0BEsuOT25rJNazxTXPIr7jXWQYK2DxlxrtI3TxRklKvhkP88iXTMB0kPsl40w9H8F
 nB4FvBYMPDOmTHabb9qGk75BUN9yFWcCzOjQR80Ss47mbT7SAR+tO36GYDlslQuGn5b9r2ZN/Z2
 acZRUwnfJQwjclGDz+yFs1HYIL4NEtsR9kNMgSyL3n8qdYJTdH0tCKdnhB589yM15V5aWpj6C0e
 Ps7A07QKmARN5PTKc
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] munlockall01: Convert to new API
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
 .../kernel/syscalls/munlockall/munlockall01.c | 140 +++---------------
 1 file changed, 18 insertions(+), 122 deletions(-)

diff --git a/testcases/kernel/syscalls/munlockall/munlockall01.c b/testcases/kernel/syscalls/munlockall/munlockall01.c
index 51f731b65..9306cef11 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall01.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall01.c
@@ -1,134 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
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
+ * Author: sowmya adiga<sowmya.adiga@wipro.com>
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
-
-	setup();
-
-	/* check looping state */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
 
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
+/*
+ * [Description]
+ *
+ * Check the basic function of munlockall(2) system call.
+ */
 
-#else
+#include "tst_test.h"
 
-int main(void)
+static void verify_munlockall(void)
 {
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
+	TST_EXP_PASS(munlockall());
 }
 
-#endif /* if !defined(UCLINUX) */
-
-/* setup() - performs all ONE TIME setup for this test. */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	mlockall(MCL_CURRENT);
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
+	.setup = setup,
+	.test_all  = verify_munlockall,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
