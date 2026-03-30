Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8154AFB3CF7
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774866630; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=MRId74mcbLhYrNbyBQRVF2BTSsBwPeY1bwQNusXBeqk=;
 b=EK3llafZXfVbj0e4Yuvr16Kss3rEf6ewwbPzmhrhVjyTq1Ojkw6HwLNJNWcrz2Y6hiul3
 OxEgGSPtOESE6U8h1jwsX0Y9KgIWwN23+CWWn8yNrcirOMcyWk/zogdFUU4SgC/QSjFrpdv
 jzdnf68auF/7rIA6WNMV+tzFm391zhM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D92F3E4F11
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 12:30:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21B083E4F1A
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:29:41 +0200 (CEST)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC9F6200AEB
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=MUd7B0+CG9tJ9JvLS1PABSpkx8XaY0Xum98X/YE5Sh0=; b=arBkJWrNarTC
 ah2jBHvd7eJszYUouDZt/AVyHlgV9fGBZ63lrDkmODxOTQYEuXpp9WVis/Hhki0w5EcitrMQpxhcF
 Yf/vU6WTpgx3bH5mXvjIYb0F4zzZ/mnyg6RPtYf06mSS0Y1aW7eypvyEBghtJo21usuT54ttaby2E
 DcZLPn5hp/H4fV7jRWuX6aq7J7ckRBVtEjy/F1jkgUnqhAbRVaqlCxyGToiSv03JyprQxHzLoAC7A
 Qtdyh8uVUPP1B8V2fTzkCDMR9YWXi0tluHuzM4GXASr4ng5AAEoSWjWjMhGtJlUMHKHJsEK8r4APi
 9Oo4r4KfUdOz799If5btxw==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1w79qE-002jRx-1H; Mon, 30 Mar 2026 12:29:32 +0200
To: ltp@lists.linux.it
Date: Mon, 30 Mar 2026 10:20:25 +0000
Message-ID: <20260330102909.863484-3-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330102909.863484-1-vasileios.almpanis@virtuozzo.com>
References: <20260330102909.863484-1-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] memcg: scale memcontrol03 checkpoint timeouts for
 slow kernels
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The default checkpoint wake/wait budget is 10s. Pagecache setup plus fsync
across several filesystems can exceed that on KASAN, lockdep, or otherwise
slow configs. Parents then fail checkpoint wait or wake, children stay in
leaf cgroups, and framework cgroup teardown hits EBUSY.

Use tst_multiply_timeout(10) * 1000 ms for CHILD_IDLE / TEST_DONE waits,
the matching CHILD_IDLE wake, and TEST_DONE wake in cleanup so timeouts
follow LTP_TIMEOUT_MUL and slow-kernel scaling like other tests.

Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 testcases/kernel/controllers/memcg/memcontrol03.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 493e970ab..5820621e1 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -41,6 +41,7 @@
 #include "memcontrol_common.h"
 
 #define TMPDIR "mntdir"
+#define CHECKPOINT_TIMEOUT_MS (tst_multiply_timeout(10) * 1000)
 
 static struct tst_cg_group *trunk_cg[3];
 static struct tst_cg_group *leaf_cg[4];
@@ -72,8 +73,9 @@ static void cleanup_sub_groups(void)
 		if (!leaf_cg[i - 1])
 			continue;
 
-		TST_CHECKPOINT_WAKE2(TEST_DONE,
-				     ARRAY_SIZE(leaf_cg) - 1);
+		TST_CHECKPOINT_WAKE2_TIMEOUT(TEST_DONE,
+					     ARRAY_SIZE(leaf_cg) - 1,
+					     CHECKPOINT_TIMEOUT_MS);
 		tst_reap_children();
 		break;
 	}
@@ -140,7 +142,7 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 	size_t cgmem;
 
 	if (pid) {
-		TST_CHECKPOINT_WAIT(CHILD_IDLE);
+		TST_CHECKPOINT_WAIT2(CHILD_IDLE, CHECKPOINT_TIMEOUT_MS);
 		return;
 	}
 
@@ -155,9 +157,8 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 		alloc_pagecache(fd, size);
 
 	SAFE_FSYNC(fd);
-
-	TST_CHECKPOINT_WAKE(CHILD_IDLE);
-	TST_CHECKPOINT_WAIT(TEST_DONE);
+	TST_CHECKPOINT_WAKE_TIMEOUT(CHILD_IDLE, CHECKPOINT_TIMEOUT_MS);
+	TST_CHECKPOINT_WAIT2(TEST_DONE, CHECKPOINT_TIMEOUT_MS);
 	exit(0);
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
