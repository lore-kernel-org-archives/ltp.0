Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443D7E88D72
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 01:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775265250; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qwhKRMtW8z8QYGQljvGMfU+cXfLWTA2UQa/nLEq+Tto=;
 b=eADPNFg761cXPxlUL4iias//zC3ms2nO6WsA9IotH+EhX9oKCCeCQi3YOHz8ORvGNesT0
 yj9X1wGHGhWNliEbcWDOSgwG/DqadUK9f7ZxOtJI70+OD4Z/DWjfUls2eYZeqt9ipD6mxV4
 x1FHE00dUhXPUGRqKrEzdd6xuqLh2Bg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12F7C3E4E5F
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 03:14:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1F123E4E54
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 03:13:45 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 141841A00888
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 03:13:45 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso12761535e9.0
 for <ltp@lists.linux.it>; Fri, 03 Apr 2026 18:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775265224; x=1775870024; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCykQF2kCC5zwqjvHfl6Ie9BAloloa6IQFULWPdkKCk=;
 b=Vkzz8jeOa/QXj6dCesklECpJVEUYcTM/J8PaB+bxtF4c8oUyUme/wPm3ScoqPn2sFf
 lprLX2ptjF4rZNudk1NvsjGsHEaxXzIenEukjeMpopFBWYeIWAomR8S/tzp0jtFYWjN/
 Ham7pc9bj33gHqo55H6Cd2pZKEV1oTWLjZLu9tnmTlfOqLl/UELb1zFwOt8vlGrGAQUX
 PHQdBUV2M3srBFMw43XK4ESMkG7CElnQKXh097AGQWFpcH0+acIHyyUyPNYWWYU8+77d
 a+xrlxph0ZhxdExgwhRcbmNLckuREgUuyfCpsq0mgPEuRdIJbKHNGj3+JXl9lSdNrDi/
 wMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775265224; x=1775870024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qCykQF2kCC5zwqjvHfl6Ie9BAloloa6IQFULWPdkKCk=;
 b=VGqwt6FJa3srrdcFUR9HO1r0pq733fOvaHxK/VsZJpA+6EaPbAjmUjuyHSQsfzjCwL
 hVIBTSwQcTfjH73nrMLMn0FXaUHbf38k7joHrNRWpaM1JJaHc1wbMGJcGqSNsqiO8plR
 IZUx+H+zxn0CEbQK4kWV8gFDcn/P6T3xXaqFfE0uA6zbrUnFpcZ2oD75qrML+Siq0SUf
 Qqo1EpiiJPQWQwZ9Ri32DXwslNLK7dMSMmNxTUT00UBDCxb0kk2WW634OmzKLT9Y/YE3
 0yN35PWERh1ztURjuZhzt5Wpo3kMcsbkXF2XPMAZ+R8BdbhkIRgxYTLYAt56W1sa7HBD
 j0mw==
X-Gm-Message-State: AOJu0YxnZlvrcPPXVupvHGLVJ6pMLGcNFwR+lWGMgSI/K/yK+reEkU3r
 oBYSueW10nGONpTDt7mjGxJABKtw5QBCw56q2ZOvz1zy9diYRnH5cN7mRgfbXc7i7MxjVPxCC2I
 fZGU=
X-Gm-Gg: AeBDieuGhGxJzpd6CEZfpWopPeqiwanGeCeSWhXKwPr1u5tjlBRjaDQF89agkEHzV/Q
 WulFyOhkYkVW9M7nGtE2nn+USSMX70/rNN1kH2pSyZhPkgOt1RXps+uQGmbN1BdisnITsEASV1E
 gK6ugzEwKvPyTH2G6fzbPjp45wKKqYElmwCeUmhjQLzs6av9FCrmiNeqWPIOcWVZV4xywaZcEoZ
 uzzajpo9eIwB3puAMvz/PKkon90SClyH+qIAf34VTcwlJQ4TML4kMY+P17uvRaTljfWlaTWWoIg
 uBbEiLk1tFnUsvPZunaSlODM+C5p/CdB1z+GRBBwmRPYrs3QUvPCudnaaB8kV6AwZctHPrQxEM0
 xsRDNKdyLyzmEjwCJzDG7GhGYcbKSAwj78Wu1xs1cH/iNwx/kO8Soe4nD5l+xmXLWm9KwheL0+H
 fLV0Tc9/DlZM0=
X-Received: by 2002:a05:600c:8b34:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-488997d530fmr75228035e9.22.1775265224149; 
 Fri, 03 Apr 2026 18:13:44 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48899e491afsm30800315e9.17.2026.04.03.18.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 18:13:43 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat,  4 Apr 2026 01:13:27 +0000
Message-ID: <20260404011340.13288-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317114635.944-1-wegao@suse.com>
References: <20260317114635.944-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] io_submit04: Add test case for RWF_NOWAIT flag
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: #467
Signed-off-by: Wei Gao <wegao@suse.com>
---
v6->v7:
- Fix 32bit issue, use TST_PTR_TO_UINT convert buf
- Updated the comment header to use the :manpage:
- Simplify logic in cleanup()

 configure.ac                                  |  1 +
 include/lapi/aio_abi.h                        | 44 +++++++++
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/io_submit/.gitignore      |  1 +
 .../kernel/syscalls/io_submit/io_submit04.c   | 99 +++++++++++++++++++
 5 files changed, 146 insertions(+)
 create mode 100644 include/lapi/aio_abi.h
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit04.c

diff --git a/configure.ac b/configure.ac
index e5d3ce063..812f17d8b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -173,6 +173,7 @@ AC_CHECK_FUNCS_ONCE([ \
 ])
 AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
 
+AC_CHECK_MEMBERS([struct iocb.aio_rw_flags],,,[#include <linux/aio_abi.h>])
 AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
 AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
 AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
diff --git a/include/lapi/aio_abi.h b/include/lapi/aio_abi.h
new file mode 100644
index 000000000..ac78e5500
--- /dev/null
+++ b/include/lapi/aio_abi.h
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+#ifndef LAPI_AIO_ABI_H__
+#define LAPI_AIO_ABI_H__
+
+#include <endian.h>
+#include <linux/aio_abi.h>
+
+#ifndef RWF_NOWAIT
+# define RWF_NOWAIT 0x00000008
+#endif
+
+struct iocb_fallback {
+	uint64_t aio_data;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	uint32_t   aio_key;
+	uint32_t aio_rw_flags;
+#elif __BYTE_ORDER == __BIG_ENDIAN
+	uint32_t aio_rw_flags;
+	uint32_t   aio_key;
+#else
+#error edit for your odd byteorder.
+#endif
+	uint16_t   aio_lio_opcode;
+	int16_t   aio_reqprio;
+	uint32_t   aio_fildes;
+	uint64_t   aio_buf;
+	uint64_t   aio_nbytes;
+	int64_t   aio_offset;
+	uint64_t   aio_reserved2;
+	uint32_t   aio_flags;
+	uint32_t   aio_resfd;
+};
+
+#ifndef HAVE_STRUCT_IOCB_AIO_RW_FLAGS
+typedef struct iocb_fallback iocb;
+#else
+typedef struct iocb iocb;
+#endif
+
+#endif /* LAPI_AIO_ABI_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index 6ba0227a8..d72fceb5e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -699,6 +699,7 @@ io_setup02 io_setup02
 io_submit01 io_submit01
 io_submit02 io_submit02
 io_submit03 io_submit03
+io_submit04 io_submit04
 
 keyctl01 keyctl01
 keyctl02 keyctl02
diff --git a/testcases/kernel/syscalls/io_submit/.gitignore b/testcases/kernel/syscalls/io_submit/.gitignore
index 60b07970a..abe962e1c 100644
--- a/testcases/kernel/syscalls/io_submit/.gitignore
+++ b/testcases/kernel/syscalls/io_submit/.gitignore
@@ -1,3 +1,4 @@
 /io_submit01
 /io_submit02
 /io_submit03
+/io_submit04
diff --git a/testcases/kernel/syscalls/io_submit/io_submit04.c b/testcases/kernel/syscalls/io_submit/io_submit04.c
new file mode 100644
index 000000000..d68bde909
--- /dev/null
+++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Test RWF_NOWAIT support in io_submit(), verifying that an
+ * asynchronous read operation on a blocking resource (empty pipe)
+ * will cause -EAGAIN. This is done by checking that io_getevents()
+ * :manpage:`io_getevents(2)` syscall returns immediately and
+ * io_event.res is equal to -EAGAIN.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/aio_abi.h"
+
+#define BUF_SIZE 100
+
+static int fd[2] = {-1, -1};
+static aio_context_t ctx;
+static char *buf;
+static iocb *cb;
+static iocb **iocbs;
+
+static void setup(void)
+{
+	if (tst_syscall(__NR_io_setup, 1, &ctx))
+		tst_brk(TBROK | TERRNO, "io_setup failed");
+
+	SAFE_PIPE(fd);
+
+	cb->aio_fildes = fd[0];
+	cb->aio_lio_opcode = IOCB_CMD_PREAD;
+	cb->aio_buf = TST_PTR_TO_UINT(buf);
+	cb->aio_offset = 0;
+	cb->aio_nbytes = BUF_SIZE;
+	cb->aio_rw_flags = RWF_NOWAIT;
+
+	iocbs[0] = cb;
+}
+
+static void cleanup(void)
+{
+	if (fd[0] != -1)
+		SAFE_CLOSE(fd[0]);
+
+	if (fd[1] != -1)
+		SAFE_CLOSE(fd[1]);
+
+	if (ctx && tst_syscall(__NR_io_destroy, ctx))
+		tst_brk(TBROK | TERRNO, "io_destroy() failed");
+}
+
+static void run(void)
+{
+	struct io_event evbuf;
+	struct timespec timeout = { .tv_sec = 1 };
+	long nr = 1;
+
+	TEST(tst_syscall(__NR_io_submit, ctx, nr, iocbs));
+
+	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP) {
+		tst_brk(TCONF, "RWF_NOWAIT not supported by kernel");
+	} else if (TST_RET != nr) {
+		tst_brk(TBROK | TTERRNO, "io_submit() returns %ld, expected %ld",
+				TST_RET, nr);
+	}
+
+	TEST(tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout));
+
+	if (TST_RET != 1) {
+		tst_res(TFAIL | TTERRNO, "io_getevents() failed to get 1 event");
+		return;
+	}
+
+	if (evbuf.res == -EAGAIN)
+		tst_res(TPASS, "io_getevents() returned EAGAIN on read event");
+	else
+		tst_res(TFAIL, "io_getevents() returned with %s instead of EAGAIN",
+			strerror(-evbuf.res));
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_AIO=y",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&buf, .size = BUF_SIZE},
+		{&cb, .size = sizeof(iocb)},
+		{&iocbs, .size = sizeof(iocb *)},
+		{},
+	}
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
