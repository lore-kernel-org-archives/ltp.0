Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835DFF8FA87
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 14:43:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43D683E53CE
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 16:43:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 377733E1B27
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 16:43:12 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 97720140053B
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 16:43:11 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-35d94f4ee36so2594887a91.3
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776782590; x=1777387390; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yj6XZTiYQOuhsxv6ITQTS+TTJBWVdw1ba70GugVhvm0=;
 b=g0/zfSXpZ5CEEJzxqVjxhLnemirY+gjntBuI1wM6vdmjJnXccEYvM4WbQ8x02Nb0g8
 utOXk1ogSKsHhv1E2CoZNdqu2qx8owWvo7KqkfJnvFZz3eMWkMCKi/LHFeZL/XJ5u3NU
 NmfIjAh90Adl+2VBmEzWFuI3KL5afEvIumeWhrA8YaWXiK0RT8hx/ags8VxTcQZNz2T/
 ZRf6EgrjhFCR2rgo1J0am5loUCNznLP5AoDU8NkD2/+jnaNXPcvuK7lNiP9GD5HWyMaU
 IKMS9+OnaEZ2SEZmHEA3Ep7ow1sQQfKe481ZX7EAgNTihdXQzkJPYPpjPl4zaEQHvjlq
 ruhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776782590; x=1777387390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yj6XZTiYQOuhsxv6ITQTS+TTJBWVdw1ba70GugVhvm0=;
 b=LV5Esqvi+eqm8uFiuhGbnzRO3ideuVgigLCHZI8/q2SGBoASCadz9XOHB3au3gIzIv
 m1nwrPXI16Cj7G5VO+0vn6VptJYY1Y+T9/omlu5D304anmovuYqSu4uJiUzxkfunoLX5
 wSfN4O9QScUo6a2P7t3pjukEKkplnkgCbLTEq/cXRaHAoBX/pgjj8Oawc3HAzFaxewok
 3UZnqHP/sX3h6hScGI0FAeoibeaNDDqlUoXlFFCg/aD+zCCLohsaTABvj0Funs8vLqRg
 XLIX9MeYJwMkZYtGIKxA6E9br55+Aef5nuGCcF7SOh+p88mSM8Rx3Oqd6Dipm83c+Bwe
 dCzQ==
X-Gm-Message-State: AOJu0YwtYP6PImExluz0bZ0WWXN4LjLjx3x+cWT1OoD9bpZxKqKWKGk2
 Wtzmx9apuC8Pb4kLbU+5L/OWUGKWlTnCSAT9r7o++l9lj6BykUsafa4=
X-Gm-Gg: AeBDieuN9GMj+RLLPvoskZgN4I6FlKqo37/lrnkP+3lU9PeDQH88/JrgYTup/TKeoQC
 7TWMlfAqZ2RAwlnEt/oLDdYS5XFu8MPxix/URqiUH9A/zXSE4dcAJMW2e/veAFhxBdwgg8HFw9q
 5Kxc2Qk9NyUziYAD2rtlfBD7h4tABgYRf3CZgpu+XXVDz3r5pKzL7sxfToMYthEVaoHHSzEcGfQ
 Uqkf9xrIrX9hAuEdkaLid1xmTXiVMf05PBfl+SX9ShYrb1X/GVLhW69rcEqNH5um3UVSEQCud6v
 0wi6OlXlDV1AIPnCD7YVXWE3i/saVFWIeFdACgZbiEfpYZtCRTgfmlwKltNvdN6Xe0edrrl5qfE
 18VDDbGjt9A5mhmuIH+IFVxAgM8kkZY0PiUsQV+EdEGeYmOBC0aVaqA16Z4MK5JfWAZXOR2uQY4
 hUbQIb60ovc+Y3XtTzRZuZh3Tuc5LgMi59JwHAzqqeDbU5aBfK1QD4U6E=
X-Received: by 2002:a17:90b:164a:b0:35f:b572:ece3 with SMTP id
 98e67ed59e1d1-361403bd001mr19032346a91.6.1776782589751; 
 Tue, 21 Apr 2026 07:43:09 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7ab7sm17703387a91.10.2026.04.21.07.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:43:09 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: pvorel@suse.cz
Date: Tue, 21 Apr 2026 23:42:44 +0900
Message-ID: <20260421144246.2046-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417115648.GC409289@pevik>
References: <20260417115648.GC409289@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] close02: add test for double close EBADF
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

Verify that calling close() on an already closed file descriptor fails
with EBADF.

This test adds coverage for a common state transition case where a
previously valid file descriptor becomes invalid after close().

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
Changes in v5:
- Change file descriptor as static
- Link to v4 : https://lore.kernel.org/ltp/20260416125554.2920-1-always.starving0@gmail.com

Changes in v4:
- Remove enum, add fd/expected errno in tcases, and move preparation
  to setup().
- Link to v3: https://lore.kernel.org/ltp/20260413165457.1349-1-always.starving0@gmail.com

Changes in v3:
- Add O_RDWR flag to SAFE_OPEN
- Link to v2: https://lore.kernel.org/ltp/20260411110405.7330-1-always.starving0@gmail.com

Changes in v2:
- Add additional test coverage to close02 instead of creating a separate
  close03 test.
- Link to v1: https://lore.kernel.org/ltp/20260406133134.17238-2-always.starving0@gmail.com
---
 testcases/kernel/syscalls/close/close02.c | 37 ++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index 617c48237..a48570d12 100644
--- a/testcases/kernel/syscalls/close/close02.c
+++ b/testcases/kernel/syscalls/close/close02.c
@@ -5,17 +5,46 @@
  */

 /*\
- * Call close(-1) and expects it to return EBADF.
+ * Verify :manpage:`close(2)` failure cases:
+ *
+ * 1) close(-1) returns EBADF.
+ * 2) closing the same fd twice returns EBADF on the second call.
  */

 #include <errno.h>
+#include <fcntl.h>
+
 #include "tst_test.h"

-static void run(void)
+static int fd_closed = -1;
+
+static struct tcase {
+	const char *desc;
+	int fd;
+	int exp_errno;
+} tcases[] = {
+	{ "close(-1)", -1, EBADF },
+	{ "close same fd twice", -1, EBADF },
+};
+
+static void verify_close(unsigned int i)
 {
-	TST_EXP_FAIL(close(-1), EBADF);
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(close(tc->fd), tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	fd_closed = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
+
+	SAFE_CLOSE(fd_closed);
+	tcases[1].fd = fd_closed;
 }

 static struct tst_test test = {
-	.test_all = run,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_close,
 };
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
