Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7F3C9832A
	for <ltp@archiver.kernel.org>; Sat, 26 Sep 2026 20:45:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 429883C5E2C
	for <ltp@archiver.kernel.org>; Sat, 26 Sep 2026 22:45:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B52613E9FE0
 for <ltp@lists.linux.it>; Sat, 26 Sep 2026 22:45:05 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5747F600666
 for <ltp@lists.linux.it>; Sat, 26 Sep 2026 22:45:05 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so13904145e9.2
 for <ltp@lists.linux.it>; Sat, 26 Sep 2026 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790455505; x=1791060305; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IcQxl45XCypqSqzebURwqki4fhJtSDts8C8Y84zPv8k=;
 b=LNX+VYLVbmOZb3D7kKhaJbJlSd2MVmP3Y5nVa4PzEnVq+2iFAcgIsGSsWccPbCt8Ul
 oBk4YNPmQmMAWYgmhrOYVnw1Vo7tV49VW2UVUOVMQCBYLI4Tjt+dnOeqixCceUlp1r40
 u3goqK32B2TvKJztBFmci8YwUW22jArUPV5nOTm95EfjjhnHD0MsiWLWVTqvqOPwyAnJ
 JGXCdwDvwqnHqHRGVqSA9mUF/YM+2Banj4Iv7h8BU0mM8WGidCLqkHQwxfiEJnQAi1+j
 EAYWSnC0mhoj+c/bTDex6oAbQk/9Yqonuurrme59X7i0lLtejNpbVcetA2pgtGUoNLgN
 8DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790455505; x=1791060305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IcQxl45XCypqSqzebURwqki4fhJtSDts8C8Y84zPv8k=;
 b=wztcXdl8kDJqKQPIo6n+gtxU8DqCRWT5bJZzTEJ+abLCsHxZ/5yNOTcAGIc90XkL22
 96VKIB9NspsLO5//WhBUa+izrR9XQuILoLvnhhUTz3FfGOsfPlmDw6L1I1xLricPYYm9
 7joC61cJf02LXTtlHEqFmcBIQqd8LXgAXbbPRuxDz6LsAZJIihz27I4rfqpGA/y0I8C0
 w7B7SCOeIzSxEKXuxJ3RU26tC4MGddaA/RujaeTBvShECU833YZK9S8A9qRbxFBb1+/3
 JQALKFS8tuth9VKfibNcI8RlltKsdaCJghZIPC/B9ORUA4PGNX9RNyDeTBDVmYwkJVNY
 iiPg==
X-Gm-Message-State: AFuF++m3xF8C2aMb/rcmKH3FsqfF0rGYTn16eN0ace3oDxhtcb4wqxwh
 0EkpBDpM8iHsBtuCQQVyVuCE06fc3DxAyPuJThlFk8Q9d1vGzpV2XClW/Em6ukRF
X-Gm-Gg: AYBFou0HXCxlnHzH6AzcOkuIdkcQXTeuuMs2F1HmRLKgidq1IipkDUDmLOxfbt3gfuw
 eGEeuodfLwEWmkCK3UBMKji+aXClk9cziQDIU3iZ/zTotGJ7IuPn+aJNMz6W1tBYUd2YHlTChue
 ItbD6fSJNPEgFr2MbFUMg71Kj9ODifwjkV+HcnhQ96OOit+I25FWyOzRd3jptVh1RjTdLAO0ocx
 m+ankqutT0k20Fiw70xMlRS4BjH8L4kW4uFahMaeRE9VXvMYxqx7NrYysyNYICQ0etC2rY6F+fh
 B3yaTSyQ3dBjZ+PbBCsqXTKuNgVpaMTYzPsb5gsN4iImPZa+231eywf7UvWuNAlUWcYOPKVCcSW
 Oo4QPAlDORmTmXAcsJ/2tlKvesNy8vU2GZu4qpzGLjMiDqi2VdNkrlBPPC6YW0NE3SLA34ozUlL
 A3r/zC8tfU8Iz3rLNW+ndPsx7L+3Y6S5afFTS0sJCgzsPz+9+/to1VN9tNbNcgJv14FZdbNyae1
 6I6/GDb0IQdqno4ci9r+N/I2Sf6pHMPBuLn17ErAX0q
X-Received: by 2002:a05:600c:a47:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49fe66abc9cmr164883535e9.6.1790455504707; 
 Sat, 26 Sep 2026 13:45:04 -0700 (PDT)
Received: from localhost.suse.org ([37.109.167.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff13b3c59sm18554405e9.0.2026.09.26.13.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 13:45:04 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: ltp@lists.linux.it
Date: Sat, 26 Sep 2026 22:44:54 +0200
Message-ID: <20260926204459.20699-3-sebastianchlad@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260926204459.20699-1-sebastianchlad@gmail.com>
References: <20260926204459.20699-1-sebastianchlad@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] memcg/memcontrol0[34]: Remove protection from the
 top level group
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Sebastian Chlad <sebastian.chlad@suse.com>

The memory pressure in both tests comes from A/G hitting the
memory.max of A, so A is the reclaim root. Protection of the reclaim
root is ignored by the kernel and the direct children of the root
(A/B and A/G) use their own memory.min/memory.low as is, see
page_counter_calculate_protection(). The 50M of memory.min
(memcontrol03) and memory.low (memcontrol04) set on A thus has no
effect on what the tests check; it would only protect the whole
hierarchy against reclaim from outside, which the tests don't need.

The kselftest the tests are ported from dropped it for the same reason
in kernel commit 6a35919005d4 ("selftests: memcg: remove protection
from top level memcg"). Do the same and correct the descriptions, as
the pressure is created in A, not in A/G.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 testcases/kernel/controllers/memcg/memcontrol03.c | 5 ++---
 testcases/kernel/controllers/memcg/memcontrol04.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index aa94f4999..25b84c24e 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -5,7 +5,7 @@
  *
  * Original description:
  * "First, this test creates the following hierarchy:
- * A       memory.min = 50M,  memory.max = 200M
+ * A       memory.min = 0,    memory.max = 200M
  * A/B     memory.min = 50M,  memory.current = 50M
  * A/B/C   memory.min = 75M,  memory.current = 50M
  * A/B/D   memory.min = 25M,  memory.current = 50M
@@ -15,7 +15,7 @@
  * Usages are pagecache, but the test keeps a running
  * process in every leaf cgroup.
  * Then it creates A/G and creates a significant
- * memory pressure in it.
+ * memory pressure in A.
  *
  * A/B    memory.current ~= 50M
  * A/B/C  memory.current ~= 29M
@@ -194,7 +194,6 @@ static void test_memcg_min(void)
 		alloc_pagecache_in_child(leaf_cg[i], MB(50));
 	}
 
-	SAFE_CG_PRINT(trunk_cg[A], "memory.min", "50M");
 	SAFE_CG_PRINT(trunk_cg[B], "memory.min", "50M");
 	SAFE_CG_PRINT(leaf_cg[C], "memory.min", "75M");
 	SAFE_CG_PRINT(leaf_cg[D], "memory.min", "25M");
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index 92ab53a51..f1e136df4 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -5,7 +5,7 @@
  *
  * Original description:
  * "First, this test creates the following hierarchy:
- * A       memory.low = 50M,  memory.max = 200M
+ * A       memory.low = 0,    memory.max = 200M
  * A/B     memory.low = 50M,  memory.current = 50M
  * A/B/C   memory.low = 75M,  memory.current = 50M
  * A/B/D   memory.low = 25M,  memory.current = 50M
@@ -14,7 +14,7 @@
  *
  * Usages are pagecache
  * Then it creates A/G and creates a significant
- * memory pressure in it.
+ * memory pressure in A.
  *
  * A/B    memory.current ~= 50M
  * A/B/C  memory.current ~= 29M
@@ -167,7 +167,6 @@ static void test_memcg_low(void)
 		alloc_pagecache_in_child(leaf_cg[i], MB(50));
 	}
 
-	SAFE_CG_PRINT(trunk_cg[A], "memory.low", "50M");
 	SAFE_CG_PRINT(trunk_cg[B], "memory.low", "50M");
 	SAFE_CG_PRINT(leaf_cg[C], "memory.low", "75M");
 	SAFE_CG_PRINT(leaf_cg[D], "memory.low", "25M");
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
