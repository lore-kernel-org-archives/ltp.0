Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683B7CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED83D3E6F9C
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 16:38:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E8753E6FE3
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:37:15 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B1F43601FF5
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:37:14 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so3120528f8f.1
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780929434; x=1781534234; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VpyMLKcXcUq75ksR1Gt4AdgQ+WsIolO10mFLTjIb0DM=;
 b=HkFGT3b2Jy21HMsGRDM17gZBhNW9EHJv9/G5mmfZS3a2OQA0RaYsrffrRvwt9ss5/L
 /xl37EmYuXMQ7YaJCnNuqIzOWlDNJibkL69f5WlO30+uIEiqnEEzbMUM36Ss4hFD5nxZ
 03tjKpDu3hQP7OwEspdOYcVJoOXm/OJ8pqCewcpAnCnP2hCauNyGaa5/4NrFCxyViCpN
 zd4scuLuDisflR+4gf57EwTuMr6PTZMuBfjsUM8Xzj30/NUNAfk6b2Q/qc851btryLwO
 ISdDFCFpySSAnk8xNvjXS0VpQ0OuVVU4V15RAq850aFVSaL4bvpFakVCMW6uSwLoQVPd
 MBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780929434; x=1781534234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VpyMLKcXcUq75ksR1Gt4AdgQ+WsIolO10mFLTjIb0DM=;
 b=DJtaleZXxtRhvILmH2ccfr7OksiN9yw+jk7FavZjgTzhBdjKfvEJNg0s8W872Wr746
 8Y3f94Zs55rd7Y+dTzQbCPdcjjXlXXdZNesZ4mDxQG1qQx/jm4ltxCeCMDotVewTZRfv
 ClzeWb2jekaePFkBEcPUz1R/2jg8jgOMpO12MZFUWR28nbDzRum0s10fI9NldB5pQjYP
 RpFTUhMCLm5nZ0IdZdfyMunXZQkyk25bG904RanFlofM50EtKvaqAMweTbOjhyFKUuHA
 GYguHTyaJUM0IBzVI/7r7pgaVVZWPRMNrZ/QklAEVDdsKmAHm7nw7qLD4jG40hp7wYOb
 jUEQ==
X-Gm-Message-State: AOJu0YwSlbc3rox2ZC/liJsSadNzmagmGYeXoQhavA1sLjV7HWrunxsg
 azvjsd0TjD0BZRMtDyvV9MBoshCjOAIb6ILIdNi+JVWBSoBubwPHEormep9qDA==
X-Gm-Gg: Acq92OEsVRBhkzI3C8xoCvcAGMbG317SfmizJmtx3tUDQTXGvAhVxyKnX2sLLOz9sje
 N68LMfNUKFDWNB6zvGIs09kY/teO1PMSTGWenMIYFj0el4tb6U8bOgnp09TIQLHukq7g54q3Ev8
 Ek/egeKlvM8Hj0eSZPdB9AMpHgwNThHUqzK85TFQQtsvn9J05Kf8TnwXrJ2Ec9BK1O+J6NrG6hZ
 T//qj7SNtp3nDkXD3woNrmiKaoL7L0M6Jd+13qlCtUR7UWHo8Ynl0g3cd1h2ENSS13vlqYt1woE
 oIttLzN6YK1RGC8Wq1cPSFnIlBhkMIjQVU2FUDPNQsfFHl+wY20ROb0/foQDlEQgPPv67w3j/wl
 CSF8OdmYyCcmIwRccMgiuswMVU6MPXBwEOGBnpXGCK0Ko0pjEXJ/8SqangWTUcpEJXGQAOmANKj
 77Ca23ifEs1tWJi8wnIQEeDvPmYc0CYqM5phRL61r6Cq/CvhMH7OUiTwawF+klRO8b8cu2C+8bP
 nGTsD20
X-Received: by 2002:a05:6000:25c4:b0:43d:7c6c:a0dd with SMTP id
 ffacd0b85a97d-460306226c3mr27391315f8f.35.1780929434019; 
 Mon, 08 Jun 2026 07:37:14 -0700 (PDT)
Received: from localhost.suse.org ([37.109.163.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm52180854f8f.21.2026.06.08.07.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:37:13 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 16:36:52 +0200
Message-ID: <20260608143652.6356-4-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260608143652.6356-1-sebastian.chlad@suse.com>
References: <20260608143652.6356-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] io_uring03: Update to use new io_uring_common.h
 helpers
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

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 .../kernel/syscalls/io_uring/io_uring03.c     | 77 +++++++++++++++----
 1 file changed, 60 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring03.c b/testcases/kernel/syscalls/io_uring/io_uring03.c
index 645c96b02..2d1672c6d 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring03.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring03.c
@@ -2,6 +2,9 @@
 /*
  * Copyright (C) 2026 IBM
  * Author: Sachin Sant <sachinp@linux.ibm.com>
+ *
+ * Copyright (C) 2026 Sebastian Chlad <sebastian.chlad@suse.com>
+ *
  */
 /*
  * Test IORING_OP_READ and IORING_OP_WRITE operations.
@@ -53,53 +56,93 @@ static void verify_data_integrity(const char *test_name)
 
 static void test_write_read(void)
 {
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
 	int fd;
 
 	init_buffer('A');
-
 	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
 
 	tst_res(TINFO, "Testing IORING_OP_WRITE");
-	io_uring_do_io_op(&s, fd, IORING_OP_WRITE, write_buf, BLOCK_SZ, 0,
-			  &sig);
+	sqe = io_uring_get_sqe(&s);
+	io_uring_prep_write(sqe, fd, write_buf, BLOCK_SZ, 0);
+	io_uring_sqe_set_data64(sqe, 1);
+	io_uring_submit(&s);
+
+	cqe = io_uring_wait_cqe(&s, &sig);
+	if (cqe->res != BLOCK_SZ)
+		tst_brk(TBROK, "IORING_OP_WRITE failed: res=%d", cqe->res);
+	tst_res(TPASS, "IORING_OP_WRITE: %d bytes written", cqe->res);
+	io_uring_cqe_seen(&s);
 
 	SAFE_FSYNC(fd);
 
 	tst_res(TINFO, "Testing IORING_OP_READ");
 	memset(read_buf, 0, BLOCK_SZ);
-	io_uring_do_io_op(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0,
-			  &sig);
+	sqe = io_uring_get_sqe(&s);
+	io_uring_prep_read(sqe, fd, read_buf, BLOCK_SZ, 0);
+	io_uring_sqe_set_data64(sqe, 2);
+	io_uring_submit(&s);
 
-	verify_data_integrity("Basic I/O");
+	cqe = io_uring_wait_cqe(&s, &sig);
+	if (cqe->res != BLOCK_SZ)
+		tst_brk(TBROK, "IORING_OP_READ failed: res=%d", cqe->res);
+	tst_res(TPASS, "IORING_OP_READ: %d bytes read", cqe->res);
+	io_uring_cqe_seen(&s);
 
+	verify_data_integrity("Basic I/O");
 	SAFE_CLOSE(fd);
 }
 
 static void test_partial_io(void)
 {
-	int fd;
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
 	size_t half = BLOCK_SZ / 2;
+	int fd;
 
 	tst_res(TINFO, "Testing partial I/O operations");
-
 	init_buffer('a');
-
 	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
 
-	io_uring_do_io_op(&s, fd, IORING_OP_WRITE, write_buf, half, 0,
-			  &sig);
-
-	io_uring_do_io_op(&s, fd, IORING_OP_WRITE, write_buf + half, half,
-			  half, &sig);
+	sqe = io_uring_get_sqe(&s);
+	io_uring_prep_write(sqe, fd, write_buf, half, 0);
+	io_uring_sqe_set_data64(sqe, 1);
+	io_uring_submit(&s);
+
+	cqe = io_uring_wait_cqe(&s, &sig);
+	if (cqe->res != (int)half)
+		tst_brk(TBROK, "IORING_OP_WRITE failed: res=%d", cqe->res);
+	tst_res(TPASS, "IORING_OP_WRITE: %d bytes written at offset 0", cqe->res);
+	io_uring_cqe_seen(&s);
+
+	sqe = io_uring_get_sqe(&s);
+	io_uring_prep_write(sqe, fd, write_buf + half, half, half);
+	io_uring_sqe_set_data64(sqe, 2);
+	io_uring_submit(&s);
+
+	cqe = io_uring_wait_cqe(&s, &sig);
+	if (cqe->res != (int)half)
+		tst_brk(TBROK, "IORING_OP_WRITE failed: res=%d", cqe->res);
+	tst_res(TPASS, "IORING_OP_WRITE: %d bytes written at offset %zu",
+		cqe->res, half);
+	io_uring_cqe_seen(&s);
 
 	SAFE_FSYNC(fd);
 
 	memset(read_buf, 0, BLOCK_SZ);
-	io_uring_do_io_op(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0,
-			  &sig);
+	sqe = io_uring_get_sqe(&s);
+	io_uring_prep_read(sqe, fd, read_buf, BLOCK_SZ, 0);
+	io_uring_sqe_set_data64(sqe, 3);
+	io_uring_submit(&s);
 
-	verify_data_integrity("Partial I/O");
+	cqe = io_uring_wait_cqe(&s, &sig);
+	if (cqe->res != BLOCK_SZ)
+		tst_brk(TBROK, "IORING_OP_READ failed: res=%d", cqe->res);
+	tst_res(TPASS, "IORING_OP_READ: %d bytes read", cqe->res);
+	io_uring_cqe_seen(&s);
 
+	verify_data_integrity("Partial I/O");
 	SAFE_CLOSE(fd);
 }
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
