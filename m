Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A934CC4332F
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 09:15:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F8763CC66A
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 10:15:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 973963C585E
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 10:15:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 7FF031000467
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 10:15:23 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33C571063
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 01:15:28 -0800 (PST)
Received: from e126380.arm.com (unknown [10.57.39.128])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11A6F3F73B
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 01:15:20 -0800 (PST)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Mon, 28 Nov 2022 09:15:08 +0000
Message-Id: <20221128091508.75414-2-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221128091508.75414-1-teo.coupriediaz@arm.com>
References: <20221128091508.75414-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] syscalls/brk: use direct syscall
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
them to properly validate brk behavior.

Use tst_syscall() and handle the failure cases ourselves, as
we don't depend on the libc to do it anymore.

The patch also removes the dependency on sbrk to get the current break
as it has the same issues. Instead, call tst_syscall(__NR_brk, 0) which
always returns the current break.

Update brk01 to use void* to unify it with brk02.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
 testcases/kernel/syscalls/brk/brk01.c | 15 ++++++---------
 testcases/kernel/syscalls/brk/brk02.c | 14 ++++++--------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index a9b89bce5..d4596c20f 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -9,14 +9,15 @@
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
+	cur_brk = (void *)tst_syscall(__NR_brk, 0);
 
 	for (i = 0; i < 33; i++) {
 		switch (i % 3) {
@@ -31,16 +32,12 @@ void verify_brk(void)
 		break;
 		}
 
-		TST_EXP_PASS_SILENT(brk((void *)new_brk), "brk()");
-		if (!TST_PASS)
-			return;
-
-		cur_brk = (uintptr_t)sbrk(0);
+		cur_brk = (void *)tst_syscall(__NR_brk, new_brk);
 
 		if (cur_brk != new_brk) {
 			tst_res(TFAIL,
 				"brk() failed to set address have %p expected %p",
-				(void *)cur_brk, (void *)new_brk);
+				cur_brk, new_brk);
 			return;
 		}
 
diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
index 11e803cb4..dabda30c2 100644
--- a/testcases/kernel/syscalls/brk/brk02.c
+++ b/testcases/kernel/syscalls/brk/brk02.c
@@ -14,24 +14,22 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 
 void brk_down_vmas(void)
 {
-	void *brk_addr = sbrk(0);
-
-	if (brk_addr == (void *) -1)
-		tst_brk(TBROK, "sbrk() failed");
+	void *brk_addr = (void *)tst_syscall(__NR_brk, 0);
 
 	unsigned long page_size = getpagesize();
 	void *addr = brk_addr + page_size;
 
-	if (brk(addr)) {
+	if ((void *)tst_syscall(__NR_brk, addr) < addr) {
 		tst_res(TFAIL | TERRNO, "Cannot expand brk() by page size");
 		return;
 	}
 
 	addr += page_size;
-	if (brk(addr)) {
+	if ((void *)tst_syscall(__NR_brk, addr) < addr) {
 		tst_res(TFAIL | TERRNO, "Cannot expand brk() by 2x page size");
 		return;
 	}
@@ -42,12 +40,12 @@ void brk_down_vmas(void)
 	}
 
 	addr += page_size;
-	if (brk(addr)) {
+	if ((void *)tst_syscall(__NR_brk, addr) < addr) {
 		tst_res(TFAIL | TERRNO, "Cannot expand brk() after mprotect");
 		return;
 	}
 
-	if (brk(brk_addr)) {
+	if ((void *)tst_syscall(__NR_brk, brk_addr) != brk_addr) {
 		tst_res(TFAIL | TERRNO, "Cannot restore brk() to start address");
 		return;
 	}
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
