Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861E6E64016
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 13:32:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40C673D2279
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 15:32:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F42F3D0F4D
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 15:32:04 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A8F62600628
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 15:32:03 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso1482232a12.0
 for <ltp@lists.linux.it>; Mon, 06 Apr 2026 06:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775482322; x=1776087122; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Zpl/uuIAznAQK7i0SGnLYs6CPCINXthrI2OlyKR5do=;
 b=H3GsJlBVWpauRtWIma/AH6Ko6q4I+FU6zCPB08CvTHLgkw2JwPgG1Xk2EYxS4Yb3Sh
 Qy6/rnuquhTyHZZtTkjj1fY6EIgOaMpWW8PAKymr9wCBzTNsBnsa9/kywQtrvpWWwPvh
 t1GgOVGw87OFuoNIiBqZjPOu+i45XPvPUla34wQSSeEoOPaGICsLNBmy5sq+aRg1B/2E
 NQh2XosRB8XorI++5jKw/Szu8vrsNEGyaay5oFG3Q8CvPUqMuhD7moH39Kq8XLYlEL3T
 gs/YYhCIT2o2INnVKvYpnTA4rDMwqjUtAOdB8RAI7OrhAPne0nOb+nvPUuxXKi/mjoDc
 Ps4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775482322; x=1776087122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Zpl/uuIAznAQK7i0SGnLYs6CPCINXthrI2OlyKR5do=;
 b=adGar0PNQ3tIxUuiNGU6gkyJUP7npBr3J0zzbJiDxocKXM5KC9x7daU0S1SW5/8IAn
 YPLNkSGAluCEyi0ePC0lCeIYRjCH6Ho0V4VGBWcHY5UKRfpQ/FhmVJVeZGfiSciV0x12
 rY8dq7tRMQDf3GCW+oZaRfV6z83p/drizEzqMeiYg9rGEltM65liNBlslJ10KuyRIq70
 KpF7iwxude7V+dYoIa7/ur1sDhr5lpWw+vM/j45dW0yBnJ/7qNXzuDJArMqDoeO/SPOR
 BUzOVXpk1JDIsS0BdJsFq6JZrqSsIQndzN4LTp/XqoSZoF1U1u40fwrbQFKJS9PzN8b1
 i/IA==
X-Gm-Message-State: AOJu0YzeK2q3c9DbrAAF0bXexuYboe8ltVPvEobxtT4H6l/rlL1gzCag
 0FISeb/f8kUl1ZfqWQ87TnWrz5XB5m/PJIpWZOxXiurpsWxxu4gXy3yTZ49R8bJvNg==
X-Gm-Gg: AeBDietITgkdHaLh3W6WzW6UDuVLBVOXavSYdbeTdV6gFHQEqo6bx0iQVqHSNcGCtyS
 YQAUQOeE3Vj6gjBgNrvqi4qw/oSSZkUW69IMrfeMgB5jPgxz9J66VMpXIpCt8PiIKuXOOG4vMyr
 9tU93dCn84u/Fwkg11SZ+tQcfb6LQ5ywqAhfFHwuSM9gjEjoDcygc7er+C7/VBbYPe2ftj38CKn
 Y0snF/iMFgnpEfQJgzZuq07QVDCEZGobbKAeK/WWW7SMZEoihbX0bAAmV7t/IgvSGUe+Af+FN9/
 /zFhJ8QkGUOsetctg9XB/YfvsazseM5mNjgfZfPCt7U8rH2rS082YvAsNo8DWRMayFY3AMRAp42
 JzKE9wZrwcAk7lLxLZQdeGh2yUORGoHwZh6is0VIZo0caghQeCXd4sylU/pY8vOSP3v/VxsNgZ5
 DQr07Rt7YlIcQjQSS3P6ETBv4v69Yon76ebmXTxpzvOpmg
X-Received: by 2002:a05:6a20:94c7:b0:398:a659:eb0 with SMTP id
 adf61e73a8af0-39f2f01eca1mr11827455637.34.1775482321687; 
 Mon, 06 Apr 2026 06:32:01 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c65935cbsm12800269a12.26.2026.04.06.06.32.00
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 06:32:00 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  6 Apr 2026 22:31:00 +0900
Message-ID: <20260406133134.17238-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406133134.17238-1-always.starving0@gmail.com>
References: <20260406133134.17238-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] close: add test for double close EBADF
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

Verify that calling close() on an already closed file descriptor fails
with EBADF.

The existing close tests cover:
- close01: successful close on valid file descriptors
- close02: invalid file descriptor (-1)

This test adds coverage for a common state transition case where a
previously valid file descriptor becomes invalid after close().

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/close/.gitignore |  1 +
 testcases/kernel/syscalls/close/close03.c  | 26 ++++++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 testcases/kernel/syscalls/close/close03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5a2e8f048..71c2b9ec5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -134,6 +134,7 @@ clone304 clone304

 close01 close01
 close02 close02
+close03 close03

 close_range01 close_range01
 close_range02 close_range02
diff --git a/testcases/kernel/syscalls/close/.gitignore b/testcases/kernel/syscalls/close/.gitignore
index 07d25bccf..1ed7e45cf 100644
--- a/testcases/kernel/syscalls/close/.gitignore
+++ b/testcases/kernel/syscalls/close/.gitignore
@@ -1,2 +1,3 @@
 /close01
 /close02
+/close03
diff --git a/testcases/kernel/syscalls/close/close03.c b/testcases/kernel/syscalls/close/close03.c
new file mode 100644
index 000000000..38950d00c
--- /dev/null
+++ b/testcases/kernel/syscalls/close/close03.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+
+/*\
+ * Verify that calling close() twice on the same fd returns EBADF on
+ * the second call.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	int fd = SAFE_OPEN("close03", O_CREAT, 0600);
+
+	TST_EXP_PASS(close(fd));
+	TST_EXP_FAIL(close(fd), EBADF);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+};
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
