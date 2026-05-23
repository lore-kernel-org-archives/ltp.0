Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DCACD5BAC
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 11:39:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02F3B3D95B1
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 13:39:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 000173CD743
 for <ltp@lists.linux.it>; Sat, 23 May 2026 13:39:27 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 57604200A1E
 for <ltp@lists.linux.it>; Sat, 23 May 2026 13:39:27 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49040362e4aso23451675e9.0
 for <ltp@lists.linux.it>; Sat, 23 May 2026 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779536367; x=1780141167; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHPV/DvLAGwqyZemlT2jZ17hF3o1cQy8V6KONCClG0w=;
 b=hKJLKtduFlX+Y/qg7RRSU60TIkKa+KKNDhpJBHVvfsj3KAxHAHpYo3hgzoSI+F/hUM
 48wLJoJCgoOmPNBJQW9DM11mMTpb/gDNuYVKf7dKa39aSOjTgG/D+D1lFBoyShe9uOyp
 2ibd/vie3Yc07NXX44sGBX1Tbv7U7o8JT7dX19wiCfv0OHOZ1eInQnuUP5Fp724XkkpB
 +xydGlnTKv62hzJtab9qjnOdbds2AI6t8/YWoYxMPMukoUqLZPrY03WVw4W2tB5XCvZa
 4ucVFlILnKQ5oGcZRCR09vnYlaY6DuwERnN3Me9I6xM0HqxWi2ZcbOxj1HDO5WcwK2RO
 1cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779536367; x=1780141167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QHPV/DvLAGwqyZemlT2jZ17hF3o1cQy8V6KONCClG0w=;
 b=KrHA2UBVHyKJwCRmgN++qCLzHkqxKowXDSyCIaWQqlnq5uBRYbtxScqVJ52ihc216m
 T43y+5UXrjA4Jkt1TZyq4xMl+cmq37UQ0UzeywPqlxMc+CCwvKgcTzZ4yJpXcrMd+mNg
 hnd9EafmzPz6gxhPuFGo+lo/+3ueQUTAmNuXL6M5q1ysBdTFglWtr3DwzTyBBDO4Jlpd
 3lo05sknBDyHvBddtikB83A6DZKjUv3gsqf0HQrOpcvaYRyGBgGg1ltqy7HS/g07Ohp5
 IyM8pxoF4VAFBb0q7IlGWirIHyigVLs3nt67R1vuRU0l3ALgJvNVu3O23R77xFzcKSQi
 Qgaw==
X-Gm-Message-State: AOJu0Ywyxm5+YREHGPueAYOeNqo4gx1VNv2cmZqM0unZJb1gRnLHHhow
 vXpz28JXv4XKQeTgcINk+7p00UlIyTc5QgxETbh++yH+mJgSzpvj44/8yIePKw==
X-Gm-Gg: Acq92OGdkj6DUEdqp+uVnAN76F9+tTD+RJoYOi7Tp7WPrxOrr1oy+d7La08XA0i21xn
 mLsDZlfYW3b1gu3ZCCbrCupStx84ZSRWbb9VZkiI/Qa5OiLAZgSeAvV2o8/EfJtPh+9KK92h9t1
 +RxPlpQtcggTdaMyfWlncMOXlOFzy/orQuPUBGyrwXd6FyONhxTduEd2eydg8JpD7gD+cPHblLo
 bBnW7Kt/LcyMAaAUVhT45Udaeo0cw5e4de9vSlZVE3Lhq6BMrWFpsuer+i6stOo0J7QOrsNCUK+
 YLBsTEmKE+010Fn/+xXR7j50WDSUbACwV0cuyeQZWEDp3kwDvlUuVjy2YKOEi9WvtWgxwX3IDMr
 BOPM/5UJ/W2RI1TTF/ERLIsliEC4JOViYawqdgWpdNYd/14drc+qFvoP/wYJiB+nQJLln9EQzFP
 YVzQmgoY+HLv3tef6FWRLyE5lT6cBLE8rSdbm3c5G8qXLZN9x5LDdevCBBesf5GcJzme1NPMkK9
 BmsEgdfrJWi3VyyH7s=
X-Received: by 2002:a05:600c:4f0b:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-490426a4753mr107578455e9.14.1779536366399; 
 Sat, 23 May 2026 04:39:26 -0700 (PDT)
Received: from localhost.suse.org ([37.109.163.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042aeafa8sm36304515e9.27.2026.05.23.04.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 04:39:25 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Sat, 23 May 2026 13:39:09 +0200
Message-ID: <20260523113909.6385-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260523101749.27657-1-sebastian.chlad@suse.com>
References: <20260523101749.27657-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] io_uring/pintheft: Add CVE-2026-43494 regression
 test
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

Test for PinTheft (CVE-2026-43494), fixed by:
e17492979319 ("net/rds: reset op_nents when zerocopy page pin fails")

The bug is in the RDS zerocopy send error path: when pinning user pages
for zerocopy send fails partway through, the error cleanup drops a page
reference that the RDS message cleanup will drop again. Combined with
io_uring fixed buffer registrations, this double-drop drains the
FOLL_PIN counter and causes a page-cache overwrite exploitable for local
privilege escalation (PinTheft).

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
v2: Address AI review findings:
 - Fix # define -> #define in lapi/io_uring.h
 - Move runtest/cve entry to the "may cause kernel memory leak" section

 include/lapi/io_uring.h                       |   4 +
 runtest/cve                                   |   1 +
 testcases/kernel/syscalls/io_uring/pintheft.c | 429 ++++++++++++++++++
 3 files changed, 434 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/pintheft.c

diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index 2026863a2..1d54ff716 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -265,6 +265,10 @@ struct io_uring_probe {
 
 #endif /* IOSQE_FIXED_FILE */
 
+#ifndef IORING_REGISTER_CLONE_BUFFERS
+#define IORING_REGISTER_CLONE_BUFFERS	30
+#endif
+
 #ifndef IOSQE_IO_HADRLINK
 /* like LINK, but stronger */
 #define IOSQE_IO_HARDLINK_BIT	3
diff --git a/runtest/cve b/runtest/cve
index 74ee8e9ba..32a0f237d 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -95,4 +95,5 @@ cve-2025-38236 cve-2025-38236
 cve-2025-21756 cve-2025-21756
 cve-2026-31431 af_alg08
 cve-2026-43284 xfrm01
+cve-2026-43494 pintheft
 cve-2026-46300 xfrm02
diff --git a/testcases/kernel/syscalls/io_uring/pintheft.c b/testcases/kernel/syscalls/io_uring/pintheft.c
new file mode 100644
index 000000000..8a7517353
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/pintheft.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Sebastian Chlad <sebastian.chlad@suse.com>
+ */
+
+/*\
+ * CVE-2026-43494
+ *
+ * Test for PinTheft, fixed by:
+ * e17492979319 ("net/rds: reset op_nents when zerocopy page pin fails").
+ *
+ * The bug is in the RDS zerocopy send error path. When RDS pins user pages for
+ * zerocopy send and a later page faults, the error cleanup can drop references
+ * for pages that are later released again during RDS message cleanup. This
+ * corrupts page reference accounting.
+ *
+ * The public exploit combines this RDS reference-counting bug with io_uring
+ * fixed buffers and cloned buffer registrations to turn stale page references
+ * into a page-cache overwrite and local privilege escalation.
+ *
+ * This test does not attempt privilege escalation. It triggers the underlying
+ * RDS zerocopy failure path by sending GUP_PIN_COUNTING_BIAS (1024) two-page
+ * iovecs where the first page is registered as an io_uring fixed buffer and
+ * the second page is PROT_NONE.  Each failing send steals one FOLL_PIN
+ * reference; after 1024 sends the io_uring-held page pin is exhausted.
+ * Unregistering the fixed buffers on a vulnerable kernel then tries to unpin
+ * a page with no remaining FOLL_PIN references, triggering a kernel WARN or
+ * BUG_ON and tainting the kernel.
+ *
+ * Vulnerable kernels may crash, taint, panic, or hang during sendmsg() or
+ * subsequent cleanup. Run only on disposable systems.
+ *
+ * Reproducer is based on:
+ * https://github.com/v12-security/pocs/tree/main/pintheft
+ */
+
+#include <errno.h>
+#include <netinet/in.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/rds.h>
+
+#include "tst_test.h"
+#include "lapi/io_uring.h"
+#include "lapi/socket.h"
+
+#define CLEANUP_WAIT_SECS	30
+#define RSS_CHECK_CHILDREN	8
+#define RSS_CHECK_SIZE		(16 * 1024 * 1024)
+
+/*
+ * io_uring pins fixed-buffer pages with FOLL_PIN, which adds
+ * GUP_PIN_COUNTING_BIAS (1024) to the page reference count.  Each failing
+ * RDS zerocopy send steals one of those references via the double-drop bug.
+ * We need exactly 1024 iterations to fully drain the FOLL_PIN counter.
+ */
+#define GUP_PIN_COUNTING_BIAS	1024
+
+/* io_uring IORING_REGISTER_CLONE_BUFFERS argument. */
+struct clone_buffers_arg {
+	uint32_t src_fd;
+	uint32_t flags;
+	uint32_t pad[6];
+};
+
+static int ring_fd1 = -1;
+static int ring_fd2 = -1;
+static int rds_fd = -1;
+static int buffer_registered;
+static int buffer_cloned;
+static long page_size;
+static void *mapped_pages;
+
+static void cleanup(void);
+
+/* Inspired by liburing's io_uring_clone_buffers(), but using raw ring fds. */
+static int clone_buffers(int dst_fd, int src_fd)
+{
+	struct clone_buffers_arg clone;
+
+	memset(&clone, 0, sizeof(clone));
+	clone.src_fd = src_fd;
+
+	return io_uring_register(dst_fd, IORING_REGISTER_CLONE_BUFFERS,
+				 &clone, 1);
+}
+
+static void setup(void)
+{
+	struct io_uring_params params = {};
+	struct iovec fixed_iov;
+	int val;
+
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	io_uring_setup_supported_by_kernel();
+
+	/*
+	 * The exploit primitive keeps one fixed-buffer registration alive and
+	 * clones it to another ring.
+	 */
+	ring_fd1 = io_uring_setup(1, &params);
+	if (ring_fd1 < 0)
+		tst_brk(TBROK | TERRNO, "io_uring_setup() failed for first ring");
+
+	memset(&params, 0, sizeof(params));
+
+	ring_fd2 = io_uring_setup(1, &params);
+	if (ring_fd2 < 0)
+		tst_brk(TBROK | TERRNO, "io_uring_setup() failed for second ring");
+
+	rds_fd = socket(AF_RDS, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
+	if (rds_fd < 0) {
+		if (errno == EAFNOSUPPORT || errno == ESOCKTNOSUPPORT ||
+		    errno == EPROTONOSUPPORT || errno == ENOPROTOOPT)
+			tst_brk(TCONF | TERRNO, "RDS is not available");
+
+		tst_brk(TBROK | TERRNO, "socket(AF_RDS) failed");
+	}
+
+	/* PinTheft uses the RDS TCP transport, so base RDS is not enough. */
+	val = RDS_TRANS_TCP;
+	TEST(setsockopt(rds_fd, SOL_RDS, SO_RDS_TRANSPORT, &val, sizeof(val)));
+
+	if (TST_RET) {
+		if (TST_ERR == ENOPROTOOPT || TST_ERR == EINVAL)
+			tst_brk(TCONF | TERRNO, "RDS TCP transport is not available");
+
+		tst_brk(TBROK | TERRNO, "setsockopt(SO_RDS_TRANSPORT) failed");
+	}
+
+	/*
+	 * Allocate two adjacent pages: the first one will be pinned as an
+	 * io_uring fixed buffer, and the second one will be made inaccessible.
+	 */
+	mapped_pages = SAFE_MMAP(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
+				 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	memset(mapped_pages, 0xa5, page_size);
+
+	/*
+	 * RDS should successfully pin the first page, then fault on the second.
+	 * That fault drives the buggy zerocopy error cleanup path.
+	 */
+	SAFE_MPROTECT((char *)mapped_pages + page_size, page_size, PROT_NONE);
+
+	fixed_iov.iov_base = mapped_pages;
+	fixed_iov.iov_len = page_size;
+
+	/*
+	 * Register only the first page as an io_uring fixed buffer. This creates
+	 * the long-term page pin whose reference accounting the RDS bug damages.
+	 */
+	if (io_uring_register(ring_fd1, IORING_REGISTER_BUFFERS, &fixed_iov, 1)) {
+		if (errno == ENOMEM)
+			tst_brk(TCONF, "Not enough memory to register io_uring buffer");
+
+		tst_brk(TBROK | TERRNO, "IORING_REGISTER_BUFFERS failed");
+	}
+
+	buffer_registered = 1;
+
+	/*
+	 * Clone the fixed buffer registration into the second ring, matching the
+	 * public reproducer's lifetime pattern without performing the later
+	 * page-cache overwrite stage.
+	 */
+	if (clone_buffers(ring_fd2, ring_fd1)) {
+		if (errno == EINVAL || errno == EOPNOTSUPP)
+			tst_brk(TCONF | TERRNO, "IORING_REGISTER_CLONE_BUFFERS is not supported");
+
+		tst_brk(TBROK | TERRNO, "IORING_REGISTER_CLONE_BUFFERS failed");
+	}
+
+	buffer_cloned = 1;
+}
+
+static void trigger(void)
+{
+	/*
+	 * Derive RDS ports from the process ID so concurrent test instances
+	 * do not collide in the RDS port namespace.
+	 */
+	const uint16_t src_port = (uint16_t)(20000 + (getpid() % 20000));
+	struct sockaddr_in bind_addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		.sin_port = htons(src_port),
+	};
+	struct sockaddr_in dst_addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		.sin_port = htons(src_port + 1),
+	};
+	char control[CMSG_SPACE(sizeof(uint32_t))];
+	struct cmsghdr *cmsg;
+	struct iovec iov = {
+		.iov_base = mapped_pages,
+		.iov_len = 2 * page_size,
+	};
+	struct msghdr msg = {
+		.msg_name = &dst_addr,
+		.msg_namelen = sizeof(dst_addr),
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = control,
+		.msg_controllen = sizeof(control),
+	};
+	int ret;
+	int val;
+	int i, efaults, first_bad_errno = 0;
+
+	/* Mirror the public PoC trigger: RDS zerocopy over TCP. */
+	val = 1;
+	if (setsockopt(rds_fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
+		if (errno == ENOPROTOOPT || errno == EINVAL)
+			tst_brk(TCONF | TERRNO, "SO_ZEROCOPY not supported on RDS sockets");
+		tst_brk(TBROK | TERRNO, "setsockopt(SO_ZEROCOPY) failed");
+	}
+
+	val = 2 * page_size * 4;
+	SAFE_SETSOCKOPT(rds_fd, SOL_SOCKET, SO_SNDBUF, &val, sizeof(val));
+
+	/*
+	 * Bind to one loopback RDS port and send to another unbound local port.
+	 * The sends are expected to fail before any useful delivery; the faulting
+	 * iovec is the interesting part.
+	 */
+	SAFE_BIND(rds_fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr));
+
+	memset(control, 0, sizeof(control));
+	cmsg = (struct cmsghdr *)control;
+	cmsg->cmsg_level = SOL_RDS;
+	cmsg->cmsg_type = RDS_CMSG_ZCOPY_COOKIE;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+
+	/*
+	 * Repeatedly attempt a two-page zerocopy send where page 0 is pinnable
+	 * and page 1 is PROT_NONE.  Each attempt should:
+	 *   1. Pin page 0 successfully.
+	 *   2. Fault on page 1, so RDS error path drops page 0's reference.
+	 *   3. RDS message cleanup drops page 0's reference again (the bug).
+	 *
+	 * On a vulnerable kernel this steals one FOLL_PIN reference per
+	 * iteration; GUP_PIN_COUNTING_BIAS iterations drain the counter to zero.
+	 * Unregistering the io_uring fixed buffer then tries to unpin a page
+	 * with no remaining FOLL_PIN references, causing a kernel WARN/BUG_ON
+	 * and taint.
+	 *
+	 * EFAULT is the expected error because page 1 is PROT_NONE. Other
+	 * errors do not count as successful pin-theft iterations.
+	 *
+	 * Vulnerable kernels may crash, taint, panic, or hang here or during
+	 * cleanup() below.
+	 */
+	for (i = 0, efaults = 0; i < GUP_PIN_COUNTING_BIAS; i++) {
+		/* rds_cmsg_zcopy() in net/rds/send.c */
+		*(uint32_t *)CMSG_DATA(cmsg) = (uint32_t)i;
+
+		ret = sendmsg(rds_fd, &msg, MSG_ZEROCOPY | MSG_DONTWAIT);
+		if (ret >= 0)
+			tst_brk(TBROK, "sendmsg() unexpectedly succeeded at iter %d", i);
+
+		if (errno == EFAULT)
+			efaults++;
+		else if (!first_bad_errno)
+			first_bad_errno = errno;
+	}
+
+	if (first_bad_errno) {
+		tst_res(TINFO, "sendmsg() returned unexpected errno %d (%s) on at least one iteration",
+			first_bad_errno, tst_strerrno(first_bad_errno));
+	}
+
+	tst_res(TINFO, "Completed %d/%d sendmsg() attempts with EFAULT",
+		efaults, GUP_PIN_COUNTING_BIAS);
+
+	if (efaults == 0)
+		tst_brk(TCONF, "sendmsg() never returned EFAULT - GUP pin path not exercised");
+
+	if (efaults < GUP_PIN_COUNTING_BIAS)
+		tst_res(TWARN, "Only %d/%d sends returned EFAULT - FOLL_PIN counter may not be fully drained",
+			efaults, GUP_PIN_COUNTING_BIAS);
+
+	/*
+	 * Unregistering fixed buffers on a vulnerable kernel triggers a
+	 * double-unpin: io_uring tries to release references that the RDS bug
+	 * already dropped, which may produce a kernel WARN or BUG_ON and taint.
+	 */
+	cleanup();
+}
+
+static void poke_rss_accounting(void)
+{
+	char *mem;
+
+	mem = SAFE_MMAP(NULL, RSS_CHECK_SIZE, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	memset(mem, 0x5a, RSS_CHECK_SIZE);
+	SAFE_MUNMAP(mem, RSS_CHECK_SIZE);
+}
+
+static void run(void)
+{
+	pid_t pid;
+	int status;
+	int i;
+
+	/*
+	 * Run the dangerous part in a child so that process teardown can expose
+	 * delayed RSS/page-accounting damage before the parent reports TPASS.
+	 */
+	pid = SAFE_FORK();
+	if (!pid) {
+		trigger();
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		return;
+
+	/*
+	 * The visible failure can be delayed until another mm is torn down.
+	 * Create short-lived children that dirty and release anonymous memory to
+	 * encourage RSS accounting checks before the parent reports success.
+	 */
+	for (i = 0; i < RSS_CHECK_CHILDREN; i++) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			poke_rss_accounting();
+			exit(0);
+		}
+
+		SAFE_WAITPID(pid, &status, 0);
+
+		if (tst_taint_check()) {
+			tst_res(TFAIL, "Kernel is vulnerable: tainted during RSS accounting checks");
+			return;
+		}
+
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			return;
+	}
+
+	/*
+	 * RDS/page cleanup can run asynchronously after userspace returns from
+	 * sendmsg() and after file descriptors are closed. Wait before declaring
+	 * that the kernel merely "seems" to have survived.
+	 */
+	for (i = 0; i < CLEANUP_WAIT_SECS; i++) {
+		sleep(1);
+
+		if (tst_taint_check()) {
+			tst_res(TFAIL, "Kernel is vulnerable: tainted during RDS zerocopy cleanup");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Kernel seems to have survived RDS zerocopy cleanup");
+}
+
+static void cleanup(void)
+{
+	/*
+	 * Unregister the clone first, then the source registration.
+	 * Order matters: on a vulnerable kernel, unregistering ring_fd1
+	 * (the original) after the FOLL_PIN references have been drained
+	 * is what triggers the double-unpin WARN/BUG_ON.
+	 */
+	if (buffer_cloned) {
+		io_uring_register(ring_fd2, IORING_UNREGISTER_BUFFERS, NULL, 0);
+		buffer_cloned = 0;
+	}
+
+	if (buffer_registered) {
+		io_uring_register(ring_fd1, IORING_UNREGISTER_BUFFERS, NULL, 0);
+		buffer_registered = 0;
+	}
+
+	if (ring_fd2 >= 0) {
+		SAFE_CLOSE(ring_fd2);
+		ring_fd2 = -1;
+	}
+
+	if (ring_fd1 >= 0) {
+		SAFE_CLOSE(ring_fd1);
+		ring_fd1 = -1;
+	}
+
+	if (rds_fd >= 0) {
+		SAFE_CLOSE(rds_fd);
+		rds_fd = -1;
+	}
+
+	if (mapped_pages) {
+		SAFE_MUNMAP(mapped_pages, 2 * page_size);
+		mapped_pages = NULL;
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_RDS",
+		"CONFIG_RDS_TCP",
+		"CONFIG_IO_URING",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/kernel/io_uring_disabled", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e17492979319"},
+		{"CVE", "2026-43494"},
+		{}
+	}
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
