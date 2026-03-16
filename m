Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD8F53D65
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 15:06:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F3F13E5D2B
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 16:06:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD5943E2B7D
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 16:06:16 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 242661A00660
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 16:06:16 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82a124f3a5bso2430982b3a.0
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773673574; x=1774278374; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwL0MnjiTYTiqi5SdhTb1z+1pyBp4N4zEmISXCZLUvM=;
 b=FA3sp93iB9DiQaJ649kDiXrLtT2XmbvrrFa8bsMbIzka2bKFUsYYmXdoSs9sLOi8K1
 gME/r43bk5HMGD3I1hBulnzRlqdkLFzMdLyTWm7pFsYfo8TydrunbeOafvZzd6+QHlX0
 J2NSc9ftsmYJGI+gHuCgbP2cE3dYiub7t+o4xxzZy0u+/p68TSVTzh+sv8lxLtdEapTE
 rM8o/EGk7TcASqWhgGSsG73Zv8+jMOofzCqAbj0FxWGMxaS9ZKMMtMXm3/2Q1KOSIsdw
 movHMyjGW+lQMMO75blgwG+Gccw8M8BAF4Fct93wr4KSFSfQhhUUO2/MsFVW61HGiDhr
 osTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773673574; x=1774278374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GwL0MnjiTYTiqi5SdhTb1z+1pyBp4N4zEmISXCZLUvM=;
 b=ldtlGNSA5xHcVXzO1xx4LXCW+eWQLJA7yj0ZLCbqgjMMdJ26amp2+zJHPLw5teXUpa
 r6sGq2N07Huqcw+MAd7Qn9L0JBc81/uUvaYScVs0epJSLbHxc+o9PObeNzkWSha4/E52
 V9wYz4wEW5L/wzaekMCdCUV5zzdtrcgsfp2xRC6nKugRhxyP/T7MvNkJXybcfXaCNX5R
 n6ucgPvJ+sy2UHHFRTwU0W7R2mveh2gAphstVZ50sWpG1zLg5xzVrqHvC0Io+saVnIqU
 vDFDHx8POGZ+LFPIxb26TQQ12I3VhxVGx6dve/Yl8f5g7KBIMKoGZ2y8j04BIhhwSVh8
 XIbg==
X-Gm-Message-State: AOJu0Yx1CHBN7WLLFQuuvP42pImTKizjShqrTRZkHfGSVY24kPggtQ7b
 TJLJrw8aYIbxl7JfvRWwJjIs1sokvKJkl+rINzgigjlCLKBf/2D8VGk=
X-Gm-Gg: ATEYQzx0vVvWkOQ8YEJhQtWRUUiZ8EOKdF24v8lpx6p+F1X2PgFlSVeY3fu51GdrLPo
 JyMIGa7SmCJyvbGp3vg/fNJpWw9eZlvvlG5kgs8CqJdMT+erfI8aC5ymhTTACqLxSYwUmsrbVBL
 svjhbAy1AdNeZRmD2Y9zjkWHfLG2EoA7BN1FB2AD5I3d5CS7lIScthlc74V/UG858e/0dlzGTxL
 lcn4xNxUaK2qQWDoHecPz0xNWDvvw5y5Q0dD9iyPAiXZG2mM2LnrUPjq0U26CvbuRGewiCeZ9yq
 0Pgx8Tzm9cNR8XLGUTDhspg3gTvyHgwCVAKWPwvoj3Ckzt/c1/jnz9CF3/Drz3N0mpZ95MBg83I
 bp4/gM9zGkOZ8tRJD9yQJjtAIfSJose694fsMLCju7rw2YXDhWotY66AiM+gaKcvotkK/CIF/7Y
 JJtx4RJX0Me3pTUWr63FFuro5wLGoApuEDp0XrG6OxaQ==
X-Received: by 2002:a05:6a00:ae18:b0:7ff:97b3:59bb with SMTP id
 d2e1a72fcca58-82a197376e5mr9283405b3a.16.1773673574266; 
 Mon, 16 Mar 2026 08:06:14 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0724407csm13435477b3a.8.2026.03.16.08.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:06:13 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Tue, 17 Mar 2026 00:00:51 +0900
Message-ID: <20260316150404.116279-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69b7b380.050a0220.2e2929.0639@mx.google.com>
References: <69b7b380.050a0220.2e2929.0639@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] open: remove O_DIRECTORY case (move to fstat
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
Cc: ltp@lists.linux.it
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
