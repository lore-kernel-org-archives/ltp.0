Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088E8FD8FC3
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 16:00:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D8103CB98B
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 17:00:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E5763CB962
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 16:59:56 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 98D1D1400C74
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 16:59:55 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-c70bfef17a4so575740a12.2
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772121594; x=1772726394; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GPM0vIXpGnqLN0wcOhRaapuyrMeVwp3dDNiGfGq+0Uk=;
 b=HhvFWTBHQ/6gpPqPsOGg/Pk8r2JCx9nNzpzBJg1YhBxtIDTCWPlUTJvEWueH0l+hRw
 IJsiSbatp8PejODkgmZXJqRaj2BhfnJm2gsEgoywr9ojPVn6wMsqhR/w5q/qASuvZAN6
 G8f5zGJvKj08RYJaJJnkGRsyDOe3Nx2mQKbuVai1vqlXu9F7+f/+r1c7yd9yU4qhV02C
 M3hkFPzzAZsQEXbGq8GXN10pu3O5iYNxQU8dmNmZJsjYIgRviilEfNUctgYcdXo6dO61
 uqHu2JyOLgHTNYWYtdxoba0BY8l4Ol4z8FQhfyLWXnwwhF9iRAN2ZFYmE06fLMIBfUTS
 rQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121594; x=1772726394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GPM0vIXpGnqLN0wcOhRaapuyrMeVwp3dDNiGfGq+0Uk=;
 b=oa16rPt+MIDjdht2gihbf9QwbD/CalnbzG5YnEQP3Y42Xl0Ks7UB1QrmvQjhxyOJAg
 eBJBmldFo1pBAZEW41eJ99SX3jfBrIzOA1joXJTiLpqVF5Tz2PTQoj6MTWIctrbRJcub
 31kXiHfhPEqxH9XJYgDlBrgjFaYTMIUITe0yEs0AbEqnIcLeu1PZQLvy/Ia0Rd0PR+4D
 zMGUsilCJNBQnuObHIXj7gb/cIhg5DD5lSWnUwUGZ4t2BeyKjXCufU2HKmgswVAQVG8E
 mJsS+v3wd3qH4Oq53j6xHynOmvwKnTmysWSNybHMgqw0b24iZbUQtqL2g7y+JcI8RJNW
 GXVg==
X-Gm-Message-State: AOJu0YyLmTEurtFmu0ffvBVL+H9k/a02OpJIOpdUgalB+WtUc2m5UEGm
 Y8ERAGkagvoQUiRHz/UY7HH2aLC5cIPcYDEvvgRyJ2YJG3t/L/taK4Br3nTUdMeViw==
X-Gm-Gg: ATEYQzzlrHX/cCOJgF8qfC6W376karLDF5tv7arZSTaqNY/8R0Ga8vwMRgLqV7Hd0KI
 NivOMXs8AqOgu6ckbLqcUa3L9EQJjAQ8vtAkVoxLHkajWMthZENWqiVe0TgsEw5qiIMGDMP4sT9
 Iq6uNl9djbHGARfFq222Z6kGuKSi/y7x5vDQld7JUylXGzPnBwm8aVZY0h43ybAuu6msYPp/YKx
 w/aRdh5bNUfKLknTf5cLJQHbEPrMGrWMlkk/noD6RS0p+8eo9pEOhxsdO4jEwPGQTwksa8iPl7f
 xBL4uPcXN6oFutCTnlm6LaSTof+FfMVPukozQYtQ3lSMCcrh5Y0AWr/H+xcIBwZ3I1kI4E0V/40
 56qhoLZVrqkiCs2RvQzug6DI/nYKaIWispMD/aY1nnsGL38Hoi1rNDDV/3izxp1bdsQ3WhT9J3r
 e1fBh9bEreLxXJG2ryDwjBzQAr2vl+JqLeHtWsox/Qug==
X-Received: by 2002:a17:90b:288a:b0:335:2eef:4ca8 with SMTP id
 98e67ed59e1d1-35928c34f6bmr4487201a91.33.1772121593589; 
 Thu, 26 Feb 2026 07:59:53 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35912ff8a92sm2607430a91.6.2026.02.26.07.59.52
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:59:53 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 27 Feb 2026 00:59:27 +0900
Message-ID: <20260226155929.3500-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open: clean up make check findings
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

Fix various issues reported by `make check` in open syscall tests:

- Replace space indentation with tabs
- Remove extra blank lines
- Mark setup/cleanup helpers as static
- Add missing SPDX-License-Identifier
- Fix typo in error message
- Fix documentation comments

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open01.c       | 2 +-
 testcases/kernel/syscalls/open/open02.c       | 6 +++---
 testcases/kernel/syscalls/open/open03.c       | 2 --
 testcases/kernel/syscalls/open/open11.c       | 4 ++--
 testcases/kernel/syscalls/open/open12_child.c | 1 +
 testcases/kernel/syscalls/open/open14.c       | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index 3ae1b269b..e5e598e56 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -5,7 +5,7 @@
  *    06/2017 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */

-/*
+/*\
  * DESCRIPTION
  *	Open a file with oflag = O_CREAT set, does it set the sticky bit off?
  *
diff --git a/testcases/kernel/syscalls/open/open02.c b/testcases/kernel/syscalls/open/open02.c
index e1c5cc5dc..30b129019 100644
--- a/testcases/kernel/syscalls/open/open02.c
+++ b/testcases/kernel/syscalls/open/open02.c
@@ -29,7 +29,7 @@ static struct tcase {
 	{TEST_FILE2, O_RDONLY | O_NOATIME, EPERM, "unprivileged O_RDONLY | O_NOATIME"},
 };

-void setup(void)
+static void setup(void)
 {
 	struct passwd *ltpuser;

@@ -45,10 +45,10 @@ static void verify_open(unsigned int n)
 	struct tcase *tc = &tcases[n];

 	TST_EXP_FAIL2(open(tc->filename, tc->flag, 0444),
-	             tc->exp_errno, "open() %s", tc->desc);
+			tc->exp_errno, "open() %s", tc->desc);
 }

-void cleanup(void)
+static void cleanup(void)
 {
 	SAFE_SETEUID(0);
 }
diff --git a/testcases/kernel/syscalls/open/open03.c b/testcases/kernel/syscalls/open/open03.c
index 275ca84f0..53baf1028 100644
--- a/testcases/kernel/syscalls/open/open03.c
+++ b/testcases/kernel/syscalls/open/open03.c
@@ -19,8 +19,6 @@ static void verify_open(void)
 	SAFE_UNLINK(TEST_FILE);
 }

-
-
 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test_all = verify_open,
diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index 6f89d558d..2d4b4e821 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -269,10 +269,10 @@ static void verify_open(unsigned int n)
 {
 	if (tc[n].err > 0) {
 		TST_EXP_FAIL2(open(tc[n].path, tc[n].flags, tc[n].mode),
-		             tc[n].err, "%s", tc[n].desc);
+				tc[n].err, "%s", tc[n].desc);
 	} else if (tc[n].err == 0) {
 		TST_EXP_FD(open(tc[n].path, tc[n].flags, tc[n].mode),
-		           "%s", tc[n].desc);
+				"%s", tc[n].desc);
 	} else {
 		TEST(open(tc[n].path, tc[n].flags, tc[n].mode));
 		tst_res(TPASS, "%s", tc[n].desc);
diff --git a/testcases/kernel/syscalls/open/open12_child.c b/testcases/kernel/syscalls/open/open12_child.c
index a6dabd5d2..2c3411426 100644
--- a/testcases/kernel/syscalls/open/open12_child.c
+++ b/testcases/kernel/syscalls/open/open12_child.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
index a3c7d38a2..7f3babda3 100644
--- a/testcases/kernel/syscalls/open/open14.c
+++ b/testcases/kernel/syscalls/open/open14.c
@@ -108,7 +108,7 @@ static int read_file(int fd)
 		SAFE_READ(0, fd, tmp, size);

 		if (memcmp(buf, tmp, size)) {
-			tst_res(TFAIL, "got unexepected data");
+			tst_res(TFAIL, "got unexpected data");
 			return 1;
 		}
 	}
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
