Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB1CCCD1A5
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 02:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761098734; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=oY4rqLkPcc+n7kh6mGmeXsQi6nwFscqWEP7aTIK68RM=;
 b=HgUgy7pQ9CxQODoi2111BMJfTGEK+QK3LR7jICeZZ/ADCoOOW/l3xBXmXQCOe2nie6m5j
 7RqDvsa7a1QH1iMNKwMSFNS0wAaFOcCLS99KkVB+amuc3eMlqJknSPTe3jDD7SjZPm6DdGx
 bsvXYS1xYi8zzoigTWpj0W3m3SwdRgg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC8773CF08C
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 04:05:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B7F63C2E27
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 04:05:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B802140005F
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 04:05:13 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-471bde1e8f8so15143195e9.0
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 19:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761098712; x=1761703512; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwkQHMLegT6f0xlNEk4b1H5VprQ0rG45BMERy1JtUgQ=;
 b=Xd5VIavTFGSxX1rlfiPB4mADWBm4RQvaIaLq4j6YqAa8slwth2yvShMzARRbM/aQq/
 Xa4AomLEeNwHS2kgTPBTKB/OtJWEyMUoZdqMkXYZh2OR6irdl85lkWLZvmslMEUdwnLl
 MTGF4pBUoX0wJVdRczQzgvikauMaeYqkXdhpyeeAATLJsjsTdk6qr3I+9Z55+9sOZ01M
 igFehB7nb96semeRX131h+2EEC3YatfQFZgeYrV4pmMx4x6aoHM2EsRSuyGgpti0aAMK
 ngz+TB3vRMfiOtN2s447UJ5RF/05E6Q+OQLjZyb8k5YHMVsv3+Dmg7XKMCJqqk70Qz4b
 Mrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761098712; x=1761703512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwkQHMLegT6f0xlNEk4b1H5VprQ0rG45BMERy1JtUgQ=;
 b=wA35H5euBnj3+LWHleGF+kHl2K5eDSA+2omW0rWp1SM4fg5ZemEhDQhZnAvGTDFGdy
 n+tSifxROutxgMh++v4uhJDN3eOhi8vNmSVBLYyvFm75lXbYgxu4nG0e31A7EasQnzhj
 VnwIKgnKWOpeGoim4cmIWbF0d0/1GowX5jguzN6t5PjMvhxrRn4tELlNyhbSWfRd42t1
 ryuxb8aXtQRQG31yTOVrmgwZtKfJv4/rwxXzIq+8dDaD6r8ZmjLFI69oMFb236nxP05u
 MY0v+8HkzcvWcO1fCk6SH0ZYLjHR7Xff2J8YTw+iZxPWRXGmIxhFL1tII+AJOswoCTkp
 eqWQ==
X-Gm-Message-State: AOJu0Yx0pv3dl3XIrqULyiclTBXHvLOlAne0LSfthtKdeBrOiHRb463N
 iuvipDV11R3Yz/16FrPS4TO+isG81xuNlEtRXptid+FzlT2lFzMjubfC+6mo2oB1qbyLBZJl0Ig
 ZLXs=
X-Gm-Gg: ASbGncu1uCQn9IcdzspHcLSGWxbPlnGRcEjgqzCwK3cD9pdkAjPQIVFiTqa9d4/XsQJ
 q1pakNQ0YFJSg3Iwql4Paykp3OP9DyX5nEsDgmpl9nKFtchz90FDTTJT8IdolBNbanXfpyJhKmY
 0LpYgDcwS5yCQikcidqgjAt5KNXySco7B5FEoPbWwy1JvuJETPXxY2YZptzW9CM1oF54NBszSXQ
 ED2HStmG3xzOVrVuTTguPrlwTwO/bzNvyfoi6br61WmJ660AcgVKToYtojS445bXzPnwbuB4WOr
 jtsO7/kq8bNrtquUNighy2GFhcF9qJr2VqZyPKv/CDVWLC5CDh9dy1TwG5dkUD7ej57Yu3K/Kxr
 goGk4zTGkzOOj3nCTaHq/vfCyXKYxujf5DqAIzTDB3jfrIYPkAo6FenxAqtXgSbGLc+cRoB0COa
 ORBttC1K4WHw==
X-Google-Smtp-Source: AGHT+IGzWlJhupkBVrRu4O/ESvofRm5GPYK/65HZ5gN5tOf1bImlBo12pZGfh0lxakD4v/b9kNhpnA==
X-Received: by 2002:a05:600d:41cc:b0:46f:d897:516f with SMTP id
 5b1f17b1804b1-4711791c880mr162118965e9.34.1761098712423; 
 Tue, 21 Oct 2025 19:05:12 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-475c42d9524sm18608655e9.18.2025.10.21.19.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 19:05:12 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 22 Oct 2025 02:05:01 +0000
Message-ID: <20251022020509.6945-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231029012755.19969-1-wegao@suse.com>
References: <20231029012755.19969-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] io_submit04: Add test case for RWF_NOWAIT flag
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
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/io_submit/.gitignore      |  1 +
 .../kernel/syscalls/io_submit/io_submit04.c   | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4b284f279..655a46e91 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -693,6 +693,7 @@ io_setup02 io_setup02
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
index 000000000..5c9c4065a
--- /dev/null
+++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
@@ -0,0 +1,87 @@
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
+#include <linux/aio_abi.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static int fd[2];
+static char buf[100];
+
+static aio_context_t ctx;
+static struct iocb iocb;
+static struct iocb *iocbs[] = {&iocb};
+
+static inline void io_prep_option(struct iocb *cb, int fd, void *buf,
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
+	io_prep_option(&iocb, fd[0], buf, sizeof(buf), 0, IOCB_CMD_PREAD);
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
