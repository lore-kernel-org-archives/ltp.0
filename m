Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492ADCF6BF0
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767766234; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=1LXgzwiRYg4p+ccdqLGVRCsIOESQiYa9n6EcQlE6rDs=;
 b=Dyew3nxa/AnB6RGk7xgP5Jv54rp0w1bx6AbwatW1R1Z4rnIBtHbeXqnfBVUroWpPlKpil
 1mDk8wQMdwMxANfdGEr1mseqKLPHWgMuYELODQztDdy42n8j+Ph3wnZ9n5lcsPBfgnYHrje
 UZQI8y8QVuUi1KRk0bQo5agdwhU+OzI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 761503C2D21
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 07:10:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E44B3C2CC0
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 07:10:12 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2B2A41A0043E
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 07:10:11 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-432755545fcso927536f8f.1
 for <ltp@lists.linux.it>; Tue, 06 Jan 2026 22:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767766210; x=1768371010; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwW+usLcPEIMonNRWYVb3Xx8uC7sVqKFNLmVRgCI2qw=;
 b=UxNwK0q/vdplIUnJnAnFPJgXh1Bsv2Ak6T82K63bo6LO61yoqSyyp7/T6AlVXxw1LJ
 5C2dfznTIFNdqDQl1EEZna+siL1a86c2u29AbVT+vbXb+BUi95u94NLglzf5JbNLkE10
 lR7C+b2a9d6szpgqTyKAe6MPQGgpotdg9Yw3ijk/PoSmvxRGHf7BfslQzaYCyGlzDxTp
 d6U4Ulvym7k4R/QoefkSLFjcfDDvb/UBEtx+nJeP7Zzsmq9Gln4dwv0iB74qxfeOkz3r
 VEhah1TK1iiaeVcd/KiYlp1VtgTCU8K2hiE9EHwaKW3r0HUfPjgGXmuII6yT7b/BOAGS
 UbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767766210; x=1768371010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hwW+usLcPEIMonNRWYVb3Xx8uC7sVqKFNLmVRgCI2qw=;
 b=lsV0dXVKzsfT1gorpJQa2VDXbPrgj93A5axvqyLYyeLti8kAmwAy/aX+tQa4q3hfoh
 6tdlRLggBoS7a9z1iziBOwriNFnR1RtnUyDr29EToZlxz32wad33xEEkz1tCMlxSI8ZW
 BGzfMZ4P4dijy1u2EKkoEdor7s86tnUFvm2ih9oUFe/a8gwJlS48G6ezdamAJKFQmV1H
 Szrqc79jJMVcZyxAT9JUunmKRGM9+Lb0do2Xy0xBj0c3T7EOyRlCYpx+EHmzJG/XhtL9
 Sju9XgJFU379CslCy/5TuDzwqwzhaYv4KJHb3T2eSTMiR6TXj0NE6tPz5EzF7sLqc9by
 nvzw==
X-Gm-Message-State: AOJu0YzHINX5tA1AeUK+K/p9k39S39idJYBVpCsE3rTJcDdfSGTtN7eD
 Syw/ebqcyzekYXaD2xxJw6yMXEgbXN2Rma/WbEilq6BwsDZeAeTdvhgkKwEit6Qr1qFg7Lf9hDS
 6NFw=
X-Gm-Gg: AY/fxX4irV9IgxUNKFN/GI7LlahZnd9Mvm3pN7yH/LfUbYRz6woI3ClptfymtwK9UTK
 lxE0NPY7qKsR7X9bxUFoKSaNZD1Ib56cEujpHkW40+eMnnWstN8gs4S08yM3jxGkVANC4xnq6Uk
 /u80ZMYavlIlUtBzEUKls0Vm/B0WymL4CclCTg7ZWgsgvQuB0rqq+JcMwQ1x2P2IxYgSPBVEOff
 pKeXdaGIMUd/B09VlIrGVFUBB5qwNBygji+TnV9QblviSXF3u+ygogPVGkcqDas0fQ2RDBq1MCz
 kxKfUfDizWrwpnwkFAZ8Fet442ybKD5k5pTHCdgGr+dj8biCObXqe1H78JPbTFxoPUkGmhFXQ8A
 mAZbwlPdvA5FsrkSqPfgNoz3TCCBGbb1dLs/4R+6VhjBydTaDUH+wSLBJADYykG8zfvBr7gL8Jk
 Y6hkcyaPxDbQ==
X-Google-Smtp-Source: AGHT+IFmjrAsNEnF+uLZqUNspJHYuNAWNrGONjj8CkhL16HgzdnE3uj34tBFcH1oKxEnaMXlcDdOAQ==
X-Received: by 2002:a5d:5f55:0:b0:431:8ec:9372 with SMTP id
 ffacd0b85a97d-432c377421amr1248332f8f.55.1767766210175; 
 Tue, 06 Jan 2026 22:10:10 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-432bd0daa84sm8190652f8f.2.2026.01.06.22.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 22:10:09 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  7 Jan 2026 06:10:04 +0000
Message-ID: <20260107061008.18971-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224085004.10267-1-wegao@suse.com>
References: <20251224085004.10267-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] io_submit04: Add test case for RWF_NOWAIT flag
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
 configure.ac                                  |  1 +
 include/lapi/aio_abi.h                        | 44 +++++++++
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/io_submit/.gitignore      |  1 +
 .../kernel/syscalls/io_submit/io_submit04.c   | 94 +++++++++++++++++++
 5 files changed, 141 insertions(+)
 create mode 100644 include/lapi/aio_abi.h
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit04.c

diff --git a/configure.ac b/configure.ac
index a0ebbb34d..ee46e3f24 100644
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
index a1ef7548b..18182a2d6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -696,6 +696,7 @@ io_setup02 io_setup02
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
index 000000000..d085d3238
--- /dev/null
+++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
@@ -0,0 +1,94 @@
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
+
+#define BUF_SIZE 100
+
+static int fd[2];
+
+static aio_context_t ctx;
+static char *buf;
+static iocb *cb;
+static iocb **iocbs;
+
+static void setup(void)
+{
+	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
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
+	tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout);
+
+	if (evbuf.res == -EAGAIN)
+		tst_res(TPASS, "io_getevents() returned EAGAIN on read event");
+	else
+		tst_res(TFAIL | TTERRNO, "io_getevents() returned with %s instead of EAGAIN",
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
