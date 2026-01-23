Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCA9D74EEC
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 16:19:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00C7A3CB886
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 17:19:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 457513C53B4
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 17:19:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A962A60029C
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 17:19:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8542F3382B;
 Fri, 23 Jan 2026 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769185134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rpq9rt6CSu4KZ6nnMaFEUFrki1to76OEWIvJi3PTJ2c=;
 b=e19Zkl5b4EEpZsY/grYxpc2Nzd3lFsVIIUg80igCyuun1th9H6XZEviDo9AEI58iQG9J+F
 /ZXhA+FlMBbTSlPXABlju+nTyYfJjwVtZw4pH6ZDmz6LQHrtjz4w16qnG+u5QuUP4hbR/B
 lpXr/K0q89Iex+fsJbBTtCDS9cmQWao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769185134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rpq9rt6CSu4KZ6nnMaFEUFrki1to76OEWIvJi3PTJ2c=;
 b=WEjMXGdTZbde2+6d/V2dwuYyAzR9u/CsML1JGVPP9fb/CwaCQyxLGqAVhvk5/GUBYRqqLc
 E6f4/9FXuPKdndAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="WV0vbg/M";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i4IXrsIs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769185133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rpq9rt6CSu4KZ6nnMaFEUFrki1to76OEWIvJi3PTJ2c=;
 b=WV0vbg/M0XI437KG05KlV1ssgclkOKvXfzX/cOxn/lCafEZMRk/NkL6Wf//MdVtyKn95jR
 JgFWw8gNMFSEgd0CHAvNBpkUOxSfnbg0Z8UWTaS/FMCz9nRd7D2jMN/VNdHA0k6lI2fXRT
 BDwXc2n1/ZACJhvjZ0opLQ5BSjpxnLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769185133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rpq9rt6CSu4KZ6nnMaFEUFrki1to76OEWIvJi3PTJ2c=;
 b=i4IXrsIsiaTu59puQRqv6PgKvWHrWvw+mbbiylvaMh57oKOKVEDUlRuCe14gyGTxQte0G8
 VNv58vNMqoZrCJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AD0B139EA;
 Fri, 23 Jan 2026 16:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EDpqFG2fc2n1GQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 23 Jan 2026 16:18:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 23 Jan 2026 17:18:53 +0100
MIME-Version: 1.0
Message-Id: <20260123-stream_refactoring-v1-3-281b85f6ab02@suse.com>
References: <20260123-stream_refactoring-v1-0-281b85f6ab02@suse.com>
In-Reply-To: <20260123-stream_refactoring-v1-0-281b85f6ab02@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769185132; l=4903;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=QHtCW3OY6BPIxVAHJTbCExquCDbVhDMx6GSZzZhWacI=;
 b=7CRcolhzpYYhta1UXRRjqB0K80SGLD7fLLHdQgzc4Im8Ie5N9t7Kk+hS6962hOJgz7vivYeL4
 q/14bpNVtz6CPnQ9DlCjXt7CDgC7zQER0zzLWbuCLjgGN+HuHzM/KUF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8542F3382B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] fs: rewrite stream02 test using new API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/fs/stream/stream02.c | 133 ++++++++--------------------------
 1 file changed, 29 insertions(+), 104 deletions(-)

diff --git a/testcases/kernel/fs/stream/stream02.c b/testcases/kernel/fs/stream/stream02.c
index 98473d86aab686eea2212c0e005a46e950f74ae8..0c6f3737dda69623e5e2bdf35ee427de0ad24586 100644
--- a/testcases/kernel/fs/stream/stream02.c
+++ b/testcases/kernel/fs/stream/stream02.c
@@ -1,119 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *	ported from SPIE section2/filesuite/stream2.c, by Airong Zhang
  *
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
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
  */
-/* ported from SPIE section2/filesuite/stream2.c, by Airong Zhang */
-
-/*======================================================================
-	=================== TESTPLAN SEGMENT ===================
->KEYS:  < fseek() mknod() fopen()
->WHAT:  < 1)
->HOW:   < 1)
->BUGS:  <
-======================================================================*/
-
-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "test.h"
 
-char *TCID = "stream02";
-int TST_TOTAL = 1;
-int local_flag;
+/*\
+ * Verify that it's possible to `fopen()` a file that has been created by
+ * `mknod()` using different modes.
+ */
 
-#define PASSED 1
-#define FAILED 0
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
 
-char progname[] = "stream02()";
-char tempfile1[40] = "";
+#define FILENAME "ltp_file_node"
 
-/* XXX: add cleanup + setup. */
+static const char *const modes[] = {
+	"r+",
+	"w+",
+	"a+",
+};
 
-/*--------------------------------------------------------------------*/
-int main(int ac, char *av[])
+static void run(void)
 {
 	FILE *stream;
-	int fd;
-	int lc;
-
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
 
-	local_flag = PASSED;
-	tst_tmpdir();
+	SAFE_MKNOD(FILENAME, (S_IFIFO | 0666), 0);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	for (size_t i = 0; i < ARRAY_SIZE(modes); i++) {
+		stream = SAFE_FOPEN(FILENAME, modes[i]);
+		SAFE_FCLOSE(stream);
 
-		sprintf(tempfile1, "stream1.%d", getpid());
-	/*--------------------------------------------------------------------*/
-		//block0:
-		if (mknod(tempfile1, (S_IFIFO | 0666), 0) != 0) {
-			tst_resm(TFAIL, "mknod failed in block0: %s",
-				 strerror(errno));
-			local_flag = FAILED;
-			goto block1;
-		}
-		if ((stream = fopen(tempfile1, "w+")) == NULL) {
-			tst_resm(TFAIL, "fopen(%s) w+ failed for pipe file: %s",
-				 tempfile1, strerror(errno));
-			local_flag = FAILED;
-		} else {
-			fclose(stream);
-		}
-		if ((stream = fopen(tempfile1, "a+")) == NULL) {
-			tst_resm(TFAIL, "fopen(%s) a+ failed: %s", tempfile1,
-				 strerror(errno));
-			local_flag = FAILED;
-		} else {
-			fclose(stream);
-			unlink(tempfile1);
-		}
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed in block0.");
-		} else {
-			tst_resm(TFAIL, "Test failed in block0.");
-		}
-		local_flag = PASSED;
+		tst_res(TPASS, "Opened file using '%s' mode", modes[i]);
+	}
 
-	/*--------------------------------------------------------------------*/
-block1:
-		if ((fd = open("/dev/tty", O_WRONLY)) >= 0) {
-			close(fd);
-			if ((stream = fopen("/dev/tty", "w")) == NULL) {
-				tst_resm(TFAIL | TERRNO,
-					 "fopen(/dev/tty) write failed");
-				local_flag = FAILED;
-			} else {
-				fclose(stream);
-			}
-		}
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed in block1.");
-		} else {
-			tst_resm(TFAIL, "Test failed in block1.");
-		}
-
-	/*--------------------------------------------------------------------*/
-	}			/* end for */
-	tst_rmdir();
-	tst_exit();
+	SAFE_UNLINK(FILENAME);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
