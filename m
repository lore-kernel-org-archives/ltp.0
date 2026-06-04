Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5507CD6E77
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 14:21:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05F173E618C
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 16:21:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83C2D3E16D0
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 16:20:55 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E21020093D
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 16:20:55 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-8423f52af13so541329b3a.2
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780582853; x=1781187653; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GwL0MnjiTYTiqi5SdhTb1z+1pyBp4N4zEmISXCZLUvM=;
 b=ICQ94m/zevIujOjiB5t3Iq88f1wdzjXb/HQjV6xHxa24EV7n8fABWqtQsZC+Tr8IEK
 GX7pmTwDRDLN01OeEM1FRVVhQb7nzXbLHuw8g70WeCFwdUJPyLtsikTdchz4RfTsX7KG
 XlcmQu2+LZKp6DYwQ0PmHD6hH0E5OeFJ/J4NXBh+mdLrgHeRlPb2Z7tnA6U8pUsrumaA
 c3o43LBYm47i/ers29ccyQuau8afEyHfShbfvug16IlU2IIhnK7RPD22jpf2CI8zS0Ky
 T4J9UfhExCmXgGw2CbiwnObPMeO6hwVd1D7l5gl3BH+LjTFwb1iFL1NmIMxSL+9GqdA1
 1z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780582853; x=1781187653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GwL0MnjiTYTiqi5SdhTb1z+1pyBp4N4zEmISXCZLUvM=;
 b=gOTx/gk5qsw4sbkPRtP10eZACNjG0zxlcAVikn+DTTNedJnBFo6LW5giDRGrMMExmh
 9csrpbK/6mnhHqhtPZNliNjaSup1RGvOPZ2yPTYIyhDlvnW/Nyx7bR78NtxolTV+sweN
 x8ql8J/wcO6e7m87vtBxSXunCsx9XSuniw46QRhz3/z+lO2Yvjcmm9/RmTRygQ7m+XdH
 97WvHKZwcEfQlzpJy2bGqhZ7LkYh96UeIhJnj21CR7xq9/0efFdjfXeYRse3/KANKiUg
 JVSSgVDrVUy/Fl2JJ179znmZQyj+x+fYHcul9H75Eu28AIDRD7jYW8VLdjrUn0z+/SHH
 3R0A==
X-Gm-Message-State: AOJu0Yz6u6AdjqkAMyMs5pHQObeMO7mXoJ8S5xu0HyZytSNxIsbQipw+
 Oi3YN2GAjeoCqk6jCsPBic7povc3ME7hcNceJUwm75g2JZdZ2wNDMzJ454l8kd9Xcg==
X-Gm-Gg: Acq92OHm2ncy+HoBo11bbq5ZXp0ADpd7aLDNxIdNAfZQKnglzuBlQupxcBjW5KP+Kp4
 ZsqSqn0Wjs4Gr9VtKeLvwMTNMUDF1Eq0dwnf8C4s9jbw5Lum0h6bKy4oPS2CUd8NRn1qudM+Eqc
 fQsXbgYutcQ0GbSeEdPDkXYqewSeCZwk6021jD0r+Z56sDsyVt3ujbxrLHGBzkl0tuQzbdMpX9c
 AvN6cpACbQXawdM1KfC0pWiqYIkbFpSAQysLmCvchjsA60S3p9F6/eMED8VNLEKczfRspunBN3h
 uRGxNCW6Z0aJTpc9lzfNlZw1Zax/+HaKYwajLkAGcYVEE2z+TTZwiyVzIoixBDaVJT+hkoAo1lg
 iHwOpZ2M1WQqw69o6kje08O9Yyh1AicaPOB5qft9Yb5FgqcF4Vlyvpv0kFZTwoFyLj0LES39kvZ
 5hWbKAAbDpSvmdgDLTvzGtvJuk9yKepCaJcKOtS+aMegQMwNXIDlNhS5g=
X-Received: by 2002:a05:6a00:3288:b0:842:377a:4dcd with SMTP id
 d2e1a72fcca58-84284eecfc5mr7917734b3a.43.1780582853127; 
 Thu, 04 Jun 2026 07:20:53 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282916b10sm6464018b3a.58.2026.06.04.07.20.52
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:20:52 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 23:20:26 +0900
Message-ID: <20260604142029.2077-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 1/2] open: remove O_DIRECTORY case (move to fstat
 test)
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

The O_DIRECTORY test case was mostly verifying fstat() behavior on an
existing directory rather than testing any specific open() behavior.

Following review suggestion, remove it from open01.c. A separate fstat
test will be added in a follow-up patch to cover file type checks
(S_ISDIR, etc.) more comprehensively.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open01.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index 1cefb4790..1413ccdec 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -6,15 +6,12 @@
  */

 /*\
- * Basic :manpage:`open(2)` test, checking sticky/directory bit.
+ * Basic :manpage:`open(2)` test, checking sticky bit.
  *
  * 1. Open a new file with O_CREAT, fstat.st_mode should not have the
  *    01000 (S_ISVTX) bit on. In Linux, the save text bit is *NOT* cleared.
- * 2. Open a new directory with O_DIRECTORY, fstat.st_mode should have the
- *    040000 (S_IFDIR) bit on.
  */

-#define _GNU_SOURCE		/* for O_DIRECTORY */
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -22,7 +19,6 @@
 #include "tst_test.h"

 #define TEST_FILE	"testfile"
-#define TEST_DIR	"testdir"

 static int fd;

@@ -34,7 +30,6 @@ static struct tcase {
 	char *desc;
 } tcases[] = {
 	{TEST_FILE, O_RDWR | O_CREAT, 01444, S_ISVTX, "sticky bit"},
-	{TEST_DIR, O_DIRECTORY, 0, S_IFDIR, "directory bit"}
 };

 static void verify_open(unsigned int n)
@@ -60,11 +55,6 @@ static void verify_open(unsigned int n)
 		SAFE_UNLINK(tc->filename);
 }

-static void setup(void)
-{
-	SAFE_MKDIR(TEST_DIR, 0755);
-}
-
 static void cleanup(void)
 {
 	if (fd > 0)
@@ -74,7 +64,6 @@ static void cleanup(void)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
-	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_open,
 };
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
