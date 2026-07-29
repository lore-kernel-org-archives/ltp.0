Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04FDC54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 14:33:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D8F13E4D10
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 16:33:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24A503E4B10
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 16:33:15 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BAE0B10009E6
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 16:33:14 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2cf02ecb572so11039355ad.1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785335593; x=1785940393; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TaGYWr+g9Fn+Ih6j7cunuGrsC++mm/PsPdJKU/86gxg=;
 b=Vxs/eymXOA0aOur+tS6tzrXXI99al+Mh0txdP2wgmLj6ix8QXdT1OfZtghvlPhsXI+
 S/GyCtivjTKdTZZVzwUQqmb1hGYonLjDHtsb/ILyrJKsuOm6tU22axmoQ6i5fDX1WoZA
 2CLBavpwYIt0Wy2okzuoLBQa8Zk8LJgktTA5urG+3y6H0F6V022aBUf0N20aHEJ3T7pV
 Sx/KWa1sNSvBMHlKHeXe000ULMlBunBXrkoucSpu1HleVY9Ji/Y2FLzR3E9hSbhd00UF
 YbM/RTwgNJT/+ixARGMEA7nAgfM0+wR0pHWheJP9lIKJ466HNIY/C8GKT1tS60HH4R/O
 LhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785335593; x=1785940393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TaGYWr+g9Fn+Ih6j7cunuGrsC++mm/PsPdJKU/86gxg=;
 b=lW/2zLn8AMkVi0jq9QQzKdHN4gt6TVR8SaGaX554tSZxPIyy+ab50z5sdiG/UPWgWc
 BCGal5SLcRDzyfG1b2SSpqYENWmi75uWpg0/geAfNnuUWctHhdxsFUUKA7mYTGcijYAS
 BbfT1f/8BCctTskFj9nDzcepc+zmN/ZtVj+0eMVMjwC8N75sx/dXeD7NmvQXs72xNuM5
 pMM6Qomftowj5/OCS5r2oPahJAA1TZJq0s4FQU+M+5uChjLhlOnXIVAYvhfJbTPqh0Wj
 cxqdAi2BvvMsr8xqc6gXv0JIVoU1dndnFuoASBnuxcBhUE1TnuQaddlPYOWklw1xGR/2
 mzfA==
X-Gm-Message-State: AOJu0Yzl618QEx/LxEYhhFqKrYM9opT5JtvgijMCBQxb8tyPKB1rBCah
 EkqH4kAvpJ0JmhwIpj4+TNEORBI51+x/XvOK/u6KNFUnbDw/eivbrjrV0QLE7kMyF5XB
X-Gm-Gg: AR+sD13mySXcvw2Da6CS9e1+oXkfKFkI3fIS7pDM6NxWtwDa7b3MUy3Apia9gCo3/oO
 V+Mq59YPZCKtt55XCpd0eyWU6TDs+AOUmIyfzY1z/kgpXSSiAJRW4gK7WoXC4LbgDvnXWxe0Tbe
 c8ZXZn3WuZgcVgjgQ/0CcFPYlnG+4RDdA/vkfR1JQlVu/EfKuo9ZLPqNnUogcHWtEMkF1re7xdR
 3rvFSLhzS1BXGGIrqfXBhqe7betpw2OB3YovBaMhrYySgFTblb5oJ/wMRJ/o3+y/yjeQqnrXQFu
 iz9sGp4NotH3xDfX3aKiprh9KeJv3ZMrg25jD3+iP/0HlcmuNokSD5737u7NgdOYUIEUBApsHJd
 u+ZlrKzDHi1tjU7RSVU0RE9pBT6nrObD+LWOjDhKKgUJdnkyWFxZf/IoKbXsTenYbB6Z3skGp7N
 PUdL4ARpWp4uDUPQ3KB2slAl8Ci6OG7W14YPWA3q7rp6EZ4tJ5Hyzn8bsh28nL3GzPqsLpA0dCe
 oHiyHvh53g1Hl9kI1L7T8b5Ueqd4g==
X-Received: by 2002:a05:6a20:cf8b:b0:3c3:a7ab:135a with SMTP id
 adf61e73a8af0-3c8aafd6622mr7634122637.20.1785335592904; 
 Wed, 29 Jul 2026 07:33:12 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdba63c743sm1008323a12.26.2026.07.29.07.33.11
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:33:12 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 23:32:02 +0900
Message-ID: <20260729143243.8433-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729143243.8433-1-always.starving0@gmail.com>
References: <20260729143243.8433-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 2/3] open01: remove O_DIRECTORY case (move to
 fstat test)
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
index f1a3720aa..b1b32510a 100644
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

 static int fd = -1;

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
 	if (fd != -1)
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
