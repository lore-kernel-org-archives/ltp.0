Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AAAF8A171
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:56:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D61C3E2928
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:56:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E83993E1685
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:56:22 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A2DD2600873
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:56:19 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c74f0c3fc16so2855588a12.2
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776344178; x=1776948978; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9eEJKgB9g7s5Rq5JAJgz5oq9E/3l59wVg/oFVxPDec=;
 b=cxEACefrowWv0mUBCxpVb8cgadZ/U37wz1KSHTuYhnXyA52+wvrlA2NQaNmGcuqamE
 DnRUQjhWhSVH1xZ/jmT8U8rjOjEWr5woTQgQOdCuRcszCwt2Iyv0pEkfzXwUx0OvOfki
 ow/UZ+0kRvw3E6pFE1sqArblnAyu/fF7bp0ueyp+EugMnWCrKvEz3trZwydqVQrACzE2
 u9CnBLyXPtzEKEiSNk16yk23l6rUy5x+/+41G3GZ6nDQ0n1VJFBIVDG0vaCNftkS/Q0y
 beh20Ea4y5ypxdot6SlVcoVeTGzMPQLzx4hSBu3jlWbsqL2KYr3R/91+lKU8P2DjZSE7
 UVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776344178; x=1776948978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l9eEJKgB9g7s5Rq5JAJgz5oq9E/3l59wVg/oFVxPDec=;
 b=Ma7YK8m9nLZCMFZvJcjWeXI+yPM5Fdq56aozIzfIOwreqv0K33cXbZ4nmWium+nZKm
 tqE+4I6VvyqEtY0RT4Y4RD2kaxoBu8d7nGjhAdUh2nlmPNZKO8b7QSqng/jcf/s0bLlm
 C5mOJQU3HAf8q5rkDO+gvE03nLM4YsltEWif4+EG3Q24DE6dOTbZUg6+oWr93dsJ1QwX
 TJe3WYxlGBaDxgCdG7OViPfuNCxpRtApGrhFUIhp7mUjpIP626KvijaA/xWhT7uoMo7W
 7uBdia8Jewz+w5SyHirCUQxsdhe/kcKlqtWPagQq5VUW4fTkNabByNjLEHyzzSnxigH5
 mmmQ==
X-Gm-Message-State: AOJu0YyMK08CVfTZW1LZWPAIUU6bTpA0qN6mPCphRyWxS7Y0Ua5uMtH8
 OzUI3YCVV40PP8s8ZUJJ4GeiDyF+eQrOJvOInm96g/bREqUimdTL8P+kZ0aeQIjbc2Ba
X-Gm-Gg: AeBDies4Tlv7K07KvGKt23ZmKRX3p9gBQRNsxj49ZKXfKlrQAV/f766OsBHKgn6peRy
 Y0Ft63aIoRfrcoePAuQaT97AIDwumKXYlBBGTGUgSRtG1TY/EsQJ9xL2RyDIT0PSNQ/mVg66H6y
 pqzsXqfCWYb0mm3LE/XVoSvKERVt7J5VO3E8Ew6rU6XOtusFTyrrzrLcofvigfntXsYU/IIs8U0
 czLo4ptNo4MCceKuHsTWpm83CF2mnkKqtiXOE+BAdfLXJ9Yot6xApa0ghekkBckrREHnQPoJYiM
 XyAN3K2/PheP97T1zvXXVddUrE/klrV3/Yo3U6ccXnWwvmRAZY74ZqjkYPVbOBXW2j0rqRRYSFQ
 L2S8OQuTagZOrlYe2lpPOsfnFWzbvM3oe3wsMau7dOVJKduPtegc5nfBz96dqNm3hfJYSYgs0MH
 7jX1NQEdFukhxV0bPKJOe9wR9c0KaWwvWtPchctAyI9fIWTIR9Sn76tdo=
X-Received: by 2002:a05:6a20:7f89:b0:398:7855:3e33 with SMTP id
 adf61e73a8af0-39fe409bbc8mr29194554637.56.1776344177978; 
 Thu, 16 Apr 2026 05:56:17 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f738b399bsm3282778b3a.8.2026.04.16.05.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 05:56:17 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: pvorel@suse.cz,
	wangli.ahau@gmail.com
Date: Thu, 16 Apr 2026 21:55:18 +0900
Message-ID: <20260416125554.2920-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413204519.GB153189@pevik>
References: <20260413204519.GB153189@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] close02: add test for double close EBADF
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
 testcases/kernel/syscalls/close/close02.c | 35 ++++++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index 617c48237..1919a27fb 100644
--- a/testcases/kernel/syscalls/close/close02.c
+++ b/testcases/kernel/syscalls/close/close02.c
@@ -5,17 +5,44 @@
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
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(close(tc->fd), tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
 {
-	TST_EXP_FAIL(close(-1), EBADF);
+	int fd = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
+
+	SAFE_CLOSE(fd);
+	tcases[1].fd = fd;
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
