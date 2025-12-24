Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B38E7491E
	for <ltp@archiver.kernel.org>; Wed, 24 Dec 2025 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766566233; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=kRTvY5wqVK1apnwroprMOMKJaBwEH21eAZFoyg8JBeE=;
 b=PvcgPZmkqCmwJbyIybR/XBWFLDU4o0Wk2KrrAssRvrudfrH+iOjzFj22I+rHQHc3RSwdg
 f2HoPbg5b8R8d7R5+cqOmMGgfRAESNPL3MgazvZsO50+djkrdx4a4Jm/jCbav8KN2UHpgFa
 lEITFscqmurLa4v77AO+cUnXsLwe23s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88CA13D050B
	for <ltp@archiver.kernel.org>; Wed, 24 Dec 2025 09:50:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B187B3D000C
 for <ltp@lists.linux.it>; Wed, 24 Dec 2025 09:50:08 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D68FA1400452
 for <ltp@lists.linux.it>; Wed, 24 Dec 2025 09:50:07 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso4586304f8f.1
 for <ltp@lists.linux.it>; Wed, 24 Dec 2025 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766566207; x=1767171007; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DD4Up3cFj4ojApZ13/LIeW45xcjkqVuhtfs+DTxQIiM=;
 b=HUIg1Qu7jU4hGJ7EuEe3p2Wq151MletnSF3S9cKR8etvRKv9uyHJMsM14AfA5+ghUT
 WV+KVhk6Z2VeZ3dlWAcsJrMRGBQH2PbQLOLZf6xD8HJfbh0Toxgtpwm0Je/LgVYUU6H5
 O4ylVScFvEbrw0jE0EJW5whtIk3Dvr3nrO3asUjnFXzgV6zZF/nUeERioqdM2KQAsV7K
 UUb0RDpJ+804lE5LrgWuxUpirtwZ5Aqldr/BkTzEW1SD21T1rIs0wpy1ZriNVf1UR0xc
 xiYcDAqaHjwPnBQZcR8rO33pekbALrPNBwQB7AbZpnm/Wcooc28m4flAv/03GXwrh2WQ
 McsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766566207; x=1767171007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DD4Up3cFj4ojApZ13/LIeW45xcjkqVuhtfs+DTxQIiM=;
 b=V8BYMe/TaiKpKFXGMiG7dM2kqf3Geu8GP46whLE5Sq+ehR/AVA19nsluxgaq+M/5+F
 PiRALXw3Q93uN+a0yuOvUMRsJnVzWPuNJdF0pxdy444OexnfcHz7WQdUfC9XCpWwWRG1
 62vwN+WIVpsmIpVDDOQxkp5rudlY/NEsZOUqbz6jdnKp4ku3K3gpRJuf5Cu6jD7IMO2P
 ebyBo5cL6GBAFElHFY9ByoLQCxkxtRwlyLiI0ctjj0xwyRUvjdzlb5hbYn4gKU08RC60
 ii9JgLohMl3STZPUTNQdX/IumcCB8ddAmBH1qq8qJrP/QlzROsQVwH8ocX5DewdCn0Jw
 Uyog==
X-Gm-Message-State: AOJu0YyE6pZTkqWrbTqsBxqjHzcNyLk+s9Y5i3C5FYB5S9S2Ol8Fzogv
 07z5MGHErABlXfJvpEiyxPoYVMbOukNYarZ7RqpWSUhC9fujJpXJzfrrh22pyf6h6N0r4TcufU7
 eaZo=
X-Gm-Gg: AY/fxX5eRB5V5cRQCxcxREgs8kh2ePujqI5dgnu9AGU/15WdUdBgt6LrSgSLfToshHz
 KiYGLFALxtnlqEWJl2xn//J5Q5NlNgWqYVUDGko91r/FmpgBmUuweaBP+aocl/uZxl02z9duZFb
 lzfcB0Ort9UlNtgJGGS61gOeSN+T0EuND+yzk6CQQLDx91Phrt/5S5OUBjwVOr2mqPrfVhdFW77
 WwvbBE0XhJFz+mRclv3AziRdPd4iEkfuQAPy/ybggTPPh7p5CzLWIEUV1Rcd0Py4ybkAegRIMDD
 D5eNR5cfUzX+DayhPuCweguGuiZ2px96SfARmerToKGsE0pzUq1xa94xR39Q4HmgpeXiRToj8JD
 C+I2lLzOtuY+89FNOV/kdL3Nxpz9NEifpvB3b455jMmvcNb8mfgN+CN5qEujCShbleZ+hnbEB4X
 A=
X-Google-Smtp-Source: AGHT+IF7lCORiO4DPHgAw1u1B3TKcEROlxxdcbxI+4vp+dCmp4xdtsuUnyARDc/Q/91dRciWyLMFhA==
X-Received: by 2002:a05:6000:2dc7:b0:42f:b9c6:c89b with SMTP id
 ffacd0b85a97d-4324e5104c7mr17156669f8f.50.1766566206904; 
 Wed, 24 Dec 2025 00:50:06 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4324e9ba877sm32303358f8f.0.2025.12.24.00.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 00:50:06 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 24 Dec 2025 08:49:52 +0000
Message-ID: <20251224085004.10267-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022020509.6945-1-wegao@suse.com>
References: <20251022020509.6945-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] io_submit04: Add test case for RWF_NOWAIT flag
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
 include/lapi/aio_abi.h                        | 44 ++++++++++
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/io_submit/.gitignore      |  1 +
 .../kernel/syscalls/io_submit/io_submit04.c   | 86 +++++++++++++++++++
 5 files changed, 133 insertions(+)
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
index 000000000..bae89828a
--- /dev/null
+++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Test iocb RWF_* flags support: RWF_NOWAIT
+ *
+ * Checks if an asynchronous read operation with RWF_NOWAIT on a blocking
+ * resource (empty pipe) fails immediately with -EAGAIN.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/aio_abi.h"
+
+static int fd[2];
+static char buf[100];
+
+static aio_context_t ctx;
+static iocb cb;
+static iocb *iocbs[] = {&cb};
+
+static inline void io_prep_option(iocb *cb, int fd, void *buf,
+			size_t count, long long offset, unsigned int opcode)
+{
+	memset(cb, 0, sizeof(*cb));
+	cb->aio_fildes = fd;
+	cb->aio_lio_opcode = opcode;
+	cb->aio_buf = (uint64_t)buf;
+	cb->aio_offset = offset;
+	cb->aio_nbytes = count;
+	cb->aio_rw_flags = RWF_NOWAIT;
+}
+
+static void setup(void)
+{
+	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
+	SAFE_PIPE(fd);
+	io_prep_option(&cb, fd[0], buf, sizeof(buf), 0, IOCB_CMD_PREAD);
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
+	if (tst_syscall(__NR_io_destroy, ctx))
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
+	if (TST_RET == nr)
+		tst_res(TPASS, "io_submit() pass");
+	else
+		tst_res(TFAIL | TTERRNO, "io_submit() returns %ld, expected %ld", TST_RET, nr);
+
+	tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout);
+
+	if (evbuf.res == -EAGAIN)
+		tst_res(TINFO, "io_submit RWF_NOWAIT flag check pass");
+	else
+		tst_res(TFAIL | TTERRNO, "io_submit expect EAGAIN, but get %s", strerror(-evbuf.res));
+
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_AIO=y",
+		NULL
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
