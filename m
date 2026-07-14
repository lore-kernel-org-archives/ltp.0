Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E295BC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 07:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784015857; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qZrEsVjyi+8P+PmD0+k4OoA3oIc6e7VS79mdt3X8uos=;
 b=mYMF3f4VZFIlyNVTgHUhdNpSugb9xnKgYRQdQr7P0f3XcJwSfKWhTxj0S4EvZ6We2ytR2
 lVbmAJM0G/bUYrTw/YS9BfltaB1GagblpKQXOxCkX0gPazT5fLp5oVeO3xStBRwUY4BrInf
 FSh1ouftODKo290rm57qNpxoOax9e/0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DAA83E26BA
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 09:57:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70B8C3E010C
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 09:57:16 +0200 (CEST)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D7CFD10004A1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 09:57:15 +0200 (CEST)
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2cceabd70f5so15663075ad.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784015834; x=1784620634; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J5lUBd4EizwOOD2SEalB27L33GP2XzGKqzOF0QTEhOg=;
 b=nx89iJxGXGzl0wExAv6M+crDswIhrq/BFQb3gYYxRgZF/IFJ77YV5LSweDZymGds0o
 5Nttt8KruCubCmjkbkJQtoJCsotMZ7vJ+t5zjiDCsM/g6w5myD0QnajIjExiiRjvU0Yq
 ke7jafB0/HQFu98+cGKVo4MnIZwl4G3K8Cm1Gg/bRVqsIblCaC9ZdZLQwnXIqJHky+p2
 CcASbkDsrxCl9NDBgAqynOzvybzeJgBXxHQv26uV4OTAMbA4awW+rLj9WnEzLIhhH2oB
 tAa9QCvfMwTToUWYg25p+jHRle/Xbg6sY9GFMZ2Thok+efAp+mDcV3fZ9yxxQHp+QXgK
 dbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784015834; x=1784620634;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5lUBd4EizwOOD2SEalB27L33GP2XzGKqzOF0QTEhOg=;
 b=GzUtIYf2Uy305hZx0ydk5Mt5gSTmETwIvgE4JuhYnNRQG1/JZxuuJ4FcWnSEuYJXEI
 G7GcHj+6JEtW7XLYudqLWWiYKUctb4WiR/jZUXgYfV7QzmahkGRtMUw7f8K7ejai0OoL
 6qUDLALtowEYB+RhcG7USp0dK4DCAX37M2lvH1VufP3CfM851tGhKyx8z+trhB7zpKPx
 xG2fO5LdUYt1u5uJA/4eIV9/7xxsLYuxNnbR3lX+E8ayClWQqhMquVXAEZybLJU1T+Oj
 rW4XmjVdEMoCTAZ4OmbsE7YhUbBqnHE6Jtj8ZCgybg0pSrPTncOioAn55pXfrSWQthcp
 W3CA==
X-Gm-Message-State: AOJu0Yz0qfWMli04MJDFSz8mu/Wrk3XZTuIJb40DPg7GiOCxmATvp0in
 oNnOSbpunCjpdP+bq76ttkMwXQf2DpMo+gsTR8BxpcHUHD/YadqaCcpD9bFvb2ElMkk6zpmGO0i
 e5ZfE80LjZ5KuqcuL2MsFUXUumqvdIc8UDLMOalf/8qJN3yiBJQ6ze7TG3R7F2+Fia2xj23LCzi
 /9wC1Mk7nqTZRx5jwKTfKRW/Dfow==
X-Received: from pleu1.prod.google.com ([2002:a17:903:41c1:b0:2c7:f3c5:4bc6])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc86:b0:2ca:6d87:cda0
 with SMTP id d9443c01a7336-2ce9e59db5cmr131017505ad.6.1784015833301; Tue, 14
 Jul 2026 00:57:13 -0700 (PDT)
Date: Tue, 14 Jul 2026 07:57:10 +0000
In-Reply-To: <20260713114220.4185427-1-wakel@google.com>
Mime-Version: 1.0
References: <20260713114220.4185427-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714075710.894370-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] madvise09: Reset cgroup limits before retrying test
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

When madvise09 enters its retry loop, the cgroup limits (memory.max and
memory.swap.max) configured in the previous run remain active. If the
previous run ended due to memory pressure, the inherited limits will
cause the new child to immediately reclaim MADV_FREE pages. This
results in false-positive failures during test verification.

Reset memory.max unconditionally, and memory.swap.max when swap
accounting is enabled, to "max" at the start of child() to ensure
each retry run begins in an unconstrained cgroup.

Signed-off-by: Wake Liu <wakel@google.com>
---
v5:
- Update commit message description to clarify that memory.swap.max is only
  reset when swap accounting is enabled, matching the code logic.

v4:
- Remove redundant SAFE_CG_HAS checks for memory.max and memory.swap.max.

v3:
- Fix commit message layout and length to follow guidelines.
- Use SAFE_CG_PRINT instead of SAFE_CG_PRINTF to fix compile errors.

v2:
- Reset memory limits to max in child.

 testcases/kernel/syscalls/madvise/madvise09.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 87fe096fb..821d40545 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -146,6 +146,15 @@ static void child(void)
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 
+	/*
+	 * Reset cgroup memory limits to default ("max") in case this is a retry run.
+	 * Otherwise, the retried child inherits the strict MEM_LIMIT from the previous
+	 * run, causing MADV_FREE pages to be dropped immediately before we touch them.
+	 */
+	SAFE_CG_PRINT(tst_cg, "memory.max", "max");
+	if (swap_accounting_enabled)
+		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
+
 	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
-- 
2.55.0.795.g602f6c329a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
