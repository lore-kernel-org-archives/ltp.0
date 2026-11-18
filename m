Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE9606A31C
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=qX1IK0bB;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KlyDjNYQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794983711; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=m4zr53YR97s1FrG9KGMqIlpyd4l1nKUTzMvny6XY9/E=;
 b=qX1IK0bBHuCQNaq6zgkm76AMt9x4E2Q/tuYysA2KYDPz/IK4S9lzOiG1XJOFMEPqgEZPB
 +HoXW7osPumVMVuEH3z8obO2oCDYibgfJY+/E9y5eLXFHOfs9SGQlJ8jRnkND+lRUxaemjY
 PbcXafawKvp5NtBaUMT3HEYRoDMp8Ro=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4B3F3E92D8
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 07:35:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AA6D3CEBFE
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 07:34:52 +0100 (CET)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com
 [IPv6:2607:f8b0:4864:20::1045])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 694871400058
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 07:34:52 +0100 (CET)
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-3b191f8a9b3so876316a91.1
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 22:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794983690; x=1795588490; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E6BqEGY5+17jQrrOCxDxsPZ/5OrheYqb4sgvR3NaLO8=;
 b=KlyDjNYQ8H7jVh60iX5hZUSTwS5duHGKtBZmexQ5dybRSosf91ucTSSpewEiWgzJBd
 rZku8brUvjVusOhgawdmm2O5Q7k3VmfYohQeKZjRuTrmBDDUUxek3ql9Ww85dBVd101h
 QgNY8xW5g0U+44iDpGByL3j7oWJCmYmXqet2KGLL7fuVXDMRTJMrskqkU9P6RIEAwjjT
 z4vTJscs+NXnO7iIZFwz7Y+WcwJI80w2VWeqjXzSBdcBF0nvyhFokWaY2pD+F8cZ2N1m
 tiQLlE9hPkha8Ff4AT9G67/n21z75U2wmVFAgdbMVSlkm8JCELJsqEPCmBBv3zcHsr+X
 FrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794983690; x=1795588490;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E6BqEGY5+17jQrrOCxDxsPZ/5OrheYqb4sgvR3NaLO8=;
 b=00AQ/prL4rR/C2QvLZZ/KFs7zYAh+LclHuHwF/EAHRGss/E8uvfAdsVQ3KTcgCwu9Z
 6lF8/CTkvUGwbuAaw3HERvXp6lDY2zBixJ8/Toe/uP+C4pfYm1yHDZKVodZJmDNjeO1H
 A/ULfI6g12WgbxlmqWkcguyqrFxoRyhLUf1mCFZmleiRZ6LhIkpAosmTn1+0Jkaf+Xei
 Y1eenAlJXvcpPbMb/yhSHnUcH49Z8syMFvlylru1RjhwOdF2WaJeadpUBQLWPofxRSGk
 kV4lcoT3+TdhEDIv2FvY+kh9Pzu/lw8wbY/tpWYrPPAij79mOarw1qRD2eoIsVLUDqnt
 08uQ==
X-Gm-Message-State: APuU4Z/kQZwu9wzy4e9mOH308NkUWwc7RY49k1OnbiyxMW0wLH0pjsaD
 BIMTE/GovQ4V5eFW+DT6zLU4ckpPyIb7z7FYuuuexZi6uDJn1QGy+ywW7NjB3RVqEAxIzh1FHh1
 C8KwCvyqwrfWM9te+34uidyGcFQCGWHT2LYMCtKT5tECUJTZh9sigWhefnoNmZJWpv5d7waOO/T
 NUldEoftjkTUrowE6oDw5tgPi5YZ7P6QZnrxPuwMgEYXozxrI=
X-Received: from pjblp12.prod.google.com ([2002:a17:90b:4a8c:b0:3b0:f7d8:3b91])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4490:b0:3ad:c4e9:7beb with SMTP id
 98e67ed59e1d1-3b3d07aab52mr1744096a91.43.1794983690209; 
 Tue, 17 Nov 2026 22:34:50 -0800 (PST)
Date: Wed, 18 Nov 2026 06:34:45 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118063445.2137150-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sys_block_queue01: Accept plain "none" in
 queue/scheduler
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Darren Chang via ltp <ltp@lists.linux.it>
Reply-To: Darren Chang <chihsheng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On kernels older than 6.5, bio-based block devices (such as dm, ram,
zram, and pmem) expose queue/scheduler with plain "none" (without
brackets). Kernels before 6.14 also output plain "none" for blk-mq
devices with BLK_MQ_F_NO_SCHED.

These cases were removed in kernel 6.5 (commit 6d85ebf95c44) and
kernel 6.14 (commit e7602bb4f3a1), but older kernels still fail the
test because TST_SYSFS_ASSERT_CHOICE() expects one bracketed token:

  TFAIL: /sys/block/dm-87/queue/scheduler has 0 selected tokens, expected exactly 1

Read queue/scheduler first and pass if the value is exact "none".
Keep TCONF when the file is missing, and use TST_SYSFS_ASSERT_CHOICE()
for all other values.

Fixes: f35242c9cc22 ("testcases: sysfs: Add sys_block_queue01")
Signed-off-by: Darren Chang <chihsheng@google.com>
---
 .../kernel/sysfs/block/sys_block_queue01.c    | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/sysfs/block/sys_block_queue01.c b/testcases/kernel/sysfs/block/sys_block_queue01.c
index 38564139a..ce1f945fd 100644
--- a/testcases/kernel/sysfs/block/sys_block_queue01.c
+++ b/testcases/kernel/sysfs/block/sys_block_queue01.c
@@ -16,7 +16,13 @@
  * - read_ahead_kb, nr_requests and discard_max_bytes are non-negative
  * - nr_requests is greater than zero
  * - rotational, add_random, iostats are boolean (0 or 1)
- * - scheduler is a valid bracketed-choice file with exactly one active scheduler
+ * - scheduler is a valid bracketed-choice file with exactly one active
+ *   scheduler, or plain ``none`` without brackets for devices that do not
+ *   support I/O schedulers (bio-based devices such as dm, ram, zram, pmem on
+ *   kernels prior to 6.5 before commit 6d85ebf95c44 "blk-sysfs: add a new
+ *   attr_group for blk_mq", and blk-mq queues with BLK_MQ_F_NO_SCHED prior to
+ *   6.14 before commit e7602bb4f3a1 "block: remove BLK_MQ_F_NO_SCHED", where
+ *   elv_iosched_show() emits "none\n")
  *
  * All checks skip gracefully with TCONF when a particular attribute is not
  * present, since the set of exported queue attributes differs between kernel
@@ -36,6 +42,31 @@ static const char *const sched_allowed[] = {
 	"kyber", "bfq", "anticipatory", NULL
 };
 
+static void check_scheduler(const char *dev)
+{
+	char sched[64];
+
+	if (!TST_SYSFS_READ_STR(sched, sizeof(sched),
+				PATH_SYS_BLOCK "/%s/queue/scheduler", dev)) {
+		tst_res(TCONF, PATH_SYS_BLOCK "/%s/queue/scheduler does not exist",
+			dev);
+		return;
+	}
+
+	/*
+	 * elv_iosched_show() emits plain "none\n" without brackets for queues
+	 * that do not support I/O schedulers (bio-based devices prior to 6.5,
+	 * and BLK_MQ_F_NO_SCHED devices prior to 6.14).
+	 */
+	if (!strcmp(sched, "none")) {
+		tst_res(TPASS, PATH_SYS_BLOCK "/%s/queue/scheduler = 'none'", dev);
+		return;
+	}
+
+	TST_SYSFS_ASSERT_CHOICE(sched_allowed, NULL, 0,
+				PATH_SYS_BLOCK "/%s/queue/scheduler", dev);
+}
+
 static void check_cross(const char *dev)
 {
 	TST_SYSFS_ASSERT_LE_SUFFIX("logical_block_size", "physical_block_size",
@@ -50,8 +81,6 @@ static void check_cross(const char *dev)
 
 static void check_device(const char *dev)
 {
-	char sched[64];
-
 	tst_res(TINFO, "Checking block device '%s'", dev);
 
 	TST_SYSFS_ASSERT_POW2(PATH_SYS_BLOCK "/%s/queue/logical_block_size", dev);
@@ -68,8 +97,7 @@ static void check_device(const char *dev)
 	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/queue/add_random", dev);
 	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/queue/iostats", dev);
 
-	TST_SYSFS_ASSERT_CHOICE(sched_allowed, sched, sizeof(sched),
-				PATH_SYS_BLOCK "/%s/queue/scheduler", dev);
+	check_scheduler(dev);
 
 	check_cross(dev);
 }
-- 
2.56.1.703.gf848ed807c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
