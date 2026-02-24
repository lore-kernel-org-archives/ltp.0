Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DD4F4BB61
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 17:17:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5FCE3E8B9E
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 18:17:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11CD63E8BA3
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 18:16:56 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 95A251A006F1
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 18:16:55 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a91215c158so38695895ad.0
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771953414; x=1772558214; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUxwzjh1UowHXqLdUZbqiSBYXpRt8y7MKFeW6Mobufo=;
 b=JMGKZ5SG47b8mymMX0qn+ifenXtWsqLIWpaOxIRE/zDyPAiiFJL29joYPTqJ+6fSIe
 b+83pvuPi0nobsWefdf+zRPO+rDv2UVeSHQUhHG1P8npM+fDb2czK1rs5I83sOAIEb2n
 tV7PNEyr8oUoKDZGf+k90xmNVFOEO5KS3+AOn2YcIA+zYypB62HaVQOVzcbrI63xmEO5
 jxztqVP3G/IkSvz3g8tHZVKeA4VOfNwcEWha4PQjgCBfz15REgxWPDyrxVU68ggJRqhP
 43Z/ZANgR4Wux4jkmULr6Wgd9hBdM7AB7cmLdYyVAPJBkuVhImVlDm2pOPNy2bvB4aH3
 wSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771953414; x=1772558214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BUxwzjh1UowHXqLdUZbqiSBYXpRt8y7MKFeW6Mobufo=;
 b=PhEC0sQ5vgk2cS6J2hI6XWGJTwGxXDQETuIsLIH8+8woxVfe3qrdZtkAs5K0fKTfo5
 XAelU45sdnBZ/7HV6lAhrAiQS1eynPxM+hmL+6fqqiKFZUKqYrUC1r+HI4vO5SYB8WSS
 2533eel9pir5JT1ShX3Tu9QhkCvDPgm1az9Qk+NekZOWQ/o/hoXrjPTqErVgNZCSVD3a
 0DaZECpqSr8wPCZoMN9NPEkWBvcSmEOz9ce8lwaGLzc3hQCACVgYw6n3aAEK8siYn7ps
 lrOmIcb6FkFy/CmnonwUEIDaLP+4wiqw91LbUvDWM8+ktY8QxZQMKyoXoc9wWI4SrnhA
 ZCmQ==
X-Gm-Message-State: AOJu0YxjYSPPRTEA/t2xisGf07+sdFwRdNUrpoiOKmFgju1sfxriNogV
 A7Rp6ZhUF01gvbSPgJyOpX179L7KJlo17YFWjOaue0r+lsL0jR19aEGcZZ9hlzOniw==
X-Gm-Gg: ATEYQzzrkM6TVZ4sKOI225Pj7lvmdz8JjxpYkKwd/MYJMwjS4sp8Emhk5BlRSJ1Rhnz
 mBsw4X13EbEGVin4755oYcwI+88NtK6Yx2wt/otJY1R1BA32KH8toQrGhh7z7k7CTKu1suJML+A
 fSWUpg0xNMLZodKfrlfm0Oc2WYoACWNwFmVJmKM+MU8Dstm2+hNUWbLNzi3zx8JllkELYKrvz+f
 jMU7wfRkzOlEVAs86o8bdKyXaW7J6OOKjpmF1agCtCtZrP3upDQpo9G1WDKXu2E7SklQlzOSL30
 3s3GPQRY3qKFXUYdPDux37UiTtIvjCnwLSlJpByQAuIgkQ3D9TSo3JNaBKHXwx74z9KtgIDIvAy
 STfW+cPIEQOWiiAOAWQPkd6herWX97N2ssHHHRlvlmb3rkI6J6Tff3yb2Jhg2lARze/CnT8FO75
 nmppvD0d3xpHlXv8owY0vQ5Dn6EvBItKEuuO5XRRniiA==
X-Received: by 2002:a17:902:ce90:b0:2a9:5b28:94c0 with SMTP id
 d9443c01a7336-2ad744e13bemr105479955ad.27.1771953413901; 
 Tue, 24 Feb 2026 09:16:53 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e3445fsm135384845ad.13.2026.02.24.09.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:16:53 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz
Date: Wed, 25 Feb 2026 02:15:39 +0900
Message-ID: <20260224171609.47265-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224171609.47265-1-always.starving0@gmail.com>
References: <aZ3FiPwPd-eskHCZ@yuki.lan>
 <20260224171609.47265-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] poll: add test for POLLNVAL on invalid fd
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
Cc: ltp@lists.linux.it
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
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/poll/.gitignore |  1 +
 testcases/kernel/syscalls/poll/poll04.c   | 63 +++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 testcases/kernel/syscalls/poll/poll04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 15df7c414..f937dd4c8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1093,6 +1093,7 @@ pivot_root01 pivot_root01
 poll01 poll01
 poll02 poll02
 poll03 poll03
+poll04 poll04

 ppoll01 ppoll01

diff --git a/testcases/kernel/syscalls/poll/.gitignore b/testcases/kernel/syscalls/poll/.gitignore
index e3f66f4e6..7ba7262ec 100644
--- a/testcases/kernel/syscalls/poll/.gitignore
+++ b/testcases/kernel/syscalls/poll/.gitignore
@@ -1,3 +1,4 @@
 /poll01
 /poll02
 /poll03
+/poll04
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
