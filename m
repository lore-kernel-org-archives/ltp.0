Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41020C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 07:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713424503; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=5UiMNgtRNqeaLA+8MYdTV25UfmbOA4glV/UTXNhwwRs=;
 b=lhUX4kdHXmGkQgqD23+I9mI+8Jecn8XDGDC5HZi64YXhSpzX8hiraBIS7D3Ladff6snAS
 K0K67YRGUAnG5pbzn/lFFk4whrbtl5HyQNGceR0Dl1nnYmNG0CsOLeegGXPjmomFFKy5DOR
 sS4rWzDup72q1iOVclEuj63BjRflyo0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7176D3CFBA7
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 09:15:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B5C43CF513
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 09:14:41 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2915414098BF
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 09:14:41 +0200 (CEST)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2db2f6cb312so9739861fa.2
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 00:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713424480; x=1714029280; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NPrQOwK5zOqtDh37beYLP5A1peau2b0baTuIP0+LCiY=;
 b=WC95tsCHtxDYkd6d21jVvq8tcs4KrteFuf7XyYgkfYRZNsCbNty14aCUpXXV5HEUow
 CEq7dVWffGwWA30E0nHpGV2nYgOqGNDCt6AC3qoB/xmE7XgoW3h3rZOKWqwRBl3Lv1gj
 YTzmq7AVmO8RNlySyOzrI9Quj84xwehuIZYTl2hDjwDpmk6FLK+ZYPiOucZfY96vz4+n
 vvTMuYjMr29c9wMYQGyyXh2m7C7f1rWepgG1THcS/Dtb8HttwEm9xy5+mpHGeOVaRdrV
 HqhNQHGqGaOyPz8EmV3IyVMeG3c304sXfjgafSxJUPRGRfkvw81ZRPVOBMWR+BpCNO8H
 nUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713424480; x=1714029280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NPrQOwK5zOqtDh37beYLP5A1peau2b0baTuIP0+LCiY=;
 b=apzCHEDC5boyeH2KRak6BaxT53k7ryrf/cP3gU31Ie1RWhfKr+MjRv3V3YLv1dQeeu
 1yHajRengc/OwYbcrnWFKDaVqzNRswAeLOGX86eDu+xljG8LlTSJJvcCvMoFBa1gXLYt
 PQTseVNu1poHmOaJTrpUrmRnwgkhqtzHeUiEy9uQSsGxGjDlQzhkAthjjpYrI0fMY4ne
 S2vlnh9Z/AV7+neMKH5JNYVffUrInPx9H7cvZwjCm7Rg3xCJBCzwRhB9jzMX2rkuqpOH
 0f2LrkNVBc2MFSUgggt3jCGDz0bI8VTPcWNfKS3mwyoBOtOq0NnX4uj56n6BphBIc3og
 sy5g==
X-Gm-Message-State: AOJu0YwZFyQ0wcspJVxvE18U5JiusnBLq2K9IdET9KGt3odLcj58wAk+
 YzpkYHnSu7mbeh5DjwuQJH47eDk03pl3WOUVACTzLWV0fnUReM/TRZjkLg30Dqjo3s+1PMkd/To
 =
X-Google-Smtp-Source: AGHT+IE9BwXMB5UoFV3wEWe4oiecesTdcNnQqtphbMLoOqn0l5/Zoyq87mz5+6FwNqzAKi7/X0mvBg==
X-Received: by 2002:a2e:330b:0:b0:2d8:3ccc:60e8 with SMTP id
 d11-20020a2e330b000000b002d83ccc60e8mr1103967ljc.48.1713424479650; 
 Thu, 18 Apr 2024 00:14:39 -0700 (PDT)
Received: from localhost ([223.72.87.223]) by smtp.gmail.com with ESMTPSA id
 f6-20020a635546000000b005f41aeec262sm754924pgm.44.2024.04.18.00.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 00:14:39 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 18 Apr 2024 03:14:22 -0400
Message-Id: <20240418071422.10221-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] swapping01.c: Add sleeps in the loop that dirties
 the memory
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In our test env this case failed sporadically, we suspect swapout speed not fast enough
in some situation.

Detail info please check following comments;
https://bugzilla.suse.com/show_bug.cgi?id=1217850#c34

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index a0030a75f..338881c8e 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -47,6 +47,7 @@
 #define COE_DELTA       1
 /* will try to alloc 1.3 * phy_mem */
 #define COE_SLIGHT_OVER 0.3
+#define MEM_SIZE 1024 * 1024
 
 static void init_meminfo(void);
 static void do_alloc(int allow_raise);
@@ -101,6 +102,13 @@ static void init_meminfo(void)
 				swap_free_init, mem_over_max);
 }
 
+static void memset_blocks(char *ptr, int mem_count, int sleep_time_ms) {
+	for (int i = 0; i < mem_count / 1024; i++) {
+		memset(ptr + (i * MEM_SIZE), 1, MEM_SIZE);
+		usleep(sleep_time_ms * 1000);
+	}
+}
+
 static void do_alloc(int allow_raise)
 {
 	long mem_count;
@@ -115,7 +123,7 @@ static void do_alloc(int allow_raise)
 	if (allow_raise == 1)
 		tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
 	s = SAFE_MALLOC(mem_count * 1024);
-	memset(s, 1, mem_count * 1024);
+	memset_blocks(s, mem_count, 10);
 
 	if ((allow_raise == 1) && (raise(SIGSTOP) == -1)) {
 		tst_res(TINFO, "memory allocated: %ld MB", mem_count / 1024);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
