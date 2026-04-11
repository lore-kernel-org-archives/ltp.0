Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCBBF3ED44
	for <ltp@archiver.kernel.org>; Sat, 11 Apr 2026 11:04:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 809BE3E268D
	for <ltp@archiver.kernel.org>; Sat, 11 Apr 2026 13:04:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 653CF3CF0FF
 for <ltp@lists.linux.it>; Sat, 11 Apr 2026 13:04:33 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF13F1400062
 for <ltp@lists.linux.it>; Sat, 11 Apr 2026 13:04:32 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82cebbdbdccso1436951b3a.1
 for <ltp@lists.linux.it>; Sat, 11 Apr 2026 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775905471; x=1776510271; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8eBP1YjoBogaBX/+Bnbn/aJMUD2+nA+csx2I54oe4Y=;
 b=qHfE2JN/8OBdNaJe+3QvEpI/EWJVUylbOKI7UOOgmc6vjXqLggCdE0WVPMRcOPZNWv
 iGcpdwT3df4ZzsZl+th7J/9uVfxZ/8xmXHwnTd0ZO8UvnXkjx0FQdGlN1FBlEAumKE5l
 k8Sx0+6rrqtExZwoyYrdrHP6MeojBF4xsiFBytbhonIf/hXgcP/y5779xAlgzqfMdGT2
 IFQg5gBJtnzKNJL97LII3/ZQbWqbeWefey5xKpJfbMLy3FNbBsILHp2Bsg/Z1vgjasTq
 g6PxCeU6x3x2iFyBNi4OrnbgFSxdU5SpSPVD6PYLkqBZMsaMLewI8F/t1QL7q1UQWXvX
 ohJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775905471; x=1776510271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a8eBP1YjoBogaBX/+Bnbn/aJMUD2+nA+csx2I54oe4Y=;
 b=YCUT12w6/yCKdlqNqRVa24bQWJyWc9N/WZ7R28zPU9+FHae+EBt5BnrS8j7fmvcnfi
 lSN6COI56XzeforojM5w8sr9nZcrDK/u1++DWytliynmELilR2FyADfY0fQ14oGVR2O2
 K6JtLscw7P/SjZYj6g28L49cmoWMQyVvPXSx5VAxVIko3aLZBAP6BIkFH8a20MUY7LLp
 Q8Kn7slg0eyC8yfYFk9bywntoHadxb/jH5uQTyH5hMrEvySR3mcdcnW5Cw3oVqZuf8V+
 3AzS2lNELDG11ofUXNZtQccz/xA/pqrWkZDoCbPyXU80Qvh2KhZ6IFht7QfrLoDtt3bL
 Z/4w==
X-Gm-Message-State: AOJu0Yw5zixcLH6bDsASqDiaT62levnIUL1Ou0SAdCoJnQY7na2xtvh8
 ixdbRrH0fWRCLXh0VVkBUKKjC1Wc/xBsYSDtyEmSaSWHg+ToZtuCtm0=
X-Gm-Gg: AeBDievn9HS/ngOvpJMmCKMIm09rtd1zbTKz5AqEf951kP9+6Ac/Q0e7okZoRc7zNyX
 KLu7zuEAGjO1IRleKk+18z3hoygaMDoBnAq58UHHKttftKzL6rQA6bJSqnOJd82b93HM217WpOb
 P4n5Gi7pC43k2cDqDkWjgYaXlDYRqhV6+rrtGOqLUVQL1E/p2C8jRCGONu5hVRJCNLXbfgE1vc+
 cjZaF6k7DdmIbsdUb1acQFlHYe7O5DsiRSYY5uRDT3YapBs/qhZ610WJ4XW0MxKP2yMVK57LfUP
 UfMUbRjqpngJfWXcoBJ1Ss2nj4DZV/Ot4oed36GTClM8zB4F7C450K6VcPiOl94/hQWCfyXNBAd
 87D9TFpgYc+76O+2NFYncfzw8+ZK9TQFYTVJa+FbkKfbYOx7VaLuEKNRnVMvffIXyZZc6u6taMG
 oJi7hyW2kxYrmihanGXKfmZOw+jLy/DpjNLi6uFvvKtw==
X-Received: by 2002:a05:6a00:1f18:b0:82a:76ab:3279 with SMTP id
 d2e1a72fcca58-82dd8a1d540mr9089419b3a.4.1775905470956; 
 Sat, 11 Apr 2026 04:04:30 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4b251esm5242114b3a.37.2026.04.11.04.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 04:04:30 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: pvorel@suse.cz
Date: Sat, 11 Apr 2026 20:04:03 +0900
Message-ID: <20260411110405.7330-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409081546.GB96667@pevik>
References: <20260409081546.GB96667@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] close: add test for double close EBADF
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
Changes in v2:
- Add additional test coverage to close02 instead of creating a separate
  close03 test.
- Link to v1: https://lore.kernel.org/ltp/20260406133134.17238-2-always.starving0@gmail.com
---
 testcases/kernel/syscalls/close/close02.c | 42 ++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index 617c48237..768361e56 100644
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
+		fd = SAFE_OPEN("close02", O_CREAT, 0600);
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
