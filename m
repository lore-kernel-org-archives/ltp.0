Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03248CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:58:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 905053E619C
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 13:58:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A00463E5DD2
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:58:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7F09600811
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:58:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 496CA67569;
 Wed,  3 Jun 2026 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtjM0eVfpXekoHk4QnXVhTbAto+6pk7U6wNuRXUFh4s=;
 b=hJr+ZS/TbINGrDU4EnG8PWoNRXWH5YEI88/Hpxllc3YY2tf1FDMWQCW4UrUYDqLZVO16Jv
 qxZp/uP81StFagBZV/K76NvDRKX1MOOmjgdE3u4GCv2x1sncfTACkkvowgeDVkhAlWussW
 YIhEOO3+CeJ0jnyzYWncj+u8C6IAkFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtjM0eVfpXekoHk4QnXVhTbAto+6pk7U6wNuRXUFh4s=;
 b=r0btWUBZJNTP8OGv2LIkxyAlw4K9PvpuIg90J58h4Fzud0HaMDa/0uOjjU9RzK4ed4TjDQ
 W3U7E5qxCCgi4fCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtjM0eVfpXekoHk4QnXVhTbAto+6pk7U6wNuRXUFh4s=;
 b=hJr+ZS/TbINGrDU4EnG8PWoNRXWH5YEI88/Hpxllc3YY2tf1FDMWQCW4UrUYDqLZVO16Jv
 qxZp/uP81StFagBZV/K76NvDRKX1MOOmjgdE3u4GCv2x1sncfTACkkvowgeDVkhAlWussW
 YIhEOO3+CeJ0jnyzYWncj+u8C6IAkFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtjM0eVfpXekoHk4QnXVhTbAto+6pk7U6wNuRXUFh4s=;
 b=r0btWUBZJNTP8OGv2LIkxyAlw4K9PvpuIg90J58h4Fzud0HaMDa/0uOjjU9RzK4ed4TjDQ
 W3U7E5qxCCgi4fCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31212779A9;
 Wed,  3 Jun 2026 11:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kG77CvEWIGqLagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jun 2026 11:58:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 13:58:27 +0200
Message-ID: <20260603115828.587769-3-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.com:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] renameat202.c: Rewrite into new API
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

Again, as in previous commit, Due cdd1fedf8261c ("btrfs: add support
for RENAME_EXCHANGE and RENAME_WHITEOUT") from v4.7-rc1 which has been
backported to 4.4 based SLES 12-SP3 kernel it's not possible to use
TST_EXP_PASS() (which would further simplify the code) because we cannot
raise .min_kver = "4.7".

Other options would be to use tst_kvercmp2(), which is defacto
deprecated (single test is using it).

* Replace char content[] as preprocessor macro, fix typo implemeted.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/renameat2/renameat202.c   | 159 ++++++------------
 1 file changed, 55 insertions(+), 104 deletions(-)

diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
index a635206f7d..17acd7206e 100644
--- a/testcases/kernel/syscalls/renameat2/renameat202.c
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -1,31 +1,17 @@
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
- *   Calls renameat2(2) with the flag RENAME_EXCHANGE and check that
- *   the content was swapped
+/*\
+ * Verify that :manpage:`renameat2(2)` with RENAME_EXCHANGE swapps the content.
  */
 
 #define _GNU_SOURCE
 
-#include "test.h"
-#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
+#include "tst_test.h"
 #include "renameat2.h"
 
 #define TEST_DIR "test_dir/"
@@ -34,80 +20,42 @@
 #define TEST_FILE "test_file"
 #define TEST_FILE2 "test_file2"
 
-char *TCID = "renameat202";
+#define CONTENT "content"
 
 static int olddirfd;
 static int newdirfd;
 static int fd = -1;
-static int cnt;
-
-static const char content[] = "content";
 static long fs_type;
 
-
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-static void renameat2_verify(void);
-
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(renameat2(olddirfd, TEST_FILE,
-				newdirfd, TEST_FILE2, RENAME_EXCHANGE));
-
-		cnt++;
-
-		renameat2_verify();
-	}
-
-	cleanup();
-	tst_exit();
-}
+/* workaround for iterations not being exposed by lib/tst_test.c */
+static int cnt;
 
 static void setup(void)
 {
-	tst_tmpdir();
-
-	fs_type = tst_fs_type(cleanup, ".");
-
-	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
-	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
+	fs_type = tst_fs_type(".");
 
-	SAFE_TOUCH(cleanup, TEST_DIR TEST_FILE, 0600, NULL);
-	SAFE_TOUCH(cleanup, TEST_DIR2 TEST_FILE2, 0600, NULL);
+	SAFE_MKDIR(TEST_DIR, 0700);
+	SAFE_MKDIR(TEST_DIR2, 0700);
 
-	olddirfd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
-	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
+	SAFE_TOUCH(TEST_DIR TEST_FILE, 0600, NULL);
+	SAFE_TOUCH(TEST_DIR2 TEST_FILE2, 0600, NULL);
 
-	SAFE_FILE_PRINTF(cleanup, TEST_DIR TEST_FILE, "%s", content);
+	olddirfd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
+	newdirfd = SAFE_OPEN(TEST_DIR2, O_DIRECTORY);
 
+	SAFE_FILE_PRINTF(TEST_DIR TEST_FILE, "%s", CONTENT);
 }
 
 static void cleanup(void)
 {
-	if (olddirfd > 0 && close(olddirfd) < 0)
-		tst_resm(TWARN | TERRNO, "close olddirfd failed");
+	if (olddirfd > 0)
+		SAFE_CLOSE(olddirfd);
 
-	if (newdirfd > 0 && close(newdirfd) < 0)
-		tst_resm(TWARN | TERRNO, "close newdirfd failed");
-
-	if (fd > 0 && close(fd) < 0)
-		tst_resm(TWARN | TERRNO, "close fd failed");
-
-	tst_rmdir();
+	if (newdirfd > 0)
+		SAFE_CLOSE(newdirfd);
 
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static void renameat2_verify(void)
@@ -116,51 +64,54 @@ static void renameat2_verify(void)
 	struct stat st;
 	char *emptyfile;
 	char *contentfile;
-	int readn, data_len;
-
-	if (TEST_ERRNO == EINVAL && TST_BTRFS_MAGIC == fs_type) {
-		tst_brkm(TCONF, cleanup,
-			"RENAME_EXCHANGE flag is not implemeted on %s",
-			tst_fs_type_name(fs_type));
-	}
 
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO, "renameat2() failed unexpectedly");
-		return;
+	TEST(renameat2(olddirfd, TEST_FILE, newdirfd, TEST_FILE2,
+		       RENAME_EXCHANGE));
+
+	if (TST_RET == -1) {
+		/*
+		 * cdd1fedf8261c ("btrfs: add support for RENAME_EXCHANGE and
+		 * RENAME_WHITEOUT") from v4.7-rc1 has been backported to 4.4
+		 * based SLES 12-SP3 kernel.
+		 */
+		if (TST_ERR == EINVAL && fs_type == TST_BTRFS_MAGIC) {
+			tst_brk(TCONF, "RENAME_EXCHANGE flag is not implemented on %s",
+				tst_fs_type_name(fs_type));
+		}
+		tst_brk(TFAIL | TTERRNO, "renameat2() failed");
 	}
 
-	if (cnt % 2 == 1) {
+	if (cnt % 2 == 0) {
 		emptyfile = TEST_DIR TEST_FILE;
 		contentfile = TEST_DIR2 TEST_FILE2;
 	} else {
 		emptyfile = TEST_DIR2 TEST_FILE2;
 		contentfile = TEST_DIR TEST_FILE;
 	}
+	cnt++;
 
-	fd = SAFE_OPEN(cleanup, contentfile, O_RDONLY);
-
-	SAFE_STAT(cleanup, emptyfile, &st);
+	fd = SAFE_OPEN(contentfile, O_RDONLY);
 
-	readn = SAFE_READ(cleanup, 0, fd, str, BUFSIZ);
+	SAFE_STAT(emptyfile, &st);
 
-	if (close(fd) < 0)
-		tst_brkm(TERRNO | TFAIL, cleanup, "close fd failed");
-	fd = 0;
+	SAFE_READ(SAFE_READ_ANY_EAGAIN, fd, str, BUFSIZ);
+	SAFE_CLOSE(fd);
 
-	data_len = sizeof(content) - 1;
-	if (readn != data_len) {
-		tst_resm(TFAIL, "Wrong number of bytes read after renameat2(). "
-				"Expect %d, got %d", data_len, readn);
-		return;
-	}
-	if (strncmp(content, str, data_len)) {
-		tst_resm(TFAIL, "File content changed after renameat2(). "
-				"Expect '%s', got '%s'", content, str);
+	TST_EXP_EQ_STRN(CONTENT, str, sizeof(CONTENT) - 1);
+	if (!TST_PASS)
 		return;
-	}
+
 	if (st.st_size) {
-		tst_resm(TFAIL, "emptyfile has non-zero file size");
+		tst_res(TFAIL, "emptyfile has non-zero file size");
 		return;
 	}
-	tst_resm(TPASS, "renameat2() test passed");
+
+	tst_res(TPASS, "renameat2() test passed");
 }
+
+static struct tst_test test = {
+	.test_all = renameat2_verify,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
