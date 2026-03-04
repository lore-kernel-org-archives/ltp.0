Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7CDEF8FE1
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 13:26:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B63F73DB1F5
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:26:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E48C23C61C5
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:25:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3DAF16002DE
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:25:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC2D73F842;
 Wed,  4 Mar 2026 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8JegXby7tmYUCh+cLALfIZpeYLSuZXB/50zIw8zxbU=;
 b=oI3wogzuhwwo+BEhgIg2/uh5nlEW9DTL/q/tqsGkZCWeMRNJKQJ+WM9FRfjMtLthqee9q7
 ukyyrqb8z9xfzT9yYR9qIwNHgbgBw5vMrEbZ5qjTtClF5dJGu8ZjLW0wO0OwTkT6nVcg6F
 ONXFefz6jcGj5ivsswNzL/N/aJnu+54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8JegXby7tmYUCh+cLALfIZpeYLSuZXB/50zIw8zxbU=;
 b=I0Ve8iYDzT8lmPSqVOTkuPGYMW9ywBDRrcTtW3Bz1kJmiPTSkwKrUtsOgjsqPx+iyervhi
 7jFbfp/yz4ioIYCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oI3wogzu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I0Ve8iYD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8JegXby7tmYUCh+cLALfIZpeYLSuZXB/50zIw8zxbU=;
 b=oI3wogzuhwwo+BEhgIg2/uh5nlEW9DTL/q/tqsGkZCWeMRNJKQJ+WM9FRfjMtLthqee9q7
 ukyyrqb8z9xfzT9yYR9qIwNHgbgBw5vMrEbZ5qjTtClF5dJGu8ZjLW0wO0OwTkT6nVcg6F
 ONXFefz6jcGj5ivsswNzL/N/aJnu+54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8JegXby7tmYUCh+cLALfIZpeYLSuZXB/50zIw8zxbU=;
 b=I0Ve8iYDzT8lmPSqVOTkuPGYMW9ywBDRrcTtW3Bz1kJmiPTSkwKrUtsOgjsqPx+iyervhi
 7jFbfp/yz4ioIYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A3883EA69;
 Wed,  4 Mar 2026 13:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IM17I+IyqGlBTgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 04 Mar 2026 13:25:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 04 Mar 2026 14:25:40 +0100
MIME-Version: 1.0
Message-Id: <20260304-stream_refactoring-v2-2-3e48ada8ff1a@suse.com>
References: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
In-Reply-To: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772630754; l=6123;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=WwsxWQ4jN6MN8N8Dp6fZwIkR0Txr2+Yw0sY1szRI3Dw=;
 b=jtQyBDnMiwShqUD3e832YzSlkhtEQ7KjfxplFQ9Q9XCa12yfEaxsm7etwHNuaH/Di4IZYXzJg
 v3EY0ZHEa9jB9UhcKoj7yYAPvYtNJasgyStWcuiAUApr5Cr8g0IEHDr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BC2D73F842
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/6] fs: rewrite stream01 test using new API
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
 testcases/kernel/fs/stream/stream01.c | 155 +++++++++++-----------------------
 1 file changed, 49 insertions(+), 106 deletions(-)

diff --git a/testcases/kernel/fs/stream/stream01.c b/testcases/kernel/fs/stream/stream01.c
index af56bca3b916c080328c3356681efbd869b961d2..d666e67491e53b1c45dabef5bb6118dbbdc8ad38 100644
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
+	char buf[n];
+	FILE *stream;
+	size_t len;
 
-#define PASSED 1
-#define FAILED 0
+	memset(buf, 0, sizeof(buf));
 
-/* XXX: add setup and cleanup. */
+	stream = SAFE_FOPEN(file, "r");
+	len = SAFE_FREAD(buf, n, n, stream);
+	SAFE_FCLOSE(stream);
 
-char progname[] = "stream01()";
-char tempfile1[40] = "";
-char tempfile2[40] = "";
+	TST_EXP_EXPR(len == n, "Read the entire %s file buffer", file);
+	TST_EXP_EQ_STRN(buf, str, len);
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
+	SAFE_FWRITE(buff_file1, strlen(buff_file1), 3, stream);
 
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
+	SAFE_FWRITE(buff_file2, strlen(buff_file2), 3, stream);
 
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
