Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0043FC433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 06:48:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0C733CA646
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 08:47:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 552323C19CA
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 08:47:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DBF196003D0
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 08:47:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED86F2112B;
 Tue, 19 Apr 2022 06:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650350867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2n9hQNVPnU93OfRH8qtvIXD4tqLr2Z8Itd3aCCF/nlk=;
 b=h20Af+jlkY4aS0Iw/UgSjW/Z6yJKnW5wF7ETNzykvN58lwwzPkWDLqfLYurOhTnGjH0Eqn
 Y/2Y7d1iuRAPPz4XPub5KUGUPE09oZoDnubtC+Jf1bqr12Fj8cvCQ3QMkgajsAjEF2USOh
 WtIjhE0Eg6gTdzJZBkKVvx31kcIe6k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650350867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2n9hQNVPnU93OfRH8qtvIXD4tqLr2Z8Itd3aCCF/nlk=;
 b=sxeWeVSt06vWULQIWB+5hNwtzj5eugp04BhmVDC7Gbyr02jzCxPAkd9be/3Uctt1c0ptEQ
 2YWM/Am0qlyqZLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9CB8139BE;
 Tue, 19 Apr 2022 06:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TRFUKhNbXmKYPAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 19 Apr 2022 06:47:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 19 Apr 2022 08:47:44 +0200
Message-Id: <20220419064744.11487-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] confstr01: Update to X/Open 7 (POSIX 2008)
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

_CS_POSIX_V7_THREADS_{C,LD}FLAGS aren't currently supported on glibc
(2.35) nor on musl (v1.2.2), uclibc-ng (v1.0.40).

_CS_V7_ENV is not on uclibc-ng.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* wrap _CS_V7_ENV with #ifdef (missing on uclibc)

 testcases/kernel/syscalls/confstr/confstr01.c | 81 ++++++-------------
 1 file changed, 25 insertions(+), 56 deletions(-)

diff --git a/testcases/kernel/syscalls/confstr/confstr01.c b/testcases/kernel/syscalls/confstr/confstr01.c
index 57ac0a9ad9..2b2daa0d4e 100644
--- a/testcases/kernel/syscalls/confstr/confstr01.c
+++ b/testcases/kernel/syscalls/confstr/confstr01.c
@@ -10,19 +10,16 @@
 /*\
  * [Description]
  *
- * Test confstr(3) 500 (X/Open 5) functionality &ndash; POSIX 1995.
+ * Test confstr(3) 700 (X/Open 7) functionality &ndash; POSIX 2008.
  */
 
-#include "tst_test.h"
-
-#ifdef _XOPEN_SOURCE
-# undef _XOPEN_SOURCE
-#endif
-#define _XOPEN_SOURCE 500
+#define _XOPEN_SOURCE 700
 
 #include <stdlib.h>
 #include <unistd.h>
 
+#include "tst_test.h"
+
 static struct test_case_t {
 	int value;
 	char *name;
@@ -30,55 +27,27 @@ static struct test_case_t {
 	{ _CS_PATH, "PATH" },
 	{ _CS_GNU_LIBC_VERSION, "GNU_LIBC_VERSION" },
 	{ _CS_GNU_LIBPTHREAD_VERSION, "GNU_LIBPTHREAD_VERSION" },
-
-/* checking for obsolete configurations */
-#ifdef _CS_XBS5_ILP32_OFF32_CFLAGS
-	{ _CS_XBS5_ILP32_OFF32_CFLAGS, "XBS5_ILP32_OFF32_CFLAGS" },
-#endif
-#ifdef _CS_XBS5_ILP32_OFF32_LDFLAGS
-	{ _CS_XBS5_ILP32_OFF32_LDFLAGS, "XBS5_ILP32_OFF32_LDFLAGS" },
-#endif
-#ifdef _CS_XBS5_ILP32_OFF32_LIBS
-	{ _CS_XBS5_ILP32_OFF32_LIBS, "XBS5_ILP32_OFF32_LIBS" },
-#endif
-#ifdef _CS_XBS5_ILP32_OFF32_LINTFLAGS
-	{ _CS_XBS5_ILP32_OFF32_LINTFLAGS, "XBS5_ILP32_OFF32_LINTFLAGS" },
-#endif
-#ifdef _CS_XBS5_ILP32_OFFBIG_CFLAGS
-	{ _CS_XBS5_ILP32_OFFBIG_CFLAGS, "XBS5_ILP32_OFFBIG_CFLAGS" },
-#endif
-#ifdef _CS_XBS5_ILP32_OFFBIG_LDFLAGS
-	{ _CS_XBS5_ILP32_OFFBIG_LDFLAGS, "XBS5_ILP32_OFFBIG_LDFLAGS" },
-#endif
-#ifdef _CS_XBS5_ILP32_OFFBIG_LIBS
-	{ _CS_XBS5_ILP32_OFFBIG_LIBS, "XBS5_ILP32_OFFBIG_LIBS" },
-#endif
-#ifdef _CS_XBS5_ILP32_OFFBIG_LINTFLAGS
-	{ _CS_XBS5_ILP32_OFFBIG_LINTFLAGS, "XBS5_ILP32_OFFBIG_LINTFLAGS" },
-#endif
-#ifdef _CS_XBS5_LP64_OFF64_CFLAGS
-	{ _CS_XBS5_LP64_OFF64_CFLAGS, "XBS5_LP64_OFF64_CFLAGS" },
-#endif
-#ifdef _CS_XBS5_LP64_OFF64_LDFLAGS
-	{ _CS_XBS5_LP64_OFF64_LDFLAGS, "XBS5_LP64_OFF64_LDFLAGS" },
-#endif
-#ifdef _CS_XBS5_LP64_OFF64_LIBS
-	{ _CS_XBS5_LP64_OFF64_LIBS, "XBS5_LP64_OFF64_LIBS" },
-#endif
-#ifdef _CS_XBS5_LP64_OFF64_LINTFLAGS
-	{ _CS_XBS5_LP64_OFF64_LINTFLAGS, "XBS5_LP64_OFF64_LINTFLAGS" },
-#endif
-#ifdef _CS_XBS5_LPBIG_OFFBIG_CFLAGS
-	{ _CS_XBS5_LPBIG_OFFBIG_CFLAGS, "XBS5_LPBIG_OFFBIG_CFLAGS" },
-#endif
-#ifdef _CS_XBS5_LPBIG_OFFBIG_LDFLAGS
-	{ _CS_XBS5_LPBIG_OFFBIG_LDFLAGS, "XBS5_LPBIG_OFFBIG_LDFLAGS" },
-#endif
-#ifdef _CS_XBS5_LPBIG_OFFBIG_LIBS
-	{ _CS_XBS5_LPBIG_OFFBIG_LIBS, "XBS5_LPBIG_OFFBIG_LIBS" },
-#endif
-#ifdef _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS
-	{ _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS, "XBS5_LPBIG_OFFBIG_LINTFLAGS" },
+	{ _CS_POSIX_V7_ILP32_OFF32_CFLAGS, "POSIX_V7_ILP32_OFF32_CFLAGS" },
+	{ _CS_POSIX_V7_ILP32_OFF32_LDFLAGS, "POSIX_V7_ILP32_OFF32_LDFLAGS" },
+	{ _CS_POSIX_V7_ILP32_OFF32_LIBS, "POSIX_V7_ILP32_OFF32_LIBS" },
+	{ _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS, "POSIX_V7_ILP32_OFFBIG_CFLAGS" },
+	{ _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS, "POSIX_V7_ILP32_OFFBIG_LDFLAGS" },
+	{ _CS_POSIX_V7_ILP32_OFFBIG_LIBS, "POSIX_V7_ILP32_OFFBIG_LIBS" },
+	{ _CS_POSIX_V7_LP64_OFF64_CFLAGS, "POSIX_V7_LP64_OFF64_CFLAGS" },
+	{ _CS_POSIX_V7_LP64_OFF64_LDFLAGS, "POSIX_V7_LP64_OFF64_LDFLAGS" },
+	{ _CS_POSIX_V7_LP64_OFF64_LIBS, "POSIX_V7_LP64_OFF64_LIBS" },
+	{ _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS, "POSIX_V7_LPBIG_OFFBIG_CFLAGS" },
+	{ _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS, "POSIX_V7_LPBIG_OFFBIG_LDFLAGS" },
+	{ _CS_POSIX_V7_LPBIG_OFFBIG_LIBS, "POSIX_V7_LPBIG_OFFBIG_LIBS" },
+#ifdef _CS_POSIX_V7_THREADS_CFLAGS
+	{ _CS_POSIX_V7_THREADS_CFLAGS, "POSIX_V7_THREADS_CFLAGS" },
+#endif
+#ifdef _CS_POSIX_V7_THREADS_LDFLAGS
+	{ _CS_POSIX_V7_THREADS_LDFLAGS, "POSIX_V7_THREADS_LDFLAGS" },
+#endif
+	{ _CS_POSIX_V7_WIDTH_RESTRICTED_ENVS, "POSIX_V7_WIDTH_RESTRICTED_ENVS" },
+#ifdef _CS_V7_ENV
+	{ _CS_V7_ENV, "V7_ENV" },
 #endif
 };
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
