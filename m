Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B04EF8FE1
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 13:27:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB3073DB038
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:27:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAF4E3DB4AE
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:26:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D6112600AFC
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:25:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 280B73F848;
 Wed,  4 Mar 2026 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLYGKC9XcgcCvCU7SembhihsVHoDOzKLiMiiS6g6E1k=;
 b=S38ypbS1IZA7W5Qa2rF5hm7rBwmpVmk2APSZWj1CFyKnTSywyo/h3k4LDYTYvfrQUvU10G
 YK6UDyx3CkDW2VkYjKic2HoKul9+vPWWWI9RnUKNwc21Zm79vGGrXAC4pPBrqo1lyLz1T3
 x80CfKozXLqYIw36PpdOcVC2MCnpJeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLYGKC9XcgcCvCU7SembhihsVHoDOzKLiMiiS6g6E1k=;
 b=KaPaQ9Rzqow+eX3y0vcwn2cBRkYlgvOhuYHEzWYJDosqk07TvzBZzilVcj+xAwvStF+NsT
 vF15yuPS6nt+sKCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLYGKC9XcgcCvCU7SembhihsVHoDOzKLiMiiS6g6E1k=;
 b=S38ypbS1IZA7W5Qa2rF5hm7rBwmpVmk2APSZWj1CFyKnTSywyo/h3k4LDYTYvfrQUvU10G
 YK6UDyx3CkDW2VkYjKic2HoKul9+vPWWWI9RnUKNwc21Zm79vGGrXAC4pPBrqo1lyLz1T3
 x80CfKozXLqYIw36PpdOcVC2MCnpJeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLYGKC9XcgcCvCU7SembhihsVHoDOzKLiMiiS6g6E1k=;
 b=KaPaQ9Rzqow+eX3y0vcwn2cBRkYlgvOhuYHEzWYJDosqk07TvzBZzilVcj+xAwvStF+NsT
 vF15yuPS6nt+sKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F38963EA69;
 Wed,  4 Mar 2026 13:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mPZVOeIyqGlBTgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 04 Mar 2026 13:25:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 04 Mar 2026 14:25:42 +0100
MIME-Version: 1.0
Message-Id: <20260304-stream_refactoring-v2-4-3e48ada8ff1a@suse.com>
References: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
In-Reply-To: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772630754; l=9806;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=IBsYqZkHI73guZesUqB7FSfiVuOmIy3eCmB6zQd52gY=;
 b=dXPkaAHvseO79PbAxRctUknlywUqoXvkCn0R+o4se92tSG0Rtz3jXVm6z0tH4OQWgti9Ptin7
 OB8xNCrUl8EDfl/3hTaIuNNfpD5pDU88Fi3IgU+UK1tnRal9Vb2jMWO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/6] fs: rewrite stream03 test using new API
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/fs/stream/stream03.c | 326 ++++++----------------------------
 1 file changed, 50 insertions(+), 276 deletions(-)

diff --git a/testcases/kernel/fs/stream/stream03.c b/testcases/kernel/fs/stream/stream03.c
index 31715f740a070d01aec1087981e092b361e656da..24928c5e1a15cc4a5b17b22bcfb907519ed9b4e4 100644
--- a/testcases/kernel/fs/stream/stream03.c
+++ b/testcases/kernel/fs/stream/stream03.c
@@ -1,297 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *	ported from SPIE, section2/filesuite/stream3.c, by Airong Zhang
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
 
-/* ported from SPIE, section2/filesuite/stream3.c, by Airong Zhang */
-
-/*======================================================================
-	=================== TESTPLAN SEGMENT ===================
->KEYS:  < fseek() ftell()
->WHAT:  < 1) Ensure ftell reports the correct current byte offset.
->HOW:   < 1) Open a file, write to it, reposition the file pointer and
-	     check it.
->BUGS:  <
-======================================================================*/
-#define _XOPEN_SOURCE 500
-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <inttypes.h>
-#include "test.h"
+/*\
+ * Verify that `ftell()` reports the correct current byte offset after
+ * moving it.
+ */
 
-char *TCID = "stream03";
-int TST_TOTAL = 1;
-int local_flag;
+#include "tst_test.h"
+#include "tst_rand_data.h"
+#include "tst_safe_stdio.h"
 
-#define PASSED 1
-#define FAILED 0
+#define FILENAME "ltp_file"
+#define DATASIZE 30
+#define BUFFSIZE 10
 
-char progname[] = "stream03()";
-char tempfile1[40] = "";
+static char *data;
+static char *buff;
 
-int main(int ac, char *av[])
+static void run(void)
 {
 	FILE *stream;
-	char buf[30];
-	char *junk = "abcdefghijklmnopqrstuvwxyz";
-	long pos;
-	off_t opos;
-	int lc;
-
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	local_flag = PASSED;
-	tst_tmpdir();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		sprintf(tempfile1, "stream03.%d", getpid());
-	/*--------------------------------------------------------------------*/
-		//block0:
-
-		if ((stream = fopen(tempfile1, "a+")) == NULL) {
-			tst_brkm(TBROK, NULL, "fopen(%s) a+ failed: %s",
-				 tempfile1,
-				 strerror(errno));
-		}
-
-		/* make sure offset of zero at start */
-		pos = ftell(stream);
-
-		if (pos != 0) {
-			tst_resm(TFAIL, "file pointer descrepancy 1");
-			local_flag = FAILED;
-		}
-
-		/* write something and check */
-		if (fwrite(junk, sizeof(*junk), strlen(junk), stream) == 0) {
-			tst_brkm(TFAIL, NULL, "fwrite failed: %s",
-				 strerror(errno));
-		}
-
-		pos = ftell(stream);
-
-		if (pos != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk)=%zi: file pointer descrepancy 2 (pos=%li)",
-				 strlen(junk), pos);
-			local_flag = FAILED;
-		}
-
-		/* rewind and check */
-		rewind(stream);
-		pos = ftell(stream);
-
-		if (pos != 0) {
-			tst_resm(TFAIL,
-				 "file pointer descrepancy 3 (pos=%li, wanted pos=0)",
-				 pos);
-			local_flag = FAILED;
-		}
-
-		/* seek from current position and then check */
-		if (fseek(stream, strlen(junk), 1) != 0) {
-			tst_brkm(TFAIL, NULL, "fseek failed: %s",
-				 strerror(errno));
-		}
-
-		pos = ftell(stream);
-
-		if (pos != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk)=%zi: file pointer descrepancy 4 (pos=%li)",
-				 strlen(junk), pos);
-			local_flag = FAILED;
-		}
-
-		/* seek from end of file and then check */
-		if (fseek(stream, 0, 2) != 0) {
-			tst_brkm(TFAIL, NULL, "fseek failed: %s",
-				 strerror(errno));
-		}
-
-		pos = ftell(stream);
-
-		if (pos != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk)=%zi: file pointer descrepancy 5 (pos=%li)",
-				 strlen(junk), pos);
-			local_flag = FAILED;
-		}
-
-		/* rewind with seek and then check */
-		if (fseek(stream, 0, 0) != 0) {
-			tst_brkm(TFAIL, NULL, "fseek failed: %s",
-				 strerror(errno));
-		}
 
-		pos = ftell(stream);
+	memset(buff, 0, BUFFSIZE);
 
-		if (pos != 0) {
-			tst_resm(TFAIL,
-				 "file pointer descrepancy 6 (pos=%li, wanted pos=0)",
-				 pos);
-			local_flag = FAILED;
-		}
+	stream = SAFE_FOPEN(FILENAME, "a+");
+	TST_EXP_EQ_LI(SAFE_FTELL(stream), 0);
 
-		/* read till EOF, do getc and then check ftell */
-		while (fgets(buf, sizeof(buf), stream)) ;
-		pos = ftell(stream);
-		getc(stream);
-		pos = ftell(stream);
+	SAFE_FWRITE(data, 1, DATASIZE, stream);
+	TST_EXP_EQ_LI(SAFE_FTELL(stream), DATASIZE);
 
-		if (pos != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk)=%zi: file pointer descrepancy 7 (pos=%li)",
-				 strlen(junk), pos);
-			local_flag = FAILED;
-		}
+	rewind(stream);
+	TST_EXP_EQ_LI(SAFE_FTELL(stream), SEEK_SET);
 
-		fclose(stream);
+	SAFE_FSEEK(stream, 10, SEEK_CUR);
+	TST_EXP_EQ_LI(SAFE_FTELL(stream), 10);
 
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed in block0.");
-		} else {
-			tst_resm(TFAIL, "Test failed in block0.");
-		}
+	SAFE_FSEEK(stream, 0, SEEK_END);
+	TST_EXP_EQ_LI(SAFE_FTELL(stream), DATASIZE);
 
-		local_flag = PASSED;
+	SAFE_FSEEK(stream, 0, SEEK_SET);
+	TST_EXP_EQ_LI(SAFE_FTELL(stream), 0);
 
-		unlink(tempfile1);
-	/*--------------------------------------------------------------------*/
-		//block1:
-		if ((stream = fopen(tempfile1, "a+")) == NULL) {
-			tst_brkm(TFAIL, NULL, "fopen(%s) a+ failed: %s",
-				 tempfile1,
-				 strerror(errno));
-		}
+	while (fgets(buff, BUFFSIZE, stream))
+		;
+	TST_EXP_EQ_LI(SAFE_FTELL(stream), DATASIZE);
 
-		/* make sure offset of zero at start */
-		opos = ftello(stream);
-
-		if (opos != 0) {
-			tst_resm(TFAIL,
-				 "file pointer descrepancy 1 (opos=%" PRId64
-				 ", wanted opos=0)", (int64_t) opos);
-			local_flag = FAILED;
-		}
-
-		/* write something and check */
-		if (fwrite(junk, sizeof(*junk), strlen(junk), stream) == 0) {
-			tst_brkm(TFAIL, NULL, "fwrite failed: %s",
-				 strerror(errno));
-		}
-
-		opos = ftello(stream);
-
-		if (opos != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk)=%zi: file pointer descrepancy 2 (opos=%"
-				 PRId64 ")", strlen(junk), (int64_t) opos);
-			local_flag = FAILED;
-		}
-
-		/* rewind and check */
-		rewind(stream);
-		opos = ftello(stream);
-
-		if (opos != 0) {
-			tst_resm(TFAIL,
-				 "file pointer descrepancy 3 (opos=%" PRId64
-				 ", wanted opos=0)", (int64_t) opos);
-			local_flag = FAILED;
-		}
-
-		/* seek from current position and then check */
-		if (fseeko(stream, strlen(junk), 1) != 0) {
-			tst_brkm(TFAIL, NULL, "fseeko failed: %s",
-				 strerror(errno));
-		}
-
-		opos = ftello(stream);
-
-		if (opos != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk)=%zi: file pointer descrepancy 4 (opos=%"
-				 PRId64 ")", strlen(junk), (int64_t) opos);
-			local_flag = FAILED;
-		}
-
-		/* seek from end of file and then check */
-		if (fseeko(stream, 0, 2) != 0) {
-			tst_brkm(TFAIL, NULL, "fseeko failed: %s",
-				 strerror(errno));
-		}
-
-		opos = ftello(stream);
-
-		if (opos != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk)=%zi: file pointer descrepancy 5 (opos=%"
-				 PRId64 ")", strlen(junk), (int64_t) opos);
-			local_flag = FAILED;
-		}
-
-		/* rewind with seek and then check */
-		if (fseeko(stream, 0, 0) != 0) {
-			tst_brkm(TFAIL, NULL, "fseeko failed: %s",
-				 strerror(errno));
-		}
-
-		opos = ftello(stream);
-
-		if (opos != 0) {
-			tst_resm(TFAIL,
-				 "file pointer descrepancy 6 (opos=%" PRId64
-				 ", wanted opos=0)", (int64_t) opos);
-			local_flag = FAILED;
-		}
-
-		/* read till EOF, do getc and then check ftello */
-		while (fgets(buf, sizeof(buf), stream)) ;
-
-		opos = ftello(stream);
-		getc(stream);
-		opos = ftello(stream);
-
-		if (opos != strlen(junk)) {
-			tst_resm(TFAIL,
-				 "strlen(junk)=%zi: file pointer descrepancy 7 (opos=%li)",
-				 strlen(junk), opos);
-			local_flag = FAILED;
-		}
-
-		fclose(stream);
-
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed in block1.");
-		} else {
-			tst_resm(TFAIL, "Test failed in block1.");
-		}
-
-		unlink(tempfile1);
-	}
+	SAFE_FCLOSE(stream);
+	SAFE_UNLINK(FILENAME);
+}
 
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
+	.bufs = (struct tst_buffers[]) {
+		{&data, .size = DATASIZE},
+		{&buff, .size = BUFFSIZE},
+		{},
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
