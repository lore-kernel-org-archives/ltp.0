Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F5CFD8741
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773748025; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=N/9BDiLiofN8pMhajMfTV+iSnLFa8sUMAP9XpK54O+4=;
 b=E01Vaq6AwOdw1q9O1Q0uikZI4ffv0qtl/sD8cZ/8y8mzOqm+rBT8wUxatt2SkBciy8dzJ
 yhETz6x89SchmnBgxz9WVUEMKc/1CMB01rnSb52YJabCwXEyLQIRbgrM8ccNq1UP9MQr/jl
 e2sOLUYTJ1EW4uLXR3D0m0U1scnTwe4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBA1C3E485E
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 12:47:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF0FC3C59AE
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 12:46:41 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AE2961400987
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 12:46:40 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so39399815e9.3
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773748000; x=1774352800; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnAr3Me/7F48LVJ2+ys/olCbNI0udLJGSFEad+2yqy4=;
 b=AQfmidUVgNuma8T0vw9FPgcLQm8ot7c4M5afGdtmtfibSwgVO2GxS7tspbc5+5sTLV
 luqrWS5bEb7Sn/DVAZpAeWyYp4Rj91ESm2WptfL0vIkm3GmuYwXEPCfY9TY35Ukoxs3c
 kyOxNJGT6X9kkx0YLBx8BVarl8VB06qZ0wJ2lv/gRJLS7FvsiAB3Cn1DVr8ZBkd6aOHF
 nl6PXwkb5e4s8PFdLyDQa1XCn6iFvmGpX4HYcVDA4gmscpxHfTWDJx+mkF4/t5orW9Jx
 1R/WYR4mqJlAlLZci8tn8u/KUgSLO+mp0NeBpgqciO5UOguAC1Gdzu6VslPcvllSYfoB
 Fsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773748000; x=1774352800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fnAr3Me/7F48LVJ2+ys/olCbNI0udLJGSFEad+2yqy4=;
 b=kIAfW+VEPpp991gSVZCB0Dk0u+tcYyDs8mKoCdq2kKnBrkHoo41azVlfqRd3+V7lIp
 MM/UYByfKWTsTlWVRU4TAlC5f7m50Yr7Nd6qG9m4a9Y57C1D7TMnP+e3Rq+7mEKszDF/
 v89MiA4k01DTqP9tKOnIydGT1FpcxaDa67cxsnT0hsA7KRhp51UkaSO+0mf/eZCX4qCV
 ZN12rfom7NZ8nt9Txp6Hn5RS7ix9lT60pXEYYfQ835Lchxj7aFarmle6TgSX9Ho9jhaz
 t/2h5VmyJrbNxfFrCVFRfFyxQyWF4Nn6ZywYJFOk4EEDE6OWIvDk0/yA9k87FjoJe/de
 gGLg==
X-Gm-Message-State: AOJu0Yw5Qhy5SqOPEzQbVSkdcTodiwW4QtrdnOoeEO5JVIlYdavmkG0D
 mo5jFQckMP1p0fP1Y1UTeaAFrW5qNb1Yt0P4y7MFQh/URtGNKiW/jWqCe5E2gBsTkZsaY793pnY
 3EzE=
X-Gm-Gg: ATEYQzwn9HnemNK+JnqLclDqF+QRBr/rEYFvJgmRG+/miZEeYJb0k0HZcSMFmWO27lx
 4CbMJDrzkoqcevBYFXBPlot21DQrWCAKNG6V9UfhktKBzPNLCZyiZnpLI9RjCdn5jnvtXggGgNd
 nU6EYuAUSFIhJu52dRAHhN+glCbNUxXeDetWjk/UNJ6tpdCcqg4irKh8kftfveCHdurMk8OnLXF
 I1hnLIeAuYRfNOE8G4xGNbolMqTSW1PQIxPwvYMzvnzTjeqi14V5v9iLflX1AuTplykD+cdvuTF
 OTMbJjWP0RSwTfu7FJOJJXpg52cjBDwHkmXLaTO6kdCP7zAJFbIzEjWiPiIS70URg842+fvNBez
 lCIgvkpq6sa0/OoO+zV5LzMFUKRIHGu/03hJHE4fQLcU/sudY+uQsuGC5sMCAeVfsM3KTdbLQjo
 LOIyt+4B90pcM=
X-Received: by 2002:a05:600c:698e:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-485566ca5cdmr276743215e9.6.1773747999720; 
 Tue, 17 Mar 2026 04:46:39 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-485696a12d0sm48694185e9.13.2026.03.17.04.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 04:46:39 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 17 Mar 2026 11:46:16 +0000
Message-ID: <20260317114635.944-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317074340.589-1-wegao@suse.com>
References: <20260317074340.589-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] io_submit04: Add test case for RWF_NOWAIT flag
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

v5-v6:
- Changed fd checks to != -1 in cleanup function
- Replaced errno with TST_ERR for LTP macro consistency
- cleanup format issue for aio_abi.h

Fixes: #467
Signed-off-by: Wei Gao <wegao@suse.com>
---
 configure.ac                                  |  1 +
 include/lapi/aio_abi.h                        | 44 +++++++++
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/io_submit/.gitignore      |  1 +
 .../kernel/syscalls/io_submit/io_submit04.c   | 99 +++++++++++++++++++
 5 files changed, 146 insertions(+)
 create mode 100644 include/lapi/aio_abi.h
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit04.c

diff --git a/configure.ac b/configure.ac
index 7fa614dcb..61462d192 100644
--- a/configure.ac
+++ b/configure.ac
@@ -172,6 +172,7 @@ AC_CHECK_FUNCS_ONCE([ \
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
index 2179e007c..9812b1bfe 100644
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
index 000000000..3b8842da0
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
+ * syscall returns immediately and io_event.res is equal to -EAGAIN.
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
+	cb->aio_buf = (uint64_t)buf;
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
+	if (ctx)
+		if (tst_syscall(__NR_io_destroy, ctx))
+			tst_brk(TBROK | TERRNO, "io_destroy() failed");
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
