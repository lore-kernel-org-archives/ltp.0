Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4284CA5FDD
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 01:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791078889; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=GAEHljUk6r1pEHLFTD9IaHYX30LBiuzbEtvSvsdeMg4=;
 b=iFszUy0QjYx5A1ZB/voqUHxpmy42ZWsE92QgX3RdZ34+bdxTZEZN3AjeijKQjCFkSQuyE
 eaoG8+h2EeJOaNse03gVGnw6Yvr6lVL2iEnYzJUwQv2DcYF3Ugp2Wh5veRSNcigfFaTRyPa
 FRm2AVC89hJuqeMzBwnj9xs9pqifX10=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3C1A3E6B7A
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 03:54:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 837723E27FD
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 03:54:29 +0200 (CEST)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com
 [IPv6:2607:f8b0:4864:20::1048])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F3013100014B
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 03:54:28 +0200 (CEST)
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-395543dc382so562296a91.0
 for <ltp@lists.linux.it>; Sat, 03 Oct 2026 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791078867; x=1791683667; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O3lQcR/fw2UMTQnOnWmzZKnvw0sPJLGVA/1rcZmu/mI=;
 b=CLy8pVT00JbFgQzfv3CtQqGnVyuzbxI62dHlSsDBrB3SJLnmeoEPEmHqJ2A8U2Vjbl
 AQPBSGX1tnkB+BYdAmELA8oDTIPxdna03SqRnYNXV2tGxflQJ6/8iJAb6GJabuKAYO3B
 h+4y7BDMMqNr3rmtoxw8rx9QFZ8WEix9hFI0IqQc66DXegqWs+MISqUgK3JGrGu1mWtC
 kD1j8AsWdFBj/eZf5p8kgoJ7I2Ep5kvhYtlvsJhSFlt8F5RjxSFhRxWfTpbaknYOd3fo
 VCCgtrz436AE9XxQX1l94RyHoJFWwOSZZ9OtxAM77fLxAahe20KWmpgXcZQMmyoir+xw
 U7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791078867; x=1791683667;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O3lQcR/fw2UMTQnOnWmzZKnvw0sPJLGVA/1rcZmu/mI=;
 b=YV6G6Itb4r7i3Xv7nZSnKc7kCLbf7Xo51wh3mOLKGXAGBFMfLO/vARnHEvE5114XKG
 mDkL2ziotOZI5JAWGN1HlblT7DPhdi6LRSQv+o0vzKoRGmUogrE4wopY6s//v9HrbvtF
 l1PJmXmC0aqs+S6cr/5O7yzIK5p5NWx+LMKY5W8TzdcYCsL0S6BsDZm/WgaMwbCpIfd3
 sIqzbMUJ5XCH1f4ZYT4xSNHH2CJ9HdZDHQSFRp8WUoHuf+SV7XVOSLCSc0qvd1PjhslA
 7SFZ1ft/hYlbw3UsJy+0mketz8x3GBXilH0+Shon8zWMSwROYPQjRBDVotca1HZXMsyB
 XGcg==
X-Gm-Message-State: AFq9FYJ+rHRgXWxCrBcoyWK174TgoVcjSmc7ongtPxB2ZlQAofh/uThF
 sBK0CUGLBNy+wV1iVwqXRpw7FoxyxyONRTTuarRpcdaf0DXMQPi3a2y0BNnxPgGl2x69ZMMxrjq
 vMsUhzRh2y928jsObkJkIIUa83bimydZanhq8MNCJiaaB3dCifmhz3jsyrE3oHK+5xAahBQJpQI
 gfJLjd+HVX/zva855vYkpzqs03bQ==
X-Received: from plme2.prod.google.com ([2002:a17:903:4902:b0:2e1:2414:b08c])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce8e:b0:2e3:1bb4:610f
 with SMTP id d9443c01a7336-2e49b694cd5mr62315935ad.71.1791078866955; Sat, 03
 Oct 2026 18:54:26 -0700 (PDT)
Date: Sun,  4 Oct 2026 01:54:24 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261004015424.3821821-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sched_{set,
 get}attr: Call the syscalls via tst_syscall()
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

From: Wake Liu <wakel@google.com>

The sched_setattr01, sched_setattr02, sched_getattr01 and
sched_getattr02 tests call sched_setattr() and sched_getattr().
Depending on the libc, these names resolve either to the lapi fallback
wrappers or to the libc functions.

On Bionic, sched_setattr() and sched_getattr() were added in API level
37. When LTP is built against such headers, the test binaries link
against the libc symbols. They then fail to start on devices with an
older libc:

  CANNOT LINK EXECUTABLE "sched_setattr01": cannot locate symbol
  "sched_setattr"

These are syscall tests, so call the syscalls directly through
tst_syscall(), as SAFE_SCHED_SETATTR() already does. This makes the
tests independent of libc support, and tst_syscall() reports TCONF if
the kernel lacks the syscalls. As a bonus, the negative tests no longer
pass NULL to the libc wrappers, whose attr parameter is declared
nonnull by glibc and Bionic.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/sched_getattr/sched_getattr01.c | 3 ++-
 testcases/kernel/syscalls/sched_getattr/sched_getattr02.c | 7 ++++---
 testcases/kernel/syscalls/sched_setattr/sched_setattr01.c | 5 +++--
 testcases/kernel/syscalls/sched_setattr/sched_setattr02.c | 3 ++-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
index bd05164ca..2f3bd4a9c 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
@@ -51,7 +51,8 @@ static void run(void)
 
 	memset((void *)read_attr, 0, sizeof(*read_attr));
 
-	TST_EXP_PASS(sched_getattr(0, read_attr, sizeof(*read_attr), 0),
+	TST_EXP_PASS(tst_syscall(__NR_sched_getattr, 0, read_attr,
+				 sizeof(*read_attr), 0),
 		     "sched_getattr() with valid parameters");
 	if (!TST_PASS)
 		return;
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
index e2c0bf43b..a70b8ac5c 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -40,9 +40,10 @@ static void verify_sched_getattr(unsigned int n)
 {
 	struct test_case *tc = &tcase[n];
 
-	TST_EXP_FAIL(sched_getattr(*(tc->pid), tc->attr, tc->size, tc->flags),
-				 tc->exp_errno, "sched_getattr(%d, ..., %d, %d)", *tc->pid,
-				 tc->size, tc->flags);
+	TST_EXP_FAIL(tst_syscall(__NR_sched_getattr, *tc->pid, tc->attr,
+				 tc->size, tc->flags),
+		     tc->exp_errno, "sched_getattr(%d, ..., %d, %d)",
+		     *tc->pid, tc->size, tc->flags);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
index 93e532774..b1fe93735 100644
--- a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
+++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
@@ -51,12 +51,13 @@ static void run(void)
 {
 	struct sched_attr read_attr = { .size = sizeof(read_attr) };
 
-	TST_EXP_PASS(sched_setattr(0, &attr, 0),
+	TST_EXP_PASS(tst_syscall(__NR_sched_setattr, 0, &attr, 0),
 		     "sched_setattr() with valid parameters");
 	if (!TST_PASS)
 		return;
 
-	if (sched_getattr(0, &read_attr, sizeof(read_attr), 0) == -1) {
+	if (tst_syscall(__NR_sched_getattr, 0, &read_attr,
+			sizeof(read_attr), 0) == -1) {
 		tst_res(TFAIL | TERRNO, "sched_getattr() failed");
 		return;
 	}
diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr02.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr02.c
index 9f1ccfcd0..462f182a5 100644
--- a/testcases/kernel/syscalls/sched_setattr/sched_setattr02.c
+++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr02.c
@@ -123,7 +123,8 @@ static void verify_sched_setattr(unsigned int n)
 	 */
 	attr_small.size = SCHED_ATTR_SIZE_VER0 - 1;
 
-	TST_EXP_FAIL(sched_setattr(pid, target_attr, tc->flags),
+	TST_EXP_FAIL(tst_syscall(__NR_sched_setattr, pid, target_attr,
+				 tc->flags),
 		     tc->exp_errno, "%s", tc->desc);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
