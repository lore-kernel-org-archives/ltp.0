Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FF5FCEE8A
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 11:29:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 867E73C81BB
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 12:29:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 723043C2C9C
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:29:29 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 083D76002AD
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:29:29 +0100 (CET)
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2add623cb27so4441985ad.3
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 03:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772018967; x=1772623767; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyu+lUPwQFXe39ID+QtlN8Qen38QYDWmyu7tONBDAEg=;
 b=VhxNW02uvCuq1Pa54dIQ4+EGsFw858z5iUogjFsAKTxMzgGURfYoVT0mkJJ6S/DlIi
 uhVnlOj/4LyrHgbTeh3xFbw59Dn1A8hziSxdDKCs4KiKi6i64D5iVhaXfzX8pyXZDrLi
 uqJDWrVwRWUJTirJEfEhlnJcZLbaIpgXvQG7gXHy3F0uvZXQZ1ZVykII6KW1P29c3+gD
 5M8vBMCt8W9kP/pNh+agTxQex8DWSBFScaM96eEdL3HjIIsarFZlkhJ7PgkwFU6xi47Q
 gGO7LQ2ZrHK7Q0tlFdYTNwF2wOPlfjl0++UT8LvzyCDhK5DvuQnBU6BXxm9ysJMtBjgZ
 PIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772018967; x=1772623767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fyu+lUPwQFXe39ID+QtlN8Qen38QYDWmyu7tONBDAEg=;
 b=Nu0XpbqnEmm0g73eKlVGmZVoOjzOvAmbxhsBx2AagvHq/XJD526JPWQoYOk3dk4ZuK
 Hak4tacOfWr2rrj+eERpcUysD+ROM3n/Hb+R+H/42pznJHE7jjwvvcj5y5yGa3jxulha
 p5b7M/GwFluXnU4TWlk/HnFxq/dGSfz4MesxUoU4akop+A9lw4m829D57p20kirzz1/D
 LhRNaebjv/lyHnmMsGcmw5uMASpZJ0jUqJMk5HUotMUTw3M9B3WaqN24CalfEXM3BDpV
 2Vj2yT6MZs0WoomSGJQBZZfEmst/FsFTG1wxxgVKFl8wfHkTbExtKTD1HPuKuSOmz4/Q
 /zlQ==
X-Gm-Message-State: AOJu0YzVx7kioANlVPjjWtRfoGdjKxRscz5efG72z7Qfw2HjiynkFpK0
 QOW1448/NlGNQVlTe/9ivkM/2meSl4QaTgx4cDbGgMzkFYcCJjJzEsg=
X-Gm-Gg: ATEYQzzfxTJycV8rkwIfn4CiAUwDBmkWJGpFHC4w0VJyoDqZaWJUh/Wa7g1irf7M/iS
 DTa/uRLKhpQGpa/QKuojgm8JeeQPkNh1TkjF9P4qfMPqmdsXbD26CaHygp+BUojGCOungs3c/yB
 ggUHNpFJb5C4D8JRU2zpVqe+4PzyUu7TeUwh+6T39JQUP+yZwkmk2N98rnXGPIxDkfW2nfujyKO
 IqRorc/1zfJosrP6iC3DkOgtLrpvcWkbKplfTD7hV6ioNY+ZmHHhapWpEkBGuFQaAeZlHY7mTQ6
 0mAqHCuv7dd/ffTZagjIkDanxgJCL0DRBR+IFneFHKWDEDjgHo8BIQ/qHfb4uS1PrhkWRcaXnsD
 0FSjzN20I47eZVJPYT4eYcT622AbWd701a9mXYSs/dIJxMxUmhZjq4CTkPE/SwVFNgEUJdNFmQ+
 Q/bKR1mj5GKuyF0ldY0NMlOV9qWaE8FhTer6+40a/Pkw==
X-Received: by 2002:a17:903:11d2:b0:2aa:e6c8:2c6e with SMTP id
 d9443c01a7336-2ad7457a8c8mr134519425ad.56.1772018967261; 
 Wed, 25 Feb 2026 03:29:27 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2addc7a9032sm12113415ad.27.2026.02.25.03.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 03:29:26 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz
Date: Wed, 25 Feb 2026 20:28:58 +0900
Message-ID: <20260225112903.1978-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZ7Q-PB-_LV2K1xK@yuki.lan>
References: <aZ7Q-PB-_LV2K1xK@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] poll: add basic POLLHUP semantics test
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

Add a basic poll() test to verify that POLLHUP is reported when the
peer end of a pipe is closed.

The test creates a pipe, closes the write end, and polls the read end
for POLLIN events. poll() is expected to return successfully and set
POLLHUP in revents.

This covers basic poll() lifecycle semantics that were not previously
tested.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/poll/.gitignore |  1 +
 testcases/kernel/syscalls/poll/poll03.c   | 61 +++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 testcases/kernel/syscalls/poll/poll03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 05bb3ceb1..15df7c414 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1092,6 +1092,7 @@ pivot_root01 pivot_root01

 poll01 poll01
 poll02 poll02
+poll03 poll03

 ppoll01 ppoll01

diff --git a/testcases/kernel/syscalls/poll/.gitignore b/testcases/kernel/syscalls/poll/.gitignore
index 83be0ddf8..e3f66f4e6 100644
--- a/testcases/kernel/syscalls/poll/.gitignore
+++ b/testcases/kernel/syscalls/poll/.gitignore
@@ -1,2 +1,3 @@
 /poll01
 /poll02
+/poll03
diff --git a/testcases/kernel/syscalls/poll/poll03.c b/testcases/kernel/syscalls/poll/poll03.c
new file mode 100644
index 000000000..182d8bd3c
--- /dev/null
+++ b/testcases/kernel/syscalls/poll/poll03.c
@@ -0,0 +1,61 @@
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
+static void verify_pollhup(void)
+{
+	struct pollfd pfd = {
+		.fd = fds[0], .events = POLLIN,
+	};
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
+	SAFE_CLOSE(fds[1]);
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
