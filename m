Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8520C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 08:23:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2C263D073F
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 10:23:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 519213C0E10
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:22:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B70D71A001FC
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:22:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6F372128B;
 Thu, 27 Aug 2026 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787818958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kM5jVg4tn4y4rQSzCYuktRlGvQfC0PHUCgV9N5tg6U=;
 b=WyM4fT4j9UiS4LJQCo70vYo9+PNjG9HE1dNnoz1Y7oKWKzWCb96KnMG5QuTovltO9V02Nv
 jGrPqB6Jmn84PWE2C9KFyp333AP5qvSmnESXpeDrACwIw+hdbYD7jc7Y8tMn09Nnmv8/YD
 Z77o9upjAW7HREZxzhiaCrEFayRmoIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787818958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kM5jVg4tn4y4rQSzCYuktRlGvQfC0PHUCgV9N5tg6U=;
 b=YbXLaR3jY8uby8y9Qq+YuYg99jFCB1rv7dQpxuxrs0dsU2fOUYfFJnNgY92pJueSk7y9CE
 SLddwVBdBK9PMhBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NE8q1u0f;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W9R+IFwy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787818954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kM5jVg4tn4y4rQSzCYuktRlGvQfC0PHUCgV9N5tg6U=;
 b=NE8q1u0fJH3IVPXAHnoIt4WV51PgRNYnTN06XYCsRqRIVxQ3y1NfUHsAZKsZSvC+Vl/JlF
 47f03FflMegMI+iwSmhQTTwNg2SKhV+llj+F/spr1urJdCionpY12H4RXpgqKrcN/W0xoG
 2k2zR9Ms6/kNGU4Az+p1V/U53W66fxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787818954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kM5jVg4tn4y4rQSzCYuktRlGvQfC0PHUCgV9N5tg6U=;
 b=W9R+IFwybmTIRwX8C42eMqPMCAaWtpg9+f9SvFfCLs87w632gUIZ4hHJZ6FjDCm05s1bnX
 tSqFb4zZRvQfBdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CC8413533;
 Thu, 27 Aug 2026 08:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8NmhIMrzj2oQNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Aug 2026 08:22:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 10:22:34 +0200
MIME-Version: 1.0
Message-Id: <20260827-convert_fallocate_suite-v5-2-650ab2acdac1@suse.com>
References: <20260827-convert_fallocate_suite-v5-0-650ab2acdac1@suse.com>
In-Reply-To: <20260827-convert_fallocate_suite-v5-0-650ab2acdac1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787818954; l=7477;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=2TxBtijFudxU8bLggcCxHMTZUkd6vfmPeJe4jXoOIKk=;
 b=Jc+huiPxzjFJJjWpevHl0tCndOAJHH/plPNMQvxwGii3rhfd6HBR8pss2uOwgFBhH3SnR7ZIp
 jOIVQMzdj9pDbkd6i9JnQ8ijZXLCD1QeQLJWeHMpk01pvo+zRXhMB9V
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A6F372128B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] fallocate02: Convert to new API
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

Convert the fallocate02 test case from the legacy LTP API (test.h) to the
new tst_test API using a table-driven struct tcase[] and TST_EXP_FAIL for
each error-path oracle.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/fallocate/fallocate02.c | 192 +++++++---------------
 1 file changed, 61 insertions(+), 131 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index 4469f02f2..0a25a5611 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -1,164 +1,94 @@
-/******************************************************************************
- *	Copyright (c) International Business Machines  Corp., 2007
- *	Author: Sharyathi Nagesh <sharyathi@in.ibm.com>
- ******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2007
+ * Author: Sharyathi Nagesh <sharyathi@in.ibm.com>
+ * Copyright (c) Linux Test Project, 2026
+ */
 
-/***************************************************************************
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+/*\
+ * Verify that :manpage:`fallocate(2)` fails with the expected error codes:
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Library General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-***************************************************************************/
-
-/*
- * DESCRIPTION
- *	check fallocate() with various error conditions that should produce
- *	EBADF, EINVAL and EFBIG.
+ * - EBADF when the file descriptor is opened read-only.
+ * - EINVAL when the offset or length is negative, or the length is zero.
+ * - EFBIG when the requested range exceeds the maximum file size (only
+ *   tested on 64-bit offset ABIs).
  */
 
 #define _GNU_SOURCE
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <endian.h>
-#include <errno.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include <sys/utsname.h>
-#include <limits.h>
-
-#include "test.h"
-#include "tso_safe_macros.h"
+#include "tst_test.h"
 #include "lapi/fallocate.h"
 #include "lapi/abisize.h"
 
-#define BLOCKS_WRITTEN		12
-#ifdef TEST_DEFAULT
-# define DEFAULT_TEST_MODE	0
-#else
-# define DEFAULT_TEST_MODE	1
-#endif
-#define OFFSET			12
-#define FNAMER			"test_file1"
-#define FNAMEW			"test_file2"
-#define BLOCK_SIZE		1024
-#define MAX_FILESIZE            (LLONG_MAX / 1024)
-
-static void setup(void);
-static void fallocate_verify(int);
-static void cleanup(void);
+#define BLOCKS_WRITTEN	12
+#define OFFSET		12
+#define FNAMER		"test_file1"
+#define FNAMEW		"test_file2"
+#define BLOCK_SIZE	1024
+#define MAX_FILESIZE	(LLONG_MAX / BLOCK_SIZE)
 
-static int fdw;
-static int fdr;
+static int fdr = -1;
+static int fdw = -1;
 
-static struct test_data_t {
+static struct tcase {
 	int *fd;
-	char *fname;
-	int mode;
 	loff_t offset;
 	loff_t len;
-	int error;
-} test_data[] = {
-	{&fdr, FNAMER, DEFAULT_TEST_MODE, 0, 1, EBADF},
-	{&fdw, FNAMEW, DEFAULT_TEST_MODE, -1, 1, EINVAL},
-	{&fdw, FNAMEW, DEFAULT_TEST_MODE, 1, -1, EINVAL},
-	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, 0, EINVAL},
-	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL},
-	{&fdw, FNAMEW, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN+OFFSET), 1, EINVAL},
+	int exp_errno;
+} tcases[] = {
+	{&fdr, 0, 1, EBADF},
+	{&fdw, -1, 1, EINVAL},
+	{&fdw, 1, -1, EINVAL},
+	{&fdw, BLOCKS_WRITTEN, 0, EINVAL},
+	{&fdw, BLOCKS_WRITTEN, -1, EINVAL},
+	{&fdw, -(BLOCKS_WRITTEN + OFFSET), 1, EINVAL},
 #if defined(TST_ABI64) || _FILE_OFFSET_BITS == 64
-	{&fdw, FNAMEW, DEFAULT_TEST_MODE, MAX_FILESIZE, 1, EFBIG},
-	{&fdw, FNAMEW, DEFAULT_TEST_MODE, 1, MAX_FILESIZE, EFBIG},
+	{&fdw, MAX_FILESIZE, 1, EFBIG},
+	{&fdw, 1, MAX_FILESIZE, EFBIG},
 #endif
 };
 
-TCID_DEFINE(fallocate02);
-int TST_TOTAL = ARRAY_SIZE(test_data);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			fallocate_verify(i);
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
 static void setup(void)
 {
+	char buf[BLOCK_SIZE];
 	int i;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	TEST(fallocate(-1, 0, 0, 0));
+	if (TST_ERR == EOPNOTSUPP || TST_ERR == ENOSYS)
+		tst_brk(TCONF, "fallocate() not supported");
 
-	fdr = SAFE_OPEN(cleanup, FNAMER, O_RDONLY | O_CREAT, S_IRUSR);
+	fdr = SAFE_OPEN(FNAMER, O_RDONLY | O_CREAT, 0400);
+	fdw = SAFE_OPEN(FNAMEW, O_RDWR | O_CREAT, 0700);
 
-	fdw = SAFE_OPEN(cleanup, FNAMEW, O_RDWR | O_CREAT, S_IRWXU);
-
-	char buf[BLOCK_SIZE];
 	memset(buf, 'A', BLOCK_SIZE);
 	for (i = 0; i < BLOCKS_WRITTEN; i++)
-		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fdw, buf, BLOCK_SIZE);
+		SAFE_WRITE(SAFE_WRITE_ALL, fdw, buf, BLOCK_SIZE);
 }
 
-static void fallocate_verify(int i)
+static void cleanup(void)
 {
-	TEST(fallocate(*test_data[i].fd, test_data[i].mode,
-		       test_data[i].offset * BLOCK_SIZE,
-		       test_data[i].len * BLOCK_SIZE));
-	if (TEST_ERRNO != test_data[i].error) {
-		if (TEST_ERRNO == EOPNOTSUPP ||
-		    TEST_ERRNO == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "fallocate system call is not implemented");
-		}
-		tst_resm(TFAIL | TTERRNO,
-			 "fallocate(%s:%d, %d, %" PRId64 ", %" PRId64 ") "
-			 "failed, expected errno:%d", test_data[i].fname,
-			 *test_data[i].fd, test_data[i].mode,
-			 test_data[i].offset * BLOCK_SIZE,
-			 test_data[i].len * BLOCK_SIZE, test_data[i].error);
-	} else {
-		tst_resm(TPASS | TTERRNO,
-			 "fallocate(%s:%d, %d, %" PRId64 ", %" PRId64 ") "
-			 "returned %d", test_data[i].fname, *test_data[i].fd,
-			 test_data[i].mode, test_data[i].offset * BLOCK_SIZE,
-			 test_data[i].len * BLOCK_SIZE, TEST_ERRNO);
-	}
+	if (fdw != -1)
+		SAFE_CLOSE(fdw);
+	if (fdr != -1)
+		SAFE_CLOSE(fdr);
 }
 
-static void cleanup(void)
+static void verify_fallocate(unsigned int n)
 {
-	if (fdw > 0)
-		SAFE_CLOSE(NULL, fdw);
-	if (fdr > 0)
-		SAFE_CLOSE(NULL, fdr);
-
-	tst_rmdir();
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(fallocate(*tc->fd, FALLOC_FL_KEEP_SIZE,
+			       tc->offset * BLOCK_SIZE,
+			       tc->len * BLOCK_SIZE), tc->exp_errno,
+		     "fallocate(%d, %lld, %lld)", *tc->fd,
+		     (long long)(tc->offset * BLOCK_SIZE),
+		     (long long)(tc->len * BLOCK_SIZE));
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_fallocate,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
