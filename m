Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B722C352A1
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 12:26:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A87863CC19C
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 13:26:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE99B3CC168
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 13:26:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id DB4EF140111E
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 13:26:22 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756F223A
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 04:26:27 -0800 (PST)
Received: from e126380.arm.com (unknown [10.57.37.186])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 38AB83F73D
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 04:26:20 -0800 (PST)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Tue,  6 Dec 2022 12:26:04 +0000
Message-Id: <20221206122604.212528-1-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/brk: add direct syscall tst_variant
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

Direct usage of brk is discouraged in favor of using malloc. Also, brk was
removed from POSIX in POSIX.1-2001.
In particular, the Musl libc's brk always returns -ENOMEM which causes
the LTP tests to exit prematurely. Invoking the syscall directly allows
them to properly validate brk behavior. Add a new test variant handling if
the libc wrappers are not implemented and testing the direct syscall.

Use tst_syscall() and handle the failure cases ourselves, as
we don't depend on the libc to do it anymore.

The patch also works around the dependency on sbrk to get the current break
as it has the same issues. Instead, call tst_syscall(__NR_brk, 0) which
always returns the current break.

Update brk01 to use void* to unify it with brk02.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
v1: Reworked from RFC by adding a variant rather than replacing the
    existing tests. Thanks Petr and Cyril !

Not sure this is the best way to do it. Maybe it could use a shared header
for testing if the libc version is implemented ?

Green CI: https://github.com/Teo-CD/ltp/actions/runs/3629342833/jobs/6121433817

 testcases/kernel/syscalls/brk/brk01.c | 36 +++++++++++++++++------
 testcases/kernel/syscalls/brk/brk02.c | 42 ++++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index a9b89bce5..bd12940c2 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -9,14 +9,31 @@
 #include <errno.h>
 
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 
 void verify_brk(void)
 {
-	uintptr_t cur_brk, new_brk;
-	uintptr_t inc = getpagesize() * 2 - 1;
+	void *cur_brk, *new_brk;
+	size_t inc = getpagesize() * 2 - 1;
 	unsigned int i;
 
-	cur_brk = (uintptr_t)sbrk(0);
+	if (tst_variant) {
+		tst_res(TINFO, "Testing syscall variant");
+		cur_brk = (void *)tst_syscall(__NR_brk, 0);
+	} else {
+		tst_res(TINFO, "Testing libc variant");
+		cur_brk = (void *)sbrk(0);
+
+		if (cur_brk == (void*)-1)
+			tst_brk(TCONF, "sbrk() not implemented");
+
+		/*
+		 * Check if brk itself is implemented: updating to the current break
+		 * should be a no-op.
+		 */
+		if ((void *)brk(cur_brk) != cur_brk)
+			tst_brk(TCONF, "brk() not implemented");
+	}
 
 	for (i = 0; i < 33; i++) {
 		switch (i % 3) {
@@ -31,16 +48,16 @@ void verify_brk(void)
 		break;
 		}
 
-		TST_EXP_PASS_SILENT(brk((void *)new_brk), "brk()");
-		if (!TST_PASS)
-			return;
-
-		cur_brk = (uintptr_t)sbrk(0);
+		if (tst_variant) {
+			cur_brk = (void *)tst_syscall(__NR_brk, new_brk);
+		} else {
+			cur_brk = (void *)brk(new_brk);
+		}
 
 		if (cur_brk != new_brk) {
 			tst_res(TFAIL,
 				"brk() failed to set address have %p expected %p",
-				(void *)cur_brk, (void *)new_brk);
+				cur_brk, new_brk);
 			return;
 		}
 
@@ -54,4 +71,5 @@ void verify_brk(void)
 
 static struct tst_test test = {
 	.test_all = verify_brk,
+	.test_variants = 2,
 };
diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
index 11e803cb4..d26ef2100 100644
--- a/testcases/kernel/syscalls/brk/brk02.c
+++ b/testcases/kernel/syscalls/brk/brk02.c
@@ -14,24 +14,51 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
+
+inline void *brk_variants(void *addr)
+{
+	void *brk_addr;
+	if (tst_variant) {
+		brk_addr = (void *)tst_syscall(__NR_brk, addr);
+	} else {
+		brk_addr = (void *)brk(addr);
+	}
+	return brk_addr;
+}
 
 void brk_down_vmas(void)
 {
-	void *brk_addr = sbrk(0);
+	void *brk_addr;
 
-	if (brk_addr == (void *) -1)
-		tst_brk(TBROK, "sbrk() failed");
+	if (tst_variant) {
+		tst_res(TINFO, "Testing syscall variant");
+		brk_addr = (void *)tst_syscall(__NR_brk, 0);
+	} else {
+		tst_res(TINFO, "Testing libc variant");
+		brk_addr = (void *)sbrk(0);
+
+		if (brk_addr == (void*)-1)
+			tst_brk(TCONF, "sbrk() not implemented");
+
+		/*
+		 * Check if brk itself is implemented: updating to the current break
+		 * should be a no-op.
+		 */
+		if ((void *)brk(brk_addr) != brk_addr)
+			tst_brk(TCONF, "brk() not implemented");
+	}
 
 	unsigned long page_size = getpagesize();
 	void *addr = brk_addr + page_size;
 
-	if (brk(addr)) {
+	if (brk_variants(addr) < addr) {
 		tst_res(TFAIL | TERRNO, "Cannot expand brk() by page size");
 		return;
 	}
 
 	addr += page_size;
-	if (brk(addr)) {
+	if (brk_variants(addr) < addr) {
 		tst_res(TFAIL | TERRNO, "Cannot expand brk() by 2x page size");
 		return;
 	}
@@ -42,12 +69,12 @@ void brk_down_vmas(void)
 	}
 
 	addr += page_size;
-	if (brk(addr)) {
+	if (brk_variants(addr) < addr) {
 		tst_res(TFAIL | TERRNO, "Cannot expand brk() after mprotect");
 		return;
 	}
 
-	if (brk(brk_addr)) {
+	if (brk_variants(brk_addr) != brk_addr) {
 		tst_res(TFAIL | TERRNO, "Cannot restore brk() to start address");
 		return;
 	}
@@ -57,4 +84,5 @@ void brk_down_vmas(void)
 
 static struct tst_test test = {
 	.test_all = brk_down_vmas,
+	.test_variants = 2,
 };

base-commit: 990c0b48f8508a747863b1dea5556fba57e1c304
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
