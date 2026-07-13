Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88136C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783942967; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2dSqJ3iGdm9c44xZ72DB8xKq+jyknvkRaosKaDwtBaY=;
 b=D4jYzj0XDRtqgIVSCcbYR0EzuT3corLq2N5BhnFGpZdOZ9OCyx50OqWXGv/GRqlSIyM4W
 aThVJ4ODPCT8WSpb+Aj5qmTO9MUQ+OIECF/i5VIQVaUVHiwJYvTzzXFaKJPpvkBEbP182U7
 tTTY70ZHXvrMdBZ1e8+52JWGQX/xU2g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05C723E295D
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:42:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 106D83E295D
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:42:24 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 505C6100014F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:42:24 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-c85798977dcso1848704a12.0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783942943; x=1784547743; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zkiHeItbq79dyDeu6bohp9UioHnCvwGef4MDZxJ99AA=;
 b=l5mHup2SGm3kcQVJNV+6qgWU7KCRVW358r+QHapXN/BYk3siszURddAvUkZLPHpCxD
 r/OqII9jAw9LnxFFxi75S1oA2ePo7PINHaYjAQexenqxxmZxvs0/IQj8r7YSoCQmrYS0
 aEVddyZEr0Tsxq9fl32yLZS2JiyQF2TuGOSRWxB6BieafGBIo6ulI/8MZ1/VCevo1DPv
 v7DxmvIwme4nohsod25h1GY5n25jPyvapeDePt8p+EP1L3sgzytXjZoYViA4WZ8cpvL9
 FernCw6BRzIhOqSrOX+8dUgSO/fGgVvWBUB9VvKFJo9+pkXTGlpcghlvkreGR83hBICi
 j8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783942943; x=1784547743;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zkiHeItbq79dyDeu6bohp9UioHnCvwGef4MDZxJ99AA=;
 b=UTksoCR9nlCu8pggyzsI2t5WG+7zo3PtZL3pO2ou5wY+t2VWP7D6rOSk5YFL2lG41V
 zvX7eSgoLBSJ07zCmkLy06rhogEIWkZNq6G/YxFzqbJWNrQN8wqLzaOisp9JRWGx6xkR
 PdfjazvDRB8eyPbpkUKZ7N6n1Ukltj8gVxNh2jsd8ItrxTBKJ8pj+6hwnJ61tf9Zr2Rb
 Lr4Y+ifrbsFrp0cGOv5AU9Kyj0/pcKeCgoO78onhqF7UJvlc+Z2XDeLzAqKVmTiGydTO
 RXt80HgGV9jErPEdZdrsSu3tPNCgx32GgyYaicMXmhEf6y4UdyuVBfhxHANLxtlhn2K2
 bsiw==
X-Gm-Message-State: AOJu0YxbtQD2AY8bpTUxJlVrA3DOO1Dw14iizCLfQbWxrbLDywzK3gOM
 2n9Ih5IvKxX9b3HLYQgKuU8PJRUUZfPPg2VoXz/c8aaie92CDPc4wiRSVQX804iyhZi3rZOSMHM
 IGcYVi+/rXeXx83OFj6I2u4hHaZ/hDo8cyKreDYsRPTvtd/QWnc2HGnDRRpTCwIOlN5YxhX2FCF
 9lL9skHJD0pj+0EsNY2tt5jvYLmA==
X-Received: from pfbcu1.prod.google.com ([2002:a05:6a00:4481:b0:848:8827:5d12])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b4e:b0:848:2f7a:2e5c
 with SMTP id d2e1a72fcca58-84889763ab2mr7357665b3a.75.1783942942004; Mon, 13
 Jul 2026 04:42:22 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:42:20 +0000
In-Reply-To: <20260713012545.3875573-1-wakel@google.com>
Mime-Version: 1.0
References: <20260713012545.3875573-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713114220.4185427-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] madvise09: Reset cgroup limits before retrying test
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

Reset both memory.max and memory.swap.max to "max" at the start of
child() to ensure each retry run begins in an unconstrained cgroup.

Signed-off-by: Wake Liu <wakel@google.com>
---
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
