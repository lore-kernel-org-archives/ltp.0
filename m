Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459DEC46CD4
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 06:57:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71FE93C9B67
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 07:56:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 854113C9A28
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:56:46 +0100 (CET)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B58161000A2D
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:56:44 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="144133673"
X-IronPort-AV: E=Sophos;i="6.04,294,1695654000"; d="scan'208";a="144133673"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 15:56:44 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 79FE6D64B3
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:56:41 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A5BEB106017
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:56:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A6DE200A80C3
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:56:40 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E76FB1A006F;
 Fri, 22 Dec 2023 14:56:39 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 22 Dec 2023 00:00:05 -0500
Message-Id: <20231222050006.148845-6-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28072.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28072.005
X-TMASE-Result: 10--14.579500-10.000000
X-TMASE-MatchedRID: wdEAHguiaMioXGwWsKbNNMQ4mpKyfkqZqf/efKFN1nAsNj/xIgdFOz13
 GoPFA1HFIvrftAIhWmLy9zcRSkKatYRiOzyn0C74DnkURiAlfT0Ea8g1x8eqF8+FtP9CIg3lGJ0
 UP0AzEBXF0OnGYU+EGEyVB8hCiPpVv7DNTciZY+u/QNwZdfw3FVf0dYIWn7J33unRG7yMq8Wsw1
 6ankSpXeLuuo8wVu5nyHMs+sHfluyV4vZXlgxe6fCCu8kVj0TRe9J6VkwneFbea+qLADPgjqPFj
 JEFr+olwXCBO/GKkVr3FLeZXNZS4JFOlJCK/1fttEEZawRd3mWPYW/ImaERYyuFE1uHzWNoF+Wx
 9hsAfWTe1J4D0Q3tIAfBqTLHEZuQ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/7] syscalls/swapon03: Simply this case
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

By moving swapfile create stage from verify_swaopon and
test EPERM error more accurate. Also use glibc wrapper by
using swapon/swapoff instead of call syscall number directly
because glibc/musl/binoic also support them since long time ago.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swapon03.c | 111 +++-----------------
 1 file changed, 16 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index a553dd485..3f3fa7a54 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -16,93 +16,27 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <sys/wait.h>
-
+#include <sys/swap.h>
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "libswap.h"
 
+#define TESTFILE "testfile"
+
 static int setup_swap(void);
 static int clean_swap(void);
 static int check_and_swapoff(const char *filename);
-
 static int swapfiles;
 
-int testfiles = 3;
-static struct swap_testfile_t {
-	char *filename;
-} swap_testfiles[] = {
-	{"firstswapfile"},
-	{"secondswapfile"},
-	{"thirdswapfile"}
-};
-
-int expected_errno = EPERM;
-
 static void verify_swapon(void)
 {
-	if (setup_swap() < 0) {
-		clean_swap();
-		tst_brk(TBROK, "Setup failed, quitting the test");
-	}
-
-	TEST(tst_syscall(__NR_swapon, swap_testfiles[0].filename, 0));
-
-	if ((TST_RET == -1) && (TST_ERR == expected_errno)) {
-		tst_res(TPASS, "swapon(2) got expected failure (%d),",
-			expected_errno);
-	} else if (TST_RET < 0) {
-		tst_res(TFAIL | TTERRNO,
-			"swapon(2) failed to produce expected error "
-			"(%d). System reboot recommended.",
-			expected_errno);
-	} else {
-		/* Probably the system supports MAX_SWAPFILES > 30,
-		 * let's try with MAX_SWAPFILES == 32 */
-
-		/* Call swapon sys call once again for 32
-		 * now we can't receive an error */
-		TEST(tst_syscall(__NR_swapon, swap_testfiles[1].filename, 0));
-
-		/* Check return code (now we're expecting success) */
-		if (TST_RET < 0) {
-			tst_res(TFAIL | TTERRNO,
-				"swapon(2) got an unexpected failure");
-		} else {
-			/* Call swapon sys call once again for 33
-			 * now we have to receive an error */
-			TEST(tst_syscall(__NR_swapon, swap_testfiles[2].filename, 0));
-
-			/* Check return code (should be an error) */
-			if ((TST_RET == -1) && (TST_ERR == expected_errno)) {
-				tst_res(TPASS,
-					"swapon(2) got expected failure;"
-					" Got errno = %d, probably your"
-					" MAX_SWAPFILES is 32",
-					expected_errno);
-			} else {
-				tst_res(TFAIL,
-					"swapon(2) failed to produce"
-					" expected error: %d, got %s."
-					" System reboot after execution of LTP"
-					" test suite is recommended.",
-					expected_errno, strerror(TST_ERR));
-			}
-		}
-	}
-
-	if (clean_swap() < 0)
-		tst_brk(TBROK, "Cleanup failed, quitting the test");
+	TST_EXP_FAIL(swapon(TESTFILE, 0), EPERM, "swapon(%s, 0)", TESTFILE);
 }
 
-/*
- * Create 33 and activate 30 swapfiles.
- */
 static int setup_swap(void)
 {
 	pid_t pid;
 	int j, max_swapfiles, used_swapfiles;
 	int status;
-	int res = 0;
 	char filename[FILENAME_MAX];
 
 	if (seteuid(0) < 0)
@@ -130,16 +64,7 @@ static int setup_swap(void)
 			make_swapfile(filename, 0);
 
 			/* turn on the swap file */
-			res = tst_syscall(__NR_swapon, filename, 0);
-			if (res != 0) {
-				if (errno == EPERM) {
-					printf("Successfully created %d swapfiles\n", j);
-					break;
-				} else {
-					printf("Failed to create swapfile: %s\n", filename);
-					exit(1);
-				}
-			}
+			TST_EXP_PASS_SILENT(swapon(filename, 0));
 		}
 		exit(0);
 	} else
@@ -148,9 +73,8 @@ static int setup_swap(void)
 	if (WEXITSTATUS(status))
 		tst_brk(TFAIL, "Failed to setup swaps");
 
-	/* Create all needed extra swapfiles for testing */
-	for (j = 0; j < testfiles; j++)
-		make_swapfile(swap_testfiles[j].filename, 0);
+	tst_res(TINFO, "Successfully created %d swapfiles", swapfiles);
+	make_swapfile(TESTFILE, 0);
 
 	return 0;
 }
@@ -178,12 +102,9 @@ static int clean_swap(void)
 		}
 	}
 
-	for (j = 0; j < testfiles; j++) {
-		if (check_and_swapoff(swap_testfiles[j].filename) != 0) {
-			tst_res(TWARN, "Failed to turn off swap file %s.",
-				 swap_testfiles[j].filename);
-			return -1;
-		}
+	if (check_and_swapoff("testfile") != 0) {
+		tst_res(TWARN, "Failed to turn off swap file testfile");
+		return -1;
 	}
 
 	return 0;
@@ -201,20 +122,15 @@ static int check_and_swapoff(const char *filename)
 		     "grep -q '%s.*file' /proc/swaps", filename) < 0) {
 		tst_res(TWARN, "sprintf() failed to create the command string");
 	} else {
-
 		rc = 0;
-
 		if (system(cmd_buffer) == 0) {
-
 			/* now we need to swapoff the file */
-			if (tst_syscall(__NR_swapoff, filename) != 0) {
-
+			if (swapoff(filename) != 0) {
 				tst_res(TWARN, "Failed to turn off swap "
 					 "file. system reboot after "
 					 "execution of LTP test suite "
 					 "is recommended");
 				rc = -1;
-
 			}
 
 		}
@@ -229,6 +145,11 @@ static void setup(void)
 		tst_brk(TCONF, "swap not supported by kernel");
 
 	is_swap_supported("./tstswap");
+
+	if (setup_swap() < 0) {
+		clean_swap();
+		tst_brk(TBROK, "Setup failed, quitting the test");
+	}
 }
 
 static void cleanup(void)
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
