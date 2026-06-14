Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E5CCD98C5
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 17:48:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EBF23E2A86
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 19:48:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8B713E5E2A
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 19:48:08 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CAEB410000EE
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 19:48:07 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so2076299f8f.0
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781459287; x=1782064087; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3nRB6hJgTvF8fMINKyyZo0glDuuPT8eI4fAgLjggQg=;
 b=beZgKSjIdQaL0YZ9HASVvZR3MiyFUaZRyEbzxSBAZ3BCoNhIQlMpH00DjH7Wj0ZbVz
 ObuXRTg4vvelAUpWbi87l0wSnEAYdYmDz0gijf9Q4ZWYAPW6akyURL/9yklwE9R9j9yQ
 jgMZIGIAfMWDLMjUJ/CM2XRB6vb38DQRVAfJIjjvUQxUwvupWPHDx61DEx/OJPmiztAe
 zOHdSaT5Ruu2Mi5XjxEhhUaOTyU6YRf7MBKQ1UFz4Y/rJKPPeisNm0kDrZX2dzJMdXXT
 VYe13rj/pSwppPOu18zvud5/di/aUxxsFcFze+bOvTDvibVven/UcXxb1dug0+I3GaM7
 EgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781459287; x=1782064087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g3nRB6hJgTvF8fMINKyyZo0glDuuPT8eI4fAgLjggQg=;
 b=VULOxVt9N7O703Fx6FNI6BYofo5Z4qcpxDp8dl/YwRzdvP305p1uUhBuJywMoIDzsi
 3YoEW8XhDQYI5uRX0ltEiUi6Iiwi2exI0YhZ/Y/oRpbmfIAaAm96x+5TDkPq/QtQMLz9
 aPQ0nu+G4rDkXer2SZKXLZRaEdcYzV4YLhQj/ZYU+WdterzPx+rNAKgkH8I2E3a4e4s2
 xxz+a+qlNAwA4YEV5+kX+QqAB3FEAE/ybK4xkkP20b0IgcnZvbARoW5G2sKV+F18YJK7
 KXy17lgpF6lIS9ppCr6Xpy12fg2NYTxnVdzSB1zbcoHkty4mMCVKqKi6mlIAjB5CphBQ
 ibTg==
X-Gm-Message-State: AOJu0Yz1SYgV5q3dkVVJLGNU0n2w4a34wmjj9Yp4U/udM+LLkAiofGOD
 NLGhzJiff8NTOcv3xU63aEFzCj6l0R7me/zaV/w053TmwTDAUVx4nZy0lbtqhQ==
X-Gm-Gg: Acq92OESzGdUhBxpSYgO+2xjYyJcQjL0yI3ywT/U8Bbjpg4o8crghptcC3jlvgt9ls+
 99f55DrwoOXsR+3o7t/E0H6yTdtedva3pL7/Yx4hDE6YZnEJSP2E3fy+2uMptuEqZMhEStRjwE1
 /AYPdn0MO95krmuGZKrw8BQ4mwdNl/83V+Y+XyV6ryown8I9z384Jzil1BqDchpi28XK1WyBSwV
 xPqcfjWg9GWSrD3T9I6tx6emQmpw9XbQaOVTkzpySvhDBjcBsl4DlCbRHIGeb9Z2dd2HSXUBAdx
 hToYbj27BEe6r9FeYayTbYXZGA2isnDveg2ChZqOzKEj3AGfqhFlGXYGXbbXMdulF78hIqLiH5S
 MIwt/bJX2LVOQyj0UG/8P6xtJ4p5qa8+PEUdcThtZ8xRXfvdpHuJGPCv7nmdSS/RM70e664xaL0
 v/5nM+QraJL1Tre9u0QLvHDiVz3KT4MSBtMmFzdCzZY6qY9/mTmqepQhnpPaa24bAv9Aa+Zbx35
 JN5G2bxI39rwPGoW8gszAxQ
X-Received: by 2002:a05:6000:4024:b0:43d:1c21:ead5 with SMTP id
 ffacd0b85a97d-4606dbdf9bcmr16369845f8f.22.1781459286952; 
 Sun, 14 Jun 2026 10:48:06 -0700 (PDT)
Received: from localhost (apn-78-30-82-184.dynamic.gprs.plus.pl.
 [78.30.82.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2637ccsm26318980f8f.6.2026.06.14.10.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 10:48:06 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Sun, 14 Jun 2026 19:47:57 +0200
Message-ID: <20260614174759.24546-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260614174759.24546-1-sebastian.chlad@suse.com>
References: <20260614174759.24546-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] io_uring01: Update to use new
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
 .../kernel/syscalls/io_uring/io_uring01.c     | 64 ++++++++-----------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
index 1d2029fdf..d9dac8c10 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring01.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
@@ -5,11 +5,14 @@
  *
  * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
  *
+ * Copyright (C) 2026 Sebastian Chlad <sebastian.chlad@suse.com>
+ *
  * Tests for asynchronous I/O raw API i.e io_uring_setup(), io_uring_register()
- * and io_uring_enter(). This tests validate basic API operation by creating a
+ * and io_uring_enter(). This test validates basic API operation by creating a
  * submission queue and a completion queue using io_uring_setup(). User buffer
  * registered in the kernel for long term operation using io_uring_register().
- * This tests initiates I/O operations with the help of io_uring_enter().
+ * This test initiates I/O operations using io_uring_submit() and
+ * io_uring_cqe_wait() helpers built on top of io_uring_enter().
  */
 #include "io_uring_common.h"
 
@@ -27,7 +30,6 @@ static struct tcase {
 };
 
 static struct io_uring_submit s;
-static sigset_t sig;
 static struct iovec *iov;
 
 static int setup_io_uring_test(struct io_uring_submit *s, struct tcase *tc)
@@ -58,72 +60,58 @@ static void check_buffer(char *buffer, size_t len)
 
 static void drain_uring_cq(struct io_uring_submit *s, unsigned int exp_events)
 {
-	struct io_cq_ring *cring = &s->cq_ring;
-	unsigned int head = *cring->head;
 	unsigned int events = 0;
+	struct io_uring_cqe *cqe;
+	struct iovec *iovecs;
 
-	for (head = *cring->head; head != *cring->tail; head++) {
-		struct io_uring_cqe *cqe = &cring->cqes[head & *s->cq_ring.ring_mask];
-
+	while (events < exp_events) {
+		cqe = io_uring_cqe_wait(s, NULL);
 		events++;
 
 		if (cqe->res < 0) {
 			tst_res(TFAIL, "CQE result %s", tst_strerrno(-cqe->res));
 		} else {
-			struct iovec *iovecs = (void*)cqe->user_data;
+			iovecs = (void *)cqe->user_data;
 
 			if (cqe->res == BLOCK_SZ)
 				tst_res(TPASS, "CQE result %i", cqe->res);
 			else
-				tst_res(TFAIL, "CQE result %i expected %i", cqe->res, BLOCK_SZ);
+				tst_res(TFAIL, "CQE result %i expected %i",
+					cqe->res, BLOCK_SZ);
 
 			check_buffer(iovecs[0].iov_base, cqe->res);
 		}
-	}
 
-	*cring->head = head;
-
-	if (exp_events == events) {
-		tst_res(TPASS, "Got %u completion events", events);
-		return;
+		io_uring_cqe_seen(s);
 	}
 
-	tst_res(TFAIL, "Got %u completion events expected %u",
-	        events, exp_events);
+	if (exp_events == events)
+		tst_res(TPASS, "Got %u completion events", events);
+	else
+		tst_res(TFAIL, "Got %u completion events expected %u",
+			events, exp_events);
 }
 
 static int submit_to_uring_sq(struct io_uring_submit *s, struct tcase *tc)
 {
-	int ret;
+	struct io_uring_sqe *sqe;
 	int fd;
 
 	memset(iov->iov_base, 0, iov->iov_len);
 
-	ret = io_uring_register(s->ring_fd, tc->register_opcode,
-				iov, QUEUE_DEPTH);
-	if (ret == 0) {
-		tst_res(TPASS, "io_uring_register() passed");
-	} else {
+	if (io_uring_register(s->ring_fd, tc->register_opcode,
+			      iov, QUEUE_DEPTH)) {
 		tst_res(TFAIL | TERRNO, "io_uring_register() failed");
 		return 1;
 	}
+	tst_res(TPASS, "io_uring_register() passed");
 
 	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
 
-	/* Submit SQE using common helper */
-	io_uring_submit_sqe_internal(s, fd, tc->enter_flags,
-				     (unsigned long)iov->iov_base,
-				     BLOCK_SZ, 0,
-				     (unsigned long long)iov);
-
-	ret = io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, &sig);
-	if (ret == 1) {
-		tst_res(TPASS, "io_uring_enter() waited for 1 event");
-	} else {
-		tst_res(TFAIL | TERRNO, "io_uring_enter() returned %i", ret);
-		SAFE_CLOSE(fd);
-		return 1;
-	}
+	sqe = io_uring_get_sqe(s);
+	io_uring_prep_rw(sqe, tc->enter_flags, fd, iov->iov_base, BLOCK_SZ, 0);
+	io_uring_sqe_set_data64(sqe, (uint64_t)iov);
+	io_uring_submit(s);
 
 	SAFE_CLOSE(fd);
 	return 0;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
