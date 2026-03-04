Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4E8EF8FE2
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 13:27:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29AB73DADA3
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:27:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACDD03DB94F
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:26:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA2F01A009B8
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:26:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E86445BE31;
 Wed,  4 Mar 2026 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hT8SfefarrYrrV9yYJTTyZj2v38nNvTUH7mlBQT10jU=;
 b=LzANcBUFQgOwSSX0iqUhhnv/jOvnmQgE+ETei/IbdUi7s21mKmxz7togP7uQGi19cTbKGv
 MSEQMxU8f++YNBHSQxiRvrhrQoy/v/P8QLZdCR1+jxsdTARSWar7JjwJRGjwtPMvvvvwf2
 toJmStyofqRJwNL6p3VL/+CUiXCt7qQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hT8SfefarrYrrV9yYJTTyZj2v38nNvTUH7mlBQT10jU=;
 b=/57QHTwiIkMjI3Re1CrMmFfOxvibshc3ncOkaK623yBdniqJflUJY7SUhD8ZbZ5yB5J4E5
 ZckxC1PHOGg7CZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hT8SfefarrYrrV9yYJTTyZj2v38nNvTUH7mlBQT10jU=;
 b=JTZiO5oOj7GGr6YRFFTb/OqVfPmSBcxs/PTMiGmXz3HmFF4OQFV6XGcnGbvc3JQ3YH4duP
 tL7JiG848dcQZzKvEVgUbJhjIZaGK2ZwKCR0Bx2I1oZBc6qEJIE9vE4Q8MuFj7jpeubaC2
 VWVU15WGXysfh8sNk9e3/W6HVChV1OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hT8SfefarrYrrV9yYJTTyZj2v38nNvTUH7mlBQT10jU=;
 b=HwS/iBzMYSQCg3Yz5v9UQgQfGJ9VFuNxj1pwnx+NI6/O7BchxZ/UXSOZa4IIQ55iChKMVz
 KHj9x/dzFhcVD9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6BF83EA6C;
 Wed,  4 Mar 2026 13:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eKptLuIyqGlBTgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 04 Mar 2026 13:25:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 04 Mar 2026 14:25:41 +0100
MIME-Version: 1.0
Message-Id: <20260304-stream_refactoring-v2-3-3e48ada8ff1a@suse.com>
References: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
In-Reply-To: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772630754; l=5004;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=GP4yC8ZmmCvTCMSWyvg187xDOvviBLgSfVzT9uQcJ3Q=;
 b=HV8V83FCeVxLfUlal1Ylu1ewoX75SrCkf1YoDt7eQ9twsXBfPqJ1pZsxxFeNJzVQqDx9wLcW0
 /qO6wP5vrIOBxTc3JGblt+45yeppIJdHnXbyw9ZOT4txX1CFK4MmtLD
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/6] fs: rewrite stream02 test using new API
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
 testcases/kernel/fs/stream/stream02.c | 136 +++++++++-------------------------
 1 file changed, 33 insertions(+), 103 deletions(-)

diff --git a/testcases/kernel/fs/stream/stream02.c b/testcases/kernel/fs/stream/stream02.c
index 98473d86aab686eea2212c0e005a46e950f74ae8..c08bdbed0754453c6ab666fe5e733d31383587fb 100644
--- a/testcases/kernel/fs/stream/stream02.c
+++ b/testcases/kernel/fs/stream/stream02.c
@@ -1,119 +1,49 @@
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
 
-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "test.h"
-
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
-
-	local_flag = PASSED;
-	tst_tmpdir();
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	SAFE_MKNOD(FILENAME, (S_IFIFO | 0666), 0);
 
-		sprintf(tempfile1, "stream1.%d", getpid());
-	/*--------------------------------------------------------------------*/
-		//block0:
-		if (mknod(tempfile1, (S_IFIFO | 0666), 0) != 0) {
-			tst_resm(TFAIL, "mknod failed in block0: %s",
-				 strerror(errno));
-			local_flag = FAILED;
-			goto block1;
+	for (size_t i = 0; i < ARRAY_SIZE(modes); i++) {
+		stream = SAFE_FOPEN(FILENAME, modes[i]);
+		if (!stream) {
+			tst_res(TFAIL, "fopen(%s) returned NULL pointer", modes[i]);
+			return;
 		}
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
+		SAFE_FCLOSE(stream);
+
+		tst_res(TPASS, "Opened file using '%s' mode", modes[i]);
+	}
 
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
