Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B599C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 15:01:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFA943CF91C
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 16:01:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 254213C896B
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 16:01:38 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3FF5B600F5B
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 16:01:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D6E81FB87
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706713297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TeO81dWhYKvzWMDy85nqs3kfK2R0pCFTwgYqQ5D93Eo=;
 b=mqKUxV0A0k3GuwyDh7jgvd+jnmoONLGmKxrV2ej4AaWXvvFnIyk5VH8HoxMX9QJ+k9JtP9
 Oy5hziQ3bfoa6XFysLMohX/oNAt1LhcyW/y6GcDlbFJXab0o+Qop1Thqq73yUDk9VfxjwQ
 e/uiVVArSXJb5a38C9I4SJH4c+ZHdRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706713297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TeO81dWhYKvzWMDy85nqs3kfK2R0pCFTwgYqQ5D93Eo=;
 b=xLZoErBNsz+BIEq7ZPkm8VgzaRGgx8+FwjzN1twAr8lvhqHmfWOFVbBSF/FXSZbT54QSXG
 ZUEChC1pMoNZX7Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706713297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TeO81dWhYKvzWMDy85nqs3kfK2R0pCFTwgYqQ5D93Eo=;
 b=mqKUxV0A0k3GuwyDh7jgvd+jnmoONLGmKxrV2ej4AaWXvvFnIyk5VH8HoxMX9QJ+k9JtP9
 Oy5hziQ3bfoa6XFysLMohX/oNAt1LhcyW/y6GcDlbFJXab0o+Qop1Thqq73yUDk9VfxjwQ
 e/uiVVArSXJb5a38C9I4SJH4c+ZHdRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706713297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TeO81dWhYKvzWMDy85nqs3kfK2R0pCFTwgYqQ5D93Eo=;
 b=xLZoErBNsz+BIEq7ZPkm8VgzaRGgx8+FwjzN1twAr8lvhqHmfWOFVbBSF/FXSZbT54QSXG
 ZUEChC1pMoNZX7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0103B139B1
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 15:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id APk1ANFgumW9HAAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 15:01:37 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 16:01:27 +0100
Message-ID: <20240131150136.4082-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [10.00 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(5.10)[100.00%];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/mmap14: Rewrite test using new LTP API
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
 testcases/kernel/syscalls/mmap/mmap14.c | 135 ++++++++----------------
 1 file changed, 45 insertions(+), 90 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
index 31632601b..33c6d1ef0 100644
--- a/testcases/kernel/syscalls/mmap/mmap14.c
+++ b/testcases/kernel/syscalls/mmap/mmap14.c
@@ -1,124 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) 2024 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Description:
- *  Verify MAP_LOCKED works fine.
- *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."
+/*\
+ * [Description]
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and this region should be locked into memory.
+ * Verify that, mmap() call with MAP_LOCKED flag successfully locks
+ * the mapped pages into memory.
  */
-#include <stdio.h>
-#include <sys/mman.h>
 
-#include "test.h"
+#include <stdio.h>
+#include "tst_test.h"
 
-#define TEMPFILE        "mmapfile"
-#define MMAPSIZE        (1UL<<20)
+#define MMAPSIZE        (1UL<<22)
 #define LINELEN         256
 
-char *TCID = "mmap14";
-int TST_TOTAL = 1;
-
 static char *addr;
-
 static void getvmlck(unsigned int *lock_sz);
-static void setup(void);
-static void cleanup(void);
+static struct rlimit rlim;
+static unsigned int sz_before;
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-	unsigned int sz_before;
-	unsigned int sz_after;
-	unsigned int sz_ch;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
+	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &rlim);
 
-		getvmlck(&sz_before);
+	getvmlck(&sz_before);
 
-		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
-			    MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
-			    -1, 0);
-
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
-			continue;
-		}
-
-		getvmlck(&sz_after);
-
-		sz_ch = sz_after - sz_before;
-		if (sz_ch == MMAPSIZE / 1024) {
-			tst_resm(TPASS, "Functionality of mmap() "
-					"successful");
-		} else {
-			tst_resm(TFAIL, "Expected %luK locked, "
-					"get %uK locked",
-					MMAPSIZE / 1024, sz_ch);
-		}
-
-		if (munmap(addr, MMAPSIZE) != 0)
-			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
-	}
-
-	cleanup();
-	tst_exit();
+	if (((sz_before * 1024) + MMAPSIZE) > rlim.rlim_cur)
+		tst_brk(TCONF, "Trying to exceed RLIMIT_MEMLOCK limit");
 }
 
 void getvmlck(unsigned int *lock_sz)
 {
-	int ret;
 	char line[LINELEN];
-	FILE *fstatus = NULL;
+	FILE *fp = NULL;
 
-	fstatus = fopen("/proc/self/status", "r");
-	if (fstatus == NULL)
-		tst_brkm(TFAIL | TERRNO, NULL, "Open dev status failed");
+	fp = fopen("/proc/self/status", "r");
+	if (fp == NULL)
+		tst_brk(TFAIL | TERRNO, "could not open status file");
 
-	while (fgets(line, LINELEN, fstatus) != NULL)
+	while (fgets(line, LINELEN, fp) != NULL) {
 		if (strstr(line, "VmLck") != NULL)
 			break;
+	}
 
-	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
-	if (ret != 1)
-		tst_brkm(TFAIL | TERRNO, NULL, "Get lock size failed");
+	if (sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz) != 1)
+		tst_brk(TFAIL | TERRNO, "Getting locked memory size failed");
 
-	fclose(fstatus);
+	fclose(fp);
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
+	unsigned int sz_after, sz_diff;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS, -1, 0);
 
-	TEST_PAUSE;
-}
+	if (addr != MAP_FAILED) {
+		tst_res(TPASS, "mmap() with MAP_LOCKED flag passed");
+	} else {
+		tst_res(TFAIL | TERRNO, "mmap() failed");
+		return;
+	}
 
-static void cleanup(void)
-{
+	getvmlck(&sz_after);
+	sz_diff = sz_after - sz_before;
+	TST_EXP_EQ_LU(MMAPSIZE / 1024, sz_diff);
+
+	SAFE_MUNMAP(addr, MMAPSIZE);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
