Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB864FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:21:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51EF73E210E
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 16:21:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19C5A3C66CA
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:20:47 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9C6771400C79
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:20:46 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso7984961a91.2
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777472445; x=1778077245; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20+RWMRnNuoaXzYfRoID/2A5zx8Sdc5C8yJorq9Uqpo=;
 b=P3HtWQ0wl5HF7gj6bJdTvSmeeKkgV2OvPg94VgVzmO0ye9tavadUqCa+FlunL/qCkk
 7ISGWR4v6fRb44ybcqfJ9awCZJLaBHyA/Sk/ti3h1tveEiDCwRsfUo/8fzyNka5PFQKV
 4QXIM39B50Qir92IgWrTMYAsEyEphb4jVevaCHIpQ75lDZ0tm+8tWs7gwiEbWmxti9Lu
 zdEpDGFenhEV+wzNFFKHDwUNdBU78aORr7IYcFroAbit26Wu1Nf6nSMoG4HE8AUUs1H9
 jERl2kTI0/aqhx9QfwW/0Qxkpkod64e4rpeDpurk3Kfy5+UB43eV7zuPXsiJCpdz+L03
 XFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472445; x=1778077245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=20+RWMRnNuoaXzYfRoID/2A5zx8Sdc5C8yJorq9Uqpo=;
 b=TCRjSTa099Z8btPNQ+01nm5k4iMzPiNKz/938QdZpA2q2AkuXL5htMOoDGonA005hX
 L53V3G+9zc0e+GAw01znzWDu78gtzjg2dDY6OnAjAf/vMI7JmlMTg+Ht3n3kBxB3/MBK
 LSkvzdwtKKlj+lCc+EI55S63u9Vjzd8k0h1sLMBJu5ocgyCMhFt7/So7DhhVcqbbpCuO
 sunm9x7gP+GWH4PWlwrWLtnxusv5HeExKtfm48L6JfuDDloAOwkM7d425lp3AsXkbfsI
 3evf5hkfmZH9L3K95X1kCrxcTG5uK72i4S9TWLGjVZ7rgK2xeSqlPD7eqEy8kPlHntRG
 xAtw==
X-Gm-Message-State: AOJu0YxUWNpmhWdEu/Syo5i//EqKQwC5YJnwEAwZ6WaJ8SL2ZPsxAUMP
 MSvhqMvx8bhRmvJ1oqxLSysXoakV7NgLP3XPuMRrOFz69D/RRGydh3U=
X-Gm-Gg: AeBDievtb1hDh3PJf+75E5bPqbnNxR6Hf/BkU25hTCsqweLxClGFVKqA1WKqZ7qO7Hn
 XOV2YeuiAToNBkEhY6RpyKJULgWzb1LZZupUNYdvhOJPrUaKqDzbgxpconvj8zs1T6mPe+7DS37
 auhfLsZioQgq2vsbQF3AZ1RHBLBpoWRXL3UgUp4Hou+IUiJzrHSZSzidISaVqC5qy3a8ejownMq
 P9J+rhxLQfFpAunHXhr6TX8k4P++GPFNiG5+515Js5YnN3c3Te95w0jAbaWT/lUyjKh1k31qzIL
 67XhRFLbcEQxvfEq7tmGYEbSx+qxcozS/UkdT9vGujAPZ7tG1QNn1YjjKz2KZ08Eeh1uzbyaslB
 plrZw8rK/khSdayMY1exWr+//xX14Twd6JhTvRL0GFI25JaTaVEhGK3Bc7xIpwgNfv1jmCdzKnE
 HhMfWYSlbVxAw1TMCOEhXhLUOPW7c/+Hyxfl29GAFK0fu0FD+Nu+jNipE=
X-Received: by 2002:a17:90b:4a81:b0:35e:57cf:c0ae with SMTP id
 98e67ed59e1d1-36491fc1658mr8207810a91.7.1777472444911; 
 Wed, 29 Apr 2026 07:20:44 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a0303f52sm4154623a91.16.2026.04.29.07.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:20:44 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: pvorel@suse.cz
Date: Wed, 29 Apr 2026 23:20:14 +0900
Message-ID: <20260429142016.1483-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422114126.GD402660@pevik>
References: <20260422114126.GD402660@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] close02: add test for double close EBADF
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
Changes in v6:
- Use a pointer for fd, referencing the bind01.c approach
- Link to v5 : https://lore.kernel.org/ltp/20260421144246.2046-1-always.starving0@gmail.com

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
 testcases/kernel/syscalls/close/close02.c | 36 ++++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index 617c48237..c54789e7e 100644
--- a/testcases/kernel/syscalls/close/close02.c
+++ b/testcases/kernel/syscalls/close/close02.c
@@ -5,17 +5,45 @@
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
+static int fd_invalid = -1;
+static int fd_closed = -1;
+
+static struct tcase {
+	const char *desc;
+	int *fd;
+	int exp_errno;
+} tcases[] = {
+	{ "close(-1)", &fd_invalid, EBADF },
+	{ "close same fd twice", &fd_closed, EBADF },
+};
+
+static void verify_close(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(close(*tc->fd), tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
 {
-	TST_EXP_FAIL(close(-1), EBADF);
+	fd_closed = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
+	SAFE_CLOSE(fd_closed);
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
