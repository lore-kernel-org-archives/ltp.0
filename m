Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF12C197A0
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 15:49:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 947653CE1C9
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 16:48:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70DBF3CB683
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 16:48:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1AEC5140120C
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 16:48:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D5112184B;
 Mon, 20 Nov 2023 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700495323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1T6oGJv7B930fW738Ounom7vajoqRipUBYpWm6cqttk=;
 b=Ox4yiDcg7SsW4lfnonT+o9L8VryXggwW9GtpTqkIvapYTWYMJb7ERwvhUz5NL52+3yO7CT
 gbyojpY6lQyCVlNrBud/LKQ70kro3U8v3HKYCfM1wANKZ1WT9KCIji2b9cASpBySprskFO
 JMA3rEHXQUlfHaZBLWDOVg09BMfbnRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700495323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1T6oGJv7B930fW738Ounom7vajoqRipUBYpWm6cqttk=;
 b=hptHahwF1qhAAf6/iiA1RtS7M23Hhs6ayGTew8vuOLsg0jNrxfhOsamZSyARI+k2e4wB77
 4Z2TGubf5bXsxpCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 344A6134AD;
 Mon, 20 Nov 2023 15:48:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SlwfC9t/W2XzVAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 20 Nov 2023 15:48:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 20 Nov 2023 16:48:42 +0100
Message-Id: <20231120154842.17037-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Delete getdtablesize01 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The getdtablesize syscall has been created in the early Linux versions
and it has been replaced by getrlimit, which is now tested by its own
testing suite. For this reason we don't need this test anymore, since
its refactoring to new API can be considered a waste of time.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |   2 -
 .../kernel/syscalls/getdtablesize/.gitignore  |   1 -
 .../kernel/syscalls/getdtablesize/Makefile    |   8 --
 .../syscalls/getdtablesize/getdtablesize01.c  | 119 ------------------
 4 files changed, 130 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/getdtablesize/.gitignore
 delete mode 100644 testcases/kernel/syscalls/getdtablesize/Makefile
 delete mode 100644 testcases/kernel/syscalls/getdtablesize/getdtablesize01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c98992d44..4dc7c8ddc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -449,8 +449,6 @@ getdents02 getdents02
 
 getdomainname01 getdomainname01
 
-getdtablesize01 getdtablesize01
-
 getegid01 getegid01
 getegid01_16 getegid01_16
 getegid02 getegid02
diff --git a/testcases/kernel/syscalls/getdtablesize/.gitignore b/testcases/kernel/syscalls/getdtablesize/.gitignore
deleted file mode 100644
index 67a71b5e2..000000000
--- a/testcases/kernel/syscalls/getdtablesize/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/getdtablesize01
diff --git a/testcases/kernel/syscalls/getdtablesize/Makefile b/testcases/kernel/syscalls/getdtablesize/Makefile
deleted file mode 100644
index 044619fb8..000000000
--- a/testcases/kernel/syscalls/getdtablesize/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) International Business Machines  Corp., 2001
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
deleted file mode 100644
index d25cac261..000000000
--- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
+++ /dev/null
@@ -1,119 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2005
- * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : getdtablesize01
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Basic tests for getdtablesize01(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Prashant P Yendigeri
- *                        <prashant.yendigeri@wipro.com>
- *                        Robbie Williamson
- *                        <robbiew@us.ibm.com>
- *
- *    DESCRIPTION
- *      This is a Phase I test for the getdtablesize01(2) system call.
- *      It is intended to provide a limited exposure of the system call.
- *
- **********************************************************/
-
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <unistd.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "getdtablesize01";
-int TST_TOTAL = 1;
-
-int main(void)
-{
-	int table_size, fd = 0, count = 0;
-	int max_val_opfiles;
-	struct rlimit rlp;
-
-	setup();
-	table_size = getdtablesize();
-	getrlimit(RLIMIT_NOFILE, &rlp);
-	max_val_opfiles = (rlim_t) rlp.rlim_cur;
-
-	tst_resm(TINFO,
-		 "Maximum number of files a process can have opened is %d",
-		 table_size);
-	tst_resm(TINFO,
-		 "Checking with the value returned by getrlimit...RLIMIT_NOFILE");
-
-	if (table_size == max_val_opfiles)
-		tst_resm(TPASS, "got correct dtablesize, value is %d",
-			 max_val_opfiles);
-	else {
-		tst_resm(TFAIL, "got incorrect table size, value is %d",
-			 max_val_opfiles);
-		cleanup();
-	}
-
-	tst_resm(TINFO,
-		 "Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1");
-	for (;;) {
-		fd = open("/etc/hosts", O_RDONLY);
-
-		if (fd == -1)
-			break;
-		count = fd;
-
-#ifdef DEBUG
-		printf("Opened file num %d\n", fd);
-#endif
-	}
-
-//Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
-
-	if (count > 0)
-		close(count);
-	if (count == (max_val_opfiles - 1))
-		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
-	else if (fd < 0 && errno == ENFILE)
-		tst_brkm(TCONF, cleanup, "Reached maximum number of open files for the system");
-	else
-		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-void cleanup(void)
-{
-}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
