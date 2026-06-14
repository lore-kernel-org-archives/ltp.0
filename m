Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FD9CD98C5
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 17:48:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 401F13E5E02
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 19:48:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2EF43E5E25
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 19:48:09 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3723E60062C
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 19:48:09 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so1566502f8f.0
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781459288; x=1782064088; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIMtsK5YuuyorIyrt30vjxd/+S2toIJvZsi7n8NCnnw=;
 b=dImdpLVY1D6h6VhSZXeovOA0R1o74WanR0NUCBLFF8x63wdpt+YSG0GuQUIo9fpzwy
 PmhM0dELYBWu0ERvtyDKFaABfRdET9j1S5vGlhadm88bHZXUZ37sjs0hfGMxUCeBKkDg
 hkdM48NXKwoa2TXT3q1pNTCCz0HZvrZgYlbhd8Y1KP3nSXi9xWUILfpsRx9yLM3EbizI
 5JGGJehF8XMq39kMAuJz4m9EDl1VlY+nC0TtSqMTcK2W6qEUWXRNcaQcujnMjk9s6EuS
 8htDk8pb5mRAc0QfPyNiqJ+eikH8gPinNrYSYfH12Ekf8JOrBwjdG4e36w/eB6KYNyBG
 sZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781459288; x=1782064088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nIMtsK5YuuyorIyrt30vjxd/+S2toIJvZsi7n8NCnnw=;
 b=YxM/CxN0zN7OrVL2kysnpLedrD8FdyhZFnih4h3y1LD8RQVeNCrTDP4seRdkIxW7ho
 xmjKwFCMdpHcqPY4VwPWuKvvAVkrovqb/VDrZo08sCl42GX9/ng8jOqyt87AFic1PnwL
 os1fhjhQpOhYewhmYLkVZ+XGJ/RF2Lpn0Of48KgdrnmgQmxvLKPQ+KHjSbnQRhFiQafz
 XiiSbuoxh2Q7Rp9Us/Rmxb0EiOVpuIWNNc9fObpu52/QlqScmKxnR0cKp0/vHMqof8Di
 lnK82dmDBP55XPCak2fOjrpw8a13Ls3BYhkio3iujHo0RByFrkw0XdluK1FYnZjdanla
 stJg==
X-Gm-Message-State: AOJu0YyG9QuWm9ejyZyTEUMqfSbLAPZBhiYCD/2c/UtvPX5JwUZjJIty
 ttlnZU6dE2gExEp2oQoyl9Rkvll/WliMmp7QcEA+1prOGlNFYljkRyD7PHBjBg==
X-Gm-Gg: Acq92OGNwe2ZgH93Yg118spANnk6Ro2g8grI4CrtwlL4FnqNmlskZuMtd7ap5roYGjK
 ttgbFz3a5XlpJyFvEBd5wBb777QToHDWPOQ2ymIZOKMjz9WoKn6QAf/4EC3vpHS+o6EL23PBI94
 UACkPngpwplkj35YeGdMTiPw1FgF6zWw69btPQLAAP1r3CVW1AwHBU+7KJGn3PWZYfIUO0gYqDs
 5hXn/duIG5Ew7fQ1af1a4L2KQ2eQ533OJm9fRyAwSPCd5VecK1RpzajNkvdLyH7mLWWUK5vxIrm
 kVk8mSbdKZjIHu6IZcAXx2tWOH63tRlT+ENIFJta034Hc4z0hI9g4XYtOd3cbHQ9YtSULyk3vMc
 amNS9eQrA/oLcJ1xU93HDi6kMzlLCpEd1wzb+AxV7qF2jqN/kw0Ih6ts2F0bA6Xwvu2BfHxPvFz
 Lmc/6YtgbGSMu7jfzlRjvo7XkbVNCecnO3kYuH4oaZRIArXRnlOcU5beD4IgChXiBYp3PXvt5xY
 kUnJVKHYji2ZmM6Drlwof6v
X-Received: by 2002:a5d:5d13:0:b0:460:e2e:6e2b with SMTP id
 ffacd0b85a97d-46074a8a1b7mr10323146f8f.20.1781459288571; 
 Sun, 14 Jun 2026 10:48:08 -0700 (PDT)
Received: from localhost (apn-78-30-82-184.dynamic.gprs.plus.pl.
 [78.30.82.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2637ccsm26318980f8f.6.2026.06.14.10.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 10:48:08 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Sun, 14 Jun 2026 19:47:58 +0200
Message-ID: <20260614174759.24546-3-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260614174759.24546-1-sebastian.chlad@suse.com>
References: <20260614174759.24546-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] io_uring03: Update to use new
 io_uring_common.h helpers
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
index d3b9cff82..521ec0942 100644
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
+	cqe = io_uring_cqe_wait(&s, &sig);
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
+	cqe = io_uring_cqe_wait(&s, &sig);
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
+	cqe = io_uring_cqe_wait(&s, &sig);
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
+	cqe = io_uring_cqe_wait(&s, &sig);
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
+	cqe = io_uring_cqe_wait(&s, &sig);
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
