Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30568C761AF
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 10:37:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8033E3C9A41
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 12:37:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 484333CAC2D
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 12:37:16 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 654076000E0
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 12:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680604634; i=@fujitsu.com;
 bh=h7FE9fc1fO+RQV8/sKQX2iE61uYWPUfG/9PPb3DYyRQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=NddImZxjqZllGR5rAq0UiFoSybAujC30/1pVxCkOiou50rB2eLVy8pj8cj1TcWKcZ
 2vmHbGWJ3wynDS3NhYZJoPxrBThNP0Y9h8CKX68NdmkyfJen3WUlAS/SxcSix92o+H
 Cz9YANbj8QeH6EUczuX7SZjhNTr8vYx4gggfzFrZhPjvosqob3gRwvRDc+V4nB03h2
 7k7a3qXIIefaNRIUlZZUCGIgaNyuE1xffPh5XGm1EH6wf+2J1+Z3Blsov6++4NRVr6
 DKDGEZbzMwHKZjirmKDwcmxuejTee1+0M2FTzdxjDFf72yK0a+8bTVmDuTxGphE+dl
 UPg041fWT2XSA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsViZ8ORpHvzr3a
 KwbYvZhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bLnlPsBY9NK17vmMrWwLhFp4uRi0NI4BSj
 xJaWbexdjJxAzl4mia1nSiESexglnp7sZARJsAloSjzrXMAMYosISEh0NLwFa2AWUJdYPukXU
 xcjB4ewgLXE1818IGEWARWJA633WEBsXgFPiY7Fp8DGSAgoSEx5+B5sDKeAl8Sv5SuZIfZ6Sm
 z+3M8IUS8ocXLmExaI8RISB1+8YIboVZJoa73CCmFXSDROP8QEYatJXD23iXkCo+AsJO2zkLQ
 vYGRaxWhWnFpUllqka2iil1SUmZ5RkpuYmaOXWKWbqJdaqlueWlyia6SXWF6sl1pcrFdcmZuc
 k6KXl1qyiREYuinFKi92MD7r+6t3iFGSg0lJlPfRRu0UIb6k/JTKjMTijPii0pzU4kOMMhwcS
 hK8dq+BcoJFqempFWmZOcA4gklLcPAoifAK/wFK8xYXJOYWZ6ZDpE4xKkqJ8xoBo09IACSRUZ
 oH1waL3UuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHnn/wKawpOZVwI3/RXQYiagxa1RGiC
 LSxIRUlINTKXXbvDPreAybL92THbLvet2TE9Ttjy7V3M9dOLSmYKHcuckTTWMZkismXr9ozX7
 2anqaYGvz5l8/X3yHNdp7eOygQUrhBm2LF+wxqWqb9FC9TTP997mRxOjlhT+sOhdPUHiwwtmC
 b9Apkns12f9+lVy9rJpn55wsyqnrOe0tVolSkazRYJfL/mR9ne56te3J45VcAUe+nfebeXESc
 nCb+Yve64987LV5RCT2UH92htYunSn/1nBM9Vpk2R+45fWynYl7kPNxX+e6rxVe7/6dmF+Z9m
 nCsW/uyNePWmdbZ2+7vqSxpKtPsVXViY3rD4uq3n/4JW97Zkyd7vaFlp02ic7F+od4p66pqBm
 wVy/JD8lluKMREMt5qLiRACpsWPCWAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-548.messagelabs.com!1680604633!19334!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15067 invoked from network); 4 Apr 2023 10:37:13 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-6.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Apr 2023 10:37:13 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 91B071D1
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 11:37:13 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 8693D1AF
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 11:37:13 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 4 Apr 2023 11:37:11 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Apr 2023 18:36:32 +0800
Message-ID: <1680604594-16596-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] syscalls/mlock02: Convert into new api
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

Also use safe_macro and TST_EXP_FAIL macro. And remove uclinux code.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock02.c | 190 ++++++----------------
 1 file changed, 51 insertions(+), 139 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index 50ee31d1c..921ddeeae 100644
--- a/testcases/kernel/syscalls/mlock/mlock02.c
+++ b/testcases/kernel/syscalls/mlock/mlock02.c
@@ -1,109 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2002
- *	06/2002 Written by Paul Larson
+ * Copyright (c) International Business Machines Corp., 2002
  *
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
+ * 06/2002 Written by Paul Larson
  */
 
-/*
- * Test Description:
- *  Verify that,
- *   1. mlock() fails with -1 return value and sets errno to ENOMEM,
- *      if some of the specified address range does not correspond to
- *      mapped pages in the address space of the process.
- *   2. mlock() fails with -1 return value and sets errno to ENOMEM,
- *      if (Linux  2.6.9  and  later)  the caller had a non-zero RLIMIT_MEMLOCK
- *      soft resource limit, but tried to lock more memory than the limit
- *      permitted.  This limit is not enforced if the process is privileged
- *      (CAP_IPC_LOCK).
- *   3. mlock() fails with -1 return value and sets errno to EPERM,
- *      if (Linux 2.6.9 and later) the caller was not privileged (CAP_IPC_LOCK)
- *      and its RLIMIT_MEMLOCK soft resource limit was 0.
+/*\
+ * [Description]
+ *
+ * Test for ENOMEM, EPERM errors.
+ *
+ * 1) mlock(2) fails with ENOMEM if some of the specified address range
+ *    does not correspond to mapped pages in the address space of
+ *    the process.
+ *
+ * 2) mlock(2) fails with ENOMEM if the caller had a non-zero RLIMIT_MEMLOCK
+ *    soft resource limit, but tried to lock more memory than the limit
+ *    permitted.  This limit is not enforced if the process is
+ *    privileged (CAP_IPC_LOCK).
+ *
+ * 3) mlock(2) fails with EPERM if the caller was not privileged (CAP_IPC_LOCK)
+ *    and its RLIMIT_MEMLOCK soft resource limit was 0.
  */
 
-#include <errno.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <sys/types.h>
 #include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "mlock02";
-
-#if !defined(UCLINUX)
-
-static void setup(void);
-static void cleanup(void);
-static void test_enomem1(void);
-static void test_enomem2(void);
-static void test_eperm(void);
-static void mlock_verify(const void *, const size_t, const int);
+#include "tst_test.h"
 
 static size_t len;
 static struct rlimit original;
 static struct passwd *ltpuser;
 
-static void (*test_func[])(void) = { test_enomem1, test_enomem2, test_eperm };
-
-int TST_TOTAL = ARRAY_SIZE(test_func);
-
-int main(int ac, char **av)
-{
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			(*test_func[i])();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
-
-	len = getpagesize();
-
-	SAFE_GETRLIMIT(cleanup, RLIMIT_MEMLOCK, &original);
-}
-
 static void test_enomem1(void)
 {
 	void *addr;
-	struct rlimit rl;
 
-	addr = SAFE_MMAP(cleanup, NULL, len, PROT_READ,
+	addr = SAFE_MMAP(NULL, len, PROT_READ,
 			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-
-	SAFE_MUNMAP(cleanup, addr, len);
-
-	mlock_verify(addr, len, ENOMEM);
+	SAFE_MUNMAP(addr, len);
+	TST_EXP_FAIL(mlock(addr, len), ENOMEM, "mlock(%p, %lu)", addr, len);
 }
 
 static void test_enomem2(void)
@@ -113,20 +50,14 @@ static void test_enomem2(void)
 
 	rl.rlim_max = len - 1;
 	rl.rlim_cur = len - 1;
-	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &rl);
-
-	addr = SAFE_MMAP(cleanup, NULL, len, PROT_READ,
+	SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &rl);
+	addr = SAFE_MMAP(NULL, len, PROT_READ,
 			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-
-	mlock_verify(addr, len, ENOMEM);
-
-	SAFE_SETEUID(cleanup, 0);
-
-	SAFE_MUNMAP(cleanup, addr, len);
-
-	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &original);
+	SAFE_SETEUID(ltpuser->pw_uid);
+	TST_EXP_FAIL(mlock(addr, len), ENOMEM, "mlock(%p, %lu)", addr, len);
+	SAFE_SETEUID(0);
+	SAFE_MUNMAP(addr, len);
+	SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &original);
 }
 
 static void test_eperm(void)
@@ -136,51 +67,32 @@ static void test_eperm(void)
 
 	rl.rlim_max = 0;
 	rl.rlim_cur = 0;
-	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &rl);
-
-	addr = SAFE_MMAP(cleanup, NULL, len, PROT_READ,
+	SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &rl);
+	addr = SAFE_MMAP(NULL, len, PROT_READ,
 			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-
-	mlock_verify(addr, len, EPERM);
-
-	SAFE_SETEUID(cleanup, 0);
-
-	SAFE_MUNMAP(cleanup, addr, len);
-
-	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &original);
+	SAFE_SETEUID(ltpuser->pw_uid);
+	TST_EXP_FAIL(mlock(addr, len), EPERM, "mlock(%p, %lu)", addr, len);
+	SAFE_SETEUID(0);
+	SAFE_MUNMAP(addr, len);
+	SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &original);
 }
 
-static void mlock_verify(const void *addr, const size_t len, const int error)
+static void run(void)
 {
-	TEST(mlock(addr, len));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "mlock succeeded unexpectedly");
-		return;
-	}
-
-	if (TEST_ERRNO != error) {
-		tst_resm(TFAIL | TTERRNO,
-			 "mlock didn't fail as expected; expected - %d : %s",
-			 error, strerror(error));
-	} else {
-		tst_resm(TPASS | TTERRNO, "mlock failed as expected");
-	}
+	test_enomem1();
+	test_enomem2();
+	test_eperm();
 }
 
-static void cleanup(void)
-{
-}
-
-#else
-
-int TST_TOTAL = 1;
-
-int main(void)
+static void setup(void)
 {
-	tst_brkm(TCONF, NULL, "test is not available on uClinux");
+	ltpuser = SAFE_GETPWNAM("nobody");
+	len = getpagesize();
+	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &original);
 }
 
-#endif /* if !defined(UCLINUX) */
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
