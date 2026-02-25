Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947D3FD375D
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 13:20:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C3503C7C62
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 14:20:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48DBA3C5398
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 14:19:47 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C26CB1400441
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 14:19:46 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2ade574f05eso1259765ad.3
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772025585; x=1772630385; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OcF16yLSa8KDOkzTiaFlU0YjYIn4oAiG1dhbqEwH7s=;
 b=kazlF8VxIJAcw9z4WNUmzXSjafKexiK0PhVzlV1MQu9NlnUguS9mipe/giZRL2pix/
 qmQqLUZYX8iCM2It6U8eXaX0Z8/OgiW3LBtI2PNaAb1bQ6CUuFidZZLOCCBwxI2cNCYJ
 4khwnR5kwLfpUh2mcJMdlZkock/m/4aZyoIg1B2R+b0KVOHb/x5EPyUGdsulg7+p9rdA
 NZNs7OGilVVfPmHKPFofXq1v+J22H1t10QIGK8BjV12iV4oykTq8ek+mQgCQWzXotA0o
 0TSPyB8rxJga2xLIdRghFb/d7fiUwyHWkPIaueDQAnYoEwvZyeWD7O//3ytvZqW6J4zQ
 wm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772025585; x=1772630385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4OcF16yLSa8KDOkzTiaFlU0YjYIn4oAiG1dhbqEwH7s=;
 b=nqYu3nvTE4Bw/dom6N0LUS+/Jj8z5gz79cF79ZiHR7Ara4Czv4nro/VyIrNMwpOVk8
 pKLmh8jQMNZchvaj0HmjGKSmfxoIQBbLXpJgYDMxSbFGNaXLh8LCI1LXjbkuxQ9/h8BS
 1LNjemBNzXCvyr3H5suV+uGMWHKC+ErhjAaqSFRPtvcG78SwfVXB959gUi6jlvYsTmRI
 +BQTxKVZAqGS2cgDcfizrd5avVWVNBxVWGTWgpXyJGUmTVY2oP/OJKYgnBqnze2zNV+0
 2BIjcETp3dB88DBkAAjYLAwczeZQ6UqNw5N6yOImdvkEfirNh3GJSfjN+Fr8QskLQ/Hs
 s2eQ==
X-Gm-Message-State: AOJu0YwtyiG/Q7RtjqXmWUNHe7ZrbBkbdsIF+Q2nz5WF8UfCVR3TmNDo
 wAfRoenAx9cC7duekexwJ6+sqbIITQm2mmk1mTnZP9igA4K9+Ou7Hc2lYjhOHDtxCg==
X-Gm-Gg: ATEYQzw4ZvhKLO1QhPz/EDMi24ohRVxCUlVVFaqT+v7p6u+4u5GUhXv+KOlyPYeTmwB
 lrXLsUBL2i89x0bv9a8YCREHDyokEZABqLMuV5rn/OSK3T5qTICOesE+vgh1NnqDa5GNoocT3/c
 IFZEInUKrlcRbEjfvxDCnRbCCTO5P1FNEF3tsuUBRuCQM9jyuWwT5asfJMXrvKBMYmwLmkb/Gca
 n6akiM5ppemJmihP8+ORsUQ7VVYca8tyAENXskT3CIiI7mQYH8w671Av+c4HkGj+JLsrZE5+bJX
 5XOb5uTsM/USRLzOjeTX4+Gc4tCgp4AdIWctbr4XkpACREbOYQ7SX0wXPY7IfizquJC5VkaXNYr
 +xVoqBYita3EzawaheNxuEbRtxa0JaF8Zs46GTYm4A/8c/iFoCw2iu216S9v1+s2EesQVvttj/d
 sK5aJpw7Ya9FIWidePo4BwrOHzh9FeCWbC6jN0O/SavQ==
X-Received: by 2002:a17:903:b88:b0:2aa:d29f:1444 with SMTP id
 d9443c01a7336-2ad743ffd28mr140017385ad.10.1772025584812; 
 Wed, 25 Feb 2026 05:19:44 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75029f11sm136682645ad.69.2026.02.25.05.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 05:19:44 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 25 Feb 2026 22:19:18 +0900
Message-ID: <20260225131922.5723-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DGN98XP7WAZD.310XXFFOA9X2R@suse.com>
References: <DGN98XP7WAZD.310XXFFOA9X2R@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] open: remove O_DIRECTORY case (move to fstat
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
 testcases/kernel/syscalls/open/open01.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index baf73ab11..3ae1b269b 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -8,16 +8,12 @@
 /*
  * DESCRIPTION
  *	Open a file with oflag = O_CREAT set, does it set the sticky bit off?
- *	Open a dir with O_DIRECTORY, does it set the S_IFDIR bit on?
  *
  * ALGORITHM
  *	1. open a new file with O_CREAT, fstat.st_mode should not have the
  *	   01000 bit on. In Linux, the save text bit is *NOT* cleared.
- *	2. open a new dir with O_DIRECTORY, fstat.st_mode should have the
- *	   040000 bit on.
  */

-#define _GNU_SOURCE		/* for O_DIRECTORY */
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -25,7 +21,6 @@
 #include "tst_test.h"

 #define TEST_FILE	"testfile"
-#define TEST_DIR	"testdir"

 static int fd;

@@ -37,7 +32,6 @@ static struct tcase {
 	char *desc;
 } tcases[] = {
 	{TEST_FILE, O_RDWR | O_CREAT, 01444, S_ISVTX, "sticky bit"},
-	{TEST_DIR, O_DIRECTORY, 0, S_IFDIR, "sirectory bit"}
 };

 static void verify_open(unsigned int n)
@@ -46,7 +40,7 @@ static void verify_open(unsigned int n)
 	struct stat buf;

 	TST_EXP_FD_SILENT(open(tc->filename, tc->flag, tc->mode),
-	           "open() with %s", tc->desc);
+				"open() with %s", tc->desc);
 	if (!TST_PASS)
 		return;

@@ -63,11 +57,6 @@ static void verify_open(unsigned int n)
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
@@ -77,7 +66,6 @@ static void cleanup(void)
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
