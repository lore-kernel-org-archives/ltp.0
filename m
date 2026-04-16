Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4533BF8D754
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:36:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 030523E596E
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 16:36:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07FA73E4E54
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 001931400DAF
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07E4F5BD12;
 Thu, 16 Apr 2026 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swCk5K33V9CiDhlSS8z1WXGgJ68obO8ZjycbV83ly9E=;
 b=vFJp1d4Mk3cz2/J0tbunKR7tRwA0MrpR+xxljNqoSmdfTX0z+MxBDo9XQHIcqDB+BcjRW0
 A1gRbX3oQ7GRhQNJzn64xiHv0YZ3GsrO67nS3qm6BTsBlFQOP5GWK8Phxi/EZZk0//KyjP
 FoHJPipGgOrQsMUwfGeHDmJazSLsrkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swCk5K33V9CiDhlSS8z1WXGgJ68obO8ZjycbV83ly9E=;
 b=j358PWHlvZLRnjsrfUBcYnDMqOVDhhWzcWj2DT5Y5Ilvei1YN8raJSXJmZqRtbpwI7mAY2
 acbyXgOOgkUDaVBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swCk5K33V9CiDhlSS8z1WXGgJ68obO8ZjycbV83ly9E=;
 b=vFJp1d4Mk3cz2/J0tbunKR7tRwA0MrpR+xxljNqoSmdfTX0z+MxBDo9XQHIcqDB+BcjRW0
 A1gRbX3oQ7GRhQNJzn64xiHv0YZ3GsrO67nS3qm6BTsBlFQOP5GWK8Phxi/EZZk0//KyjP
 FoHJPipGgOrQsMUwfGeHDmJazSLsrkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swCk5K33V9CiDhlSS8z1WXGgJ68obO8ZjycbV83ly9E=;
 b=j358PWHlvZLRnjsrfUBcYnDMqOVDhhWzcWj2DT5Y5Ilvei1YN8raJSXJmZqRtbpwI7mAY2
 acbyXgOOgkUDaVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8FB4593AA;
 Thu, 16 Apr 2026 14:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0DsBL0Hz4GniGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Apr 2026 14:33:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 16:33:41 +0200
MIME-Version: 1.0
Message-Id: <20260416-stream_refactoring-v2-7-8321b1ec6f68@suse.com>
References: <20260416-stream_refactoring-v2-0-8321b1ec6f68@suse.com>
In-Reply-To: <20260416-stream_refactoring-v2-0-8321b1ec6f68@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776350016; l=8972;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=XtGV4wrJiWsdcy7LG+F1NvUOzmp7mPgp2HoQ5N1jK/E=;
 b=UsTyd2UC10BNEbjnjZ5HEjDxClPXbMgizjmRQkCHRtmO+L1J8pThVMZwGNTdCW5MEwQ7HSIHl
 oysitgKw1KNCINsWb9uljIDN92CO1QoKRowPJMC0CXq2Ks9RZI7YqJ1
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/7] fs: rewrite stream05 test using new API
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

Old LTP API is deprecated. Replace the old stream05 with a new test
that verifies read/write on a file descriptor obtained via fileno()
and that fclose() fails with EBADF after the fd is closed directly.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/fs/stream/stream05.c | 258 +++++++---------------------------
 1 file changed, 47 insertions(+), 211 deletions(-)

diff --git a/testcases/kernel/fs/stream/stream05.c b/testcases/kernel/fs/stream/stream05.c
index f561744c3da86cc5d80b97c9707f5583059d21f0..04cb237a145246f607f874c97bc1758724b325a2 100644
--- a/testcases/kernel/fs/stream/stream05.c
+++ b/testcases/kernel/fs/stream/stream05.c
@@ -1,230 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *	ported from SPIE section2/filesuite/stream.c, by Airong Zhang
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
 
-/* ported from SPIE, section2/filesuite/stream.c, by Airong Zhang */
-
-/*======================================================================
-	=================== TESTPLAN SEGMENT ===================
->KEYS:  < ferror() feof() clearerr() fileno()
->WHAT:  < 1) check that ferror returns zero
-	< 2) check fileno returns valid file descriptor
-	< 3) check that feof returns zero (nonzero) appropriately
-	< 4) check that clearerr resets EOF indicator.
->HOW:   < 1) open a stream and immediately execute ferror
-	< 2) use the file des returned from fileno to read a file
-	<    written with stream - compare actual vs expected.
-	< 3) open stream and ensure feof returns zero, read to end of
-	<    file and ensure feof returns non-zero.
-	< 4) after 3) above use clearerr and then use feof to ensure
-	<    clearerr worked
->BUGS:  <
-======================================================================*/
-
-#include <unistd.h>
-#include <stdio.h>
-#include <errno.h>
-#include "test.h"
+/*\
+ * Verify that it's possible to read/write on a file descriptor returned by
+ * `fileno()` and to close it, leaving `fclose()` to raise EBADF error.
+ */
 
-char *TCID = "stream05";
-int TST_TOTAL = 1;
-int local_flag;
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_rand_data.h"
 
-#define PASSED 1
-#define FAILED 0
+#define FILENAME "ltp_file"
+#define DATASIZE 3
+#define BUFFSIZE (2 * DATASIZE)
 
-char progname[] = "stream05()";
-char tempfile[40] = "";
+static char *data;
+static char *buff;
 
-/*--------------------------------------------------------------------*/
-int main(int ac, char *av[])
+static void run(void)
 {
+	int fd;
 	FILE *stream;
-	char buf[10];
-	int nr, fd;
-
-	int lc;
-
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-	tst_tmpdir();
-	local_flag = PASSED;
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		local_flag = PASSED;
-
-		sprintf(tempfile, "stream05.%d", getpid());
-	/*--------------------------------------------------------------------*/
-		//block0:
-		if ((stream = fopen(tempfile, "a+")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) a+ failed: %s",
-				 tempfile,
-				 strerror(errno));
-		}
-		fprintf(stream, "a");
-		fclose(stream);
-
-		if ((stream = fopen(tempfile, "r+")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) r+ failed: %s",
-				 tempfile,
-				 strerror(errno));
-		}
-
-		/* check that ferror returns zero */
-		if (ferror(stream) != 0) {
-			tst_resm(TFAIL, "ferror did not return zero: %s",
-				 strerror(errno));
-			local_flag = FAILED;
-		}
-
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed in block0.");
-		} else {
-			tst_resm(TFAIL, "Test failed in block0.");
-		}
 
-		local_flag = PASSED;
+	memset(buff, 0, BUFFSIZE);
 
-	/*--------------------------------------------------------------------*/
-		//block1:
+	stream = SAFE_FOPEN(FILENAME, "a+");
+	SAFE_FWRITE(data, 1, DATASIZE, stream);
+	SAFE_FFLUSH(stream);
 
-		/* check that fileno returns valid file descriptor */
-		fd = fileno(stream);
-		if ((nr = read(fd, buf, 1)) < 0) {
-			tst_brkm(TFAIL, NULL, "read failed: %s",
-				 strerror(errno));
-		}
-		if (nr != 1) {
-			tst_resm(TFAIL, "read did not read right number");
-			local_flag = FAILED;
-		}
-		if (buf[0] != 'a') {
-			tst_resm(TFAIL, "read returned bad values");
-			local_flag = FAILED;
-		}
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed in block1.");
-		} else {
-			tst_resm(TFAIL, "Test failed in block1.");
-		}
+	fd = SAFE_FILENO(stream);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, data, DATASIZE);
 
-		local_flag = PASSED;
-	/*--------------------------------------------------------------------*/
-		//block2:
+	SAFE_FSYNC(fd);
+	SAFE_FSEEK(stream, 0, SEEK_SET);
+	SAFE_READ(1, fd, buff, BUFFSIZE);
 
-		/* read to EOF and ensure feof returns non-zero */
-		fclose(stream);
+	TST_EXP_EQ_STRN(data, buff, DATASIZE);
+	TST_EXP_EQ_STRN(data, buff + 3, DATASIZE);
 
-		if ((stream = fopen(tempfile, "r+")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) r+ failed: %s",
-				 tempfile,
-				 strerror(errno));
-		}
-		if (feof(stream) != 0) {
-			tst_resm(TFAIL,
-				 "feof returned non-zero when it should not: %s",
-				 strerror(errno));
-			local_flag = FAILED;
-		}
-		fread(buf, 1, 2, stream);	/* read to EOF */
-		if (feof(stream) == 0) {
-			tst_resm(TFAIL,
-				 "feof returned zero when it should not: %s",
-				 strerror(errno));
-			local_flag = FAILED;
-		}
+	SAFE_CLOSE(fd);
+	TST_EXP_FAIL(fclose(stream), EBADF);
 
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed in block2.");
-		} else {
-			tst_resm(TFAIL, "Test failed in block2.");
-		}
-
-		local_flag = PASSED;
-	/*--------------------------------------------------------------------*/
-		//block3:
-		/* ensure clearerr works */
-		clearerr(stream);
-		if (feof(stream) != 0) {
-			tst_resm(TFAIL, "clearerr failed: %s", strerror(errno));
-			local_flag = FAILED;
-		}
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed in block3.");
-		} else {
-			tst_resm(TFAIL, "Test failed in block3.");
-		}
-
-		local_flag = PASSED;
-	/*--------------------------------------------------------------------*/
-		//block4:
-
-		/* test fopen "b" flags -- should be allowed but ignored */
-		(void)fclose(stream);
-
-		if ((stream = fopen(tempfile, "rb")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) rb failed: %s",
-				 tempfile,
-				 strerror(errno));
-		}
-		(void)fclose(stream);
-
-		if ((stream = fopen(tempfile, "wb")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) wb failed: %s",
-				 tempfile,
-				 strerror(errno));
-		}
-		(void)fclose(stream);
-
-		if ((stream = fopen(tempfile, "ab")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) ab failed: %s",
-				 tempfile,
-				 strerror(errno));
-		}
-		(void)fclose(stream);
-
-		if ((stream = fopen(tempfile, "rb+")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) rb+ failed: %s",
-				 tempfile,
-				 strerror(errno));
-		}
-		(void)fclose(stream);
-
-		if ((stream = fopen(tempfile, "wb+")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) wb+ failed: %s",
-				 tempfile,
-				 strerror(errno));
-		}
-		(void)fclose(stream);
-
-		if ((stream = fopen(tempfile, "ab+")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) ab+ failed: %s",
-				 tempfile,
-				 strerror(errno));
-		}
-		(void)fclose(stream);
+	SAFE_UNLINK(FILENAME);
+}
 
-		tst_resm(TPASS, "Test passed in block4.");
-	/*--------------------------------------------------------------------*/
-		unlink(tempfile);
-	}			/* end for */
-	tst_rmdir();
-	tst_exit();
+static void setup(void)
+{
+	memcpy(data, tst_rand_data, DATASIZE);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&data, .size = DATASIZE},
+		{&buff, .size = BUFFSIZE},
+		{},
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
