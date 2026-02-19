Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA10E9A04A
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 16:38:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A16173D0784
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 17:38:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DBAB3D0778
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 17:37:27 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EA4822005C3
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 17:37:26 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-824a3ba5222so615064b3a.2
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771519045; x=1772123845; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VaaEMHm4xn8ap9BfyhAxdf+0Z1OuCu2IAI6KsnLiDTI=;
 b=hsI+EOABt+E2DB/eXhVFHWg76zA7lCow7qRs7arrW1/6XjdYuq2115reRVyLuKCQv7
 J67DuKGwDEsmwt11nOVZhpmhvA6RKcPtBIPXBRJ3jKIWyAPoZc2e4Pn9ETi1DuCx/C2Y
 fGl8Hsh9BqLoe4z9/1c9IcIH+Uozr/dNYS8AyV6NHilSR/EDKXOfhhxxtWmnxB7o3bym
 95GUYatjoCJ/OU0nfJAkkJKt1t/IQO46xZPT2sy3EZTpVu/3iPG6tjLxTy46JDqnYSMe
 6npe98r7ndn47lZbkmyn8aByC54URi5LI/XXuUueEdtzrD0uYlhRZb5zVLhAgQS68WAa
 KXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771519045; x=1772123845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VaaEMHm4xn8ap9BfyhAxdf+0Z1OuCu2IAI6KsnLiDTI=;
 b=B5ytlcqgAVSi54sfNbZ7iuyYuwB8CM2SK0yaol67cjCfNiVoJckV+nS4dt5zD0bJjj
 5jSIKjhgesKxUD0atMUfyUfGuHPGULUtpFHF9I7NIYwPqkkxaGZQXlLVzgO9lTWKD+df
 VuCYXI62/Gn9LvcIJ4Gqkn9+W49nlbP68n8u5UF9F9ihvxD6YKivWZWgu3ujoilK19Ag
 Qug8VEGxgDC2TFuGNSX4g8BVgrmVBNz+6Lhl9wV3MimU5iJ0ocxFfdScbKZAtt7jO7nL
 2Fq6KBQ+42GkSan+By6RH0HqBkKuKlcSV8NYUAl3vDnnwIy7DXtQIQ3k1GgI0xleOHfj
 SaBw==
X-Gm-Message-State: AOJu0Yzc1MbOrTm+rfIMBaka//hbqujwv771S7JSP39H2jUBOD0Is5Rx
 hsPTB8nSdQGoQKOYu4YF6hEV3aJoNJtDp0YrNfdWwRhcahQnST9/QRgpOQXDRbXCjw==
X-Gm-Gg: AZuq6aJWHolNHmke7zlRUv1K7E3JvS5cs20HIcYZNydcYzz27RA+BlpD7lqDslS9o7W
 3IIoeBhDSJ4gB8eGOqvf9T+uRP9p0MPZpd8WjMR83XdypKILjWjCEXW/cnQ1Qi6N2SvSyJg4Vv7
 WpOUWr7C8T31P06VjbIz4rPsVpK8JuYDGYEAel3s69HNj2p31BAnAl02Pm2IVo8+/8jgf7lfWkR
 uGetT+po1oEnlaqkRCqygljYNdu3S5bXixxmp92LGzxZwX8WY+tsSMXlOJg/PVPaC80tpEjygKb
 AXOba5xxOT92mxyp72eZR9+tOlr03ty1EkKZSC/huenhgIj/kq/6vrjy6jZOhCG8cmLXqqRGyN8
 gvmCubGrq+rhUaFnEum4eg3d+jXlt6vfkoqlQ2hfjbKQtBDNMetCWTmAWaNU9tP08zzHAD8S/uq
 ll+TSzI05SmkpP/dJKa8lL+pPVpgh4J0eAoF6eMA6zhw==
X-Received: by 2002:a05:6a00:1993:b0:823:1cae:10bb with SMTP id
 d2e1a72fcca58-824d962289cmr14899234b3a.51.1771519045114; 
 Thu, 19 Feb 2026 08:37:25 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a2e936sm19376978b3a.6.2026.02.19.08.37.23
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 08:37:24 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 20 Feb 2026 01:36:37 +0900
Message-ID: <20260219163654.39155-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219163654.39155-1-always.starving0@gmail.com>
References: <20260219163654.39155-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] poll: add test for POLLNVAL on invalid fd
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
 testcases/kernel/syscalls/poll/poll04.c | 60 +++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 testcases/kernel/syscalls/poll/poll04.c

diff --git a/testcases/kernel/syscalls/poll/poll04.c b/testcases/kernel/syscalls/poll/poll04.c
new file mode 100644
index 000000000..2013de642
--- /dev/null
+++ b/testcases/kernel/syscalls/poll/poll04.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+
+/*
+ * Check that poll() reports POLLNVAL for invalid file descriptors.
+ */
+#include <unistd.h>
+#include <errno.h>
+#include <sys/poll.h>
+
+#include "tst_test.h"
+
+static int fds[2];
+
+void verify_pollnval(void)
+{
+	int invalid_fd = fds[0];
+	struct pollfd pfd = {
+		.fd = invalid_fd, .events = POLLIN,
+	};
+
+	SAFE_CLOSE(fds[0]);
+	fds[0] = -1;
+
+	TEST(poll(&pfd, 1, 0));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "poll() failed");
+		return;
+	}
+
+	if (!(pfd.revents & POLLNVAL)) {
+		tst_res(TFAIL, "poll() did not report POLLNVAL");
+		return;
+	}
+
+	tst_res(TPASS, "poll() reported POLLNVAL");
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
+	.test_all = verify_pollnval,
+};
\ No newline at end of file
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
