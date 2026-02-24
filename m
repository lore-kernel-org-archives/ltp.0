Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A5BF4BB60
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 17:17:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55FB33E8B93
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 18:17:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 505C93CC5B9
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 18:16:54 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2F311600A3A
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 18:16:54 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso26520735ad.1
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771953412; x=1772558212; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zi56zfgRdLvneD34NszEuTYInaARMED5tKkzKCpZ50I=;
 b=HV4dD27Uk8Nsg9u82W2ERh1eSvb28H27N9kGAyJuMwzHGrotum5BYwRdHhtao+51kv
 QajaSvIE/Jnyia+8iCUvFxe152OTmtgNWE3iH1V3Q4VqixaxVwDhXAa1HvnWybLPVEGJ
 BRC/WT8AQVcM8NM/fR6ljetoTduLsEAmArLnaGKSSWEQUoRO7K5nbdf62mFrSNgJUdya
 53TEHliouXrk5qbaLhDgwELjnIlO05QkIPAXMlY6qw+Q9xouX4eyQ+UdVf6LQ5myU3F0
 WTQ2fZlzY3/2fF+WEveEd1V/rJwfwnuNw/aaRnXK+5aPdK1ian7BygO0zUfZE6lXNps9
 1Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771953412; x=1772558212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zi56zfgRdLvneD34NszEuTYInaARMED5tKkzKCpZ50I=;
 b=HbWOwlz/pGQ6K/uyrRmyqwFtR2/VA/nVlRc0jGP9Tsblhpfu8hhbMFM75zirz6Yf4i
 VFC3Y5s2YtsnaSjOXG1DrPEMJdnFhB2HRd1FUkmIs8p8fEtC35k1mUprqJVXFOg5Xuo8
 bp9FD602HYRLyb6lDDPlbnsEf0fH8X+8sBECy2o0XUt0FdoM2ycpv8HgXGTKBVBVGBV1
 S7ScqgsBS/ED+VxNq+bydjJWGuJLNiFEdzmSjV3grxcyhtgXndnVkx6oC3Dpg3wdSEQR
 el4hFjlivsCuzdISbGMCouqVoNEarbsU8BeroMk89fjteC0IdP58ORKpp1MFXNV2fJyE
 ikOQ==
X-Gm-Message-State: AOJu0Yym7tCM8ik2RIjLY8OrbddpcidehDUUaJO7wFgAlYy6YTh5NMQF
 9vTw9IJUxDVGn+Qke13Z/EZY/vrKmJRJkVMEo3NZ98nHmOA1elfeMfZbYr9ypPKuGA==
X-Gm-Gg: ATEYQzz1KaTY54b++24Tfey0Bx/xpYKnXYb1pDblNGB08gQYCZE+fOSqGqL+E6HezsW
 E2F4hIcVNgTCNTD/0QRaH4q3C8Bs80SE4l4KO/8Q3UJ0FlJklIBueurDflVf/5rzLP8Ts/RN4el
 Tpxvw1HHVqazaKUoUmBhRZpRZkFOCTOkYtjtriED1Oji/MYV77qPl2hT0sE5m0entjk9eSnuouT
 /kngpJDuDQKKiqeYnJkxjYLXk5CLk01/V/f4yCpDY3kkBppkddlOvigaI0FghY5mm6pmJlQ1uCr
 rtIFUjBF5shusydoZgttAcZ7sOS/eBOLzy30pKa+SfI57SX3BD+F7v4QgZLBKafXAPTDlJLxLlR
 LZCjtMnPxu0s8hfFaEJxNhEfFZfezsEPh1D8cVg9uyVcyZMvvPvbBKH5GmH75LZvFl0Hw3vf91X
 06PzqGAOJgsK1hF8c5FQE7bXvvMq/7I5PegyjHYLhY5g==
X-Received: by 2002:a17:903:2408:b0:2aa:f07f:a776 with SMTP id
 d9443c01a7336-2ad74538457mr130778085ad.43.1771953412472; 
 Tue, 24 Feb 2026 09:16:52 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e3445fsm135384845ad.13.2026.02.24.09.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:16:52 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz
Date: Wed, 25 Feb 2026 02:15:38 +0900
Message-ID: <20260224171609.47265-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZ3FiPwPd-eskHCZ@yuki.lan>
References: <aZ3FiPwPd-eskHCZ@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] poll: add basic POLLHUP semantics test
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
 testcases/kernel/syscalls/poll/poll03.c   | 59 +++++++++++++++++++++++
 3 files changed, 61 insertions(+)
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
index 000000000..d621a492a
--- /dev/null
+++ b/testcases/kernel/syscalls/poll/poll03.c
@@ -0,0 +1,59 @@
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
+	TEST(poll(&pfd, 1, -1));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "poll() failed");
+		return;
+	} else if (TST_RET != 1) {
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
