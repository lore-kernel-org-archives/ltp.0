Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B02E64016
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 13:32:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 014D33D0F4D
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 15:32:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 694013C259D
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 15:32:02 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0D4C320009C
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 15:32:02 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so3545369a91.3
 for <ltp@lists.linux.it>; Mon, 06 Apr 2026 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775482320; x=1776087120; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5HnbHOp7Q4ycRb1IouZ3RpTVBY2mVgcLqjL2zLFW07g=;
 b=X7cltXdZlBv0GbJyR1lZ6p143YWUKNhGUT/dprGLG9y8gm0xC5C7jPT+6scC8OFVcY
 BjTcOQor0JjI1SHx15/Nrd5OJc5k4bFgWT3W05XtwbrCo2XtmqWE9gxLI+glwxNDndah
 bcqrJ9WEWSU2B6b8f+y7Liu+M91hQM3q5+f3FrVMZ/tixFDovK3xwOKBQ8GoishsrulY
 GVXwwCV/2SIGL5oGA7AvqRDRYiOE/3Oj/OEtIwyNi1TDPmp4CD0KAqXxoanyTvK0hi/Z
 hyt25k6BhiN1KUNTND70cPZ0ywvJ2yESF2i+ikHzCAIhPxrnOf754Ym+D83z3sacJul9
 ju8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775482320; x=1776087120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5HnbHOp7Q4ycRb1IouZ3RpTVBY2mVgcLqjL2zLFW07g=;
 b=P6/3HSy8nTdmEfgwTC06gsvxwT2D+QUReKjCSIHNKfczI8mKxc8BAqIGGGgUgsosTL
 4Q2gY8YgUaeXFiajcCZqBhQUbvz/f/r/Uh5gdOJda0ZjpsEaNJOYkp463DhjNhYr1ZjB
 rl4PvQfP7f+AcVSMnMIIR3QbHAZVwMmViUJZ61+1Xa71AvN3AKvR1ukN94lXt77U0z8p
 TSje0DnbWmhFihnlGZpOQeXt7f4DQNtgO9OUqT3iCmCEYph+iLc7cEwhQpb6zpa0/vyT
 6w+5oP+PWfpUrgPkGK1/xdlP00lWyiZko+NzpWsia3cXyBuYePbycl8iKQAu2SDOR3KO
 MnrQ==
X-Gm-Message-State: AOJu0Ywg5fp8Jghpc/JBsVhNccDgYYdU3udNJhHjgnqwQZnF//QzoGGw
 NQPbYEgzWL2S0GWmG2XzeoBFPEuGapizNcA6ZW5DqH6Y2iCXFvGSqts/CJ3MvptJ3A==
X-Gm-Gg: AeBDieu6yEQUDLB1Nk1bZF/1IfAZTpfPMHupnVfAWrdxQdBEj9PiSHvMTsyLSOTtILx
 xnD6ZbqF/xnHmjsZvyuxkKDPzM3hPYb4/Bm02bJ7WqpFixcjCpa8uN7wzthJ/nXByzJM5qH8SbN
 AWbwLI9eIKZAO/ase5BbsvJxXOGC0dN9Ry+m+H/sER+vJw4GeIIJ1W72GkSm/Ql+gwVz306/sHb
 iMHR9n57X0auMqlX99SNlgHmuAXcdwmFhokolad7p0q4D71Du8Uoh9ZUHYT/mYWKiez+o47iDgK
 FdZs2LUlz6mFd7LQRU8Li9Pty3S8clC6BzG9upVL8TdjTSITD90F/zO/kYcKZK8j9KQduAu0WDc
 4Ezukx17+4hJeAg99ilGdBYNSM/NUMn5QRNJnRw/fiEjsOOCZC1/TMLvQptxux2p8dcBK0w2pgW
 AmvnyHxmVVvEgFbw0cmtP7lHoX4jr/m3lDXWqr+S5SO2Wx
X-Received: by 2002:a05:6a20:3d26:b0:398:6b9a:6765 with SMTP id
 adf61e73a8af0-39f2f16d5f5mr12522131637.58.1775482319886; 
 Mon, 06 Apr 2026 06:31:59 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c65935cbsm12800269a12.26.2026.04.06.06.31.58
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 06:31:59 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  6 Apr 2026 22:30:59 +0900
Message-ID: <20260406133134.17238-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] close: remove unused headers and fix minor style
 issues
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

Remove unused headers (<stdio.h>, <errno.h>, <sys/stat.h>) from close01.c
and (<stdio.h>, <sys/stat.h>) from close02.c.

Also make struct test_case_t static and apply minor style fixes.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/close/close01.c | 6 ++----
 testcases/kernel/syscalls/close/close02.c | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close01.c b/testcases/kernel/syscalls/close/close01.c
index 4e4f107ef..616752595 100644
--- a/testcases/kernel/syscalls/close/close01.c
+++ b/testcases/kernel/syscalls/close/close01.c
@@ -8,10 +8,7 @@
  * Test that closing a file/pipe/socket works correctly.
  */

-#include <stdio.h>
-#include <errno.h>
 #include <fcntl.h>
-#include <sys/stat.h>
 #include "tst_test.h"

 #define FILENAME "close01_testfile"
@@ -24,6 +21,7 @@ static int get_fd_file(void)
 static int get_fd_pipe(void)
 {
 	int pipefildes[2];
+
 	SAFE_PIPE(pipefildes);
 	SAFE_CLOSE(pipefildes[1]);
 	return pipefildes[0];
@@ -34,7 +32,7 @@ static int get_fd_socket(void)
 	return SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
 }

-struct test_case_t {
+static struct test_case_t {
 	int (*get_fd) ();
 	char *type;
 } tc[] = {
diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index 2016453f8..617c48237 100644
--- a/testcases/kernel/syscalls/close/close02.c
+++ b/testcases/kernel/syscalls/close/close02.c
@@ -8,9 +8,7 @@
  * Call close(-1) and expects it to return EBADF.
  */

-#include <stdio.h>
 #include <errno.h>
-#include <sys/stat.h>
 #include "tst_test.h"

 static void run(void)
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
