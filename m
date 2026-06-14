Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE6ACD98C7
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 17:48:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D85873E2A86
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 19:48:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C65C3C230D
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 19:48:04 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78F4D140013E
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 19:48:04 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso1267993f8f.2
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781459284; x=1782064084; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rk9SWsNU89gy32gcpGJ3mHWC2IdYzQMOAEcoakTaRGk=;
 b=kzRWu7dwEfVSZpf7+F7DBzmxa6reDOFG56NPETD5MJv/pd97sq2EjoBip7LxI4U9Lh
 yVx2PB0XxLkl5BGHSSULUS2eXHCE0oLsmLcwc8Mz839QCTYVX6wwHOWZb39FT7frlc3m
 GCGjxk/cQ3FUTrllOChwteKBOY+l31OH/dzfg8ciytOEau9OgoaDs0Im/TWV11Iuh7gw
 kjGOsTc+3Ear76zz3FLTlBY/RChhNYBi+gR0Ys4zOc9lNj0DLPMoHCY4CTDm5VTijDf1
 zjF/K5L20TBMHRR3/Mh75Q5NcEBJCq00YbWFEZ+ZlIYPfveemWCf/yylgq9WSU3VkHMt
 ZWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781459284; x=1782064084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rk9SWsNU89gy32gcpGJ3mHWC2IdYzQMOAEcoakTaRGk=;
 b=NNjMgeRIeMgdgubogt7SNrN9xtwS19/4TsMt4y8POu7ltGtiH+6VPRVBZKDBB6NFd0
 LTEmAAcf692qkIj/jvC98IfTtabUOn/Qu1cZtoiuwCo1rQRwT4pHdq3mK8ZSXY4drHmI
 l2UOL+aYfaYWY2pzVlyRiiqS+bIVyGjj/bC8EqGOv3lbcX/yf7UzM4V5wT/yNngQa65I
 fSwJCv1126SJw1WMODfO6DOtJ+V2NP0oyStjaWSF1sbSX5WZOnxd7OACkcYktBnwZZRD
 2K0Kyfsn2vUmH0fwoxg9owP4KPpsnTtgfSEmaTt8fw1FLP/a7rn+iwhOpQvrSeuB0eX0
 1vhQ==
X-Gm-Message-State: AOJu0YzHOXsZ4dkuW9iI8g9DPv2+QJyEiXQzHMIPFW4j30NbPl3Gh3/r
 mK9OUrX8XMf+6Q7giMhogVGcQQiDcaH4VHKWQs9r8usfi2OKgjfAj7Q5GQCZBA==
X-Gm-Gg: Acq92OES34p/SrpTa/oynX7bR+ifRd6CGNsP2GTRS77mRqEaclhkWE5JXNedeQtIkUK
 aWxEzowzbm5T4efRNnyMG1l0NU5AD+gNAbwfsxsRJ0CoH4FuBarA6K1nDJ1n/Thb2jHt5lC0LJT
 sbWpJRshS3/QoAme+0WLVpMT66nZbOcW/e6SkIp5i1aHKEsy8LcjSJNPMyUhLAT8iS5JG2eEInG
 rfAIJCArhi7EnMyK4PNMrovF8UZu8Mm7erMzO2LRRC4JWsR1xAHmIGMzGJ0qaezmmRm2zhg+5Bj
 CZFyAiIvvFxKPVfDcOmxUgbDPR8ULK12XJGCacPjNz2Z9vH7yitD8c6NnbPeVIE5vCHK1Yd89I6
 7lqjVxPor6AvRZ5Esgg6ONwwiDeOFIHQtOxY7za1hgo2dM2qPHz4iHeg5IaqdZxhoAYfT3qeIQj
 82Fdnia1VECwyFxdWTs+qwHCpm89jP4mEeSK7qY2QqSGBGfB++qIdjgNnSzH19cq99aa1J3zBv7
 GwNWHMAsTcIXUI8SEA7A/Gz
X-Received: by 2002:a05:6000:608:b0:460:70ae:f196 with SMTP id
 ffacd0b85a97d-46070aef211mr15878175f8f.7.1781459283647; 
 Sun, 14 Jun 2026 10:48:03 -0700 (PDT)
Received: from localhost (apn-78-30-82-184.dynamic.gprs.plus.pl.
 [78.30.82.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2637ccsm26318980f8f.6.2026.06.14.10.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 10:48:03 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Sun, 14 Jun 2026 19:47:56 +0200
Message-ID: <20260614174759.24546-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] io_uring: Redesign common helpers to follow
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
- io_uring_prep_rw(): generic SQE fill for read/write operations
- io_uring_prep_read/write/readv/writev(): operation-specific prep helpers
- io_uring_sqe_set_data64(): set user_data explicitly on the SQE
- io_uring_submit(): submit all pending SQEs to the kernel
- io_uring_cqe_wait(): wait for next CQE, return pointer without consuming it
- io_uring_cqe_seen(): advance the CQ head to mark a CQE as consumed

With the new API, each test controls SQE preparation, user_data
assignment, submission, CQE validation and result reporting explicitly
in its own body, matching how real io_uring applications are written.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
Changes in v2:
- Keep deprecated helpers alongside new ones for bisectability
  (removal moved to patch 4/4)
- Since doing the above, the io_uring_wait_cqe() had to be renames so it
  is renamed to io_uring_cqe_wait() to avoid name conflict with the
  pre-existing io_uring_wait_cqe() helper
- Use __atomic_store/__atomic_load with __ATOMIC_RELEASE/__ATOMIC_ACQUIRE

 .../syscalls/io_uring/io_uring_common.h       | 126 +++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
index aa31339fb..8ff024e5f 100644
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
 
@@ -16,7 +18,6 @@
 #include "tst_test.h"
 #include "lapi/io_uring.h"
 
-/* Common structures for io_uring ring management */
 struct io_sq_ring {
 	unsigned int *head;
 	unsigned int *tail;
@@ -43,6 +44,7 @@ struct io_uring_submit {
 	size_t sq_ptr_size;
 	void *cq_ptr;
 	size_t cq_ptr_size;
+	unsigned int sq_pending;
 };
 
 /*
@@ -275,4 +277,126 @@ static inline void io_uring_do_vec_io_op(struct io_uring_submit *s, int fd,
 		expected_size);
 }
 
+/*
+ * Get the next available SQE slot from the submission ring.
+ * The SQE is zeroed and tracked as pending until io_uring_submit() is called.
+ */
+static inline struct io_uring_sqe *io_uring_get_sqe(struct io_uring_submit *s)
+{
+	struct io_sq_ring *sring = &s->sq_ring;
+	unsigned int index = (*sring->tail + s->sq_pending) & *sring->ring_mask;
+	struct io_uring_sqe *sqe = &s->sqes[index];
+
+	memset(sqe, 0, sizeof(*sqe));
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
+	sqe->opcode = opcode;
+	sqe->fd = fd;
+	sqe->addr = (unsigned long)addr;
+	sqe->len = len;
+	sqe->off = offset;
+}
+
+static inline void io_uring_prep_read(struct io_uring_sqe *sqe, int fd,
+				      void *buf, size_t len, off_t offset)
+{
+	io_uring_prep_rw(sqe, IORING_OP_READ, fd, buf, len, offset);
+}
+
+static inline void io_uring_prep_write(struct io_uring_sqe *sqe, int fd,
+				       const void *buf, size_t len, off_t offset)
+{
+	io_uring_prep_rw(sqe, IORING_OP_WRITE, fd, buf, len, offset);
+}
+
+static inline void io_uring_prep_readv(struct io_uring_sqe *sqe, int fd,
+				       struct iovec *iovs, int nr_vecs,
+				       off_t offset)
+{
+	io_uring_prep_rw(sqe, IORING_OP_READV, fd, iovs, nr_vecs, offset);
+}
+
+static inline void io_uring_prep_writev(struct io_uring_sqe *sqe, int fd,
+					struct iovec *iovs, int nr_vecs,
+					off_t offset)
+{
+	io_uring_prep_rw(sqe, IORING_OP_WRITEV, fd, iovs, nr_vecs, offset);
+}
+
+/*
+ * Set the user_data field of an SQE. user_data is returned verbatim in the
+ * corresponding CQE and must be unique per in-flight request to allow correct
+ * correlation of completions.
+ */
+static inline void io_uring_sqe_set_data64(struct io_uring_sqe *sqe,
+					   uint64_t data)
+{
+	sqe->user_data = data;
+}
+
+/*
+ * Submit all pending SQEs to the kernel.
+ */
+static inline void io_uring_submit(struct io_uring_submit *s)
+{
+	unsigned int pending = s->sq_pending;
+
+	if (!pending)
+		return;
+
+	unsigned int tail = *s->sq_ring.tail + pending;
+
+	__atomic_store(s->sq_ring.tail, &tail, __ATOMIC_RELEASE);
+	s->sq_pending = 0;
+
+	if (io_uring_enter(s->ring_fd, pending, 0, 0, NULL) < 0)
+		tst_brk(TBROK | TERRNO, "io_uring_enter() failed");
+}
+
+/*
+ * Wait for the next CQE and return a pointer to it.
+ * Does not advance the CQ head - call io_uring_cqe_seen() when done.
+ */
+static inline struct io_uring_cqe *io_uring_cqe_wait(struct io_uring_submit *s,
+						      sigset_t *sig)
+{
+	struct io_cq_ring *cring = &s->cq_ring;
+	int ret;
+
+	ret = io_uring_enter(s->ring_fd, 0, 1, IORING_ENTER_GETEVENTS, sig);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "io_uring_enter() failed");
+
+	unsigned int cq_tail;
+
+	__atomic_load(cring->tail, &cq_tail, __ATOMIC_ACQUIRE);
+	if (*cring->head == cq_tail)
+		tst_brk(TBROK, "No completion event received");
+
+	return &cring->cqes[*cring->head & *cring->ring_mask];
+}
+
+/*
+ * Mark the current CQE as consumed, advancing the CQ head.
+ */
+static inline void io_uring_cqe_seen(struct io_uring_submit *s)
+{
+	unsigned int head = *s->cq_ring.head + 1;
+
+	__atomic_store(s->cq_ring.head, &head, __ATOMIC_RELEASE);
+}
+
+
 #endif /* IO_URING_COMMON_H */
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
