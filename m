Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98503E7716A
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 08:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734422781; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=NqSGK858cVB6E+IWTH30UCw+IGvn6ppMFkY1cy1ds6g=;
 b=a568ST2eE8EUJynats4U21Y7hOEGi57Be1vruOUEjlUDTelcqHuoOrjQ8Hy9x03tsMKQM
 h1PVF4uLc6F1T7dsVHAWmcpB+QUUz8AmvL/HzG9TqCrf1hMeikGiyejoHgVmC7JBloembl2
 +wDbBCwsEmmA54zh9yYCkakDMnMhRWQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D9053E7A90
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 09:06:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 495583E2990
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 09:06:00 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DD6261431293
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 09:05:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1734422759; x=1765958759;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cNYM9NtPi4Q/xxmRGm7YySiuXtSVE7zIAsiMx9v3Q48=;
 b=oZctYlqZLt8bBy31iLkKoHuA7r+Xc8vZiDktyo7vlmFOUII9/siqv1SH
 KCR/xFleaHBMrGtJ9ZaLyVoNwapAP5ji6D22DPmdILUUau50TgKAxuvL9
 78WnXZ4vQZq6djQK0H0DrvM8jaypvPt+tEouWmkTtP5rilf/RPzEgOe+g
 y0zQC+iaDdQnEeBa3LXnVudDMlCr8JsKxAmg/SLsKyRz9SgbOslFevFTw
 pFAMzyHlSKS42ULo3u0QfymGLwIDwQukVG4HYJNHQjN29+TLdmsDdHPmr
 OWpnXd58m2aXx8oHf53A6o61O7IbsBsotNhEKnGtNdMcQiMo7i8Dqp0Xk g==;
X-CSE-ConnectionGUID: MkeQOsR5Svmwnwa9Sl67Ww==
X-CSE-MsgGUID: cbRjhNVMSXWeWoSvDefiTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="162947888"
X-IronPort-AV: E=Sophos;i="6.12,241,1728918000"; d="scan'208";a="162947888"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 17:05:56 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 67281D4C39
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 17:05:54 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 38A4FD6FF3
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 17:05:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id B62992007FAD3
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 17:05:53 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 5683F1A000B;
 Tue, 17 Dec 2024 16:05:53 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 17 Dec 2024 16:05:22 +0800
Message-ID: <20241217080522.2993992-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28864.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28864.006
X-TMASE-Result: 10--2.572900-10.000000
X-TMASE-MatchedRID: mLEC5fZiOdAB90FcL1q4MKzGfgakLdjaNmVjpriVEtlRTd1AeDAt7zib
 ESY8R8hiQMOJEqjTDACHzK4exfm8m04GO5MhEQotqug9vIA2WODTAe9FsgbYxxd+xtxH8FsxqCf
 eIlEscU5KU23a3Z4Sgl9QwtoILPgbYwBIYRLig/YTMSg6oABUszaEg2r8izCUTPm/MsQarwMsjs
 Y5yg0AYwm6uSKbYHiD3f+upNqH8RFJ6sKfyz0AbW03YawHJvPCHJJXhOFmNVtULhp+W/a9megoS
 vaKsl/kTWffQzmh43jUf0qVquiKqOQu+8z9/q/ltPYfgFJ3kY/1q+x7zkhJWpyG1Z7KRwOKpTac
 d14H2kiLVDMXzEGmRY/WTtrhCSgoNyl1nd9CIt0URSScn+QSXt0H8LFZNFG7/nnwJ52QYi+Std8
 3kHCpUWpGI/X5iJebAc1RJZA2k3LWwsva9wHkEDnhduaamnEG/xuuHCs/5/k07/CzMXl4sCT7RS
 Yv3Tgfaz38LS2gFGId5LRa9em2y1uMG6V02+QySir3tZId0WN+6klq53W5kJ9Gzq4huQVX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] set_tid_address01: refactor with new LTP API
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

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../set_tid_address/set_tid_address01.c       | 146 +++---------------
 1 file changed, 23 insertions(+), 123 deletions(-)

diff --git a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
index 11fa27540..fa03a1489 100644
--- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
+++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
@@ -1,129 +1,29 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007                                   */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/*                                                                            */
-/* File:        set_tid_address01.c                                           */
-/*                                                                            */
-/* Description: This tests the set_tid_address() syscall                      */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* set_tid_address01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   set_tid_address01                                             */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
-/******************************************************************************/
-
-#include <stdio.h>
-#include <errno.h>
-
-#include "test.h"
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) Crackerjack Project., 2007
+ * Copyright (c) Linux Test Project, 2007-2024
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify the basic functionality of set_tid_address() syscall.
+ */
+
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 
-char *TCID = "set_tid_address01";
-int testno;
-int TST_TOTAL = 1;
-
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-	tst_exit();
-}
-
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
-void setup(void)
-{
-	/* Capture signals if any */
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-int main(int ac, char **av)
+static void verify_set_tid_address(void)
 {
 	int newtid = -1;
-	int lc;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST(tst_syscall(__NR_set_tid_address, &newtid));
-			if (TEST_RETURN == getpid()) {
-				tst_resm(TPASS,
-					 "set_tid_address call succeeded:  as expected %ld",
-					 TEST_RETURN);
-			} else {
-				tst_brkm(TFAIL, cleanup, "%s failed - errno = %d : %s",
-					 TCID, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			}
-		}
-	}
-	cleanup();
-	tst_exit();
+	TEST(tst_syscall(__NR_set_tid_address, &newtid));
+	if (TST_RET == getpid())
+		tst_res(TPASS, "set_tid_address call succeeded: as expected %ld", TST_RET);
+	else
+		tst_res(TFAIL | TTERRNO, "set_tid_address call failed: expected %ld, but got %ld", getpid(), TST_RET);
 }
+
+static struct tst_test test = {
+	.test_all = verify_set_tid_address,
+	.needs_tmpdir = 1,
+};
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
