Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298AECD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:59:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD1623E61A8
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 13:59:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 762AF3E5DD2
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:58:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D81C420076B
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:58:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31B076A952;
 Wed,  3 Jun 2026 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L068Tw6zEQZ6jpZkNZcE4tF0m70SNB+VMnqdCvHehhg=;
 b=IlH2U8h4a3OjaAz2EswaUhTYVutgDGvHKmJW7cZFYTjEO6UB7F7SBy+0JlyClBTxzGnmlm
 s3zX+sEX/2I3/JRKl6y/xj7v06OutRQDePcFqX1IkkzcjHgswIel15LI7EVz5w5PugDLXv
 zlwmTNcJxZB72eiuR8Fdq8T/9YH53Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L068Tw6zEQZ6jpZkNZcE4tF0m70SNB+VMnqdCvHehhg=;
 b=FwIa9VDWtXI4nnatgvlcins7abu1N/h2JOmixxdfDEUC9iEs6R+P6GibJwvuXfTfbYvFYZ
 BmA3mqMQbTJnzdAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L068Tw6zEQZ6jpZkNZcE4tF0m70SNB+VMnqdCvHehhg=;
 b=IlH2U8h4a3OjaAz2EswaUhTYVutgDGvHKmJW7cZFYTjEO6UB7F7SBy+0JlyClBTxzGnmlm
 s3zX+sEX/2I3/JRKl6y/xj7v06OutRQDePcFqX1IkkzcjHgswIel15LI7EVz5w5PugDLXv
 zlwmTNcJxZB72eiuR8Fdq8T/9YH53Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L068Tw6zEQZ6jpZkNZcE4tF0m70SNB+VMnqdCvHehhg=;
 b=FwIa9VDWtXI4nnatgvlcins7abu1N/h2JOmixxdfDEUC9iEs6R+P6GibJwvuXfTfbYvFYZ
 BmA3mqMQbTJnzdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 110A2779A8;
 Wed,  3 Jun 2026 11:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KNt2A/EWIGqLagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jun 2026 11:58:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 13:58:26 +0200
Message-ID: <20260603115828.587769-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603115828.587769-1-pvorel@suse.cz>
References: <20260603115828.587769-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] renameat201.c: Rewrite into new API,
 split into renameat203.c
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

Keep only expected errors changes in renameat201.c, move successful
cases into renameat203.c (although RENAME_EXCHANGE is somehow covered by
renameat202.c, lets keep simple RENAME_EXCHANGE test also in new
renameat203.c).

Due cdd1fedf8261c ("btrfs: add support for RENAME_EXCHANGE and
RENAME_WHITEOUT") from v4.7-rc1 which has been backported to 4.4 based
SLES 12-SP3 kernel it's not possible to use TST_EXP_PASS() (which would
further simplify the code) because we cannot raise .min_kver = "4.7".

Other options would be to use tst_kvercmp2(), which is defacto
deprecated (single test is using it).

Simplify, print a description, fix typo implemented.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/renameat2/renameat201.c   | 172 +++++-------------
 .../kernel/syscalls/renameat2/renameat203.c   |  99 ++++++++++
 2 files changed, 148 insertions(+), 123 deletions(-)
 create mode 100644 testcases/kernel/syscalls/renameat2/renameat203.c

diff --git a/testcases/kernel/syscalls/renameat2/renameat201.c b/testcases/kernel/syscalls/renameat2/renameat201.c
index 01e34d6534..a7ec388ab4 100644
--- a/testcases/kernel/syscalls/renameat2/renameat201.c
+++ b/testcases/kernel/syscalls/renameat2/renameat201.c
@@ -1,163 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Copyright (c) 2026 Petr Vorel <pvorel@suse.cz>
  */
 
- /* Description:
- *   Verify that:
- *   1) renameat2(2) returns -1 and sets errno to EEXIST because newpath
- *		already exists and the flag RENAME_NOREPLACE is used.
- *   2) renameat2(2) returns 0.
- *   3) renameat2(2) returns -1 and sets errno to ENOENT because the flag
- *		RENAME_EXCHANGE is used and newpath does not exist.
- *   4) renameat2(2) returns 0 because the flag RENAME_NOREPLACE is used,
- *		both olddirfd and newdirfd are valid and oldpath exists and
- *		newpath does not exist.
- *   5) renameat2(2) returns -1 and sets errno to EINVAL because
- *		RENAME_NOREPLACE and RENAME_EXCHANGE are used together
- *   6) renameat2(2) returns -1 and sets errno to EINVAL because
- *		RENAME_WHITEOUT and RENAME_EXCHANGE are used together
+/*\
+ * Verify that :manpage:`renameat2(2)` returns -1 and sets errno to:
+ *
+ * 1. EEXIST when newpath already exists and the flag RENAME_NOREPLACE is used.
+ * 2. ENOENT when the flag RENAME_EXCHANGE is used and newpath does not exist.
+ * 3. EINVAL when RENAME_NOREPLACE and RENAME_EXCHANGE are used together
+ * 4. EINVAL when RENAME_WHITEOUT and RENAME_EXCHANGE are used together
  */
 
 #define _GNU_SOURCE
 
-#include "test.h"
-#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
+#include "tst_test.h"
 #include "renameat2.h"
 
 #define TEST_DIR "test_dir/"
 #define TEST_DIR2 "test_dir2/"
 
+#define TEST_PATH TEST_DIR TEST_FILE
+#define TEST_PATH2 TEST_DIR2 TEST_FILE2
+
 #define TEST_FILE "test_file"
 #define TEST_FILE2 "test_file2"
-#define TEST_FILE3 "test_file3"
 #define NON_EXIST "non_exist"
 
-char *TCID = "renameat201";
-
-static int olddirfd;
-static int newdirfd;
-static long fs_type;
+#define FLAGS_ERRNO_DESC(x, y) .flags = x, .exp_errno = y, .desc = "flags: " #x ", errno: " #y
 
-static struct test_case {
-	int *olddirfd;
-	const char *oldpath;
-	int *newdirfd;
+static struct tcase {
 	const char *newpath;
 	int flags;
 	int exp_errno;
-} test_cases[] = {
-	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE2, RENAME_NOREPLACE, EEXIST},
-	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE2, RENAME_EXCHANGE, 0},
-	{&olddirfd, TEST_FILE, &newdirfd, NON_EXIST, RENAME_EXCHANGE, ENOENT},
-	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE3, RENAME_NOREPLACE, 0},
-	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE2, RENAME_NOREPLACE
-				| RENAME_EXCHANGE, EINVAL},
-	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE2, RENAME_WHITEOUT
-				| RENAME_EXCHANGE, EINVAL}
+	char *desc;
+} tcases[] = {
+	{TEST_FILE2, FLAGS_ERRNO_DESC(RENAME_NOREPLACE, EEXIST)},
+	{NON_EXIST, FLAGS_ERRNO_DESC(RENAME_EXCHANGE, ENOENT)},
+	{TEST_FILE2, FLAGS_ERRNO_DESC(RENAME_NOREPLACE | RENAME_EXCHANGE, EINVAL)},
+	{TEST_FILE2, FLAGS_ERRNO_DESC(RENAME_WHITEOUT | RENAME_EXCHANGE, EINVAL)}
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void setup(void);
-static void cleanup(void);
-static void renameat2_verify(const struct test_case *test);
-
-
-int main(int ac, char **av)
-{
-	int i;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; lc < TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			renameat2_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
+static int olddirfd;
+static int newdirfd;
+static long fs_type;
 
 static void setup(void)
 {
-	tst_tmpdir();
-
-	fs_type = tst_fs_type(cleanup, ".");
+	fs_type = tst_fs_type(".");
 
-	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
-	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
+	SAFE_MKDIR(TEST_DIR, 0700);
+	SAFE_MKDIR(TEST_DIR2, 0700);
 
-	SAFE_TOUCH(cleanup, TEST_DIR TEST_FILE, 0600, NULL);
-	SAFE_TOUCH(cleanup, TEST_DIR2 TEST_FILE2, 0600, NULL);
-	SAFE_TOUCH(cleanup, TEST_DIR TEST_FILE3, 0600, NULL);
+	olddirfd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
+	newdirfd = SAFE_OPEN(TEST_DIR2, O_DIRECTORY);
 
-	olddirfd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
-	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
+	SAFE_TOUCH(TEST_PATH, 0600, NULL);
+	SAFE_TOUCH(TEST_PATH2, 0600, NULL);
 }
 
 static void cleanup(void)
 {
-	if (olddirfd > 0 && close(olddirfd) < 0)
-		tst_resm(TWARN | TERRNO, "close olddirfd failed");
-
-	if (newdirfd > 0 && close(newdirfd) < 0)
-		tst_resm(TWARN | TERRNO, "close newdirfd failed");
-
-	tst_rmdir();
+	if (olddirfd > 0)
+		SAFE_CLOSE(olddirfd);
 
+	if (newdirfd > 0)
+		SAFE_CLOSE(newdirfd);
 }
 
-static void renameat2_verify(const struct test_case *test)
+static void renameat2_verify(unsigned int i)
 {
-	TEST(renameat2(*(test->olddirfd), test->oldpath,
-			*(test->newdirfd), test->newpath, test->flags));
-
-	if ((test->flags & RENAME_EXCHANGE) && EINVAL == TEST_ERRNO
-		&& fs_type == TST_BTRFS_MAGIC) {
-		tst_resm(TCONF,
-			"RENAME_EXCHANGE flag is not implemeted on %s",
-			tst_fs_type_name(fs_type));
-		return;
-	}
-
-	if (test->exp_errno && TEST_RETURN != -1) {
-		tst_resm(TFAIL, "renameat2() succeeded unexpectedly");
-		return;
-	}
-
-	if (test->exp_errno == 0 && TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO, "renameat2() failed unexpectedly");
-		return;
-	}
-
-	if (test->exp_errno == TEST_ERRNO) {
-		tst_resm(TPASS | TTERRNO,
-		"renameat2() returned the expected value");
-		return;
-	}
-
-	tst_resm(TFAIL | TTERRNO,
-		"renameat2() got unexpected return value: expected: %d - %s",
-			test->exp_errno, tst_strerrno(test->exp_errno));
+	struct tcase *tc = &tcases[i];
 
+	tst_res(TINFO, "Testing flag: %s", tc->desc);
+
+	TST_EXP_FAIL(renameat2(olddirfd, TEST_FILE, newdirfd, tc->newpath,
+						   tc->flags), tc->exp_errno);
 }
+
+static struct tst_test test = {
+	.test = renameat2_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/renameat2/renameat203.c b/testcases/kernel/syscalls/renameat2/renameat203.c
new file mode 100644
index 0000000000..dba12e48b3
--- /dev/null
+++ b/testcases/kernel/syscalls/renameat2/renameat203.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ * Copyright (c) 2026 Petr Vorel <pvorel@suse.cz>
+ */
+
+/*\
+ * Verify that :manpage:`renameat2(2)` works on these flags:
+ *
+ * 1. RENAME_EXCHANGE
+ * 2. RENAME_NOREPLACE
+ */
+
+#define _GNU_SOURCE
+
+#include "lapi/fcntl.h"
+#include "tst_test.h"
+#include "renameat2.h"
+
+#define TEST_DIR "test_dir/"
+#define TEST_DIR2 "test_dir2/"
+
+#define TEST_FILE "test_file"
+#define TEST_FILE2 "test_file2"
+
+#define TEST_PATH TEST_DIR TEST_FILE
+#define TEST_PATH2 TEST_DIR2 TEST_FILE2
+
+#define FLAGS_DESC(x) .flags = x, .desc = #x
+
+static struct tcase {
+	int flags;
+	char *desc;
+} tcases[] = {
+	{FLAGS_DESC(RENAME_EXCHANGE)},
+	{FLAGS_DESC(RENAME_NOREPLACE)},
+};
+
+static int olddirfd;
+static int newdirfd;
+static long fs_type;
+
+static void setup(void)
+{
+	// TODO
+	fs_type = tst_fs_type(".");
+
+	SAFE_MKDIR(TEST_DIR, 0700);
+	SAFE_MKDIR(TEST_DIR2, 0700);
+
+	olddirfd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
+	newdirfd = SAFE_OPEN(TEST_DIR2, O_DIRECTORY);
+}
+
+static void cleanup(void)
+{
+	if (olddirfd > 0)
+		SAFE_CLOSE(olddirfd);
+
+	if (newdirfd > 0)
+		SAFE_CLOSE(newdirfd);
+}
+
+static void renameat2_verify(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	tst_res(TINFO, "Testing flag: %s", tc->desc);
+
+	SAFE_TOUCH(TEST_PATH, 0600, NULL);
+	if (!i)
+		SAFE_TOUCH(TEST_PATH2, 0600, NULL);
+
+	TEST(renameat2(olddirfd, TEST_FILE, newdirfd, TEST_FILE2, tc->flags));
+	SAFE_UNLINK(TEST_PATH2);
+
+	if (TST_RET == -1) {
+		/*
+		 * cdd1fedf8261c ("btrfs: add support for RENAME_EXCHANGE and
+		 * RENAME_WHITEOUT") from v4.7-rc1 has been backported to 4.4
+		 * based SLES 12-SP3 kernel.
+		 */
+		if (TST_ERR == EINVAL && fs_type == TST_BTRFS_MAGIC) {
+			tst_res(TCONF, "RENAME_EXCHANGE flag is not implemented on %s",
+				tst_fs_type_name(fs_type));
+			return;
+		}
+		tst_brk(TFAIL | TTERRNO, "renameat2() failed");
+	}
+	tst_res(TPASS, "renameat2() passed");
+}
+
+static struct tst_test test = {
+	.test = renameat2_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
