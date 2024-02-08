Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEE3C48260
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707386873; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=A+6dY6z9tO7zNdg1wdCUMpoldNxnlBo9NFjnS7HKH94=;
 b=Slr3oPtmZODiLpk4jjOkXOXubs+4qmd+GFJOqJW4o695aaENzn/1rAtpXOlZPnu7Jf8ZH
 hy98irzdUt+taxLUKGTnrUhykp5nUWcssZLNFbV0VT3Rb2iTHjkeSbY7+0piLHN6zUs0m57
 nwHirThUKKpnOkzX1c5kFzXJLN4RBKE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E412C3CDEAA
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 11:07:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D12F53CC4AD
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:48 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E67F314010D9
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707386748; x=1738922748;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S5jFYD5bpraOwgClKCUwt17CtqPjJ2UePdoBicKaHhM=;
 b=NXIAdPtq9MWtWZxBLGeCJhPLbBefeQJdE7ZtcviKD4L0K1SHsIijsf2u
 Ulq+g7bgkhhbllQcdFbGqCzRQfdjoPpo6QxrhVuSPDUEN4YpgM6sNADcv
 lPhd3BQyDEhs0npZifJriEdI4lAji11uXhQH0Sz1XQMLVVNoD64uj7C0D
 MzkHM/UhkjLCXp1Hn8MkY92p8rXPukkHgjA4I8PWkuV22dT5IjIWMnQXG
 IxB+KF/bNGzyAb3XJg1+UqXf5pTchrgJngLh1ma0tG6CpQGCiQ3sftV5k
 vmIaL3mMWV+XSYpJmyvCTjw3B4MmWwQPygJRVkoJMn2kJ9jNkADQHh5lT A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="148804474"
X-IronPort-AV: E=Sophos;i="6.05,253,1701097200"; d="scan'208";a="148804474"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2024 19:05:45 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A88FE287624
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:42 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D911FBF4A4
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:41 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 76F1A41043
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:41 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 293BA1A009A;
 Thu,  8 Feb 2024 18:05:41 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 05:05:16 -0500
Message-Id: <20240208100517.1974-6-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
References: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28178.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28178.003
X-TMASE-Result: 10--13.443200-10.000000
X-TMASE-MatchedRID: ivopYYUv4wOoXGwWsKbNNMQ4mpKyfkqZqf/efKFN1nAsNj/xIgdFOz13
 GoPFA1HFIvrftAIhWmLy9zcRSkKatYRiOzyn0C74DnkURiAlfT0Ea8g1x8eqF8+FtP9CIg3lGJ0
 UP0AzEBXF0OnGYU+EGEyVB8hCiPpVv7DNTciZY+u/QNwZdfw3FVf0dYIWn7J33unRG7yMq8Wsw1
 6ankSpXeLuuo8wVu5nyHMs+sHfluzHOkf2+KMD/BIRh9wkXSlFe9J6VkwneFZp2y18eTT/bUwSv
 UpzAIpVruaWnsz0aFiAMuqetGVetnyef22ep6XY4kYXbobxJbLyU/oX+tpNmPoLEnltozQnbTWF
 2en2y4gIi8h9veOWEFmDDZo4qdDBtDApshcJLEi+68HqACCvKA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/7] syscalls/swapon03: Simply this case
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

By moving swapfile create stage from verify_swaopon and
test EPERM error more accurate. Also use glibc wrapper by
using swapon/swapoff instead of call syscall number directly
because glibc/musl/binoic also support them since long time ago.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swapon03.c | 170 +++++---------------
 1 file changed, 43 insertions(+), 127 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index e27d954a1..5ba7971e7 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -16,7 +16,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <sys/wait.h>
-
+#include <sys/swap.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "libswap.h"
@@ -24,89 +24,13 @@
 #define MNTPOINT	"mntpoint"
 #define TEST_FILE	MNTPOINT"/testswap"
 
-static int setup_swap(void);
-static int clean_swap(void);
-static int check_and_swapoff(const char *filename);
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
-static void verify_swapon(void)
-{
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
-		/*
-		 * Probably the system supports MAX_SWAPFILES > 30, let's try with
-		 * MAX_SWAPFILES == 32. Call swapon sys call once again for 32
-		 * now we can't receive an error.
-		 */
-		TEST(tst_syscall(__NR_swapon, swap_testfiles[1].filename, 0));
-
-		/* Check return code (now we're expecting success) */
-		if (TST_RET < 0) {
-			tst_res(TFAIL | TTERRNO,
-				"swapon(2) got an unexpected failure");
-		} else {
-			/*
-			 * Call swapon sys call once again for 33 now we have to receive an error.
-			 */
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
-}
-
-/*
- * Create 33 and activate 30 swapfiles.
- */
 static int setup_swap(void)
 {
 	pid_t pid;
 	int status;
 	int j, max_swapfiles, used_swapfiles;
-	int res = 0;
 	char filename[FILENAME_MAX];
 
 	if (seteuid(0) < 0)
@@ -134,16 +58,7 @@ static int setup_swap(void)
 			make_swapfile(filename, 10, 0);
 
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
@@ -152,13 +67,41 @@ static int setup_swap(void)
 	if (WEXITSTATUS(status))
 		tst_brk(TFAIL, "Failed to setup swaps");
 
-	/* Create all needed extra swapfiles for testing */
-	for (j = 0; j < testfiles; j++)
-		make_swapfile(swap_testfiles[j].filename, 10, 0);
+	tst_res(TINFO, "Successfully created %d swapfiles", swapfiles);
+	make_swapfile(TEST_FILE, 10, 0);
 
 	return 0;
 }
 
+/*
+ * Check if the file is at /proc/swaps and remove it giving swapoff
+ */
+static int check_and_swapoff(const char *filename)
+{
+	char cmd_buffer[256];
+	int rc = -1;
+
+	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
+		"grep -q '%s.*file' /proc/swaps", filename) < 0) {
+		tst_res(TWARN, "sprintf() failed to create the command string");
+	} else {
+		rc = 0;
+		if (system(cmd_buffer) == 0) {
+			/* now we need to swapoff the file */
+			if (swapoff(filename) != 0) {
+				tst_res(TWARN, "Failed to turn off swap "
+					"file. system reboot after "
+					"execution of LTP test suite "
+					"is recommended");
+				rc = -1;
+			}
+
+		}
+	}
+
+	return rc;
+}
+
 /*
  * Turn off all swapfiles previously turned on
  */
@@ -182,49 +125,17 @@ static int clean_swap(void)
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
 }
 
-/*
- * Check if the file is at /proc/swaps and remove it giving swapoff
- */
-static int check_and_swapoff(const char *filename)
+static void verify_swapon(void)
 {
-	char cmd_buffer[256];
-	int rc = -1;
-
-	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
-		     "grep -q '%s.*file' /proc/swaps", filename) < 0) {
-		tst_res(TWARN, "sprintf() failed to create the command string");
-	} else {
-
-		rc = 0;
-
-		if (system(cmd_buffer) == 0) {
-
-			/* now we need to swapoff the file */
-			if (tst_syscall(__NR_swapoff, filename) != 0) {
-
-				tst_res(TWARN, "Failed to turn off swap "
-					 "file. system reboot after "
-					 "execution of LTP test suite "
-					 "is recommended");
-				rc = -1;
-
-			}
-
-		}
-	}
-
-	return rc;
+	TST_EXP_FAIL(swapon(TEST_FILE, 0), EPERM, "swapon(%s, 0)", TEST_FILE);
 }
 
 static void setup(void)
@@ -236,6 +147,11 @@ static void setup(void)
 		tst_brk(TCONF, "swap not supported on tmpfs");
 
 	is_swap_supported(TEST_FILE);
+
+	if (setup_swap() < 0) {
+		clean_swap();
+		tst_brk(TBROK, "Setup failed, quitting the test");
+	}
 }
 
 static void cleanup(void)
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
