Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6484EC02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737016870; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=nHsKzq+A4j7E2svoFA/HwEbx6StF/z4QasxWL4cwtUs=;
 b=UQtimWsFDWh/kZsBKiN++K65wNJJtSsCp/YzZv4M8dG6cz3xMyf3Z/pLVlIrmcl06ZbR7
 QYzDV6e8dclBmikgMshWLFshVRnQjImkgE9ykENQNGA7RZ6puvAodgxWf5iFIY9+LAtKaP3
 UZMEK81v37i2NQx8M4AJGfzzWWFU/Rs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E51953C7BA2
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 09:41:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DCFF3C7B73
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:40:22 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 920ED20BCD0
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737016820; x=1768552820;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Dwrid3zOc7/qSHPLMrcI/3yf6qP189+D8B+DunngL5c=;
 b=l9Y2qv96h3+9r946ufmoIdvc08d5NzK6diSWRivzP/LYK1eKSzgTxxtI
 OIBFk3PpRUx7iwBjE0B5flEKUKkuEZuLeD5/mhk8yBHphsOFyoMFQvoxw
 gFjvpp4bG1SSnPU9gXO+UA+ob2+4yiFMAyx40Do/RyVBtAZxV8kgUdqua
 ZIf4EB+2LLqtJSSLvxEkvDRZKPsOG722PdmfPca1sowa6LTcL2pEZfFqa
 cPuF1xQXwW1T5bXq7Bf1U+rP3MfFhV80JpsH5KvuqNsyKzu914IWnBk9c
 pRWHexluDwuWwqSlhuOL+TpB6MOiMRezrRawvSMiq8+krCqSutMJ3btr6 w==;
X-CSE-ConnectionGUID: fQ2V+ej6S/SadjTbUmXQfw==
X-CSE-MsgGUID: 2+4ElR0hTeC6/SKAjyRCZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="166219833"
X-IronPort-AV: E=Sophos;i="6.13,208,1732546800"; d="scan'208";a="166219833"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 17:40:17 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 63A8DD6EA5
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:40:15 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2AD6BD0905
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:40:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9F3766B9AD
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:40:14 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 208421A0073;
 Thu, 16 Jan 2025 16:40:14 +0800 (CST)
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com,
	pvorel@suse.cz
Date: Thu, 16 Jan 2025 16:40:11 +0800
Message-ID: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28926.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28926.006
X-TMASE-Result: 10--13.307000-10.000000
X-TMASE-MatchedRID: kjrT4dFmkw75hD2hwXOXS0hwlOfYeSqx+KgiyLtJrSChuT/MQ6uAV3Ht
 NWFgCzPSvnCllUJsUcsLdJYj5o/ZfeyFp77aPvWdqoeab9Xgz8+fmd9HsjZ0U6ILsEPieIGYE2G
 7Tdxp4Puk+SAURDRhmWtb+2CMLj4BL/tBTZzO5Q23D7EeeyZCMzxXXdQ05WXBY9mvY0Dq9kbMQF
 2RiUZhlEUWuNOlf2MME/3VF0ZAfrLYMlADwgeVHfsgrpDX6v2e2aGwk4OLNSy+eGAmqR+bQKfxD
 YuLPebIrE1r27NixU39k/FBDAgpqDeTbFNCkkUz5CghTisABMxIvK4LrXs1aZyka59saICooonz
 J5ed8cBlnUu9VvrsFbwHFSeVLhE6R+vpYbhOH1pdhZyafgPiqx+KaaVwAG43JLfQYoCQHFaYnwB
 r+v+Q9p1GPljPaVOq9HG0nDNJvfkXHLPN9+q8eYvefyp1glN0rzl8sNiWClKbKItl61J/yZ+inT
 K0bC9eKrauXd3MZDUMFsa+1wyh/CHKckT5veLfnEhnF6p9CagHtlmgqGWKR9ysL6j/pLak4Irjt
 o8WcYI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] fchownat01: Convert to new API
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
From: Shiyang Ruan via ltp <ltp@lists.linux.it>
Reply-To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

1. convert to new API
2. move error tests to fchownat03
3. check if uid/gid is correctly set

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

---
V2: https://lore.kernel.org/ltp/20250115091218.2630891-1-ruansy.fnst@fujitsu.com/

Changes:
 * Initialize fd to -1, and check fd != -1 when cleanup
 * Do not use TST_*_SILENT()
 * fchownat01: describe what this case does in DESCRIPTION
 * fchownat01: use TST_EXP_EQ_LI(); do not use test case struct
 * fchownat02: use TST_EXP_EXPR()
 * fchownat03: write a proper commit message, add more errnos to test

---
 .../kernel/syscalls/fchownat/fchownat01.c     | 153 +++++-------------
 1 file changed, 42 insertions(+), 111 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index 7771c111a..fedcb8ab2 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -1,133 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2006
- *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
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
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2007-2025
  */
-/*
- * DESCRIPTION
- *	This test case will verify basic function of fchownat
- *	added by kernel 2.6.16 or up.
+
+/*\
+ * [Description]
+ *
+ * Verify that fchownat() succeeds to change file's ownership if the file
+ * descriptor is AT_FDCWD or set by opening a directory.
  */
 
 #define _GNU_SOURCE
+#include "tst_test.h"
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
+#define TESTFILE1	"testfile1"
+#define TESTFILE2	"testfile2"
 
-#define TESTFILE	"testfile"
+static uid_t set_uid = 1000;
+static gid_t set_gid = 1000;
+static int dir_fd = -1;
 
-static void setup(void);
-static void cleanup(void);
-
-static int dir_fd;
-static int fd;
-static int no_fd = -1;
-static int cu_fd = AT_FDCWD;
-
-static struct test_case_t {
-	int exp_ret;
-	int exp_errno;
-	int flag;
-	int *fds;
-	char *filenames;
-} test_cases[] = {
-	{0, 0, 0, &dir_fd, TESTFILE},
-	{-1, ENOTDIR, 0, &fd, TESTFILE},
-	{-1, EBADF, 0, &no_fd, TESTFILE},
-	{-1, EINVAL, 9999, &dir_fd, TESTFILE},
-	{0, 0, 0, &cu_fd, TESTFILE},
-};
-
-char *TCID = "fchownat01";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void fchownat_verify(const struct test_case_t *);
-
-int main(int ac, char **av)
+static void fchownat_verify(void)
 {
-	int lc;
-	int i;
+	struct stat stat_buf;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	TST_EXP_PASS(fchownat(AT_FDCWD, TESTFILE1, set_uid, set_gid, 0),
+		     "fchownat(%d, %s, %d, %d, 0)",
+		     AT_FDCWD, TESTFILE1, set_uid, set_gid);
 
-	setup();
+	SAFE_STAT(TESTFILE1, &stat_buf);
+	TST_EXP_EQ_LI(stat_buf.st_uid, set_uid);
+	TST_EXP_EQ_LI(stat_buf.st_gid, set_gid);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			fchownat_verify(&test_cases[i]);
-	}
+	TST_EXP_PASS(fchownat(dir_fd, TESTFILE2, set_uid, set_gid, 0),
+		     "fchownat(%d, %s, %d, %d, 0)",
+		     dir_fd, TESTFILE2, set_uid, set_gid);
 
-	cleanup();
-	tst_exit();
+	SAFE_STAT(TESTFILE2, &stat_buf);
+	TST_EXP_EQ_LI(stat_buf.st_uid, set_uid);
+	TST_EXP_EQ_LI(stat_buf.st_gid, set_gid);
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
-
-	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
-
-	fd = SAFE_OPEN(cleanup, "testfile2", O_CREAT | O_RDWR, 0600);
-}
-
-static void fchownat_verify(const struct test_case_t *test)
-{
-	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
-		      getegid(), test->flag));
-
-	if (TEST_RETURN != test->exp_ret) {
-		tst_resm(TFAIL | TTERRNO,
-			 "fchownat() returned %ld, expected %d, errno=%d",
-			 TEST_RETURN, test->exp_ret, test->exp_errno);
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			 "fchownat() returned the expected errno %d: %s",
-			 test->exp_ret, strerror(test->exp_errno));
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "fchownat() failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
+	SAFE_TOUCH(TESTFILE1, 0600, NULL);
+	SAFE_TOUCH(TESTFILE2, 0600, NULL);
 }
 
 static void cleanup(void)
 {
-	if (fd > 0)
-		close(fd);
-
-	if (dir_fd > 0)
-		close(dir_fd);
-
-	tst_rmdir();
+	if (dir_fd != -1)
+		SAFE_CLOSE(dir_fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test_all = fchownat_verify,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
