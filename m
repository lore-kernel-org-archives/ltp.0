Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC14CC54FDF
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 07:41:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A9C23E2D30
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 09:41:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEFC03E25E8
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 09:41:41 +0200 (CEST)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 68D5F140016D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 09:41:38 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785397297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OQcKI6Nk/WrGdiJJDJ24dI4I1aXowbchr2b/cvqM8gI=;
 b=R7CFIZFXbk9lKegyYnTatwlAVId0oj/huJXoxpHvAjPpFzk6uyS3UEffFi1zTZrRUy8bFA
 Yj3s7Vpgn9z8qUAijcuiNUTI/TavOd6gwypX9Os5iuY5UVJYhEEwsF1sZYY3OwGrT7QlD5
 7JSbrUcqu9lnEfPpYvlsSevKqp0yflg=
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it,
	li.wang@linux.dev
Date: Thu, 30 Jul 2026 15:41:19 +0800
Message-ID: <20260730074120.180101-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] madvise09: restore cgroup v1 memory limits with
 numeric values
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
Cc: Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Li Wang <liwang@hygon.cn>

madvise09 resets memory.max and memory.swap.max to "max" before retrying
the child process, so the retried child does not inherit the strict memory
limits from the previous run.

This works for cgroup v2, where "max" is the valid unlimited value.
However, cgroup v1 memory.limit_in_bytes does not accept the string "max".
When the LTP cgroup abstraction maps memory.max to the v1 memory limit
knob, writing "max" can fail with EINVAL:

  tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
  madvise09.c:154: TBROK: vdprintf(18</sys/fs/cgroup/memory/ltp/test-27493>,
		   	  'memory.limit_in_bytes', '%s'<max>): EINVAL (22)
  tst_test.c:478: TINFO: Child process reported TBROK killing the test
  tst_test.c:1938: TINFO: Killed the leftover descendant processes

Save the original cgroup v1 memory and swap limits during setup and
restore those numeric values on retry. Keep using "max" for cgroup v2.

Fixes: c118be931cd ("madvise09: Reset cgroup limits before retrying test")
Signed-off-by: Li Wang <liwang@hygon.cn>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 2fc1da581..2e792bd11 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -54,8 +54,8 @@ static int swap_accounting_enabled;
 #define TOUCHED_PAGE1 0
 #define TOUCHED_PAGE2 10
 
-static long long mem_limit;
-static long long swap_limit;
+static long long mem_limit, ori_mem_limit;
+static long long swap_limit, ori_swap_limit;
 
 static void memory_pressure_child(void)
 {
@@ -151,9 +151,17 @@ static void child(void)
 	 * Otherwise, the retried child inherits the strict MEM_LIMIT from the previous
 	 * run, causing MADV_FREE pages to be dropped immediately before we touch them.
 	 */
-	SAFE_CG_PRINT(tst_cg, "memory.max", "max");
-	if (swap_accounting_enabled)
-		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
+	if (TST_CG_VER_IS_V1(tst_cg, "memory")) {
+		SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", ori_mem_limit);
+
+		if (swap_accounting_enabled)
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", ori_swap_limit);
+	} else {
+		SAFE_CG_PRINT(tst_cg, "memory.max", "max");
+
+		if (swap_accounting_enabled)
+			SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
+	}
 
 	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
@@ -278,10 +286,17 @@ retry:
 
 static void setup(void)
 {
-	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+	if (TST_CG_VER_IS_V1(tst_cg, "memory"))
+		SAFE_CG_SCANF(tst_cg, "memory.max", "%lld", &ori_mem_limit);
+
+	if (SAFE_CG_HAS(tst_cg, "memory.swap.max")) {
 		swap_accounting_enabled = 1;
-	else
+
+		if (TST_CG_VER_IS_V1(tst_cg, "memory"))
+			SAFE_CG_SCANF(tst_cg, "memory.swap.max", "%lld", &ori_swap_limit);
+	} else {
 		tst_res(TINFO, "Swap accounting is disabled");
+	}
 
 	page_size = getpagesize();
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
