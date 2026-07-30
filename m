Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04EFC54FDF
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 10:01:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3D863E7477
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 12:01:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8CF63E2037
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 12:01:40 +0200 (CEST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D4219140096D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 12:01:39 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785405698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yIz0Uh6GUy4RfhEX07iDYKqTs+638yYVrFjh+sdW0sc=;
 b=SN7IEHxfY2fQ2g6sXBD1tBp2d8Pwq4lSR4nsohWqS0e1w3ff8xVsOFbTSKnOWKSAv7/JX8
 HsDIPlt1xWeEnIlfBzZYKSpYZmAh6Nj9Q6YcWqcfdRxBO4bzp+qRbZkdCXXbXR2u12Y2Gg
 dHtEMU7nge79QcO88otzOvajpkV7bGw=
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it,
	liwang@hygon.cn
Date: Thu, 30 Jul 2026 18:01:26 +0800
Message-ID: <20260730100127.193103-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] madvise09: restore cgroup v1 memory limits
 with numeric values
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

Notes:
    v1 -> v2:
    	- Rename saved limit variables from ori_* to orig_*.
    	- Restore v1 memsw limit before memory limit when raising limits on retry.
    	- Update the retry reset comment for both v1 and v2.

 testcases/kernel/syscalls/madvise/madvise09.c | 35 ++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 2fc1da581..5f9bf7aa8 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -54,8 +54,8 @@ static int swap_accounting_enabled;
 #define TOUCHED_PAGE1 0
 #define TOUCHED_PAGE2 10
 
-static long long mem_limit;
-static long long swap_limit;
+static long long mem_limit, orig_mem_limit;
+static long long swap_limit, orig_swap_limit;
 
 static void memory_pressure_child(void)
 {
@@ -147,13 +147,25 @@ static void child(void)
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 
 	/*
-	 * Reset cgroup memory limits to default ("max") in case this is a retry run.
+	 * Reset cgroup memory limits in case this is a retry run.
+	 * For cgroup v2, restore the default "max". For cgroup v1, restore the
+	 * saved numeric limits, raising memsw before memory to keep the v1
+	 * memory <= memsw invariant.
+	 *
 	 * Otherwise, the retried child inherits the strict MEM_LIMIT from the previous
 	 * run, causing MADV_FREE pages to be dropped immediately before we touch them.
 	 */
-	SAFE_CG_PRINT(tst_cg, "memory.max", "max");
-	if (swap_accounting_enabled)
-		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
+	if (TST_CG_VER_IS_V1(tst_cg, "memory")) {
+		if (swap_accounting_enabled)
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", orig_swap_limit);
+
+		SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", orig_mem_limit);
+	} else {
+		SAFE_CG_PRINT(tst_cg, "memory.max", "max");
+
+		if (swap_accounting_enabled)
+			SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
+	}
 
 	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
@@ -278,10 +290,17 @@ retry:
 
 static void setup(void)
 {
-	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+	if (TST_CG_VER_IS_V1(tst_cg, "memory"))
+		SAFE_CG_SCANF(tst_cg, "memory.max", "%lld", &orig_mem_limit);
+
+	if (SAFE_CG_HAS(tst_cg, "memory.swap.max")) {
 		swap_accounting_enabled = 1;
-	else
+
+		if (TST_CG_VER_IS_V1(tst_cg, "memory"))
+			SAFE_CG_SCANF(tst_cg, "memory.swap.max", "%lld", &orig_swap_limit);
+	} else {
 		tst_res(TINFO, "Swap accounting is disabled");
+	}
 
 	page_size = getpagesize();
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
