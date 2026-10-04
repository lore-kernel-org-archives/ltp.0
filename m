Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F81CA5FE6
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791124538; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VKD7KMYXEkJGeS+MhoHAlRWffwwzS/Jnt+uvnXOc21c=;
 b=hfF0jnKDsC1k5nB8egNb6wU8hF3ExAy2HLvhvfB3FN8xuxMOcXOjfoX72No4wtRrsKvxe
 sp710GLjewD9LVX2BmNU6OEjKV9u7fj8vhCIrlYRkSBvqRQ0y1+2G3j3Rr/LNRWoLZwSlkT
 mec6wvqZbM06kfo9JCxv9gWz5kW77nA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBCAA3E4E5F
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 16:35:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BD323E4E52
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 16:34:42 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A4C5B200069
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 16:34:41 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso9635315e9.2
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791124481; x=1791729281; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0YiTfYh1d3wCywLHgip7JrZCWBMG7NdovRtgZUVeEws=;
 b=MYC1hERZYe1ztyFqMc81h9jS5qBIdaXH2rYefzXc0Ktdw8XSNlNClm23kuiINtvAC/
 Qri4VpaxLqnQpcNKS1mrJnQMofoAAD/9tPeMTUOCoOyoxkIHU/TpaltUFkiHrRnw9kY9
 AAi+sMgDVXeqAgf1A8YtFBjWg7VN2IxaFKPklZm5neITDNOfo5hH7KMWQR/bhZuaD057
 TfJqrGp/nuvDd1+WDNxYEbJx2A8GMHBidR/PBWQj7K/1GJFFQ6bu7VfTwEgh5+9liDj3
 d2rXNEjoOj3rnOXLMkKOWiSo6P/POb94Sk8giyupX64qTCjGtxqbBiNjBZYg+PVr/W6R
 C3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791124481; x=1791729281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0YiTfYh1d3wCywLHgip7JrZCWBMG7NdovRtgZUVeEws=;
 b=eVIUMVGBbaea9xGaTXXBqnZggs4msSWoEFCOogEmz+PP71Up4aaNylNTnVa7B4Hn6C
 02VFfAFVALCXRSwZQVPytWlvnKvJGlc5ZhXwiS6lg6eMXmc1RAVeW2I9feoW5OJBqmce
 2uNthQmNMhGr/eCYA6Qo8WkR3Cf3NxjLO/AxeWjVZd7F4JvmjHwXzX+vcQ0Xc2I5kodH
 klptSbB5yH0WLdwUPIZo/IUY+8S9m/dNrAHDJRw+nggl0JQorih3Tnj3H9GBfADcgAro
 Wl3EBykPouQbgDjhdX1FS74OMxLGhjv4IinOWr0k3N5ZVf29j5pxZPG6s+TPmV8hnxVM
 3qIQ==
X-Gm-Message-State: AFuF++m55z8LdPVUe/ARGhtWlv9aFCxxptd23eJuWq9tfBGqHuqvMm9n
 YDFzoUIMvRQ01zv9Xe4eGkj9D6pJGgmCHxHWm+Syhi8r9HAw88L4lLePnycUainQMoSvhXnJ6qg
 BeCw=
X-Gm-Gg: AYBFou2Ov2YXmeuFsrQt+UHtgqdG0TxRjbkIAid4+RM5UQFJ9qk1SxPmqnmf2R+icXP
 WX9mVE+WEk/jrRImnfv/Ax6nqKpbgow4W/Sfm8rS7vs0MvIrZo4ioIQz9Oke3vwHEp/HNM4Km3Y
 y0iSnIXejWIY1/QSgrWCovkyG2238EyMnzT9vLp2QtaIiKr2WXpA3soUJKk0oV0RiBd31dFXm33
 +pWXep3Kl2WTDnIqTBFivBG5wDz+EF+HqtlUCKLtKcSqMHF1SYOTwQGxGYxF3NsBGe1bybR2ZsR
 slKcY0eceDRUNH4PlgAIBeQlA2G1CVsWhpIRybKC5Pw7D0rZ9IIBEjxz3XVZtkYwooFk6XZ9sVc
 XbGdJBVThX/DKT2DmjqJsMKRjWzuxcOX2Y7Uxe9MJ8fWA4OE2+D84WsYv4sqQs2+O20qro7sPhV
 0C9+dv7JBKjp9U1KfxQR3wX0AQ5zRcDJ2ngUz0m1TZ945U7gC51N6tLHce/p5SRz1kvjdxst4O2
 tGdINkIIJX8CeMWCj3mWQvV2RvK6DFOpGWX7CQifLY=
X-Received: by 2002:a05:600c:3103:b0:4a0:1efa:c746 with SMTP id
 5b1f17b1804b1-4a1680f61damr65512575e9.21.1791124480894; 
 Sun, 04 Oct 2026 07:34:40 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a03ff56136sm101698665e9.3.2026.10.04.07.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 07:34:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun,  4 Oct 2026 14:33:27 +0000
Message-ID: <20261004143332.25978-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004143332.25978-1-wegao@suse.com>
References: <20261004143332.25978-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] memcontrol03,
 memcontrol04: Set protection on parent cgroups to prevent kswapd
 over-reclaim
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On NUMA systems (observed on PowerPC), allocating memory can trigger
node-level memory pressure, waking up kswapd when free pages fall below
the low watermark on a node.

In cgroup v2, both hard protection (memory.min) and best-effort protection
(memory.low) are hierarchical and calculated top-down: effective
protection of descendant cgroups is bounded by their ancestors' protection
values. When LTP runs inside an existing cgroup hierarchy, ancestor cgroups
above the test root have memory.min and memory.low set to 0.

As a result, when kswapd performs node-level background reclaim from the
root cgroup downwards, ancestor cgroups without protection provide no
protection boundary. kswapd reclaims pages from descendant leaf cgroups
regardless of their local memory.min / memory.low settings, causing
memcontrol03 and memcontrol04 to fail with over-reclaim:

NUMA node info:
  NUMA Node 2: CPUs=[2], MemTotal=765 MB, MemFree=610 MB
  NUMA Node 0: CPUs=[0], MemTotal=240 MB, MemFree=93 MB
  NUMA Node 3: CPUs=[3], MemTotal=750 MB, MemFree=419 MB
  NUMA Node 1: CPUs=[1], MemTotal=766 MB, MemFree=95 MB

Error info:
  memcontrol03.c:519: TFAIL: Expect: (A/B/C memory.current=19070976) ~= 34603008

Set memory.min and memory.low on trunk_A and parent cgroups up through the
hierarchy before allocating child pagecache, ensuring protection propagates
down the tree to prevent kswapd over-reclaim under NUMA memory pressure,
and restore the original values upon cleanup.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/controllers/memcg/memcontrol03.c   | 20 ++++++++++++-------
 .../kernel/controllers/memcg/memcontrol04.c   | 19 +++++++++++-------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 25b84c24e..721ae0e46 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -184,21 +184,24 @@ static void test_memcg_min(void)
 
 	trunk_cg[G] = tst_cg_group_mk(trunk_cg[A], "trunk_G");
 
-	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
+	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
 		leaf_cg[i] = tst_cg_group_mk(trunk_cg[B],
 						 "leaf_%c", 'C' + i);
 
-		if (i == E)
-			continue;
-
-		alloc_pagecache_in_child(leaf_cg[i], MB(50));
-	}
-
+	SAFE_CG_PRINT(trunk_cg[A], "memory.min", "50M");
 	SAFE_CG_PRINT(trunk_cg[B], "memory.min", "50M");
 	SAFE_CG_PRINT(leaf_cg[C], "memory.min", "75M");
 	SAFE_CG_PRINT(leaf_cg[D], "memory.min", "25M");
 	SAFE_CG_PRINT(leaf_cg[E], "memory.min", "500M");
 	SAFE_CG_PRINT(leaf_cg[F], "memory.min", "0");
+	set_parent_memory_knob("memory.min", "50M");
+
+	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
+		if (i == E)
+			continue;
+
+		alloc_pagecache_in_child(leaf_cg[i], MB(50));
+	}
 
 	for (attempts = 0; attempts < 5; attempts++) {
 		SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
@@ -223,6 +226,7 @@ static void test_memcg_min(void)
 		     "(A/B/D memory.current=%ld) ~= %d", c[1], MB(21));
 	TST_EXP_EXPR(values_close(c[2], 0, 1),
 		     "(A/B/E memory.current=%ld) ~= 0", c[2]);
+	tst_res(TINFO, "A/B/F memory.current=%ld", c[F]);
 
 	alloc_anon_in_child(trunk_cg[G], MB(170), 1);
 
@@ -231,12 +235,14 @@ static void test_memcg_min(void)
 		     "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
 
 	cleanup_sub_groups();
+	restore_parent_memory_knob("memory.min");
 	SAFE_CLOSE(fd);
 	SAFE_UNLINK(TMPDIR"/tmpfile");
 }
 
 static void cleanup(void)
 {
+	restore_parent_memory_knob("memory.min");
 	cleanup_sub_groups();
 	if (fd > -1)
 		SAFE_CLOSE(fd);
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index f1e136df4..10de95bec 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -157,21 +157,24 @@ static void test_memcg_low(void)
 
 	trunk_cg[G] = tst_cg_group_mk(trunk_cg[A], "trunk_G");
 
-	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
+	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
 		leaf_cg[i] = tst_cg_group_mk(trunk_cg[B],
 						 "leaf_%c", 'C' + i);
 
-		if (i == E)
-			continue;
-
-		alloc_pagecache_in_child(leaf_cg[i], MB(50));
-	}
-
+	SAFE_CG_PRINT(trunk_cg[A], "memory.low", "50M");
 	SAFE_CG_PRINT(trunk_cg[B], "memory.low", "50M");
 	SAFE_CG_PRINT(leaf_cg[C], "memory.low", "75M");
 	SAFE_CG_PRINT(leaf_cg[D], "memory.low", "25M");
 	SAFE_CG_PRINT(leaf_cg[E], "memory.low", "500M");
 	SAFE_CG_PRINT(leaf_cg[F], "memory.low", "0");
+	set_parent_memory_knob("memory.low", "50M");
+
+	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
+		if (i == E)
+			continue;
+
+		alloc_pagecache_in_child(leaf_cg[i], MB(50));
+	}
 
 	alloc_anon_in_child(trunk_cg[G], MB(148));
 
@@ -230,12 +233,14 @@ static void test_memcg_low(void)
 	}
 
 	cleanup_sub_groups();
+	restore_parent_memory_knob("memory.low");
 	SAFE_CLOSE(fd);
 	SAFE_UNLINK(TMPDIR"/tmpfile");
 }
 
 static void cleanup(void)
 {
+	restore_parent_memory_knob("memory.low");
 	cleanup_sub_groups();
 	if (fd > -1)
 		SAFE_CLOSE(fd);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
