Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17622F8D754
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:36:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A30E3E2DF1
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 16:36:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E92553E4B09
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A5E2A6002D4
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D63D26A7FE;
 Thu, 16 Apr 2026 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+olZ5vNGu2mzeqk3yRkvWezTeJ03pdauVYc17ES0s8=;
 b=tuhPFKJkW81JBtICFvUoq7H8qpJZ0qtjPZN9FZ+9MESj1XyJ6NWjhakKL5VcC95Qn4ctr1
 cVrMgpS0d8OuSwRAX6cwoU4Nqe2SQt/uqrCGK/Hb2OzSWjlfMk0zFnQ6MJIGkvhzGJJO1t
 TbCVN9MhuLf6ypRR03XD+Siku6CSpdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+olZ5vNGu2mzeqk3yRkvWezTeJ03pdauVYc17ES0s8=;
 b=lwwIwESYUw1CLJ4ex6WW5GM0KOTQK5gBsEQsBFwBs0QyK3rrdiTUmPe2H7hwf5Iu8Zn8Hv
 +dLrTMuFQLKn2cBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tuhPFKJk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lwwIwESY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+olZ5vNGu2mzeqk3yRkvWezTeJ03pdauVYc17ES0s8=;
 b=tuhPFKJkW81JBtICFvUoq7H8qpJZ0qtjPZN9FZ+9MESj1XyJ6NWjhakKL5VcC95Qn4ctr1
 cVrMgpS0d8OuSwRAX6cwoU4Nqe2SQt/uqrCGK/Hb2OzSWjlfMk0zFnQ6MJIGkvhzGJJO1t
 TbCVN9MhuLf6ypRR03XD+Siku6CSpdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+olZ5vNGu2mzeqk3yRkvWezTeJ03pdauVYc17ES0s8=;
 b=lwwIwESYUw1CLJ4ex6WW5GM0KOTQK5gBsEQsBFwBs0QyK3rrdiTUmPe2H7hwf5Iu8Zn8Hv
 +dLrTMuFQLKn2cBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93C08593A9;
 Thu, 16 Apr 2026 14:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2HrqIUHz4GniGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Apr 2026 14:33:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 16:33:40 +0200
MIME-Version: 1.0
Message-Id: <20260416-stream_refactoring-v2-6-8321b1ec6f68@suse.com>
References: <20260416-stream_refactoring-v2-0-8321b1ec6f68@suse.com>
In-Reply-To: <20260416-stream_refactoring-v2-0-8321b1ec6f68@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776350016; l=5805;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=N6rxdNQNV9FWtt2vJznpNk+qGRCaEuy4xtyzdTZtxVU=;
 b=lLf99qlK6FXjYqqMR6DWy4XUKHotQO5knWPygzVxWutp8g/F3JmhRk5MLTA4Ks8ukGTF0hqT7
 iG0/Gi8bah6CUsRQG3/JSieleK6jbdB5drOqNhvVt9oUYoDCC6+OvRh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.cz:email];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.cz:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D63D26A7FE
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/7] fs: rewrite stream04 test using new API
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

Old LTP API is deprecated. Convert stream04 to new tst_test.h-based
API, verifying that fwrite() appends data and fread() returns the
correct content.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/fs/stream/stream04.c | 147 +++++++++-------------------------
 1 file changed, 40 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/fs/stream/stream04.c b/testcases/kernel/fs/stream/stream04.c
index 3dc679151a6a81aab8c713605c258fae2c2b3adf..560792f062f3bbb0fcb9164ffd9095803fe6c4fe 100644
--- a/testcases/kernel/fs/stream/stream04.c
+++ b/testcases/kernel/fs/stream/stream04.c
@@ -1,124 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *	ported from SPIE, section2/filesuite/stream4.c, by Airong Zhang
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
 
-/* Ported from SPIE, section2/iosuite/stream4.c, by Airong Zhang */
-
-/*======================================================================
-	=================== TESTPLAN SEGMENT ===================
->KEYS:  < fwrite() fread()
->WHAT:  < 1) Ensure fwrite appends data to stream.
-	< 2) Ensure fread and fwrite return values are valid.
->HOW:   < 1) Open a file, write to it, and then check it.
-	< 2) Fwrite a know quanity, check return value.
-	<    Fread a know quanity, check return value.
->BUGS:  <
-======================================================================*/
-
-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "test.h"
-
-char *TCID = "stream04";
-int TST_TOTAL = 1;
-int local_flag;
+/*\
+ * Ensure that `fwrite()` is appending data to stream and `fread()`
+ * `fwrite()` are returning the right data.
+ */
 
-#define PASSED 1
-#define FAILED 0
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
 
-char progname[] = "stream04()";
-char tempfile1[40] = "";
-long ftell();
+#define FILENAME "ltp_file"
+#define DATA "abcdefghijklmnopqrstuvwxyz"
+#define DATASIZE sizeof(DATA)
 
-/* XXX: add setup and cleanup */
+static char *data;
+static char *buff;
 
-/*--------------------------------------------------------------------*/
-int main(int ac, char *av[])
+static void run(void)
 {
 	FILE *stream;
-	char *junk = "abcdefghijklmnopqrstuvwxyz";
-	char *inbuf;
-	int ret;
 
-	int lc;
+	memset(buff, 0, DATASIZE);
 
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-	tst_tmpdir();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	stream = SAFE_FOPEN(FILENAME, "a+");
+	TST_EXP_EQ_LI(fwrite(data, 1, DATASIZE, stream), DATASIZE);
+	SAFE_FCLOSE(stream);
 
-		local_flag = PASSED;
+	stream = SAFE_FOPEN(FILENAME, "r+");
+	TST_EXP_EQ_LI(fread(buff, 1, DATASIZE, stream), DATASIZE);
+	SAFE_FCLOSE(stream);
 
-		sprintf(tempfile1, "stream04.%d", getpid());
-	/*--------------------------------------------------------------------*/
-		//block0:
-		if ((stream = fopen(tempfile1, "a+")) == NULL) {
-			tst_brkm(TFAIL | TERRNO, tst_rmdir, "fopen(%s) a+ failed",
-				 tempfile1);
-		}
-		/* write something and check */
-		if ((ret =
-		     fwrite(junk, sizeof(*junk), strlen(junk), stream)) == 0) {
-			tst_brkm(TFAIL, tst_rmdir, "fwrite failed: %s",
-				 strerror(errno));
-		}
+	SAFE_UNLINK(FILENAME);
 
-		if ((size_t) ret != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk) = %zi != return value from fwrite = %zi",
-				 strlen(junk), ret);
-			local_flag = FAILED;
-		}
+	TST_EXP_EQ_STRN(data, buff, DATASIZE);
+}
 
-		fclose(stream);
-		if ((stream = fopen(tempfile1, "r+")) == NULL) {
-			tst_brkm(TFAIL, tst_rmdir, "fopen(%s) r+ failed: %s", tempfile1,
-				 strerror(errno));
-		}
-		if ((inbuf = malloc(strlen(junk))) == 0) {
-			tst_brkm(TBROK, tst_rmdir, "test failed because of malloc: %s",
-				 strerror(errno));
-		}
-		if ((ret =
-		     fread(inbuf, sizeof(*junk), strlen(junk), stream)) == 0) {
-			tst_brkm(TFAIL, tst_rmdir, "fread failed: %s",
-				 strerror(errno));
-		}
-		if ((size_t) ret != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk) = %zi != return value from fread = %zi",
-				 strlen(junk), ret);
-			local_flag = FAILED;
-		}
-		fclose(stream);
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed.");
-		} else {
-			tst_resm(TFAIL, "Test failed.");
-		}
-	/*--------------------------------------------------------------------*/
-		unlink(tempfile1);
-	}			/* end for */
-	tst_rmdir();
-	tst_exit();
+static void setup(void)
+{
+	memcpy(data, DATA, DATASIZE);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&data, .size = DATASIZE},
+		{&buff, .size = DATASIZE},
+		{},
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
