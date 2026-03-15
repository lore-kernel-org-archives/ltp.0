Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E153D58B0F
	for <ltp@archiver.kernel.org>; Sun, 15 Mar 2026 07:28:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECACC3E1D02
	for <ltp@archiver.kernel.org>; Sun, 15 Mar 2026 08:28:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 069473C054A
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 08:27:46 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9E31F1400967
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 08:27:45 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so2345582a12.0
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 00:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773559664; x=1774164464; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OcF16yLSa8KDOkzTiaFlU0YjYIn4oAiG1dhbqEwH7s=;
 b=Z7IrpAcDII8Fol0IWckDUIhILepDwz66kyVydgZ6T/8P4KhxkYUqSMMgZnAOa6KXeQ
 L4aoOirXlryhDCefwHS34cgDr565Vs75jae7m3yAxsIaVwOzd/KfOuq+ojKbmdRdITDr
 3qyntyidivoE20ikmaIoyRN9IYPZmwXehT5I1LgK9Wukd7AxCCdng2oSkObWykKQS8IK
 6ytmpiret4Qm6JZMAowVwG/eCHoErS2z7sSRPi53dDDCCY8cAQlUGMKLFzoaRg/Y86+S
 EpvxdiaDP/FIVEAarFgvQJt9uL0YvODXxakkFX2txbGYcuJ0wHHUEhkmP/dg0vkHbcDu
 vGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773559664; x=1774164464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4OcF16yLSa8KDOkzTiaFlU0YjYIn4oAiG1dhbqEwH7s=;
 b=AbLXQ4I6+fy6qaBaICgTeJO0AXQqfdOUalbksCNeADyZr7gNa3LddONC+SKl+QJUPR
 f8BGPgD4+VUT3B7Bh1nHQPF5n9vkTkn/wf59xqV1pD8/clqWUnqaXaHXuhTvZJuNwLEJ
 oWlbUP4inGNfc6yrNAK1Q6KtpU3Wd951yqneI+yJw84OtO8cUYZY+rkL5PYQAEw3hkIB
 hk79xKiaPVdq4iobPVVvMIYOGhO6phXL7DQLCzNu/+di1qw/NRjRDCNBqe2YE2I2vIif
 DOwVdEILe0KJO9PxRlhFqA/7ijNGxzD/YGOCVmL7A3zF64FkeWgVOy9GJjSnQoGiU88J
 8YdQ==
X-Gm-Message-State: AOJu0YzSQ0ANyyPikHWkK8exTZtppGWMoIxmdb/glomlFAanTzCdStZI
 QRwJk8RnmnpU/Q1muPXnh91RNULmSV7X/OEJSRC7fj43/y40cpohwsM=
X-Gm-Gg: ATEYQzzoyO8WShUzjKWu+uGAyaaWNDgmzXwvtjPDhRAlGGMbsuGZhGn63jyIjt1nYIx
 A/aXtHsxNzMoBTbLeRmYoo9tizSqDtdFquuApiq0d1DOnxxmyv2Flk652or9UFtDdVh9Rtrpgzt
 tb+FjQfB/n7Kucf17dcXPtO38gGC1RQtI7mE/8PjmjKOlrpEK0kKflX78bDDfd99yPqIZqbKHfq
 WwTyNldtKeXQgFGB6tvT/QNiqcKvEAlgjogq3K2Jh7GdelrzQm9ZlMfduR7YuS1bKkz5hzZgHXi
 q6K50V3KtqzjRqCiv6Uu1q8uw89VojbPiPoQ5f99rNvECL3bfz+F1begevOQKeppqdUA77X0aMY
 8T4qNKlL1HaagC4AjnNM6Oq8z8N0qh7ex2lKOQR963XMN77KfCbhmQHzB11auAv+yI7Kg/Tg9kH
 K16CDoIepQLA0a6te/JqdF+9hXJ93IByPwPKPsImK5fw==
X-Received: by 2002:a05:6a21:4cca:b0:393:dc6b:a0eb with SMTP id
 adf61e73a8af0-398ecdde6f0mr8147988637.64.1773559663616; 
 Sun, 15 Mar 2026 00:27:43 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73eb8ade35sm5755970a12.0.2026.03.15.00.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 00:27:43 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Sun, 15 Mar 2026 16:27:15 +0900
Message-ID: <20260315072721.2083-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69b42eee.050a0220.281abf.2706@mx.google.com>
References: <69b42eee.050a0220.281abf.2706@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] open: remove O_DIRECTORY case (move to fstat
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
