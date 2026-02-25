Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A253DFCEE8A
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 11:30:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 519B53C7A5F
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 12:30:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 143EF3C7BAA
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:29:30 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E9111400070
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:29:30 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-c6541e35fc0so4031743a12.3
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 03:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772018969; x=1772623769; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRmJznArHiMCLfER7Bd4wuOMzDvgHGpbVb1SKjt1PZU=;
 b=OQQ/jh5xwEXGnoYuPeHaHqn/fTdtRf/h6mgg8oPtewW6gGrhZ4w0qXNql9iOlHwbhX
 +OwUxe9922JvMo/XchTxYIEoKuqnIjbRlGZRcHKsdxytIDKMW9+FP/kP5u0b2r4srNln
 lBvMovu1KOvp2M+aZmjKSSGqz5zuFHJHMZ7lh/apsxFIS0kzZnIUHDdPJ0vLAJNbpTOM
 N6NwyDIGq1IvE3xp7EdAyElg/jLUFvWIUDlOtS0AS3derdIDjrQy7MNjSswuGYgh+UFX
 Ko4vAEQsc4VwSgEfGLxGDhSZWbfWWFqVfCPVvMfuerGO/bVpNj/jytWHNLnQkhAzRlbD
 Xqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772018969; x=1772623769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DRmJznArHiMCLfER7Bd4wuOMzDvgHGpbVb1SKjt1PZU=;
 b=EehrWyZbsTygtTmTNdSS7JC2rrQneqqIkG6LgjIFdxrcuqzuUsoPNvMxQ7NkqEe++v
 qtngimvY+Zcam88fxLbDy99yujJy/eLLOqL/oX9jtf8fKOZwtozkKjjxOosK/lFWBqfy
 ET8j2J7JoMc0LGboD3RPE9vPU60upzpiHXtrFlCP07y9L8op4NWZ1bhW7m1yIxC3JdZt
 Q7GruY7QcJFC1Uu2PECCy3DApbAW77E0b2fXgn6veyPQylHLqmIH+pOPYjwE1oaN7bLF
 RwA7iF0BgnbYFVFroGQcjI84V/xN11vkUMGVbTICOj2voXePFK20JADw/nOPIjGOqxu+
 +jyA==
X-Gm-Message-State: AOJu0YyCwQpXen0P6ZrVZJdwwqgieYnf+oME9VgiRHEgQ/8kZMnf377y
 K84Ryy40YL6lMtKF4Fc22zPq0/bterf6msU7uaP+LiWGNkEjwJWR+eboQQAQeBhi1g==
X-Gm-Gg: ATEYQzwmuvonB8/Rlx+otDT2YXz+mecfSexHOHCEjES1wGpw9q8s5wE/HM3/svWs1gq
 U6sTLfzIfQEPwIIuATXw0Dl+a5djk43L9ujExihtJ0uFLVr8S6iQsDtERbYOGev2mIhenIFKYAu
 l9b3ujH+/lfeR3TlRJe9uYGLtsyC+/o77qGx2Gm6DoAiRNf6NL7QWBHfQpMAcjOuub0LQC6sZn+
 cvNkIYB3thgt4uAWAbQ1iyv5E1rXPhLknh7BymK7gdfo8DyW0WGJvpQYb6i9F5+wzzjomkjn0L0
 YTioSzEEKxRi6qzKyMv4MOq9Q2SF0je3Rk8S5P9/HHHjEq0Yjun0mT+cBcY5VAE9wE83QtY/B7e
 yVjKKE9bUePamETdT2FUSzmnI1cNZUtXjOtjWM0IF5yRsaVkEBMbPwVpyfcABAvg5LfSxjxmhR/
 bkOA4SwpM/VAFh1EWt6ps8GSFcUmTFS3ldthRITForaw==
X-Received: by 2002:a17:902:ce91:b0:2ad:dfb8:8ed3 with SMTP id
 d9443c01a7336-2addfb890b2mr5775105ad.8.1772018968632; 
 Wed, 25 Feb 2026 03:29:28 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2addc7a9032sm12113415ad.27.2026.02.25.03.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 03:29:28 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz
Date: Wed, 25 Feb 2026 20:28:59 +0900
Message-ID: <20260225112903.1978-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225112903.1978-1-always.starving0@gmail.com>
References: <aZ7Q-PB-_LV2K1xK@yuki.lan>
 <20260225112903.1978-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] poll: add test for POLLNVAL on invalid fd
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
index 000000000..d6019d549
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
+static void verify_pollnval(void)
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
