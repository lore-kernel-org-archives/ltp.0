Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436F5E9A04A
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 16:37:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A78813D0780
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 17:37:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EE3B3D075A
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 17:37:26 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B58C560072A
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 17:37:25 +0100 (CET)
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-8230d228372so554953b3a.1
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771519044; x=1772123844; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OK58REe1wJrR4FKb29epYIaM+wMbirUZ1f3Fk3ic3DU=;
 b=ZqRi284gHp1BNSgSZAw1YIjL4W7UQTRxqvY6nneXPItaFu7sufgeMdj45zyjKjGgta
 tmUP/HNwLUF5i2zzVEUsmPmivsreYwsQPh9HPlb9s9KBu4qgwLqEbn6sFI0vnQrBUOL6
 qDF56a0g3aPVBRyWEI8NEqeAKIX5vWy3tmxGxDT7UqpErfIVYYrEX61roLzLp5/22rAx
 t3dP+PS7mbiNaqQ042wb3QSXBy7lQ4A4Gliwq27sJ4MVQ6A0NI5Vl7lse5oQ1sPrGRx8
 X78yL5gZEq/ZdLC1MCtTgSqCIB9FwVxLoBiMxpyEMreHyznIU67KYE3lQ+k4qf17gZ1E
 Lx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771519044; x=1772123844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OK58REe1wJrR4FKb29epYIaM+wMbirUZ1f3Fk3ic3DU=;
 b=UsP2dZ3QV/VinnNcYceuL4417QN+HZXT6ajfojHZrvpXTdBLsWNnN5Crh2qopZgP9C
 wAIALMNjY48yKXpDhBXKwwCSRCkbavuddR4emSX2SXViGBsoe+O4UR2keiMTIT509+Ng
 UvQ/mRRMankTCem73VR0QPWTmk7G9+N4uH1NLFyZ7V6/PnEA4wCy39DmHSkrunOaET1V
 4XdeOdnRgcaFaFAxjPnPuwhI6K/gH8EQ3A0moZc2/BEgecQAmjSeY+U+wDOa5X4/kC6W
 q1PQFzjx3JiJOL9Dpw0y9Fwgs4IMvUGr7rRj1NN+LuTF4rFyVeumoT6xjugy4lMFWJRe
 KDjw==
X-Gm-Message-State: AOJu0YwxMwGns7WiaHQfJEluOq+/IzMVaFwDCdsSER3b3mG0lvtFEzeH
 iSqrlvAwpQNaxjM6fBGs2cuJyNCYb8NarfQS8k6hHJ1PNfdFmO9k44S9qFQ7E2a3IA==
X-Gm-Gg: AZuq6aIHHmE0Wju0aSyPpjtzKYUqdX1Kp1OK+3rtWlu2aXFIWl4wcVpgbbMfw8ksKcq
 HdBijfsExp8JDP3SUztCsUsbY5LUFJlxCbjYZ0kJMmFRxUZKfokRkX5XSpU8vFFNyEul6UXRAkC
 hZuHsd0i4Ft17VAx1U4lJ0b/OV4xGF7C3fnDBaaQHa5f5d8ctF/wgXc8iygGvWz8qUKPLs+gjcy
 L/0syymESaP7qlpGE+C5D2ScXVlfnmZKiwCLb6JnhQBYbl1hDtiIVRjABVc97GKLE/l0Y4fa5DM
 ubkHTet2GRFgcmJaEv5eyia8YDyPc8YA+0Mf/T9AmYatHfwz2R01hIJqCfb2dpW4oEiwy04AT5i
 35anT8IUXaulWQARNO4a7rB++SdWpjaO8ZMnNdM64aos5x0T7vAlmi+Jhr6iXVaiFQnXFNKGzrV
 aiHcOFoNepWdyA2ZJTHomS9UqXdxr4yM2JHlZk/2+b1Q==
X-Received: by 2002:a05:6a00:3917:b0:81f:993e:ecf6 with SMTP id
 d2e1a72fcca58-826b6874c6cmr2675324b3a.33.1771519043591; 
 Thu, 19 Feb 2026 08:37:23 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a2e936sm19376978b3a.6.2026.02.19.08.37.22
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 08:37:23 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 20 Feb 2026 01:36:36 +0900
Message-ID: <20260219163654.39155-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] poll: add basic POLLHUP semantics test
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
 testcases/kernel/syscalls/poll/poll03.c | 60 +++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 testcases/kernel/syscalls/poll/poll03.c

diff --git a/testcases/kernel/syscalls/poll/poll03.c b/testcases/kernel/syscalls/poll/poll03.c
new file mode 100644
index 000000000..01189eb70
--- /dev/null
+++ b/testcases/kernel/syscalls/poll/poll03.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+
+/*
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
+	fds[1] = -1;
+
+	TEST(poll(&pfd, 1, -1));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "poll() failed");
+		return;
+	}
+
+	if (!(pfd.revents & POLLHUP)) {
+		tst_res(TFAIL, "poll() did not report POLLHUP");
+		return;
+	}
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
+	if (fds[0] >= 0)
+		SAFE_CLOSE(fds[0]);
+
+	if (fds[1] >= 0)
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
