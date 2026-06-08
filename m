Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCD8CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CECD33E6F93
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 16:37:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0777F3E6F9E
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:37:11 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4ABE6200910
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:37:11 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-46019edc13dso2037690f8f.1
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780929431; x=1781534231; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dY2yEoggKWKuvljI7PNrl6wqIgvY5VG/EBmpZKzBraU=;
 b=nJ81QDkP6G729OPQ2/Is+PgHLTMSjHeBG7uTWcSexbpdRzopthS2P9UfWBaoh4wagi
 d+NSOs/VDU15LfdXtebbA4oP6LT8w6oL5MZpgf1zBJITt9z4TLq618nAqsLlK5Yrrhms
 P8CMF1ATcUrTddMveI/Cs1gYkFKYGn4hURoBnTS0gKAd/uTIRxRvp2h8WgyHmdljMVt+
 WNOeT7mOmuA4BdjYuia2LLF9Qe7oOvTxYKWitiyiuj4Kl+4J/ZVKiqWvCYpSdHHS1o8t
 +N1XddQhWJoTPV+nNZNyZ+B+wQvTGqMhYEl5LfnwScvSijMjKtOuMuhKXdNCHfTAFOAc
 7yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780929431; x=1781534231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dY2yEoggKWKuvljI7PNrl6wqIgvY5VG/EBmpZKzBraU=;
 b=MtqnShF2xtNl5oTbv2PRC+vK64JvyWF6tUjSAGe/0DbuRRDwDpqW8+HRKUacDC7xCE
 p2yl8Ec11NQtyGvaCm6hgkajlbDy/rKYRd+YGPYFJYiRzKNuPxoNwuW6W0EG7ZT5Wuz2
 CNJiYHR+JZy3sBWO2/eXmlmS8UiyT+rOpUdOecvr/jkNMMw/olbG1/4fuKurJp7coe1R
 /TgI/RlnRKD4WXtBPubXnW1hLPpkTCSYrA9O4Rpu1S39iR/mEjFL1EI0+sB2eddb5xfd
 myo5jkIEYOdbSBAKddkTSit49Ish1bsMykGb7CPUT79m+G/I3YKqpsZHqZvmDPANw+eN
 ke7g==
X-Gm-Message-State: AOJu0Yx9Cjw24RdzFxAcnHnTVUAMt3GobcI4PrFvhwUAj6yvfDF6GupS
 zdbfV7TP88dDJKMWx+kQmzRAS5BOLeaNJgZvermHCr+/KimINphdSX+ABq56Mw==
X-Gm-Gg: Acq92OEvObPA7U9gi5HMwiFn+/xBF/EHEpr4YKr4vy2cCIN0UrnGDVDGrhWAdFxjweu
 x2BZAyAJKkWuoF0vHVJchQlcQDTkWJW3iCzj0XnNTawDhTroFkpWF7VnFz9WkdesUeh/+RcmZn3
 DBYC5CcGn+k4tiOmpyI7OMUOeWjMlVkNcvGrAaAek4UtB+d/cBB4ppN+w6axczeP9SonBFNzKpN
 e6hGdCgCaukjoZwdgSD6fsVT1umxHlOjrOVtSbvuOBoo4L5d48HLDJDtAfdHQ7SedCd7fcOG5m1
 h0v4YLElsVbfNd7uNOj58/4rGwS65MSU2EsJCXc6+dh7dCMbZOYLm6/bC2V0zjyhCoO55p6m1sP
 O5es9rQ4YCUmXAnuGzQLV8oU7MYdcsexSMSWvrV59vNALZaQBshwG1nFElqSY7HYG2OwqrCDp0U
 gqJ4TRAm7beOrm4f7E/Wisvx2G+ICiMIq8mt/0LIBVKbiTKR5+9FCdZHc/NwjJCD0eQVhC4Rt1o
 7xH37yV
X-Received: by 2002:a05:6000:46dc:b0:460:1d74:a1b2 with SMTP id
 ffacd0b85a97d-460305146c4mr18342570f8f.16.1780929430512; 
 Mon, 08 Jun 2026 07:37:10 -0700 (PDT)
Received: from localhost.suse.org ([37.109.163.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm52180854f8f.21.2026.06.08.07.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:37:10 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 16:36:50 +0200
Message-ID: <20260608143652.6356-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260608143652.6356-1-sebastian.chlad@suse.com>
References: <20260608143652.6356-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] io_uring: Redesign common helpers to follow
 liburing API conventions
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

Replace coupled submit and wait helpers with a proper liburing-style API:
- io_uring_get_sqe(): get next SQE slot from the submission ring
- io_uring_prep_rw(): generic SQE fill for read/write perations
- io_uring_prep_read/write/readv/writev(): operation-specific prep helpers
- io_uring_sqe_set_data64(): set user_data explicitly on the SQE
- io_uring_submit(): submit all pending SQEs to the kernel
- io_uring_wait_cqe(): wait for next CQE, return pointer without consuming it
- io_uring_cqe_seen(): advance the CQ head to mark a CQE as consumed

The old io_uring_do_io_op() and io_uring_do_vec_io_op() helpers are
removed. They coupled SQE submission with an immediate CQE wait, making
tests effectively synchronous, and emitted tst_res(TPASS) from inside
the helper, hiding where test results came from. They also set user_data
to the opcode value, which is meaningless as a per-request tag and would
cause spurious passes in any test with multiple in-flight SQEs of the
same opcode.

With the new API, each test controls SQE preparation, user_data
assignment, submission, CQE validation and result reporting explicitly
in its own body, matching how real io_uring applications are written.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 .../syscalls/io_uring/io_uring_common.h       | 193 ++++++++----------
 1 file changed, 85 insertions(+), 108 deletions(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
index aa31339fb..18fdfc9b6 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring_common.h
+++ b/testcases/kernel/syscalls/io_uring/io_uring_common.h
@@ -3,6 +3,8 @@
  * Copyright (C) 2026 IBM
  * Author: Sachin Sant <sachinp@linux.ibm.com>
  *
+ * Copyright (C) 2026 Sebastian Chlad <sebastian.chlad@suse.com>
+ *
  * Common definitions and helper functions for io_uring tests
  */
 
@@ -43,6 +45,7 @@ struct io_uring_submit {
 	size_t sq_ptr_size;
 	void *cq_ptr;
 	size_t cq_ptr_size;
+	unsigned int sq_pending;
 };
 
 /*
@@ -117,162 +120,136 @@ static inline void io_uring_cleanup_queue(struct io_uring_submit *s,
 }
 
 /*
- * Internal helper to submit a single SQE to the submission queue
- * Used by both vectored and non-vectored I/O operations
+ * Get the next available SQE slot from the submission ring.
+ * The SQE is zeroed and tracked as pending until io_uring_submit() is called.
  */
-static inline void io_uring_submit_sqe_internal(struct io_uring_submit *s,
-						int fd, int opcode,
-						unsigned long addr,
-						unsigned int len,
-						off_t offset,
-						unsigned long long user_data)
+static inline struct io_uring_sqe *io_uring_get_sqe(struct io_uring_submit *s)
 {
 	struct io_sq_ring *sring = &s->sq_ring;
-	unsigned int tail, index;
-	struct io_uring_sqe *sqe;
-
-	tail = *sring->tail;
-	index = tail & *sring->ring_mask;
-	sqe = &s->sqes[index];
+	unsigned int index = (*sring->tail + s->sq_pending) & *sring->ring_mask;
+	struct io_uring_sqe *sqe = &s->sqes[index];
 
 	memset(sqe, 0, sizeof(*sqe));
+	sring->array[index] = index;
+	s->sq_pending++;
+
+	return sqe;
+}
+
+/*
+ * Generic SQE fill for read/write family operations.
+ * Does not touch user_data - caller sets it via io_uring_sqe_set_data64().
+ */
+static inline void io_uring_prep_rw(struct io_uring_sqe *sqe, int opcode,
+				    int fd, const void *addr, unsigned int len,
+				    off_t offset)
+{
 	sqe->opcode = opcode;
 	sqe->fd = fd;
-	sqe->addr = addr;
+	sqe->addr = (unsigned long)addr;
 	sqe->len = len;
 	sqe->off = offset;
-	sqe->user_data = user_data;
+}
 
-	sring->array[index] = index;
-	tail++;
+static inline void io_uring_prep_read(struct io_uring_sqe *sqe, int fd,
+				      void *buf, size_t len, off_t offset)
+{
+	io_uring_prep_rw(sqe, IORING_OP_READ, fd, buf, len, offset);
+}
 
-	*sring->tail = tail;
+static inline void io_uring_prep_write(struct io_uring_sqe *sqe, int fd,
+				       const void *buf, size_t len, off_t offset)
+{
+	io_uring_prep_rw(sqe, IORING_OP_WRITE, fd, buf, len, offset);
 }
 
-/*
- * Submit a single SQE to the submission queue
- * For basic read/write operations (non-vectored)
- */
-static inline void io_uring_submit_sqe(struct io_uring_submit *s, int fd,
-				       int opcode, void *buf, size_t len,
+static inline void io_uring_prep_readv(struct io_uring_sqe *sqe, int fd,
+				       struct iovec *iovs, int nr_vecs,
 				       off_t offset)
 {
-	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)buf,
-				     len, offset, opcode);
+	io_uring_prep_rw(sqe, IORING_OP_READV, fd, iovs, nr_vecs, offset);
+}
+
+static inline void io_uring_prep_writev(struct io_uring_sqe *sqe, int fd,
+					struct iovec *iovs, int nr_vecs,
+					off_t offset)
+{
+	io_uring_prep_rw(sqe, IORING_OP_WRITEV, fd, iovs, nr_vecs, offset);
 }
 
 /*
- * Submit a vectored SQE to the submission queue
- * For readv/writev operations
+ * Set the user_data field of an SQE. user_data is returned verbatim in the
+ * corresponding CQE and must be unique per in-flight request to allow correct
+ * correlation of completions.
  */
-static inline void io_uring_submit_sqe_vec(struct io_uring_submit *s, int fd,
-					   int opcode, struct iovec *iovs,
-					   int nr_vecs, off_t offset)
+static inline void io_uring_sqe_set_data64(struct io_uring_sqe *sqe,
+					   uint64_t data)
 {
-	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)iovs,
-				     nr_vecs, offset, opcode);
+	sqe->user_data = data;
 }
 
 /*
- * Map io_uring operation code to human-readable name
+ * Submit all pending SQEs to the kernel.
  */
-static inline const char *ioring_op_name(int op)
+static inline void io_uring_submit(struct io_uring_submit *s)
 {
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
+	unsigned int pending = s->sq_pending;
+
+	if (!pending)
+		return;
+
+	*s->sq_ring.tail += pending;
+	s->sq_pending = 0;
+
+	if (io_uring_enter(s->ring_fd, pending, 0, 0, NULL) < 0)
+		tst_brk(TBROK | TERRNO, "io_uring_enter() failed");
 }
 
 /*
- * Wait for and validate a completion queue entry
- * Aborts test on failure using tst_brk()
+ * Wait for the next CQE and return a pointer to it.
+ * Does not advance the CQ head - call io_uring_cqe_seen() when done.
  */
-static inline void io_uring_wait_cqe(struct io_uring_submit *s,
-				     int expected_res, int expected_opcode,
-				     sigset_t *sig)
+static inline struct io_uring_cqe *io_uring_wait_cqe(struct io_uring_submit *s,
+						      sigset_t *sig)
 {
 	struct io_cq_ring *cring = &s->cq_ring;
-	struct io_uring_cqe *cqe;
-	unsigned int head;
 	int ret;
 
-	ret = io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, sig);
+	ret = io_uring_enter(s->ring_fd, 0, 1, IORING_ENTER_GETEVENTS, sig);
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "io_uring_enter() failed");
 
-	head = *cring->head;
-	if (head == *cring->tail)
+	if (*cring->head == *cring->tail)
 		tst_brk(TBROK, "No completion event received");
 
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
+	return &cring->cqes[*cring->head & *cring->ring_mask];
 }
 
 /*
- * Initialize buffer with a repeating character pattern
- * Useful for creating test data with predictable patterns
+ * Mark the current CQE as consumed, advancing the CQ head.
  */
-static inline void io_uring_init_buffer_pattern(char *buf, size_t size,
-						char pattern)
+static inline void io_uring_cqe_seen(struct io_uring_submit *s)
 {
-	size_t i;
-
-	for (i = 0; i < size; i++)
-		buf[i] = pattern;
+	(*s->cq_ring.head)++;
 }
 
 /*
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
+ * Map io_uring operation code to human-readable name
  */
-static inline void io_uring_do_vec_io_op(struct io_uring_submit *s, int fd,
-					 int op, struct iovec *iovs,
-					 int nvecs, off_t offset,
-					 int expected_size, sigset_t *sig)
+static inline const char *ioring_op_name(int op)
 {
-	io_uring_submit_sqe_vec(s, fd, op, iovs, nvecs, offset);
-	io_uring_wait_cqe(s, expected_size, op, sig);
-	tst_res(TPASS, "OP=%s (%02x) fd=%i iovs=%p nvecs=%i offset=%jd "
-		"expected_size=%i",
-		ioring_op_name(op), op, fd, iovs, nvecs, (intmax_t)offset,
-		expected_size);
+	switch (op) {
+	case IORING_OP_READV:
+		return "IORING_OP_READV";
+	case IORING_OP_WRITEV:
+		return "IORING_OP_WRITEV";
+	case IORING_OP_READ:
+		return "IORING_OP_READ";
+	case IORING_OP_WRITE:
+		return "IORING_OP_WRITE";
+	default:
+		return "UNKNOWN";
+	}
 }
 
 #endif /* IO_URING_COMMON_H */
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
