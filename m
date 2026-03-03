Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E6DEC1447
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 13:33:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FCDB3DA1BD
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 14:33:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BDA03D8FCC
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 14:32:53 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 968E12003BA
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 14:32:52 +0100 (CET)
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2ae4988e039so16211375ad.1
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 05:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772544771; x=1773149571; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4OcF16yLSa8KDOkzTiaFlU0YjYIn4oAiG1dhbqEwH7s=;
 b=F0SOap0PkKzPqZpWB6CXSVxoXeKKApoEjzCmnaJA3W0osnWDxXP9s5rPQQB3aOxpOh
 iVuFL6RsFlNCxKtuzZ6qz6cTV4qmS5BpLdoZ+7qtO8FOZ5z88+KgdLDYKm4TZ4SB7FZ9
 q3Cl1n5OwyVukbDoIjEnO6/VNQDJgafpT+w5p7q/cAhppwtHp/86ykl8MQ8uP0cR5sZO
 h3JnQdjN3UGZjKS+SLk+I2Le8M36PYs4BnaZaodrZe42ofuvrAfCTIBmowFDz3QHCsGZ
 hnZ3rWaxuvOnP3zPs3cYfRji4pInRmJF0sIPJk4AQKdLx4hvaZ5efkGYwxWuy+d7N+b6
 TFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772544771; x=1773149571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4OcF16yLSa8KDOkzTiaFlU0YjYIn4oAiG1dhbqEwH7s=;
 b=cl/v2p1oXvZRZzYhXMiHgDJ2pPSvA9A0mM58S3Cc1HDpcKjQN5Z+j51P5hjFeKPPGX
 qtRkr/AiBtG/GcWwy/WC3hSysPZpiDd8BSEqdUdjgCu9HJgV13I7L4ZjsK9ojgqVyOTY
 PMDCPZpEiVMR+WghebKaiXRnV9tvqgimcYkCnI5xOuq2Vb/fclQBi7iVs/s/HSKCqJY1
 FgWx4/u2m5H4r5PZHGFdmOb2h6SQAaBHvxBQMN8wmdcaZWjOTZraLcOdR/QvZvGH+jtJ
 6AjgaektgE6dHuE0iYsfSd/vFm1VMuKQWtfeCPSbZHU7321CzZAS12rMB2Jx2TV892zp
 SWpg==
X-Gm-Message-State: AOJu0Yw1HXwtl5iuhtKT3oHd1eF/ped2qxsKGwaXCQGePmWd36Kmktof
 UiLcBq6eMaSYrOtVG8KPlrgs5Dozw3iDrDnuC1Q7bGCY5CqkxTZgRbkzIjsYdCU=
X-Gm-Gg: ATEYQzy86PUIHH3uY4HjJuOTG/ApKocca9PVrAFZxmYYLjGPRTR1elPYmiz7PPDojoR
 AybGZqs+GmWH99hbDBvKufGnsmxsTHquRGOaxEvfEsvv6o51/4rL4fq1W1o5Iku6RsH0ttlpVxc
 QSmCRMjVTW1m05zgpMoCQHyag4szBWb0epaMIgviFk4u8mmCWJPqFPogG8GmW2K+YmYH/AWH/dO
 SgF3jwyvNK5Fn5nLWpCAc2zzu8YFVRHJuGVip+wm/UoqZmw/iM7FOfaGoI/WAOkq+VNznd8jiY4
 MQnX8wtCJigFR+2BFQhQwzgbXR9rj6YAVSctVyBeIBSDU/GrGx3NNjExT2I5q5l+GBVm9ubDdgw
 sJMCRy+0a0OKhZ1o9o4EE1aKjxJb5WsYcK/BmU6cwWpOa5bva8SZycnn1V2PwXKMQWBuZiaJXb8
 iktZOhKMS1vpyPMbX0/w==
X-Received: by 2002:a17:902:f681:b0:2aa:dad4:dfa2 with SMTP id
 d9443c01a7336-2ae60d54590mr23735285ad.18.1772544770603; 
 Tue, 03 Mar 2026 05:32:50 -0800 (PST)
Received: from JS.lan ([171.3.84.26]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb69f9c2sm174400575ad.51.2026.03.03.05.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:32:49 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Tue,  3 Mar 2026 22:32:36 +0900
Message-ID: <20260303133243.66845-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DGP0CG3J3QK9.1M9KCELAS054F@suse.com>
References: <DGP0CG3J3QK9.1M9KCELAS054F@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] open: remove O_DIRECTORY case (move to fstat
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
