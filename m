Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815D8CD98C5
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 17:49:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 126FF3E11C6
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 19:49:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C13083E5E33
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 19:48:11 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0CC9F6005D4
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 19:48:11 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso1268011f8f.2
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781459290; x=1782064090; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGumoRl36VfsotZ0CoPAkAmVWcE1+CELhEjVTzdAgRk=;
 b=iyXcobP0KwkdqeOiKTxSRxXxZqPJFbbO/WXqAkKbKhlLX8QyUhiE++AslgKs6QEtvF
 exAoo5C7gsmMVML0T1CKewOEbJPyTpAZ7nC2aw1PJD23ZkozVGkq1rhR0uIZT4Qo6SmJ
 7BkMBQyIXRs/BNmghwv/0a5TgpswKzdcFDShACkn35djUCsddc+N+Y2UMRGDCpww9kMG
 se6i19GHHg6Mu4DjFIMDOQaDRGOChEuN2JG/q+cQwAzGfohXuGZxdkovzVpuD/2h4vJH
 ngSmRPq0t+wsNqOuCfFjo/MZCAb+7LN0rK0YmnD/Bai4S/sSr8qvZ9nWSSndwOfNEmBv
 Hzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781459290; x=1782064090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eGumoRl36VfsotZ0CoPAkAmVWcE1+CELhEjVTzdAgRk=;
 b=EmWtStv+DYX9/5cpWNKQmF9mYxO0FNqJsJz3m8B19wzF01hfie3J/hmNlY1Ltv796t
 qYgRzgOSH9a0HRpvsNwIyp0vGutirF1CSZQPxyTvmYRcla7Q4AjP3zzc+4C2DDWA5UVm
 TkuA59keTPSV5XE3vNsOrkNrt2TPN/5NhCR9YQE4rlSrF5nRk56EJXZ2TXRR5mnnGJuG
 3ICzPiDNLna/zryfnMWR6vFGY+S2HWbb2KrO9l43xKS5uc9z0NDuPSgx38IjYG5Kyi7P
 ksw7qaF2BFNgrT3GSX+uq8X2HOFfkOOAjrjk2Nra8chaaL5U5iY+cL9Ref4eAJAu/vPk
 nbWg==
X-Gm-Message-State: AOJu0YzOKE0Hq8wUs5WDl95AaFHEgczVYNf63wRfy8L/Mu18v5k3yooP
 Yspk5sDV3QPjAPvnYkC2B05TszsH3Xfr9krwE0EweCiIBwmQlfDQB9yk6vzW7Q==
X-Gm-Gg: Acq92OEIU73u7PFPT0lBYpYgYK3QFW3FPoyneohZQyTEDkbSyJ/fCrtztp0C/doJL3D
 XPGnQSgB4dY8oZBhJFpMNiP3g6wS6aYOV12+srXyOpnZxDXXtW6Ld03Z5BVjSsr4mI6mPkBAqaD
 7E9Z/I9oe6E9TUGE/9bqGvwYpKmTeIIoPRmSg28zLrLo7omJ5i99Zfgl02kTAzMrrfP5TlUIMYC
 QaDRY3j87BqUjO1I64kJ3+jhi8aAtDVcwYzUiWOQQe1LjeWx9nyGbKiFO8ObVpzAWnr/cnZeHVh
 7MbAm2Kb2jXt8bJyC66gvCqzyHieg3Ueb/D5Fyax/z4Mcr0hCizr+cQbDzGyLdOsodFbzdGkWdL
 SxdzJ5dciIbY9DpFWGo3g3eWx6jvvb3l4kDqDVHXPX8dfmnSTMCxsmsESjvMTpMEVIOuLkEVZVf
 qhu7gwByf/h3xfTien1ebuTvzOnUmvvHx3CRL01sn0kiSqbozGH1RzXt/DlbBqFR3Cu6XJ1aGEP
 gihp0Ue/bmHeFF7rD3l7Zol
X-Received: by 2002:a05:6000:43d6:10b0:44b:5398:4e85 with SMTP id
 ffacd0b85a97d-4606db9839emr11194167f8f.22.1781459290292; 
 Sun, 14 Jun 2026 10:48:10 -0700 (PDT)
Received: from localhost (apn-78-30-82-184.dynamic.gprs.plus.pl.
 [78.30.82.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2637ccsm26318980f8f.6.2026.06.14.10.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 10:48:09 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Sun, 14 Jun 2026 19:47:59 +0200
Message-ID: <20260614174759.24546-4-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260614174759.24546-1-sebastian.chlad@suse.com>
References: <20260614174759.24546-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] io_uring: Remove deprecated helpers
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

The old io_uring_do_io_op() and io_uring_do_vec_io_op() helpers are
removed. They coupled SQE submission with an immediate CQE wait, making
tests effectively synchronous, and emitted tst_res(TPASS) from inside
the helper, hiding where test results came from. They also set user_data
to the opcode value, which is meaningless as a per-request tag and would
cause spurious passes in any test with multiple in-flight SQEs of the
same opcode.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 .../syscalls/io_uring/io_uring_common.h       | 168 +-----------------
 1 file changed, 4 insertions(+), 164 deletions(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
index 8ff024e5f..ae0fff432 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring_common.h
+++ b/testcases/kernel/syscalls/io_uring/io_uring_common.h
@@ -18,6 +18,7 @@
 #include "tst_test.h"
 #include "lapi/io_uring.h"
 
+/* Common structures for io_uring ring management */
 struct io_sq_ring {
 	unsigned int *head;
 	unsigned int *tail;
@@ -118,165 +119,6 @@ static inline void io_uring_cleanup_queue(struct io_uring_submit *s,
 		SAFE_CLOSE(s->ring_fd);
 }
 
-/*
- * Internal helper to submit a single SQE to the submission queue
- * Used by both vectored and non-vectored I/O operations
- */
-static inline void io_uring_submit_sqe_internal(struct io_uring_submit *s,
-						int fd, int opcode,
-						unsigned long addr,
-						unsigned int len,
-						off_t offset,
-						unsigned long long user_data)
-{
-	struct io_sq_ring *sring = &s->sq_ring;
-	unsigned int tail, index;
-	struct io_uring_sqe *sqe;
-
-	tail = *sring->tail;
-	index = tail & *sring->ring_mask;
-	sqe = &s->sqes[index];
-
-	memset(sqe, 0, sizeof(*sqe));
-	sqe->opcode = opcode;
-	sqe->fd = fd;
-	sqe->addr = addr;
-	sqe->len = len;
-	sqe->off = offset;
-	sqe->user_data = user_data;
-
-	sring->array[index] = index;
-	tail++;
-
-	*sring->tail = tail;
-}
-
-/*
- * Submit a single SQE to the submission queue
- * For basic read/write operations (non-vectored)
- */
-static inline void io_uring_submit_sqe(struct io_uring_submit *s, int fd,
-				       int opcode, void *buf, size_t len,
-				       off_t offset)
-{
-	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)buf,
-				     len, offset, opcode);
-}
-
-/*
- * Submit a vectored SQE to the submission queue
- * For readv/writev operations
- */
-static inline void io_uring_submit_sqe_vec(struct io_uring_submit *s, int fd,
-					   int opcode, struct iovec *iovs,
-					   int nr_vecs, off_t offset)
-{
-	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)iovs,
-				     nr_vecs, offset, opcode);
-}
-
-/*
- * Map io_uring operation code to human-readable name
- */
-static inline const char *ioring_op_name(int op)
-{
-	switch (op) {
-	case IORING_OP_READV:
-		return "IORING_OP_READV";
-	case IORING_OP_WRITEV:
-		return "IORING_OP_WRITEV";
-	case IORING_OP_READ:
-		return "IORING_OP_READ";
-	case IORING_OP_WRITE:
-		return "IORING_OP_WRITE";
-	default:
-		return "UNKNOWN";
-	}
-}
-
-/*
- * Wait for and validate a completion queue entry
- * Aborts test on failure using tst_brk()
- */
-static inline void io_uring_wait_cqe(struct io_uring_submit *s,
-				     int expected_res, int expected_opcode,
-				     sigset_t *sig)
-{
-	struct io_cq_ring *cring = &s->cq_ring;
-	struct io_uring_cqe *cqe;
-	unsigned int head;
-	int ret;
-
-	ret = io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, sig);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "io_uring_enter() failed");
-
-	head = *cring->head;
-	if (head == *cring->tail)
-		tst_brk(TBROK, "No completion event received");
-
-	cqe = &cring->cqes[head & *cring->ring_mask];
-
-	if (cqe->user_data != (uint64_t)expected_opcode) {
-		*cring->head = head + 1;
-		tst_brk(TBROK, "Unexpected user_data: got %llu, expected %d",
-			(unsigned long long)cqe->user_data, expected_opcode);
-	}
-
-	if (cqe->res != expected_res) {
-		*cring->head = head + 1;
-		tst_brk(TBROK, "Operation failed: res=%d, expected=%d",
-			cqe->res, expected_res);
-	}
-
-	*cring->head = head + 1;
-}
-
-/*
- * Initialize buffer with a repeating character pattern
- * Useful for creating test data with predictable patterns
- */
-static inline void io_uring_init_buffer_pattern(char *buf, size_t size,
-						char pattern)
-{
-	size_t i;
-
-	for (i = 0; i < size; i++)
-		buf[i] = pattern;
-}
-
-/*
- * Submit and wait for a non-vectored I/O operation
- * Combines io_uring_submit_sqe() and io_uring_wait_cqe() with result reporting
- */
-static inline void io_uring_do_io_op(struct io_uring_submit *s, int fd,
-				     int op, void *buf, size_t len,
-				     off_t offset, sigset_t *sig)
-{
-	io_uring_submit_sqe(s, fd, op, buf, len, offset);
-	io_uring_wait_cqe(s, len, op, sig);
-	tst_res(TPASS, "OP=%s (%02x) fd=%i buf=%p len=%zu offset=%jd",
-		ioring_op_name(op), op, fd, buf, len, (intmax_t)offset);
-}
-
-/*
- * Submit and wait for a vectored I/O operation
- * Combines io_uring_submit_sqe_vec() and io_uring_wait_cqe() with
- * result reporting
- */
-static inline void io_uring_do_vec_io_op(struct io_uring_submit *s, int fd,
-					 int op, struct iovec *iovs,
-					 int nvecs, off_t offset,
-					 int expected_size, sigset_t *sig)
-{
-	io_uring_submit_sqe_vec(s, fd, op, iovs, nvecs, offset);
-	io_uring_wait_cqe(s, expected_size, op, sig);
-	tst_res(TPASS, "OP=%s (%02x) fd=%i iovs=%p nvecs=%i offset=%jd "
-		"expected_size=%i",
-		ioring_op_name(op), op, fd, iovs, nvecs, (intmax_t)offset,
-		expected_size);
-}
-
 /*
  * Get the next available SQE slot from the submission ring.
  * The SQE is zeroed and tracked as pending until io_uring_submit() is called.
@@ -352,12 +194,12 @@ static inline void io_uring_sqe_set_data64(struct io_uring_sqe *sqe,
 static inline void io_uring_submit(struct io_uring_submit *s)
 {
 	unsigned int pending = s->sq_pending;
+	unsigned int tail;
 
 	if (!pending)
 		return;
 
-	unsigned int tail = *s->sq_ring.tail + pending;
-
+	tail = *s->sq_ring.tail + pending;
 	__atomic_store(s->sq_ring.tail, &tail, __ATOMIC_RELEASE);
 	s->sq_pending = 0;
 
@@ -373,14 +215,13 @@ static inline struct io_uring_cqe *io_uring_cqe_wait(struct io_uring_submit *s,
 						      sigset_t *sig)
 {
 	struct io_cq_ring *cring = &s->cq_ring;
+	unsigned int cq_tail;
 	int ret;
 
 	ret = io_uring_enter(s->ring_fd, 0, 1, IORING_ENTER_GETEVENTS, sig);
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "io_uring_enter() failed");
 
-	unsigned int cq_tail;
-
 	__atomic_load(cring->tail, &cq_tail, __ATOMIC_ACQUIRE);
 	if (*cring->head == cq_tail)
 		tst_brk(TBROK, "No completion event received");
@@ -398,5 +239,4 @@ static inline void io_uring_cqe_seen(struct io_uring_submit *s)
 	__atomic_store(s->cq_ring.head, &head, __ATOMIC_RELEASE);
 }
 
-
 #endif /* IO_URING_COMMON_H */
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
