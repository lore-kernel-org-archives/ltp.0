Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95232CD98F0
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 09:04:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A8333C5AED
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 11:04:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E47E83C4FA3
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 11:04:38 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 444B510005E3
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 11:04:38 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-36d630c0e35so3385768a91.3
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782032676; x=1782637476; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GwL0MnjiTYTiqi5SdhTb1z+1pyBp4N4zEmISXCZLUvM=;
 b=oLgCsD6H+zQpSi/vaHJ2h79t+KmZSyl9O3C/RfvIks6q/adeSFXNv3EF5d16WDd2I6
 AoQgOxRGBzq6SG2pdfKoXr2mbd5MN92S82eb54cOqVtQdi7uP5lgo/+ztaj5Lp3RdZno
 GA6WKovedUwW7ayVp0GkxzmNPtcXaPBGmmFw9MR/3p+cJSt+7XgDWxPEi5I6TLn9PGYk
 JlL9pFcq5eCdn8cvmY/tj9qgAv6nKUyg41C5+AvAUOBTt3SKmComdTroIxWbnqpOvRVm
 pAzt4UtkAQOA0O5v953NiOAKz2XVgrVwVl1novzsC42kx9QVEklYYtU2j61tGKN5cwJ9
 KRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782032676; x=1782637476;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GwL0MnjiTYTiqi5SdhTb1z+1pyBp4N4zEmISXCZLUvM=;
 b=ouEQ59p7iT+67+knGDxLAreoYfSMSQuZEISCyUtIOzFZWe59ouWsTBULO+yjC9/SHC
 Cosrc3A7cJ8W4TKmWdi+76llHUmzNR0NZW6ls2zzZItWNc0x2uvtBLmjUl0B6+Yh/WAN
 pHIHP22HRNjMh+YaJ9rEkmoMi6DNe9G7l9gViBrBdOhKdl72p3wJrLOunHLijbyxLRUH
 nONsZPXFL0QhIhFahKHmBWIcHi1AxhvrjcVbtq7WIh3ZafJsoMaOJELWNu1p7NKPBZKK
 7zxsyLh/+uRFjthU7+9Oc++cdsw/GVYNQeblu+ncfZht9BWAJgyRbR8X4kBBG5VfWbKH
 0THA==
X-Gm-Message-State: AOJu0Yyy/CLyHA/jQhLkRgg0YSFqD7jfU2n+XNIYdRfwq1G9NLzUjpIr
 SJdpeb3rBWaGh+/ItGMAWfMULFvxzKD2pkopeDs5VGLAu6e7IW9SWI4Bwh6FctGtWzy7
X-Gm-Gg: AfdE7clIfhS2f3RZKgLErJJKp3MPjhC+vxXIAxlPubtbfAACJ5sotNec+1W4Gdc9nkY
 JPZou6/S7xjL2bj0PEqzvfrtoD8rIJzBcnMAMTtldddPr0tiLL1bjdYCVX4otewOw0MX47ASJnW
 ln+SGsHC8durbToPYs/NeBepOi31cUw36am/uyq7p+N8H9dYIWDUYcLV7uZrCbLavPGcTIZ/GCF
 CBP04HKQoRdFz280yPwiz+u4qCiRytJkqCkxUgP9Tmw/u+Ve8gqpFueNTWwYX1mkpQvRdZU/OMN
 Dscimq1eQQHB7lePzwnvt06y2Mt+SxDuKHH9NXRF8rpyF34DvR2ptR7NdGZoMcHxVtNttx/SLuc
 DTXbjTUJA1RZMgBFok2xc/lCh3VopzJ0h7vHaOYCaj4QcyBb9ntVdkJz9syiibF3Cyi+SFz1EAF
 lywz4zrtY950TdaNqrj6JwLEBwSK11WXY=
X-Received: by 2002:a17:902:e807:b0:2bd:5ab:af95 with SMTP id
 d9443c01a7336-2c7185ed173mr119695475ad.0.1782032676495; 
 Sun, 21 Jun 2026 02:04:36 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436ff3b1sm42632675ad.36.2026.06.21.02.04.34
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 02:04:35 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 21 Jun 2026 18:03:59 +0900
Message-ID: <20260621090403.2236-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 1/2] open: remove O_DIRECTORY case (move to fstat
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
