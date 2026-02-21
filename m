Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF18C61DE5
	for <ltp@archiver.kernel.org>; Sat, 21 Feb 2026 13:41:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75C903D0476
	for <ltp@archiver.kernel.org>; Sat, 21 Feb 2026 14:41:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BAF33CB3E5
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 14:40:39 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8D808600101
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 14:40:39 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-c6e191c4b8fso1106947a12.0
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771681238; x=1772286038; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yC5XwUgf8bR0Qyvbdcq4VsNXTAuX9326syTsTPvZwf0=;
 b=L2aHpZuMB/yKBLoqJ7Ygi43W8TWWkA32CRtZpJzEmpRvJaxs06pXk5S7E+k5pUI1Fn
 AYC4iQQ4+TbtgsD2AAQHfM+QPUrKyUsfVYyzQo1tbjWc/sW/ZTA4pIdY2c6onhLZQR23
 GF6bkyuqkZ6FZl4aLRC6au26EQJQUF6NeWOhtnB0hvjoIeWQu5QjMSnjom1bz5nrh11+
 UmH8NxDJd9YBBd7Tg4e/zBmOiSyaOil/hRKl3OOa06RPqtQIKnLzgFGbsR3+D70wueAV
 uSzv+9rfVyyGnJqIrKDcV6w78ip1z3wTJdVe8jHfY7AMV0KbUqNd4lfDGONmxSMgVoCO
 QDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771681238; x=1772286038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yC5XwUgf8bR0Qyvbdcq4VsNXTAuX9326syTsTPvZwf0=;
 b=oC+IUyKty8TGH9mS/ENhHW9lDc5r4VBouOHAk8OgGppjBcTOpeeycgti1X3CUU7mwU
 rqRduaz8yb/AWfVb6ccrJSFaFTZsIznmX8IpxdY1uI/SJBIjqyF37c+ytvzXUGUIR8gE
 7B4mtbSvl1Wfzm06ynTU8kxhawrHfiLpIwmP8/r48tzkiVUqOktPPReFm5F8/y5Il675
 EXpj4oRM5R+lYgT+X1aFgObd/andVKK2TYvDcrcId1GkvzaGFJL7i9UM29F6bn2qa6Hb
 nBBd8gL+VTghZ3M2ISlArVFDmYhPkaSLSsvOSnWp62GV+mNJZrhrVpHWoURW2+Fsn6aO
 whBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyg4R9Us19OwwEReAGsfUPGnanttm7ncWYVH+5Mql7Nr5P5A1ZyNe/M7bjRRvraJsU4K0=@lists.linux.it
X-Gm-Message-State: AOJu0YyfaKjUtJ7H2NVB6QG2kJC+wy3o+sfU7bNxJ5gwG3YN6bJ8bj86
 u1Nbi971DyzHyvA2PQVKZOZ3FC4w76KTVDLVXalRv61p5DZl2slegfEh1R9eu5w=
X-Gm-Gg: AZuq6aJ6ucYAETW+v6UNR4z0npXmNxWJppLXK2BuMUKe5RHRGjACh5scmLVYxpNTjfv
 3tRHVWtOGg0xpPj6KAzx2mskystL4+3sLZX/X4mxzuy2A6pcMgILBI3hxi2nDXtfgemyXaCHy+S
 Q/2jHaYV6GcYk+RJdBoNN+h4e4vvK9DE7k6v5AaEyM66gHmppg0YPG5BbMCbrY+QaWMGbu0HuKO
 rujZOGRfCEJwlCCuADLMmN5cnpMW55xterrtFPBxlKTZdskoIsUGID10oxK4vzIZfEzgbkDltAv
 RRo2Rg34YMAK2bQ4+R0MmF4VKftsGUof6LVTfhnzSkLp9M4zmBexpOeNEXkjgq5Bj6IrSfVg0TH
 2281HZQtMzp91XKN0tnWRczQCydYhU29+0mc+UhiRiFLoioZY83Gd/q5uY7h1TxM5PfhQDtFS7z
 SQwMfp1VOjxZHoHQDOkQl2hoGOQjXJlLuzYMZR0YFC2A==
X-Received: by 2002:a17:902:f611:b0:2ab:3cba:42eb with SMTP id
 d9443c01a7336-2ad7449c9f4mr30272335ad.15.1771681237913; 
 Sat, 21 Feb 2026 05:40:37 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75173903sm21624945ad.81.2026.02.21.05.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 05:40:37 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Sat, 21 Feb 2026 22:40:08 +0900
Message-ID: <20260221134014.37652-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260221134014.37652-1-always.starving0@gmail.com>
References: <aZgx0rp0MRHn4mMT@yuki.lan>
 <20260221134014.37652-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] poll: add test for POLLNVAL on invalid fd
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

Add a poll() test to verify that POLLNVAL is reported for invalid file
descriptors.

The test closes one end of a pipe and passes the closed descriptor to
poll(). poll() is expected to return successfully and set POLLNVAL in
revents.

This verifies poll() handling of invalid file descriptors without
triggering an error return.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/poll/poll04.c | 63 +++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 testcases/kernel/syscalls/poll/poll04.c

diff --git a/testcases/kernel/syscalls/poll/poll04.c b/testcases/kernel/syscalls/poll/poll04.c
new file mode 100644
index 000000000..7645459b5
--- /dev/null
+++ b/testcases/kernel/syscalls/poll/poll04.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+
+/*\
+ * Check that poll() reports POLLNVAL for invalid file descriptors.
+ */
+#include <unistd.h>
+#include <errno.h>
+#include <sys/poll.h>
+
+#include "tst_test.h"
+
+static int fds[2];
+static int invalid_fd;
+
+void verify_pollnval(void)
+{
+	struct pollfd pfd = {
+		.fd = invalid_fd, .events = POLLIN,
+	};
+
+	TEST(poll(&pfd, 1, 0));
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
+	TST_EXP_EXPR(pfd.revents & POLLNVAL);
+	TST_EXP_EXPR((pfd.revents & ~POLLNVAL) == 0);
+
+	tst_res(TPASS, "poll() reported POLLNVAL");
+}
+
+static void setup(void)
+{
+	SAFE_PIPE(fds);
+
+	invalid_fd = fds[0];
+	SAFE_CLOSE(fds[0]);
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
+	.test_all = verify_pollnval,
+};
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
