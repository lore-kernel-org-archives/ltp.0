Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82223C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 10:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783507360; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=km7j4Wre5nLC4Z5LVgvPqWm0p9exqS4bWyiERleVA4c=;
 b=RDmNLXmIoCUPIXSkVEXn6N8AdidzYI7nzLTR5GUNRVgYz6zR8OuIA9YB3JbReYtK41YFX
 cMZeiu32y0FNegxg/LHF6nIN1NKLV13ie3BXsG73nskvQqG03goElk6gDC7mvURhFJY93Sc
 Snna/237O9zvPNG9nIDsjESgJU4htrc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A5AB3E2A41
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3AB83C25D4
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:42:20 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2D83C1000987
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:42:20 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-845df469a26so1645373b3a.3
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783507338; x=1784112138; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u2OD6bWkq90IMWX4LtBTZ1odeccTTxtdRipOzCwswi4=;
 b=KyZV9Ov2FmvfNd5ESeIZ49uibY4r+ZwJRZJAPWRXDvM4uNqbN9QaSks3mJSdsWnafv
 +WPN8P9uTJXgDq7MoZmNb2uEuy6hJaGT92pHXdWCl7CwpG3WqSs6qzV33UzFDvYFBZSZ
 UUuNL+qea2kRVRdE+3WUHssYdQLVfH+2iesmnyvzdIdPhw3MqJniV5bNHx/k52lCKjEp
 okKHHqDkGR/Q/e6WRj4NT+cYq9mfWtge5ASHKIr5EfcGgiKOLjE5Po8Naq0W6HGQliG7
 1VGSJHgGKatQ0SrpnDVCWg4nOlNrVszK0U//QeNb5msOqnOIJ3Va0Zfmwl3PCGH531UV
 KusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783507338; x=1784112138;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u2OD6bWkq90IMWX4LtBTZ1odeccTTxtdRipOzCwswi4=;
 b=P0cYwDuP/2XV/8mk7rRioopjhUYJ+j9l0Run7wJrLPyB6HU5/0h1CL8JQo9I2WNBAD
 RDD9XzfQh0VLlfB/zAnLONxTygETVdyZHy/KjnIxwA6s9c/2t/2hfUJ3DBRgwkD1heoA
 tA0qAjeAZnFCZCh+Y7Uf5RaT3YUr+vPKDsLomngivZ/5XZVjKWv7UljJ/7R/x0xDq0kq
 b2MDKGi5Z0iV3YvRysCC/aCPLZK68WIYiXtvYg5izRG/pJIjZjEZsmj/6Iq3++dNIx7B
 3qkyXSaAEJEB1zRyr38Url0GiqPhNPGV55sTazPBOVgP/6uKQLlKXGkL7Z/VnEEkFEtX
 8Kog==
X-Gm-Message-State: AOJu0Yy+QaLd8bmfTvbArPtAzrC/1E4MHUUGXGUoFLs3sPRmwfp6F1+B
 FFeVCHz1waBEaXnNqD+u4WtqhZ9iEmzyTEO3mZw+AytpgAgRc/Bb3LlbDgBJuf1eDIB+7ACOoKQ
 xeEltZCaXwbWu6DZbeSFQlogA+KIQtvbhx83X6O5me/sY6oJbd7YZLKofLn5nAHj5JgdWeYA9AY
 mQnVL1+jLgMAPTMKGYSSpHn1tTcg==
X-Received: from pgu23.prod.google.com ([2002:a63:1457:0:b0:c96:680f:db07])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:94ed:b0:848:3119:941e
 with SMTP id d2e1a72fcca58-848436754cemr2072591b3a.47.1783507338207; Wed, 08
 Jul 2026 03:42:18 -0700 (PDT)
Date: Wed,  8 Jul 2026 10:42:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708104215.507193-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ltp: syscalls/madvise09: Reset cgroup memory limits
 before test retries
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

### Background
When executing `madvise09`, the test intermittently fails with:

```
madvise09.c:163: TFAIL: MADV_FREE pages were freed immediately
...
madvise09.c:116: TINFO: 0x7476845000 unexpected   (0) at 1 expected 'a'
madvise09.c:232: TFAIL: Found 2 corrupted page(s)
```

---

### Root Cause Analysis
By analyzing the failure logs, we discovered that these failures only occurred when the test entered its retry block ("Both children killed, retrying...").

1. **Why does it retry? (OOM Race Condition)**
   The test relies on inducing memory pressure to trigger the OOM killer on the `memory_pressure_child`. However, because the entire cgroup is constrained by a strict `memory.max` of 8MB (`MEM_LIMIT`), we observed instances where the parent process (`child()`) was also terminated by the OOM killer.
   Specifically, when the memory-pressure child is killed, the parent process wakes up from `SAFE_WAIT(&status)` (which invokes `wait4`). While writing the exit status to the user-space stack pointer `&status`, the parent triggers a swap-in page fault (`do_swap_page` -> `mem_cgroup_swapin_charge_folio`).
   Since the memory-pressure child was just killed and its memory charges have not yet been fully freed, the parent's page fault hits the strict 8MB limit, invoking the OOM killer on the parent process. The test framework catches `WIFSIGNALED(status)` in `run()` and jumps to `retry:`.

2. **Why does the retry fail? (Cgroup Limit Leakage)**
   When retrying, `run()` forks a new `child()`. However, the cgroup `memory.max` (8MB) and `memory.swap.max` (16MB) set in the previous run were never reset.
   As a result, the new child starts executing in a cgroup that is already heavily constrained by the inherited 8MB limit.
   - When the child allocates pages, writes `'a'`s, and calls `madvise(..., MADV_FREE)`, the kernel immediately drops and reclaims the pages to relieve the 8MB memory pressure. This triggers the first failure: `MADV_FREE pages were freed immediately`.
   - Subsequently, when the test writes `'b'` to the first byte of `TOUCHED_PAGE1` (offset 0), it triggers a Copy-on-Write (CoW) on a zero-page (since the page was already reclaimed). The page is refaulted with `'b'` at offset 0, but offsets 1-4095 remain `0` (instead of the original `'a'`).
   - Finally, `check_page_baaa()` reads offset 1, finds `0` instead of `'a'`, and reports false-positive "page corruption" failures.

---

### Fix
This patch resets both `memory.max` and `memory.swap.max` to `"max"` (unconstrained) at the beginning of the `child()` function. This guarantees that each retry run starts in a clean cgroup environment. The strict memory limits will only be applied later in the test flow after `MADV_FREE` has been marked and initial page edits are completed.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 87fe096fb..e6fb74fdb 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -146,6 +146,16 @@ static void child(void)
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 
+	/*
+	 * Reset cgroup memory limits to default ("max") in case this is a retry run.
+	 * Otherwise, the retried child inherits the strict MEM_LIMIT from the previous
+	 * run, causing MADV_FREE pages to be dropped immediately before we touch them.
+	 */
+	if (SAFE_CG_HAS(tst_cg, "memory.max"))
+		SAFE_CG_PRINTF(tst_cg, "memory.max", "max");
+	if (swap_accounting_enabled && SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "max");
+
 	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
-- 
2.55.0.795.g602f6c329a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
