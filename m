Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA55AECAAD5
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 11:12:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCDA23CA4A5
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 13:12:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79A083C7CB4
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 13:12:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 27AB21400975
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 13:12:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DED9336B4
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661512325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xQW2mKYwNuuqeAl1P5fCppF1br78ylFW4sj3rD43fGw=;
 b=iB3QfoJUH21seK1lB1U7SpTO78qTf/xhHtsGe0dWZKUaOazlQ/SvjOaXTjys72hMolEBIp
 CGEeSPfmr/jbW+qeZ/Iox7SEj2hu1R9BEBxIN31myer4CHxKfRpN29eABT7+Gw9Lne144W
 Gw0qYcFQ01TLf06L+DI/QJYLSdCVoCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661512325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xQW2mKYwNuuqeAl1P5fCppF1br78ylFW4sj3rD43fGw=;
 b=Aa7wCPShVtKWyKLGi+Rkg+rCLp/TFQDA3q/xeOovNLTURwOfh/tKZDTv21VOSaopiqgSwx
 yZTFyGVDXMS56TDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5D3413421
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 11:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3zUuJoSqCGNObwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 11:12:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 26 Aug 2022 16:42:02 +0530
Message-Id: <20220826111202.1533-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getpagesize01: Rewrite using new LTP API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../syscalls/getpagesize/getpagesize01.c      | 112 +++---------------
 1 file changed, 18 insertions(+), 94 deletions(-)

diff --git a/testcases/kernel/syscalls/getpagesize/getpagesize01.c b/testcases/kernel/syscalls/getpagesize/getpagesize01.c
index 0d0465827..eb1f3d2b1 100644
--- a/testcases/kernel/syscalls/getpagesize/getpagesize01.c
+++ b/testcases/kernel/syscalls/getpagesize/getpagesize01.c
@@ -1,105 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) International Business Machines  Corp., 2005
+ *   Robbie Williamson <robbiew@us.ibm.com>
  * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
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
+ *   Prashant P Yendigeri <prashant.yendigeri@wipro.com>
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : getpagesize01
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Basic tests for getpagesize(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Prashant P Yendigeri
- *                        <prashant.yendigeri@wipro.com>
- *			  Robbie Williamson
- *			  <robbiew@us.ibm.com>
- *
- *    DESCRIPTION
- *      This is a Phase I test for the getpagesize(2) system call.
- *      It is intended to provide a limited exposure of the system call.
- *
- **********************************************************/
-
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "getpagesize01";
-int TST_TOTAL = 1;
 
-int main(int ac, char **av)
-{
-	int lc;
-
-	int size, ret_sysconf;
-	/***************************************************************
-	 * parse standard options
-	 ***************************************************************/
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(getpagesize());
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "getpagesize failed");
-			continue;	/* next loop for MTKERNEL */
-		}
-
-		size = getpagesize();
-		tst_resm(TINFO, "Page Size is %d", size);
-		ret_sysconf = sysconf(_SC_PAGESIZE);
-#ifdef DEBUG
-		tst_resm(TINFO,
-			 "Checking whether getpagesize returned same as sysconf");
-#endif
-		if (size == ret_sysconf)
-			tst_resm(TPASS,
-				 "getpagesize - Page size returned %d",
-				 ret_sysconf);
-		else
-			tst_resm(TFAIL,
-				 "getpagesize - Page size returned %d",
-				 ret_sysconf);
-	}
+/*\
+ * [Description]
+ *
+ * Verify that getpagesize(2) returns the number of bytes in a
+ * memory page as expected.
+ */
 
-	cleanup();
-	tst_exit();
-}
+#include "tst_test.h"
 
-void setup(void)
+static void run(void)
 {
+	int pagesize_sysconf;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	pagesize_sysconf = sysconf(_SC_PAGESIZE);
+	TST_EXP_VAL(getpagesize(), pagesize_sysconf);
 }
 
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run
+};
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
