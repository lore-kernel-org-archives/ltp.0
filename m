Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8C1CD4F24
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 15:26:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB5AB3D6E20
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 17:26:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F26EA3D0F2F
 for <ltp@lists.linux.it>; Tue, 12 May 2026 17:25:44 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 103F1200ADE
 for <ltp@lists.linux.it>; Tue, 12 May 2026 17:25:44 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-3680540a6efso1778325a91.2
 for <ltp@lists.linux.it>; Tue, 12 May 2026 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778599542; x=1779204342; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlsEPNUL+jScTZ5VJMGEuzBmKpXFNNuXutmCkoRthEo=;
 b=EPlIdJ0esQFUJa4heaW+iP52ubgoqPXpkxL+Y6i9Jt6kEgNrSZVcjIjHl6pafFPf90
 GvsP0pBeKdfKNitoacxegdPvI5gMJQzm09eDEmcnyUb8xJWej3wX4n4SGo5tbC0JitTw
 1q2QIEBFoaFR6pqCLXm7PvaASU3jdFhcMSTyduxFFOCB1xnkw+JsGzQNLOLmdeAIX5PE
 pnAL8wIBxtcwGXf9iCzndKPKeP+34XxzZza07PpTcuu9N3iM0u4RP9ICBtvIpKBX5tKJ
 Iq0S5f9BYF/R0o/EM2j6C7rOdiwOhQlSWKNTcBfIzccTwLqyqQYtdoirb2p4vtP+Wm3e
 GveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778599542; x=1779204342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hlsEPNUL+jScTZ5VJMGEuzBmKpXFNNuXutmCkoRthEo=;
 b=KCahqOvPRuiHfNIxcL9pLOJ+5U7/B+NODLzeETFOLaaIAj98AR6ZmtUlPXSeBLQYnt
 IlrRQ6pxrEqr0U74MbjeGjlMtriMjACY3gueGT7nrAJTFK8brNcOBcFdrFxJC4Y/SLZw
 rA9X68XpLuR62zjRrdo5IZE5mITWIrXHJi0RxxbyIs6o9dNLm10cNl5PIn2pwqz83wEf
 pzgFxk3aWdyJCEQNlLyChuZOrQq5+38jOntKw3anJ9hVMOPizKAa4bvzSXJSW1oxTgNi
 nV95+j057XXLPSNKu8S3DU29ANLfAT4P8x4tLnQgRLX/6vlzOW54yh0zowkwG9+vSvOW
 usjA==
X-Gm-Message-State: AOJu0Yxrt4NUZLRi7WscpFcLbaXsK4RAA5dz9wjLdwnLImC/FcFDB6WH
 SNlKt2ZU+gz44Zt3hHIk+nh/xr6ciU7DaFccs17wSixqib9ZLFLWQOp4MRULkms=
X-Gm-Gg: Acq92OELdQwpfg/k2q6jrga4fO7UjCvAtdFKLs0/6ppvP80LsI+KG3TVfdlXQUVOtsp
 6eSwcl0OnpRRPsMGZCE06qwHj0VtDR+ZybfKPwQSfpljNwf581qtk8BbHsnKHRdKnvjnVHMoFr2
 arIHCAsHHzkKSTf53LtfnT+KqTtqOX+ReBSQiZhbX29LNKwZOKaq3ETLnGIkAivXJJB89HYmJYG
 g/wdGeSH09YMrdbx6Wz7vEExMPVb54t/LeXpSPOMUH72CGG5dzWs5A2CUZfI06Y5xr9+zxKnoS9
 6E7GiXr9QlP0qntjsx868ngBMExEs/EsClSSYt1Uf0VbnmI8sAtIDr34cWQlj42Zg/QdiXxtiuP
 8VmwPXNJ/lqBDorLRIRRJel3QM5d+IG2EH3FfpH3yV6ONfp0l+5figm6poz4I5kpPI7CZ2isnR5
 Jn/XSSuIYLTZ3YlCmmI7kasYV/mHyjugd6bixsVDUBPA==
X-Received: by 2002:a17:90b:3807:b0:368:763a:17b8 with SMTP id
 98e67ed59e1d1-368763a1bc3mr8185919a91.2.1778599542065; 
 Tue, 12 May 2026 08:25:42 -0700 (PDT)
Received: from localhost.localdomain ([1.232.225.242])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c826767e677sm12810731a12.4.2026.05.12.08.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:25:41 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 13 May 2026 00:25:00 +0900
Message-ID: <20260512152517.4120-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69fb2faa.050a0220.230394.be73@mx.google.com>
References: <69fb2faa.050a0220.230394.be73@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] close02: add test for double close EBADF
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
Cc: linuxtestproject.agent@gmail.com
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
Changes in v7:
- Use the raw close() to avoid setting the fd to -1.
- Link to v6 : https://lore.kernel.org/ltp/20260429142016.1483-1-always.starving0@gmail.com

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
 testcases/kernel/syscalls/close/close02.c | 37 ++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index 617c48237..03cce109a 100644
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
+	if (close(fd_closed) == -1)
+		tst_brk(TBROK | TERRNO, "close(%d) failed", fd_closed);
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
