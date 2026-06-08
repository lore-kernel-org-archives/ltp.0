Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24732CD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C97823E6FDE
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 16:37:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4B883E6FD8
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:37:13 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 52F822003B2
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:37:13 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so37750125e9.3
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780929433; x=1781534233; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPMkNC5ODM58xdHdht5q4BfAj9J6LgDQMhG0vYQl3TI=;
 b=Xq6eCox1/BTM3pGB3taxYmFj2KXZMk3ua+wCqqX68eiR2Wqc8f93UgBvfV/3cx2QUe
 T/1hrMI91x4eav/NDZGi7uUz1YoTBMPm45cTuIqK7mnyQIVsl25NS4vPv20kvvZY1OCR
 hzY+qhuFbta+w9JVcNtkB+Ku+0xx7ceEzyJLrfcSDqtZdp966qTU/5Zn/RWBZa6nKpDS
 +5Ne/Ibk3Jq/yy5RPf6UZRi3LgyNFx31pynVCeiXR2GImuunLmr/XDS71UAGRG66Z3q2
 3xvsVLpzJYJ3Ru45kHvOYHd/5qkJYfJp/Ji/VbPyeFiuFoYqpJ8UOzzme+ZkbU4m5TP6
 gQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780929433; x=1781534233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mPMkNC5ODM58xdHdht5q4BfAj9J6LgDQMhG0vYQl3TI=;
 b=QpzhjM11hstH9gnGubtCEQ9io9M2bXyzeEM2B1vXR3/910VFLsKCpfIE3I2nQg++EY
 dXGJJcVRgKtGKCHGX3kp8QwI3V+Jn18CJMcQlb0W1Gh+XEcfOEMFoTCvY1ErfncpDXFT
 bCJI8NInOwTd+s1EunKW2P2JcVM/hZq2cporkL6n82sgppXJHuS3+kufsIkNVlfrU5l1
 Fi+6OWA31rZxjHwM0QVtTD68sPjRaSQranSIz3cm+fGX6ZkT7AQtZc5I0VAW1Oi4dMBw
 Fd2aQo3sE6e97EjAivxb3sI87c+jFw1/At37NdcHeWVxZYwxcLJVSgqMQjQc8wD7GBhz
 T05Q==
X-Gm-Message-State: AOJu0YzFgNywDIlSHZn0d/jLDaexQbaNoNchsC4OF5idZ94cnFEaseOC
 JeI/vvQe6AVi5IxXL58HYow+UAy+wy51SGcg+pAxmNym2PTc10jDbKYkKOKKMg==
X-Gm-Gg: Acq92OHzsizNAIPjHnbhLjOFGIe7ZV9EIKSgt6nn9tL4ETjCgEZo8qXigxeBBN9XcYo
 QV9PJnBd4Z9H7DiHlQisC8LBTAV0N2Yja0l+WxacnBwnSsLDzzaHE9XV8v2shjv+iUNFYkdcp7I
 x/9ohIg21a6QFw5md+3jkCMKFva7f73hAxR91eIDySN1oEt6/HNkSWiTnVhZK7EUhcDyocl+W6C
 vt4SjpXTcJVxEb5BytuuZebWhrCeuA2ELkSJqLhlkoqLMWoWYwG7mHxJyiOwk0tPE+1EOiJM5mm
 w+KFRcQep3CJb5GoQPb0d+jiRjwqVqawsO2Ypg3RRh09XbiTFIaKPt0Vp2M5e24bzmwe5EkCfn+
 z4F8CifFNxjbUERyuoQzT+MMOwfsS32SssudtrwGSlk8PCis1duymB2MddUmX9FLrpgq/HMYGmf
 rWolYxAh6qw+o7cqNWBAGOH/KAHWxVKMhYEZQpz5g7IdJVm6N72XxrCmL5L+RLrv/02GqYpK42J
 UqFA8gw
X-Received: by 2002:a05:600c:620f:b0:490:b2c9:e284 with SMTP id
 5b1f17b1804b1-490c2612c43mr252990485e9.30.1780929432495; 
 Mon, 08 Jun 2026 07:37:12 -0700 (PDT)
Received: from localhost.suse.org ([37.109.163.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm52180854f8f.21.2026.06.08.07.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:37:12 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 16:36:51 +0200
Message-ID: <20260608143652.6356-3-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260608143652.6356-1-sebastian.chlad@suse.com>
References: <20260608143652.6356-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] io_uring01: Update to use new io_uring_common.h
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
 .../kernel/syscalls/io_uring/io_uring01.c     | 64 ++++++++-----------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
index 4c64e562b..7634a70c0 100644
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
+ * io_uring_wait_cqe() helpers built on top of io_uring_enter().
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
+		cqe = io_uring_wait_cqe(s, NULL);
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
