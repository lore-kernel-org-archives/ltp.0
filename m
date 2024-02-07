Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF8EC4828D
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 15:28:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7CE33CF5AC
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 16:28:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73D3D3CC529
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 16:28:38 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8A3D620173E
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 16:28:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F2E41F78A
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 15:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707319716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OlKJgsW1MizUsqFFjlPNk5XjrmkFfA+bKUYqXzwNRGo=;
 b=jVaaK6SMSHrM4jnAgRO3gWb/poV2Tbr29LqhdFEqU4pUCW0nX1PE41619aejMvCyHzH+dv
 rsmAZsRdCkNoN1waW/1fdCNXMXil5OVLwFc+qQimozcoIuOUyyZ95v/PqWwAm+Tj4ehOKT
 lV+KBC71J+p7ydIam9ydvgKUaNtDMeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707319716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OlKJgsW1MizUsqFFjlPNk5XjrmkFfA+bKUYqXzwNRGo=;
 b=WzU57yV+O2ImdsuHBBj0J5HX4snm93GfS7nsyrlvmRrlaKp6xxo7WSwJDFrCOCZvwrnlEe
 Zt+ilXxV4Bxnv9AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707319716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OlKJgsW1MizUsqFFjlPNk5XjrmkFfA+bKUYqXzwNRGo=;
 b=jVaaK6SMSHrM4jnAgRO3gWb/poV2Tbr29LqhdFEqU4pUCW0nX1PE41619aejMvCyHzH+dv
 rsmAZsRdCkNoN1waW/1fdCNXMXil5OVLwFc+qQimozcoIuOUyyZ95v/PqWwAm+Tj4ehOKT
 lV+KBC71J+p7ydIam9ydvgKUaNtDMeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707319716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OlKJgsW1MizUsqFFjlPNk5XjrmkFfA+bKUYqXzwNRGo=;
 b=WzU57yV+O2ImdsuHBBj0J5HX4snm93GfS7nsyrlvmRrlaKp6xxo7WSwJDFrCOCZvwrnlEe
 Zt+ilXxV4Bxnv9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62F2A139B9
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 15:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bjMiGKShw2XvPQAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 07 Feb 2024 15:28:36 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed,  7 Feb 2024 16:28:34 +0100
Message-ID: <20240207152836.1882-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: ++++++++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jVaaK6SM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WzU57yV+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [8.59 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 BAYES_SPAM(5.10)[100.00%];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 R_MISSING_CHARSET(2.50)[]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 6F2E41F78A
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/mmap13: Rewrite the test using new API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap13.c | 173 +++++++++---------------
 1 file changed, 65 insertions(+), 108 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap13.c b/testcases/kernel/syscalls/mmap/mmap13.c
index c5a2058e9..92eba949d 100644
--- a/testcases/kernel/syscalls/mmap/mmap13.c
+++ b/testcases/kernel/syscalls/mmap/mmap13.c
@@ -1,142 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
+ * Copyright (c) 2024 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Verify that, mmap() call succeeds to create a file mapping with length
+ * argument greater than the file size but any attempt to reference the
+ * memory region which does not correspond to the file causes SIGBUS signal.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Description:
- *  Verify error signal SIGBUS.
- *  "Attempted access to a portion of the buffer that does not correspond
- *   to the file."
+ *                  mmap(0, 8192, prot, MAP_FILE | MAP_SHARED, fd, 0);
+ *
+ *  byte offset:    0        2047 2048    4095 4096                8191 8192
+ *                  +------------+------------+------------------------+
+ *  Memory          |            |  remainder |                        |
+ *  region          |            | of page(0s)|                        |
+ *                  +------------+------------+------------------------+
+ *                  |<---------->|<---------->|<---------------------->|<--------------->
+ *                  | accessible,| accessible,        references            references
+ *                  |   mapped   | not mapped        yield SIGBUS          yield SIGSEGV
+ *                  |  to file   |  to file
+ *                  |            |
+ *                  +------------+
+ *  Mapped file     |            |
+ * (2048 bytes)     |            |
+ *                  +------------+
+ *  file offset:    0         2047
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and an attempt to access the memory which does not correspond to the file
- *  should rise the signal SIGBUS.
+ * Note: The byte offsets in the diagram are only valid for 4Kb pages.
  */
-#include <stdio.h>
+
 #include <stdlib.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
 #include <setjmp.h>
-
-#include "test.h"
+#include "tst_test.h"
 
 #define TEMPFILE	"mmapfile"
-
-char *TCID = "mmap13";
-int TST_TOTAL = 1;
-
 static size_t page_sz;
 static char *addr;
-static int fildes;
+static int fd;
 static volatile sig_atomic_t pass;
 static sigjmp_buf env;
 
-static void setup(void);
-static void cleanup(void);
-static void sig_handler(int sig);
-
-int main(int argc, char *argv[])
+static void sig_handler(int sig)
 {
-	int lc;
-	char *ch;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		addr = mmap(NULL, page_sz * 2, PROT_READ | PROT_WRITE,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap() failed on %s",
-				 TEMPFILE);
-			continue;
-		}
-
-		if (sigsetjmp(env, 1) == 0) {
-			ch = addr + page_sz + 1;
-			*ch = 0;
-		}
-
-		if (pass)
-			tst_resm(TPASS, "Got SIGBUS "
-					"as expected");
-		else
-			tst_resm(TFAIL, "Invalid access not "
-						"rise SIGBUS");
-
-		if (munmap(addr, page_sz * 2) != 0)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "failed to unmap the mmapped pages");
-
-		pass = 0;
+	if (sig == SIGBUS) {
+		pass = 1;
+		siglongjmp(env, 1);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, sig_handler, cleanup);
-
-	TEST_PAUSE;
+	SAFE_SIGNAL(SIGBUS, sig_handler);
 
 	page_sz = getpagesize();
 
-	tst_tmpdir();
-
-	fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0766);
-	if (fildes < 0)
-		tst_brkm(TFAIL | TERRNO, cleanup, "opening %s failed",
-			 TEMPFILE);
-
-	if (ftruncate(fildes, page_sz / 2) == -1)
-		tst_brkm(TFAIL | TERRNO, cleanup, "ftruncate %s failed",
-			 TEMPFILE);
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
+	SAFE_FTRUNCATE(fd, page_sz / 2);
 }
 
-/*
- *   This function gets executed when the test process receives
- *   the signal SIGBUS while trying to access the memory which
- *   does not correspond to the file.
- */
-static void sig_handler(int sig)
+static void run(void)
 {
-	if (sig == SIGBUS) {
-		pass = 1;
-		siglongjmp(env, 1);
-	} else {
-		tst_brkm(TBROK, cleanup, "received an unexpected signal");
+	char *ch;
+
+	addr = mmap(0, page_sz * 2, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap() of %s failed", TEMPFILE);
+		return;
 	}
+
+	if (sigsetjmp(env, 1) == 0) {
+		ch = addr + page_sz + 1;
+		*ch = 0;
+	}
+
+	if (pass == 1)
+		tst_res(TPASS, "Received SIGBUS signal as expected");
+	else
+		tst_res(TFAIL, "SIGBUS signal not received");
+
+	SAFE_MUNMAP(addr, page_sz * 2);
 }
 
 static void cleanup(void)
 {
-	close(fildes);
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_tmpdir = 1
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
