Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408DAC4828F
	for <ltp@archiver.kernel.org>; Sat,  3 Feb 2024 03:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1706932791; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=4qZ29tPrwCjpl6pe6Wtx79gQ1iW/oNedxm2wNUBxImI=;
 b=Xgq3i0MuFUrkUBSHOd6FGSGPH/2wGHR+vUofoC+s1P821P/zTcynzXW6dVlkeiuQhG7HW
 A++3hjcl7II6+jwTXEN69Vo/2wU7H3uFjzvlztimFK7sr8usCe1WSh0pA24t92iqPzlgnGk
 9B7TZaqT2jl6+5mKX1Fc99Y2DkS1nIE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B1C83CF858
	for <ltp@archiver.kernel.org>; Sat,  3 Feb 2024 04:59:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70FAC3CB23F
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 04:59:28 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 62C62100EEB8
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 04:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1706932767; x=1738468767;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iKhwiqZCbCU2MBS7uC7tSwzlUODOhpUBDCNPpEe1Qvg=;
 b=SJOIxXS5G7ApF9C8+V5AJrgnpLZVYYCHfB15pJ3HpWbkZHSIPsptO6Od
 OQuPTKxDtAr/GI5OykskoOdt64wLk1tp0/ILiQoVI/Gf0lxxRSS2Gnvci
 gNuhQXa6Y0EVpBpfWjithEV9WvlvTXkH6llY/i7hBS+w5ziBraL5YzFhI
 tKujoCfOrOXRUFJe6ZUn0Nkv8UJjgcUdgleONb1LGsBv0UPbFiVZBUpLw
 VDKQVJWQm3sNvJmnXQs72BkSoDZY1a7KwVohDJFezb+JNPNav8hyriN6/
 CmzPSUCWM+BwEM5cMdW8+7W58zclQY7fI8LTYevY13kYWFiAk3JXTDQo+ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="136261402"
X-IronPort-AV: E=Sophos;i="6.05,238,1701097200"; d="scan'208";a="136261402"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 12:59:23 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0EBDBE9AF3
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 12:59:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3EF46CF7D7
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 12:59:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id AFA092009355F
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 12:59:19 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2C1E31A009A;
 Sat,  3 Feb 2024 11:59:19 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri,  2 Feb 2024 22:59:14 -0500
Message-Id: <20240203035914.2669-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28162.001
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28162.001
X-TMASE-Result: 10--10.248400-10.000000
X-TMASE-MatchedRID: 6dlG10oMNyPyq/cli2hvDU7nLUqYrlslNmVjpriVEtkWxRFlzVAvGli5
 r+TKtIsrAOe0VVRgxtBWTBAeKqaX9Spe4ofkluPsqug9vIA2WODdvovMm13clcPfJfU0tMOF4Xg
 khF5FTCHzbv3mOafziDQOAygP9Dmd0vsjMZhH6s/aHU/pMDSkG9mhsJODizUsvnhgJqkfm0B9Jp
 pVNkb1KxeFELRmbzxEY018kD9GAOHBDRN9OhshUUW5la/dMBNIa9qiaDSLgo3GsuYyb68ajOZkX
 qvcLVUNu+jFdzsOrevbIWbDRjkJ1cVM5J3Ud/0UlXePXNM4FjO/XAJUFuWKa625ZjP2hWgvYxa8
 wxTbhnuekEiryU56HRqKuTwtGvmt4o4c2Gh+0ONVXhlmZsTdjB4crFjzdzs4myiLZetSf8lBgw5
 G4NYCZN9pjzubZ2rHIAcCikR3vq/2vKCpbyODf+T032PkIOgeD5mBa0uRrLYTAAaIFstnf/hrX/
 PJpXID
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fpathconf01: Convert to new API
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
 .../kernel/syscalls/fpathconf/fpathconf01.c   | 113 ++++--------------
 1 file changed, 20 insertions(+), 93 deletions(-)

diff --git a/testcases/kernel/syscalls/fpathconf/fpathconf01.c b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
index d38db401a..4a527a0b2 100644
--- a/testcases/kernel/syscalls/fpathconf/fpathconf01.c
+++ b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
@@ -1,54 +1,17 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- * Author: William Roske
- * Co-pilot: Dave Fenner
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
+ * Copyright (c) Linux Test Project, 2003-2024
  */
 
-/*
- * Testcase to test the basic functionality of fpathconf(2) system call.
+/*\
+ * [Description]
+ *
+ * Check the basic functionality of the fpathconf(2) system call.
  */
 
-#include <fcntl.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
 
-static struct pathconf_args {
+static struct tcase {
 	char *name;
 	int value;
 } test_cases[] = {
@@ -63,67 +26,31 @@ static struct pathconf_args {
 	{"_PC_NO_TRUNC", _PC_NO_TRUNC},
 };
 
-char *TCID = "fpathconf01";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
 static int fd;
 
-int main(int ac, char **av)
+static void verify_fpathconf(unsigned int n)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			errno = 0;
-
-			TEST(fpathconf(fd, test_cases[i].value));
-
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == 0) {
-					tst_resm(TINFO,
-						 "fpathconf has NO limit for "
-						 "%s", test_cases[i].name);
-				} else {
-					tst_resm(TFAIL | TTERRNO,
-						 "fpathconf(fd, %s) failed",
-						 test_cases[i].name);
-				}
-			} else {
-				tst_resm(TPASS,
-					 "fpathconf(fd, %s) returned %ld",
-					 test_cases[i].name, TEST_RETURN);
-			}
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
+	struct tcase *tc = &test_cases[n];
+	TST_EXP_POSITIVE(fpathconf(fd, tc->value));
 }
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
 
-	tst_tmpdir();
-
-	fd = SAFE_OPEN(cleanup, "fpafile01", O_RDWR | O_CREAT, 0700);
+	fd = SAFE_OPEN("fpafile01", O_RDWR | O_CREAT, 0700);
 }
 
 static void cleanup(void)
 {
 	if (fd > 0)
-		SAFE_CLOSE(NULL, fd);
+		SAFE_CLOSE(fd);
 
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test  = verify_fpathconf,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
