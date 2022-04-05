Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB65C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 13:49:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 808383CA44B
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 15:49:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E00253CA42B
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 15:48:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 283C3200AD4
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 15:48:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9547E1F7AD;
 Tue,  5 Apr 2022 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649166524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61NFMVJoXM8CgJ0fXJJUhrK/7ewPPGSUrWU2POKG60I=;
 b=MlcrC3gOgrXse5g7/r+OsCtfodY5RzaTB2qF3t374L49JG5GC/Epst/LOQO5dJb0kkXlZl
 Eq4R1PwBw8KdlkvBCMroyjIYzHmvdYYpjJ2iYExx6O5nzKDHCeu/KGV3DZdFud2L8fwe8q
 YvoaLOx+GMGV2fpMl4MTUGB9vbJNUxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649166524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61NFMVJoXM8CgJ0fXJJUhrK/7ewPPGSUrWU2POKG60I=;
 b=rz8bmwX0L+9psXOrBuSFrvPhGFXn7/IOkJcGI2oBB61X54uFPxfpIdxACmRMRVx0mbSr/8
 QF/i6BQUtedkS2BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEF2F13522;
 Tue,  5 Apr 2022 13:48:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +HFOM7tITGIUOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 05 Apr 2022 13:48:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  5 Apr 2022 15:48:36 +0200
Message-Id: <20220405134838.9440-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405134838.9440-1-pvorel@suse.cz>
References: <20220405134838.9440-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] confstr01.c: Rewrite into new API
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

From: Andrea Cervesato <andrea.cervesato@suse.de>

Fix musl build and runtime issues.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
pvorel: fix musl runtime issue, workaround a redefinition issues on musl and glibc ]
Co-developed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/confstr/confstr01.c | 193 ++++++++----------
 1 file changed, 85 insertions(+), 108 deletions(-)

diff --git a/testcases/kernel/syscalls/confstr/confstr01.c b/testcases/kernel/syscalls/confstr/confstr01.c
index 0fc4c46d51..20267f6865 100644
--- a/testcases/kernel/syscalls/confstr/confstr01.c
+++ b/testcases/kernel/syscalls/confstr/confstr01.c
@@ -1,136 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2002
+*  11/20/2002 Port to LTP <robbiew@us.ibm.com>
+*  06/30/2001 Port to Linux	<nsharoff@us.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ * Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
  */
 
-/* 11/20/2002	Port to LTP	robbiew@us.ibm.com */
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-
-/*
- * NAME
- *	confstr1.c - test for confstr(3C) - Get configuration-defined string
- *	values.
- *
- * CALLS
- *	confstr(3C)
- *
- * RESTRICTIONS
- * MUST RUN AS ROOT
+/*\
+ * [Description]
  *
+ * Test confstr(3) 500 (X/Open 5) functionality &ndash; POSIX 1995.
  */
 
+#include "tst_test.h"
+
+#ifdef _XOPEN_SOURCE
+# undef _XOPEN_SOURCE
+#endif
 #define _XOPEN_SOURCE 500
 
+#include <stdlib.h>
 #include <unistd.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <errno.h>
-
-#include "test.h"
-#include "safe_macros.h"
 
 static struct test_case_t {
 	int value;
 	char *name;
 } test_cases[] = {
-	{_CS_PATH, "PATH"},
-	{_CS_XBS5_ILP32_OFF32_CFLAGS, "XBS5_ILP32_OFF32_CFLAGS"},
-	{_CS_XBS5_ILP32_OFF32_LDFLAGS, "XBS5_ILP32_OFF32_LDFLAGS"},
-	{_CS_XBS5_ILP32_OFF32_LIBS, "XBS5_ILP32_OFF32_LIBS"},
-	{_CS_XBS5_ILP32_OFF32_LINTFLAGS, "XBS5_ILP32_OFF32_LINTFLAGS"},
-	{_CS_XBS5_ILP32_OFFBIG_CFLAGS, "XBS5_ILP32_OFFBIG_CFLAGS"},
-	{_CS_XBS5_ILP32_OFFBIG_LDFLAGS, "XBS5_ILP32_OFFBIG_LDFLAGS"},
-	{_CS_XBS5_ILP32_OFFBIG_LIBS, "XBS5_ILP32_OFFBIG_LIBS"},
-	{_CS_XBS5_ILP32_OFFBIG_LINTFLAGS, "XBS5_ILP32_OFFBIG_LINTFLAGS"},
-	{_CS_XBS5_LP64_OFF64_CFLAGS, "XBS5_LP64_OFF64_CFLAGS"},
-	{_CS_XBS5_LP64_OFF64_LDFLAGS, "XBS5_LP64_OFF64_LDFLAGS"},
-	{_CS_XBS5_LP64_OFF64_LIBS, "XBS5_LP64_OFF64_LIBS"},
-	{_CS_XBS5_LP64_OFF64_LINTFLAGS, "XBS5_LP64_OFF64_LINTFLAGS"},
-	{_CS_XBS5_LPBIG_OFFBIG_CFLAGS, "XBS5_LPBIG_OFFBIG_CFLAGS"},
-	{_CS_XBS5_LPBIG_OFFBIG_LDFLAGS, "XBS5_LPBIG_OFFBIG_LDFLAGS"},
-	{_CS_XBS5_LPBIG_OFFBIG_LIBS, "XBS5_LPBIG_OFFBIG_LIBS"},
-	{_CS_XBS5_LPBIG_OFFBIG_LINTFLAGS, "XBS5_LPBIG_OFFBIG_LINTFLAGS"},
-	{_CS_GNU_LIBC_VERSION, "GNU_LIBC_VERSION"},
-	{_CS_GNU_LIBPTHREAD_VERSION, "GNU_LIBPTHREAD_VERSION"},
+	{ _CS_PATH, "PATH" },
+	{ _CS_GNU_LIBC_VERSION, "GNU_LIBC_VERSION" },
+	{ _CS_GNU_LIBPTHREAD_VERSION, "GNU_LIBPTHREAD_VERSION" },
+
+/* checking for obsolete configurations */
+#ifdef _CS_XBS5_ILP32_OFF32_CFLAGS
+	{ _CS_XBS5_ILP32_OFF32_CFLAGS, "XBS5_ILP32_OFF32_CFLAGS" },
+#endif
+#ifdef _CS_XBS5_ILP32_OFF32_LDFLAGS
+	{ _CS_XBS5_ILP32_OFF32_LDFLAGS, "XBS5_ILP32_OFF32_LDFLAGS" },
+#endif
+#ifdef _CS_XBS5_ILP32_OFF32_LIBS
+	{ _CS_XBS5_ILP32_OFF32_LIBS, "XBS5_ILP32_OFF32_LIBS" },
+#endif
+#ifdef _CS_XBS5_ILP32_OFF32_LINTFLAGS
+	{ _CS_XBS5_ILP32_OFF32_LINTFLAGS, "XBS5_ILP32_OFF32_LINTFLAGS" },
+#endif
+#ifdef _CS_XBS5_ILP32_OFFBIG_CFLAGS
+	{ _CS_XBS5_ILP32_OFFBIG_CFLAGS, "XBS5_ILP32_OFFBIG_CFLAGS" },
+#endif
+#ifdef _CS_XBS5_ILP32_OFFBIG_LDFLAGS
+	{ _CS_XBS5_ILP32_OFFBIG_LDFLAGS, "XBS5_ILP32_OFFBIG_LDFLAGS" },
+#endif
+#ifdef _CS_XBS5_ILP32_OFFBIG_LIBS
+	{ _CS_XBS5_ILP32_OFFBIG_LIBS, "XBS5_ILP32_OFFBIG_LIBS" },
+#endif
+#ifdef _CS_XBS5_ILP32_OFFBIG_LINTFLAGS
+	{ _CS_XBS5_ILP32_OFFBIG_LINTFLAGS, "XBS5_ILP32_OFFBIG_LINTFLAGS" },
+#endif
+#ifdef _CS_XBS5_LP64_OFF64_CFLAGS
+	{ _CS_XBS5_LP64_OFF64_CFLAGS, "XBS5_LP64_OFF64_CFLAGS" },
+#endif
+#ifdef _CS_XBS5_LP64_OFF64_LDFLAGS
+	{ _CS_XBS5_LP64_OFF64_LDFLAGS, "XBS5_LP64_OFF64_LDFLAGS" },
+#endif
+#ifdef _CS_XBS5_LP64_OFF64_LIBS
+	{ _CS_XBS5_LP64_OFF64_LIBS, "XBS5_LP64_OFF64_LIBS" },
+#endif
+#ifdef _CS_XBS5_LP64_OFF64_LINTFLAGS
+	{ _CS_XBS5_LP64_OFF64_LINTFLAGS, "XBS5_LP64_OFF64_LINTFLAGS" },
+#endif
+#ifdef _CS_XBS5_LPBIG_OFFBIG_CFLAGS
+	{ _CS_XBS5_LPBIG_OFFBIG_CFLAGS, "XBS5_LPBIG_OFFBIG_CFLAGS" },
+#endif
+#ifdef _CS_XBS5_LPBIG_OFFBIG_LDFLAGS
+	{ _CS_XBS5_LPBIG_OFFBIG_LDFLAGS, "XBS5_LPBIG_OFFBIG_LDFLAGS" },
+#endif
+#ifdef _CS_XBS5_LPBIG_OFFBIG_LIBS
+	{ _CS_XBS5_LPBIG_OFFBIG_LIBS, "XBS5_LPBIG_OFFBIG_LIBS" },
+#endif
+#ifdef _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS
+	{ _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS, "XBS5_LPBIG_OFFBIG_LINTFLAGS" },
+#endif
 };
 
-char *TCID = "confstr01";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char *argv[])
+static void run(unsigned int i)
 {
-	int lc;
-	int i;
 	char *buf;
 	int len;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	TST_EXP_POSITIVE(confstr(test_cases[i].value, NULL, (size_t)0));
 
-		tst_count = 0;
+	if (!TST_PASS)
+		return;
 
-		for (i = 0; i < TST_TOTAL; i++) {
+	len = TST_RET;
+	buf = SAFE_MALLOC(len);
 
-			TEST(confstr(test_cases[i].value, NULL, (size_t)0));
+	TEST(confstr(test_cases[i].value, buf, len));
 
-			if (TEST_RETURN != 0) {
-				len = TEST_RETURN;
-				buf = SAFE_MALLOC(cleanup, len);
-				TEST(confstr(test_cases[i].value, buf, len));
-
-				if (TEST_RETURN != len || buf[len-1] != '\0') {
-					tst_brkm(TBROK, cleanup,
-						 "confstr :%s failed",
-						 test_cases[i].name);
-				} else {
-					tst_resm(TPASS, "confstr %s = '%s'",
-						 test_cases[i].name, buf);
-				}
-				free(buf);
-			} else {
-				if (TEST_ERRNO == EINVAL) {
-					tst_resm(TCONF,
-						 "confstr %s not supported",
-						 test_cases[i].name);
-				} else {
-					tst_resm(TFAIL,
-						 "confstr %s failed",
-						 test_cases[i].name);
-				}
-			}
-		}
+	if (buf[len - 1] != '\0') {
+		tst_brk(TFAIL, "confstr: %s, %s", test_cases[i].name,
+			tst_strerrno(TST_ERR));
+	} else {
+		tst_res(TPASS, "confstr %s = '%s'", test_cases[i].name, buf);
 	}
 
-	cleanup();
-
-	tst_exit();
+	free(buf);
 }
 
-static void setup(void)
-{
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(test_cases),
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
