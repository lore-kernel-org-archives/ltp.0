Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02992F34C65
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 16:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 726D73E213A
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 18:55:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E15313CD98D
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 18:55:24 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B50C6003BF
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 18:55:24 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so4193064a91.2
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776099323; x=1776704123; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0FFlJz2ZE4fMIVCrBob0heKs3fJzd9eIwkyCmz0x7U=;
 b=KNkH2n1N9ecS1xRQBfXaJnHqAq7kaBxnW3f5RhgCrgw2KBPY21XmkkyjzIQ09mPUy0
 Bu2FwqzX5OKLw4MFxIHBQgGn9B5z+q8OR14lx0u0Hy9uWJOWAD+57RtX+h0oxfv4qZ1U
 Rlyw9jinX2GLaado7kEiU7yHizWkOUOcJr5Uxn50uyelkS9Uu3Ox99pX0BQMqHT78weK
 svNZUrt3eXy9Ri7unYkEQnv07AtukreSCGT0O+fN43nZhRx4deZT3pcZ0ZUBr5BTm/tm
 OKsgAycEMU8C57jK7N6UA47nNGCzV4ZmQbj0/dEXJdaqfUxNIvwYI3nNdbNhjriagDFS
 Bvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776099323; x=1776704123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g0FFlJz2ZE4fMIVCrBob0heKs3fJzd9eIwkyCmz0x7U=;
 b=Kq25nvNbLT1NCtKh/HINwodSY8D4xk4BWRsn+5udytZjo+Ah0H6H5bpYKBkuYsPA+L
 NjDNxjfAWJ/AvnO/IY7LI9VzrZyaxhXXg9b/+KQoofspSxmixXz+ue0IY8vyAVeR0vrf
 3tN5DrKnBNg1ad4OkoU/WFjp7EzP20sD986J5ZwGdStCCXovDJmNezRAGAmH3F6HUV9Y
 uBxIBDjFc0KWtlaCrOQLABiFUvRt3G0PbFEBV7ZtkH1jwNEK/54CXlhBofUjZ0BFuDEi
 9qXlQqgF56iILpa93OOnTCwHT5TnWLzgiUjI8ev/C8soNDStPkf/+b4annuFVzwd9my+
 nDfA==
X-Gm-Message-State: AOJu0YwiCD815CByECVjv90BHnEGJc+Jv5nEPlpw49DFKoVc6re95VOe
 LcC3Ihi8nTVJQggz6UIFNYx2xUwegYVVdYCPMwDfaoZHlY6XXC/q16g=
X-Gm-Gg: AeBDiesWfpoJqclPMl7ZG6Tfp8jtvXciP89yj6D7nqYsDku9pneUOvsMN3vm1M5gyuo
 hrvmC1KXgo67z+6CTvGQ1RywmEaosXMGIEaO1uTo+TXXP/DrV3P2JNLz/Ijwkk021pCfsGKd+gj
 NM//vgj64uHD+FqY5bF8Crnwu5/s9uEOLKK2X3JkI7nGd5H/LIyGBOO78Kp2wD3BxqMr/qNgYwH
 PPBtg/NhJY41mCEd4xHOSj3AeuZ8X4zWt75n2mIYSoHZ3dyoBK3GbTJ2g2nCpsl19mYb2+SrSU4
 eAfkPJyjOsr92LokeNVNNC+pFyXT1506tphy6JIVBW9Eo/zbHp03/vNFI+PII2Lc/vO14sRAuiv
 R9zP9ZqWQ28X/tvg0z5gfLEgC4d2fiODU4j07wjmckfbEuG8ZHbk6KafiEEQfGBRxTa0KeH3zJk
 xFlMteHAbeLvF30+b4kBMEkWf8V3griENCJevnL8DulDez
X-Received: by 2002:a17:90b:1345:b0:35b:93d8:6aaa with SMTP id
 98e67ed59e1d1-35e42840b1cmr15881865a91.19.1776099322683; 
 Mon, 13 Apr 2026 09:55:22 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e3517f2a0sm20817930a91.17.2026.04.13.09.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 09:55:21 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: wangli.ahau@gmail.com,
	pvorel@suse.cz
Date: Tue, 14 Apr 2026 01:52:57 +0900
Message-ID: <20260413165457.1349-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAE1O6mgFhsT0XP33=8Ji5dJPS5d27Oz8A74wWckcDX0c4LVHxQ@mail.gmail.com>
References: <CAE1O6mgFhsT0XP33=8Ji5dJPS5d27Oz8A74wWckcDX0c4LVHxQ@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] close: add test for double close EBADF
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
Changes in v3:
- Add O_RDWR flag to SAFE_OPEN
- Link to v2: https://lore.kernel.org/ltp/20260411110405.7330-1-always.starving0@gmail.com

Changes in v2:
- Add additional test coverage to close02 instead of creating a separate
  close03 test.
- Link to v1: https://lore.kernel.org/ltp/20260406133134.17238-2-always.starving0@gmail.com
---
 testcases/kernel/syscalls/close/close02.c | 42 ++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index 617c48237..3b3c61b1e 100644
--- a/testcases/kernel/syscalls/close/close02.c
+++ b/testcases/kernel/syscalls/close/close02.c
@@ -5,17 +5,51 @@
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
+enum case_type {
+	INVALID_FD,
+	DOUBLE_CLOSE,
+};
+
+static struct tcase {
+	const char *desc;
+	enum case_type type;
+} tcases[] = {
+	{ "close(-1)", INVALID_FD },
+	{ "close same fd twice", DOUBLE_CLOSE },
+};
+
+static void verify_close(unsigned int i)
 {
-	TST_EXP_FAIL(close(-1), EBADF);
+	int fd;
+	struct tcase *tc = &tcases[i];
+
+	switch (tc->type) {
+	case INVALID_FD:
+		TST_EXP_FAIL(close(-1), EBADF, "%s", tc->desc);
+		break;
+
+	case DOUBLE_CLOSE:
+		fd = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
+
+		TST_EXP_PASS(close(fd), "%s: first close()", tc->desc);
+		TST_EXP_FAIL(close(fd), EBADF, "%s: second close()", tc->desc);
+		break;
+	}
 }

 static struct tst_test test = {
-	.test_all = run,
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_close,
 };
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
