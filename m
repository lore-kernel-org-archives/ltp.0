Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB62C5DF62
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 12:37:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AE9B3C9602
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 13:37:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C30413C96A3
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB518600D70
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E6DD218E6;
 Wed, 26 Jan 2022 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643200556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZ2257FBpKpXx4RXfZY7Kuyy9kXb4fz+X2GIlx0+CZY=;
 b=oCkBSt1KVt0DZqrlK0vBtb2x7l5MF72sdEXBUJ6Q+5bwLJJWnXGZVdfToDcN95YlSADGDU
 /TOslxIYCLY+2eH3vOaxUu1sQHPeyBdWOrUMtlIYvzJfCDuX+2ETmKq1dJj3r9304a3j60
 skGftHAHzSi1PZKXQT4YW5re4ceN9SI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643200556;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZ2257FBpKpXx4RXfZY7Kuyy9kXb4fz+X2GIlx0+CZY=;
 b=Zpx2sPEr7j5b7YCi9n+alzznj3JQx3u4vKIIDZkKMeHkwHWJPyY1DkMyUv/4uG9K8k1xjb
 9wIKe84C05H9yuAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A5DB13F30;
 Wed, 26 Jan 2022 12:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +PY9BSxA8WGkOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 12:35:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 13:35:42 +0100
Message-Id: <20220126123547.13298-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126123547.13298-1-pvorel@suse.cz>
References: <20220126123547.13298-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v2 2/7] m4: Remove check for io_set_eventfd
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It was added in Jan 2008 in libaio-0.3.108, even Centos 6 has 0.3.109,
SLES11-SP4 and Debian stretch (oldoldstable) have 0.3.110.

At least CentOS 6 and SLES11-SP4 don't event compiles LTP at least 2
releases back.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 m4/ltp-eventfd.m4                             | 11 +----------
 testcases/kernel/syscalls/eventfd/eventfd01.c | 18 +-----------------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/m4/ltp-eventfd.m4 b/m4/ltp-eventfd.m4
index 5d729a33df..ecd7e951dc 100644
--- a/m4/ltp-eventfd.m4
+++ b/m4/ltp-eventfd.m4
@@ -1,6 +1,6 @@
 dnl SPDX-License-Identifier: GPL-2.0-or-later
 dnl Copyright (c) Red Hat Inc., 2008
-dnl Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+dnl Copyright (c) 2017-2022 Petr Vorel <pvorel@suse.cz>
 dnl Author: Masatake YAMATO <yamato@redhat.com>
 
 AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
@@ -10,14 +10,5 @@ AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
 	if test "x$have_libaio" = "xyes" -a "x$have_aio" = "xyes"; then
 		AC_DEFINE(HAVE_LIBAIO, 1, [Define to 1 if you have libaio and it's headers installed.])
 		AC_SUBST(AIO_LIBS, "-laio")
-
-		AC_MSG_CHECKING([io_set_eventfd is defined in aio library or aio header])
-		AC_TRY_LINK([#include <stdio.h>
-                             #include <libaio.h>
-		            ],
-		            [io_set_eventfd(NULL, 0); return 0;],
-		            [AC_DEFINE(HAVE_IO_SET_EVENTFD, 1, [Define to 1 if you have `io_set_eventfd' function.])
-						AC_MSG_RESULT(yes)],
-		            [AC_MSG_RESULT(no)])
 	fi
 ])
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index 242e170e27..3180ea1593 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -1,5 +1,6 @@
 /*
  *   Copyright (c) 2008 Vijay Kumar B. <vijaykumar@bravegnu.org>
+ *   Copyright (c) Linux Test Project, 2008-2022
  *
  *   Based on testcases/kernel/syscalls/waitpid/waitpid01.c
  *   Original copyright message:
@@ -472,7 +473,6 @@ static void child_inherit_test(int fd)
 	}
 }
 
-#ifdef HAVE_IO_SET_EVENTFD
 /*
  * Test whether counter overflow is detected and handled correctly.
  *
@@ -648,22 +648,6 @@ static void overflow_read_test(int evfd)
 	}
 	cleanup_overflow(fd, ctx);
 }
-#else
-static void overflow_select_test(int evfd)
-{
-	tst_resm(TCONF, "eventfd support is not available in AIO subsystem");
-}
-
-static void overflow_poll_test(int evfd)
-{
-	tst_resm(TCONF, "eventfd support is not available in AIO subsystem");
-}
-
-static void overflow_read_test(int evfd)
-{
-	tst_resm(TCONF, "eventfd support is not available in AIO subsystem");
-}
-#endif
 
 int main(int argc, char **argv)
 {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
