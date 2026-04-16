Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98172F8D74B
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:34:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1015E3E4ADB
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 16:34:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAC063E1685
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2FC2D10006C1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F18705BCFF;
 Thu, 16 Apr 2026 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNvweveLksEIgbqxDOWT4YwGPOo/y8SFjPJ/HQJ2aII=;
 b=uF966s80HxZfWZB5sdd4eWAMNnBC4Yb67qOTXpRzPOt8A9qXObd/wjjshN2GKbaFtjxRPf
 s+TJQyO70AtMtSoMjv9cr0iXzmbbzr5YhLwFm7L7bgwhUXp7Q3SBUdVoOJ1HEvRMW5UD6z
 Ng5hSGWD+OC68p6f9AKnl9nNnLBFwXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNvweveLksEIgbqxDOWT4YwGPOo/y8SFjPJ/HQJ2aII=;
 b=WpbfWIQNaWlmtWdJfk2ZrFEVIJEs1Jd2GOH8tAmm2ZeTTkd4DleQfrnZmpJMFwG1whUXrG
 0tiM1P0JCVG2s2DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNvweveLksEIgbqxDOWT4YwGPOo/y8SFjPJ/HQJ2aII=;
 b=AQ7qKfJI4dlq1XlMlLaGCbESi6eC88TrgWEXY/WESMA+HnFCMXsk46sYi3H9C4Vzd/wbT9
 yoUlRFpthZG8ja/oK/74UveaTga95JUVwkRDuIZQdncM1ZiRpn/3i548bn69Z1x8IZHvo8
 DyH5e4hmDR7m0rHRiPtYPQgUM6WuU5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNvweveLksEIgbqxDOWT4YwGPOo/y8SFjPJ/HQJ2aII=;
 b=w0g1ZtGevPQ73l7hwbivEUaUYC5bv2JeXWhUp1sjO/sH/RGmXhPweEPayga8zoy9Yhd9s5
 SeDM9a3fW0EDoSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBA7F593A5;
 Thu, 16 Apr 2026 14:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2GeuL0Dz4GniGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Apr 2026 14:33:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 16:33:36 +0200
MIME-Version: 1.0
Message-Id: <20260416-stream_refactoring-v2-2-8321b1ec6f68@suse.com>
References: <20260416-stream_refactoring-v2-0-8321b1ec6f68@suse.com>
In-Reply-To: <20260416-stream_refactoring-v2-0-8321b1ec6f68@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776350016; l=6295;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=KsB9Mqim4sxKCSV4Z1DNb2b/uUwFP0wc0B/hxWG+1+g=;
 b=ytoIiCsnkhhD3Za5DMLTf+uOK49trmGYBMGWQ2J+B/HunV9fLzbBRZWhIbjufnP9VGrsqCqa5
 zSO6OrgrSRTAM3gzKPDxua6bMHUgf1HvCo8SLfxn912TLHhp0VUxhdK
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/7] fs: rewrite stream01 test using new API
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

Old LTP API is deprecated. Convert stream01 to new tst_test.h-based
API, using SAFE_FOPEN/SAFE_FWRITE/SAFE_FREOPEN/SAFE_FCLOSE macros
and structured result reporting.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/fs/stream/stream01.c | 155 +++++++++++-----------------------
 1 file changed, 49 insertions(+), 106 deletions(-)

diff --git a/testcases/kernel/fs/stream/stream01.c b/testcases/kernel/fs/stream/stream01.c
index af56bca3b916c080328c3356681efbd869b961d2..ec4bf96a47a0fc291a4c9c9c13f46705d878ca91 100644
--- a/testcases/kernel/fs/stream/stream01.c
+++ b/testcases/kernel/fs/stream/stream01.c
@@ -1,127 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *	ported from SPIE section2/filesuite/stream1.c, by Airong Zhang
  *
- *   Copyright (c) International Business Machines  Corp., 2002
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `freopen()` substitutes the named file in place of stream.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * [Algorithm]
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * - fopen() a stream
+ * - fwrite() something inside it
+ * - perform freopen() creating a new stream pointing to the first one
+ * - fwrite() data inside the new stream
+ * - check that second write to stream went to the file specified by freopen()
  */
 
-/* ported from SPIE section2/filesuite/stream1.c, by Airong Zhang */
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
 
-/*======================================================================
-	=================== TESTPLAN SEGMENT ===================
->KEYS:  < freopen()
->WHAT:  < 1) check that freopen substitutes the named file in place of stream.
->HOW:   < 1) open a stream, write something to it, perform freopen and
-	<    write some more. Check that second write to stream went to
-	<    the file specified by freopen.
->BUGS:  <
-======================================================================*/
+#define FILENAME1 "ltp_file1.txt"
+#define FILENAME2 "ltp_file2.txt"
 
-#include <stdio.h>
-#include <errno.h>
-#include "test.h"
+static char *buff_file1 = "abc";
+static char *buff_file2 = "def";
 
-char *TCID = "stream01";
-int TST_TOTAL = 1;
-int local_flag;
+static void read_file(const char *file, const char *str, size_t n)
+{
+	char buf[128];
+	FILE *stream;
+	size_t len;
 
-#define PASSED 1
-#define FAILED 0
+	memset(buf, 0, sizeof(buf));
 
-/* XXX: add setup and cleanup. */
+	stream = SAFE_FOPEN(file, "r");
+	len = SAFE_FREAD(buf, 1, n, stream);
+	SAFE_FCLOSE(stream);
 
-char progname[] = "stream01()";
-char tempfile1[40] = "";
-char tempfile2[40] = "";
+	TST_EXP_EXPR(len == n, "Read the entire %s file buffer", file);
+	TST_EXP_EQ_STRN(buf, str, n);
+}
 
-/*--------------------------------------------------------------------*/
-int main(int ac, char *av[])
+static void run(void)
 {
 	FILE *stream;
-	char buf[10];
-	int i;
-	int lc;
-
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
 
-	local_flag = PASSED;
-	tst_tmpdir();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	tst_res(TINFO, "Write %s file", FILENAME1);
+	stream = SAFE_FOPEN(FILENAME1, "a+");
+	SAFE_FWRITE(buff_file1, 1, strlen(buff_file1), stream);
 
-		sprintf(tempfile1, "stream011.%d", getpid());
-		sprintf(tempfile2, "stream012.%d", getpid());
-	/*--------------------------------------------------------------------*/
-		//block0:
-		if ((stream = fopen(tempfile1, "a+")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) a+ failed: %s",
-				 tempfile1,
-				 strerror(errno));
-		}
-		fwrite("a", 1, 1, stream);
-		if ((stream = freopen(tempfile2, "a+", stream)) == NULL) {
-			tst_brkm(TFAIL | TERRNO, NULL, "freopen(%s) a+ failed",
-				 tempfile2);
-		}
-		fwrite("a", 1, 1, stream);
-		fclose(stream);
+	tst_res(TINFO, "Write %s file streaming into %s file", FILENAME2, FILENAME1);
+	stream = SAFE_FREOPEN(FILENAME2, "a+", stream);
+	SAFE_FWRITE(buff_file2, 1, strlen(buff_file2), stream);
 
-		/* now check that a single "a" is in each file */
-		if ((stream = fopen(tempfile1, "r")) == NULL) {
-			tst_brkm(TFAIL | TERRNO, NULL, "fopen(%s) r failed",
-				 tempfile1);
-		} else {
-			for (i = 0; i < 10; i++)
-				buf[i] = 0;
-			fread(buf, 1, 1, stream);
-			if ((buf[0] != 'a') || (buf[1] != 0)) {
-				tst_resm(TFAIL, "bad contents in %s",
-					 tempfile1);
-				local_flag = FAILED;
-			}
-			fclose(stream);
-		}
-		if ((stream = fopen(tempfile2, "r")) == NULL) {
-			tst_brkm(TFAIL | TERRNO, NULL, "fopen(%s) r failed",
-				 tempfile2);
-		} else {
-			for (i = 0; i < 10; i++)
-				buf[i] = 0;
-			fread(buf, 1, 1, stream);
-			if ((buf[0] != 'a') || (buf[1] != 0)) {
-				tst_resm(TFAIL, "bad contents in %s",
-					 tempfile2);
-				local_flag = FAILED;
-			}
-			fclose(stream);
-		}
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed.");
-		} else {
-			tst_resm(TFAIL, "Test failed.");
-		}
+	SAFE_FCLOSE(stream);
 
-		local_flag = PASSED;
+	read_file(FILENAME1, buff_file1, 3);
+	read_file(FILENAME2, buff_file2, 3);
 
-	/*--------------------------------------------------------------------*/
-		unlink(tempfile1);
-		unlink(tempfile2);
-
-	}			/* end for */
-	tst_rmdir();
-	tst_exit();
+	SAFE_UNLINK(FILENAME1);
+	SAFE_UNLINK(FILENAME2);
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
