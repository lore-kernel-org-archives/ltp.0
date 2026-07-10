Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8724C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 02:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783649729; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5vJ/cTCs3PgTqYRrWHMNffvADzTQGq2OgbylTzusCNg=;
 b=eaIbIfAjEgGMJvti5R/7A2ZfxkxxNYJy00xSeHmVhVng4JCbFwFV3+pU67ea4wZdaWEPG
 hSK4/PP4VHT4iirMET+BreYInc+rAST9+gyBTqS4U2EbmyzxLh8Stn4RFXIymqJG3j9yETo
 EVFfQ2XYdsYDXLB3L/zZw4AN9g85COA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF2B33E4A6F
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 04:15:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 676243E2EA9
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 04:15:07 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 22F161400077
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 04:15:07 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-384636ba25dso762244a91.2
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783649705; x=1784254505; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YP67at9UeptYfyy2ELjO+dVwptWvpaOrwiDkHsFRPck=;
 b=exiXOdFt1hG4mM8+tKTQO5hZ5KQq+CNa62g88201UcjGbFcWmQvK+t37C/xIE1AfYw
 bU4TQB173dmDodkDz98YSgtDoUL+FlfjK1+rn17VuYynkTfz8/AmspR0OazUzW8hZZFk
 0XY88rgSv9yIZvki/dJJfKZvFBWWGu9rqBRgerwi8B/zm9JDDvYGpsjh5Q9e7nhwQe6b
 3yGmKJoJTq7k4WVrMgGuVwYOYy0Vuw4f141bZqbzs8ibirobkMBrtXLPG13F2kbM6o9k
 mKy03Ur667jvmvPr9Ah8gQ2TQIeQScwsE9rQwDsX6JtDw88eYDqmfR4cWWTu+x6Ul15s
 n40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783649705; x=1784254505;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YP67at9UeptYfyy2ELjO+dVwptWvpaOrwiDkHsFRPck=;
 b=GhRGCcEVAOYT+LcwEseMJkle4ywJBHgI93YPwG9IU5LJ6onnZJQ2w+udyUE5qNA1bx
 Y8jEwLQbYN8JQkSy8JZ1y0BbNWlc1lOjkYIr/Q2M0KaIe1qW/BCh5WtB3eOVUwnQ1UFR
 qNRkkREzHZpo+RZK4ZLH/C9dlcItoq8PRK3bkr661gpxHjPO24qyqsp5mTaP5ipjUu40
 rf22VYfupzPzg9MeiZn+Cc8kv9s7uAZ1KqL6lTWmOcg8RfREIUTK7Fw7MWkL6ZCY7dBL
 GqpbJTJft8paTRBM3AfbFfSGvxocE4si4Z7mUqU5Z43/urlQ3GB2apiAUJRp7M29izqR
 peEA==
X-Gm-Message-State: AOJu0Yzoc5xOwWbCdzPw8OCS0l//q/gxOdouR9guHT8Kghwilaegfvhw
 01Jgf/7/k4YRHE+5VJxo0iV66D6aRYRSeALBR0zFBAyzxQU1PxoHEOhrxOz+08dGDc4HXCo6jLo
 ajVv6M7QE5EvXCIadQm9ZRyO5N45gZJX4CjNkdZjHa8siRrT57pel07Me+03gIjAgGMc8f1YZ56
 MPsDcOg0MO12a8aarXy/G3uSRxlA==
X-Received: from pjbhl13.prod.google.com ([2002:a17:90b:134d:b0:384:caf7:a184])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:314c:b0:37e:1609:b304
 with SMTP id 98e67ed59e1d1-3894014c5d9mr8120652a91.1.1783649704833; Thu, 09
 Jul 2026 19:15:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 02:15:02 +0000
In-Reply-To: <20260708104215.507193-1-wakel@google.com>
Mime-Version: 1.0
References: <20260708104215.507193-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710021502.1798161-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ltp: syscalls/madvise09: Reset cgroup memory
 limits before test retries
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
index 87fe096fb..9eb6e82ec 100644
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
+		SAFE_CG_PRINT(tst_cg, "memory.max", "max");
+	if (swap_accounting_enabled && SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
+
 	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
-- 
2.55.0.795.g602f6c329a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
