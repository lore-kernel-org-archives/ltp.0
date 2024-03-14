Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B037C54E58
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 01:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710380033; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=DQO78PbOlK+J0lKKMT9MsLz6r6Gzmgez2AN8jEjpGQ4=;
 b=hky7xjXrQE5k+SR/6INLoPJyX1WTkLMCwuq+0k/8uns99o9rSy22FO1SenurIAQ+gH8Ni
 WG+UQtzXYNb5FLyvElVdR/vGeeElJBFbwxUGyPcIRbj0k+r2xuY94sZwQiH09Spgs/vhYRe
 Nm8Kd2PXatrYAabCw7zOzqwcioGSL+o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48A483D05FF
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 02:33:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24F083C06AC
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 02:33:30 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DEBF11400044
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 02:33:29 +0100 (CET)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-513a6416058so761140e87.1
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 18:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710380008; x=1710984808; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PoFWgxnbOJYKUuKl3p0DmQifQY+sIeP1GbuI7Kx/VLY=;
 b=OfaPL30eCXgdYhAAOdVtwIoz7rOZcK5Q19NhJYpBL0oUA/A5quTNGOWLTDCJjTNl0Q
 7xMiryS+3Gkt8xnBmRXxnBnvwbEnyJ2Aq79l269pMeOi1OLnG9ZpnbvefBxnJQb2rBqx
 HKJcMjAH5UvKcUzKcCVQULs2n3O4Dn1KZGEJZ9e3CUSK7XuJcEMgKOjfFLeh0JGtn7fb
 JroZ5VBapbqL445xMIrRF7FsPMiJpHYaBNbrPgeIm6zNKTp3uqyq10foGuVXXMy7k9cj
 +8gzUHlXsA7jI9i2ctBdIXvtYM0rsoJc1NboLJvl5fpKxobBxH6190jwgljDPgV3DGgw
 KW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710380008; x=1710984808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PoFWgxnbOJYKUuKl3p0DmQifQY+sIeP1GbuI7Kx/VLY=;
 b=TFoG2W6F//M3wOpQXQO56xm5BV7XbosmDzPFYWL1PAh+p4/35rO67+xXBkN5zf5wa3
 bo4+efcgPZ5YRWuTltKxzNEww1R/agg/bzftK+XK0mdGo5/bLq/BmyxqtHKInVbEg5xy
 GEIW6nwSyMwajQkDakVY7X/WUky8GBlCGQfjJ6VhmIv3QitXGld9mGHHUn6UvdntWz+1
 hayZkUwLSE+jGp1GpbDYQXVWfIBYUeQ3e1sMOamueof4Hjl1UA27YcVyH88bkbJi5bKt
 gNwCFWYvWagpWjnhswYXUs0xXK0KXrBGLfC4NH/QA9XCTlWyp758a1D9ckqkykGIAFEf
 H9bQ==
X-Gm-Message-State: AOJu0YzETSSDQ4Xzl21/R0KrI291Cu7JvoyDffhZzqB3musTeumPhI1G
 TzelzdYh3cGHlZZXJ3fXU88cAzhLCXvUOua/1TNLH69/WJ3T8oM+LxKDFJeWPb5uTAt+Y5Nis9A
 =
X-Google-Smtp-Source: AGHT+IGzT1Z5aR7gJCS0sJ4/rwrcm9T2w0mdimcaBqwgwa9QUPSPB3ZPepSlSQjqck7hFPekR5qBLw==
X-Received: by 2002:a05:6512:3d88:b0:513:a833:cda2 with SMTP id
 k8-20020a0565123d8800b00513a833cda2mr124631lfv.53.1710380008358; 
 Wed, 13 Mar 2024 18:33:28 -0700 (PDT)
Received: from localhost ([81.95.8.245]) by smtp.gmail.com with ESMTPSA id
 vi2-20020a170907d40200b00a42f6d17123sm175250ejc.46.2024.03.13.18.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 18:33:28 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 13 Mar 2024 21:33:20 -0400
Message-Id: <20240314013320.5536-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] swapon01.c: Apply a margin to avoid oom
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

During our test i find a oom error during test which triggered by
tst_pollute_memory.

kernel: oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0-1,oom_memcg=/ltp/test-9552,task_memcg=/ltp/test-95520
kernel: Memory cgroup out of memory: Killed process 9575 (swapon01) total-vm:1051484kB, anon-rss:1046572kB, file-rss:1280kB, shmem-rss:0k0

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/swapon/swapon01.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index d406e4bd9..357992525 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -41,7 +41,9 @@ static void setup(void)
 	make_swapfile(SWAP_FILE, 10, 0);
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
-	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
+
+	/* Apply a margin to avoid oom during tst_pollute_memory */
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM + TESTMEM/100);
 }
 
 static struct tst_test test = {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
