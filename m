Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98CDC61DE2
	for <ltp@archiver.kernel.org>; Sat, 21 Feb 2026 13:40:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F4963D0476
	for <ltp@archiver.kernel.org>; Sat, 21 Feb 2026 14:40:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEFC73C2C46
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 14:40:38 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 77BD91000150
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 14:40:38 +0100 (CET)
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a7bced39cfso31985615ad.1
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 05:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771681237; x=1772286037; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mBvjaWoDMNLXhUZZ21KNQjylDnbB1FAnE8Sfemvv6zg=;
 b=SLZssiiT2UZeV51YPCQ1Jhj2GzxYBbAs3Dr/8AxhXfkc/Hf/P4HkGYuNiMECnWyCE7
 HQ3IcEsS/wCw0vwOJLwYsS4uGq1OImohBdqqZCMAu4JI5qXLLeAn+fRJ80oSyiTMAG6d
 lpCQFZLj8haMz2LbD2leIcgNXTrow7oHBlU77K6OgATy72uK9+CUi6agd2vNAzsQ/R0A
 DwWiGAlteUbnMmLXDSit3lhkYUsKPsOUyYEyqrRv0eo1h6cXGqcDmOCH1ac2NPvjTWGx
 F+g5ImHyf2+kh/17zf4IExU16tSNfvGoGpfoeRRnV8BcAi/bCFasp3WSIV3ymGskMzlg
 5Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771681237; x=1772286037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mBvjaWoDMNLXhUZZ21KNQjylDnbB1FAnE8Sfemvv6zg=;
 b=gqcrejGGUHj7xSLXvwK4cZt8uPzvsU0vz2VhWRIDEmSVqfM8umK76lDijqjkloKfS3
 IzhHTH8biJJvv9FVjp+qNA5pLQuNjbX6gACc3/fywb192cdoNdhkAlILFRH99wRsmp9t
 71fkVtqwWdxjI5GYhDOWhB8NYe+lL6a8ybhaBa9TBT6sgG6sG17CPO+jNLeeUYO5PY+y
 a5uNMqsJkd+qfDSfNLkgMXJ4QbPXP5ke/ffdryPmamcUT92kIHuWCKlesjZf7DyaPHfe
 OX/ciFu0qyxOWliFoGfmz4RqlbjgriHyDMq9afSh9nM5WqWX/Dcwifk2bEY6KJdYNCbw
 JVSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTbGhtRLD9nLBhrnljeyqaskNc5NoZV+MaBpdU0gTCbnebuJIOyfYOiZVI0my3apvcO4I=@lists.linux.it
X-Gm-Message-State: AOJu0YxUa55muIgqr3fxK7M+pTeEL+yTHvQlO+TCrxZ/r0iyQn+ALRIi
 qIyXbVsN69qeU6NS8sBFxr5A1JCjFoZez6YoGANxrdAGrG/lttgG65nilucwo1c=
X-Gm-Gg: AZuq6aLAFTcFe5MxZx7YlqSvjp/d003Yw4cJfzqmFpf8mY3nDmwLsOORd0hcT1MYfDQ
 SZa/5IGCxvy050pcrBbeDWM/pqT3CiXyEq/EyzhF4XDPsUlUjbBSFy2gdobz3UHyAqAvy/JFta+
 NwH0DgYCMASqe4m6EV+wZ5+vqYkuGVuhBWLLBnS+Q+oJFLTMh1pPU7pr5lGEQiYRCCnCHNA0tFB
 3nB90NyEqxpteWe9TZhnyBUWYW2OGMzuZUqD64r/331h8ErkA19zfqwko+4EfMY22sd+IEmwYbF
 BLfDoy4ODjD6sdmv+GjIaQNmPPCmrPf8Tvk0/9/m1Lm6ISYf5O4d8YgZXwLqT3kk2SeT607FXYn
 eAGIWNbVoyUIHdCA0cmvMuzVCi9EAxll71VLhKPGb425sJvRMkPO+Qkzjb9q6ZTOMC0/M8RWrU1
 16N8IexvnIdjSNsIX+dnXQSra18ZP5AAfXmMbg8G7+mQ==
X-Received: by 2002:a17:903:4b30:b0:2a7:5171:9222 with SMTP id
 d9443c01a7336-2ad7454a2femr27212745ad.49.1771681236786; 
 Sat, 21 Feb 2026 05:40:36 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75173903sm21624945ad.81.2026.02.21.05.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 05:40:36 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Sat, 21 Feb 2026 22:40:07 +0900
Message-ID: <20260221134014.37652-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZgx0rp0MRHn4mMT@yuki.lan>
References: <aZgx0rp0MRHn4mMT@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] poll: add basic POLLHUP semantics test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a basic poll() test to verify that POLLHUP is reported when the
peer end of a pipe is closed.

The test creates a pipe, closes the write end, and polls the read end
for POLLIN events. poll() is expected to return successfully and set
POLLHUP in revents.

This covers basic poll() lifecycle semantics that were not previously
tested.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/poll/poll03.c | 62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 testcases/kernel/syscalls/poll/poll03.c

diff --git a/testcases/kernel/syscalls/poll/poll03.c b/testcases/kernel/syscalls/poll/poll03.c
new file mode 100644
index 000000000..da90b2945
--- /dev/null
+++ b/testcases/kernel/syscalls/poll/poll03.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+
+/*\
+ * Check that poll() reports POLLHUP on a pipe read end
+ * after the write end has been closed.
+ */
+#include <unistd.h>
+#include <errno.h>
+#include <sys/poll.h>
+
+#include "tst_test.h"
+
+static int fds[2];
+
+void verify_pollhup(void)
+{
+	struct pollfd pfd = {
+		.fd = fds[0], .events = POLLIN,
+	};
+
+	SAFE_CLOSE(fds[1]);
+
+	TEST(poll(&pfd, 1, -1));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "poll() failed");
+		return;
+	}
+
+	if (TST_RET != 1) {
+		tst_res(TFAIL, "Unexpected poll() return value %ld", TST_RET);
+		return;
+	}
+
+	TST_EXP_EXPR(pfd.revents & POLLHUP);
+	TST_EXP_EXPR((pfd.revents & ~POLLHUP) == 0);
+
+	tst_res(TPASS, "poll() reported POLLHUP");
+}
+
+static void setup(void)
+{
+	SAFE_PIPE(fds);
+}
+
+static void cleanup(void)
+{
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_pollhup,
+};
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
