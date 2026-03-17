Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7049F3380C
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 07:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773733449; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gT/goCgTAzyxkrE5jD5dusI85JMCjuG4NjPFHZsRmhI=;
 b=fq1lhX4d7pOwm35/kD8859gMDpO3NnuEQj/zyrqoiZE6dTqDGbjU1yCWqgakLaRtKZHlc
 WsgAC1amuPOegCGJDWNQaN1bPpoW3p7HKyPfIocmbqAbZqBHgZ0uuSkgbxFafEqDuMYqEGF
 HUBWNhRKHvkGhihMlzPlKO4abh//3LY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D3D23CB041
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 08:44:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDFB43CA05C
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 08:43:43 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 064811A009A2
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 08:43:42 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-485409ab264so2659705e9.1
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 00:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773733422; x=1774338222; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1q8GOZS4qE3pkgWbNZRknoNKhJxPd2Y8iWR4aSK9064=;
 b=WVIlvcK+KZLlXSEf3pPDvRX7I2T+Vf8Jj728dLk42gjR2MIToH4t8d1eYPW12WuVxO
 Md2ufJC/wt+ikf9VOidi8s1ww1Gl2rm4LgT0xUwXO6U4nlAzvRd36YAIr1mFoqZyM1FV
 xZIVXY21Sa3MzRvy/ayK1FBGdcc5dbzVxQ0uttQbUPeBl+zd28R7Yw811fL1KY5yubUp
 8ng/wwukXeSA2gt1RgIARVc1C67vmEk7YgCq/ZP+sHVsGj3LEcAltULf/U07d1ECW/EP
 8j2fqDsFvQOHtB4CWR7mAZmjPWAyw6CCLfXOJ+qC4MuclqU84Luv6leTsPNfelD5D0d6
 bPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773733422; x=1774338222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1q8GOZS4qE3pkgWbNZRknoNKhJxPd2Y8iWR4aSK9064=;
 b=GNTrrjLtZVvjG/0wa8/I6jKDMwd0mns8W+KxoqSwLHdIFG94PZrFwHc5yU2hAMWiOd
 xY8JNAQifk+FoWZM+MIB05zXARiZ1BmW7w7/VR3PUp3xBuP+Q/sqd2KNtrhxOI6lXNkW
 SoiSILpFTOkBQUrf2sZVDxHm2TzyZNUZ9Fe1BqQlYIsbpPXHeV/d7TT1LalhmPgOaIWu
 E7wl7NdHgFSngiSxPRUpyM8bBtxWjnu7fk1mFxqG4dg0kz7KtPTLycAFQGO26jZbS5YR
 792I7XZdqU7zFBxR//2SmXq2unCRpzyvFJ+QgSnUjQdjPrwTQ5JEOszdGlYjCudh6hy/
 P1tw==
X-Gm-Message-State: AOJu0YxAcUrPczPP6Dtcd9CoZI69wuvpf1S9KHYXv7J1fYY37dHt4c+7
 d0uKG7kSh4ZOb2kjiMlFU+BdL/Pqod/6dapFJFAMH18bavdh6RCmbT60BJ5yg74rogER6mMHjgJ
 xKVE=
X-Gm-Gg: ATEYQzzeWenabGyonoB5QIglAmRZAd14S7JPGLornrCWnu74j7Q+3AxkT8eCVDsRxz6
 D+wPZyJChrE0kZzdfXUhMiepcwYkEu+AqFA3CTru63Z6EA6kr3A/Esduguh99y1PG7UGOgqyEN6
 pPScS+dS5lYO2QEwH8FiysRxSQlzGjVpYT3OtVvQFZ1mqTCzNdJcxq7UmIY91D9UD4LYH0zPwlA
 rRpMgZDlkgeMTVXmz1GoV3ofZXa2cnTqrJMkrLWdsVWQ/rBDjkoKsGREmG6OdDxVJhM5tVCoUej
 cXGXz1x5sVHJtdPxvatokMBphLMn520ld6YxPJI7rBAitb+RfwwWcvjkXJGTo/TVs7qbyR3w2fX
 lBf0rLV/cUraxhV5fL05+cP7iCVy8yq3EtpsybiXDYATyiKtY/2cGuVFJKXIaU9BPMdSCdjpwrE
 LW6qj22DWLyHU=
X-Received: by 2002:a05:600c:1442:b0:485:50ac:b8cf with SMTP id
 5b1f17b1804b1-4856e874b20mr20300125e9.0.1773733422078; 
 Tue, 17 Mar 2026 00:43:42 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4856ea96828sm87281805e9.5.2026.03.17.00.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 00:43:41 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 17 Mar 2026 07:43:30 +0000
Message-ID: <20260317074340.589-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107061008.18971-1-wegao@suse.com>
References: <20260107061008.18971-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] io_submit04: Add test case for RWF_NOWAIT flag
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

v4->v5:
- Initialize fd to -1
- Replaces silent macros with explicit error checks
- Verifies that io_getevents actually returns the expected event
- Remove duplicate TTERRNO

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
index 000000000..bd8c2965b
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
+        uint64_t aio_data;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+        uint32_t   aio_key;
+        uint32_t aio_rw_flags;
+#elif __BYTE_ORDER == __BIG_ENDIAN
+        uint32_t aio_rw_flags;
+        uint32_t   aio_key;
+#else
+#error edit for your odd byteorder.
+#endif
+        uint16_t   aio_lio_opcode;
+        int16_t   aio_reqprio;
+        uint32_t   aio_fildes;
+        uint64_t   aio_buf;
+        uint64_t   aio_nbytes;
+        int64_t   aio_offset;
+        uint64_t   aio_reserved2;
+        uint32_t   aio_flags;
+        uint32_t   aio_resfd;
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
index 000000000..9b7b52995
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
+	if (fd[0])
+		SAFE_CLOSE(fd[0]);
+
+	if (fd[1])
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
+	if (TST_RET == -1 && errno == EOPNOTSUPP) {
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
