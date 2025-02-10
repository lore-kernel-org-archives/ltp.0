Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4696C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:10:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 997D73C9878
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:10:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18A3E3C9883
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:15 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C4486094CD
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA8491F394;
 Mon, 10 Feb 2025 09:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jI/MQcb9tOz1W3hBPzC4AU2yGBX65agzNzbRD3/6M8g=;
 b=TXChrWhcQqm9Z/1kxYEkU7ArsGI3tdY2yI8JhdJTZfAp4183blwhVodIGC8k4cDCzfFcfs
 /53YEPzX5kuvcXOZS231ekfgoNIuUJlZCvs0XK0vNi9UHlKw8XFhn36/Z1sTqR+00tkyA4
 fVM2C40jpTC2R8EDL6Db1K0TlYzS8Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jI/MQcb9tOz1W3hBPzC4AU2yGBX65agzNzbRD3/6M8g=;
 b=znMZ0J28P1RW/uWVxuSw/SBmoCpzSbKcSsQo3k0tpJZuIdpkbKKD2CUd6IZFFTPEf2KlqP
 qo6y6Tq0AqFTzPBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jI/MQcb9tOz1W3hBPzC4AU2yGBX65agzNzbRD3/6M8g=;
 b=PZt7vWSDYTQ7PZi6LhDI+dMb0BLgi5XNgEVHgQ2wjHQ3W14EKvplNmcw0vS8EyLmmofx7b
 ZurhwXs6TQAXbiMQM0bRg0DeKTr7Kcx6vnMSbVP8kXjGiyAzKydb5UBeKdBNMZ/ptnq8cE
 wvIWrTwnnLPoaVZdSrzkKVxFMDTIhRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jI/MQcb9tOz1W3hBPzC4AU2yGBX65agzNzbRD3/6M8g=;
 b=1jh09zB+F6cJCXXv1lNGiZ5ouw9qRDgiL77CN5UkUUP6YixvBfqDRUEipkKOU8Z0n+U1Jl
 XqlflgIW6PwhODAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F54D13707;
 Mon, 10 Feb 2025 09:07:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AM39IMDBqWdQLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Feb 2025 09:07:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Feb 2025 10:07:13 +0100
MIME-Version: 1.0
Message-Id: <20250210-mmap_suite_refactoring-v2-8-6edea3a4363a@suse.com>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
In-Reply-To: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739178429; l=9343;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=FF2TUl643xoZ5X9bFX/pVliow9/5Yfb8pEpkhLhcF9I=;
 b=ceaE1JR3Vb21zAurm6fz+VrFYEM4qvNcGoLXGkIUkLPr+ZCzrgPzsQ97+L8tvfhj8hll1LewX
 cnDdxBjPX7CDqt/fREo+X+kM4I59QKtSrFbMFoxoQ2klgRyCjiqQVcW
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 8/8] Refactor mmap001 test and move it to mmap21
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
Cc: rbm@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/mm                                |   8 +-
 runtest/syscalls                          |   2 +-
 testcases/kernel/syscalls/mmap/.gitignore |   2 +-
 testcases/kernel/syscalls/mmap/mmap001.c  | 183 ------------------------------
 testcases/kernel/syscalls/mmap/mmap21.c   | 108 ++++++++++++++++++
 5 files changed, 112 insertions(+), 191 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index d8e62af81fcbf9381a5419ab713139774d081c44..fd64d9a82f65ab1afc886ac1ae86955f48ef5031 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -1,13 +1,9 @@
 #DESCRIPTION:Memory Mgmt tests
-mm01 mmap001 -m 10000
+mm01 mmap021 -m 10000
 # 40 Mb mmap() test.
 # Creates a 10000 page mmap, touches all of the map, sync's it, and
 # munmap()s it.
-mm02 mmap001
-# simple mmap() test.
-#mm03 mmap001 -i 0 -I 1 -m 100
-# repetitive mmapping test.
-# Creates a one page map repetitively for one minute.
+mm02 mmap21
 
 mtest01 mtest01 -p80
 mtest01w mtest01 -p80 -w
diff --git a/runtest/syscalls b/runtest/syscalls
index 4ab8436d30ca5ffee52d9777729ec1ec09d0bf1d..6aaef356fd617bac5617a3a652c66016892b07eb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -822,7 +822,7 @@ mlock201 mlock201
 mlock202 mlock202
 mlock203 mlock203
 
-qmm01 mmap001 -m 1
+qmm01 mmap21 -m 1
 mmap01 mmap01
 mmap02 mmap02
 mmap03 mmap03
diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
index 4591fdbb9b71d5edb534c3d99f1a66e0e42ce6b6..850284d86616e29674df89b8107a5939c25723da 100644
--- a/testcases/kernel/syscalls/mmap/.gitignore
+++ b/testcases/kernel/syscalls/mmap/.gitignore
@@ -1,4 +1,3 @@
-/mmap001
 /mmap01
 /mmap02
 /mmap03
@@ -18,3 +17,4 @@
 /mmap18
 /mmap19
 /mmap20
+/mmap21
diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
deleted file mode 100644
index dabb7d1e4998b1097e179abe23555926f5841117..0000000000000000000000000000000000000000
--- a/testcases/kernel/syscalls/mmap/mmap001.c
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- * Copyright (C) 2000 Juan Quintela <quintela@fi.udc.es>
- *                    Aaron Laffin <alaffin@sgi.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
- * mmap001.c - Tests mmapping a big file and writing it once
- */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-
-#include "test.h"
-
-char *TCID = "mmap001";
-int TST_TOTAL = 5;
-static char *filename = NULL;
-static int m_opt = 0;
-static char *m_copt;
-
-static void cleanup(void)
-{
-	free(filename);
-
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	char buf[1024];
-	/*
-	 * setup a default signal hander and a
-	 * temporary working directory.
-	 */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	snprintf(buf, 1024, "testfile.%d", getpid());
-
-	if ((filename = strdup(buf)) == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup, "strdup failed");
-	}
-
-}
-
-static void help(void)
-{
-	printf("  -m x    size of mmap in pages (default 1000)\n");
-}
-
-/*
- * add the -m option whose parameter is the
- * pages that should be mapped.
- */
-option_t options[] = {
-	{"m:", &m_opt, &m_copt},
-	{NULL, NULL, NULL}
-};
-
-int main(int argc, char *argv[])
-{
-	char *array;
-	int lc;
-	unsigned int i;
-	int fd;
-	unsigned int pages, memsize;
-
-	tst_parse_opts(argc, argv, options, help);
-
-	if (m_opt) {
-		memsize = pages = atoi(m_copt);
-
-		if (memsize < 1) {
-			tst_brkm(TBROK, cleanup, "Invalid arg for -m: %s",
-				 m_copt);
-		}
-
-		memsize *= getpagesize();	/* N PAGES */
-
-	} else {
-		/*
-		 * default size 1000 pages;
-		 */
-		memsize = pages = 1000;
-		memsize *= getpagesize();
-	}
-
-	tst_resm(TINFO, "mmap()ing file of %u pages or %u bytes", pages,
-		 memsize);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fd = open(filename, O_RDWR | O_CREAT, 0666);
-		if ((fd == -1))
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "opening %s failed", filename);
-
-		if (lseek(fd, memsize, SEEK_SET) != memsize) {
-			TEST_ERRNO = errno;
-			close(fd);
-			tst_brkm(TBROK | TTERRNO, cleanup, "lseek failed");
-		}
-
-		if (write(fd, "\0", 1) != 1) {
-			TEST_ERRNO = errno;
-			close(fd);
-			tst_brkm(TBROK | TTERRNO, cleanup,
-				 "writing to %s failed", filename);
-		}
-
-		array = mmap(0, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
-		if (array == MAP_FAILED) {
-			TEST_ERRNO = errno;
-			close(fd);
-			tst_brkm(TBROK | TTERRNO, cleanup,
-				 "mmapping %s failed", filename);
-		} else {
-			tst_resm(TPASS, "mmap() completed successfully.");
-		}
-
-		tst_resm(TINFO, "touching mmaped memory");
-
-		for (i = 0; i < memsize; i++) {
-			array[i] = (char)i;
-		}
-
-		/*
-		 * seems that if the map area was bad, we'd get SEGV,
-		 * hence we can indicate a PASS.
-		 */
-		tst_resm(TPASS,
-			 "we're still here, mmaped area must be good");
-
-		TEST(msync(array, memsize, MS_SYNC));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				 "synchronizing mmapped page failed");
-		} else {
-			tst_resm(TPASS,
-				 "synchronizing mmapped page passed");
-		}
-
-		TEST(munmap(array, memsize));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				 "munmapping %s failed", filename);
-		} else {
-			tst_resm(TPASS, "munmapping %s successful", filename);
-		}
-
-		close(fd);
-		unlink(filename);
-
-	}
-	cleanup();
-	tst_exit();
-}
diff --git a/testcases/kernel/syscalls/mmap/mmap21.c b/testcases/kernel/syscalls/mmap/mmap21.c
new file mode 100644
index 0000000000000000000000000000000000000000..895f86d36afe32082205f0b391bfa19070170d87
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap21.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2000 Juan Quintela <quintela@fi.udc.es>
+ *                    Aaron Laffin <alaffin@sgi.com>
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that we can use mmap() to map a large file, write to it via memory
+ * access, and read back the data from the file. This test also verifies that
+ * accessing memory won't end up killing the test with SIGSEGV.
+ */
+
+#include "tst_test.h"
+
+static char filename[1024];
+static char *str_pages;
+static long long pages = 1000;
+static long long memory_size;
+static char *memory_data;
+
+static void run(void)
+{
+	int fd;
+	pid_t pid;
+	int status;
+	char *buff = NULL;
+
+	tst_res(TINFO, "mmap()ing file of %llu bytes", memory_size);
+
+	fd = SAFE_OPEN(filename, O_RDWR | O_CREAT, 0666);
+	SAFE_LSEEK(fd, memory_size, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\0", 1);
+
+	memory_data = SAFE_MMAP(0, memory_size, PROT_WRITE, MAP_SHARED, fd, 0);
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		tst_res(TINFO, "Touching mapped memory");
+
+		for (int i = 0; i < memory_size; i++)
+			memory_data[i] = (char)i;
+
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TFAIL, "Touching memory caused SIGSEGV");
+		goto exit;
+	}
+
+	SAFE_MSYNC(memory_data, memory_size, MS_SYNC);
+
+	buff = SAFE_MALLOC(memory_size);
+	memset(buff, 0, memory_size);
+
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+	SAFE_READ(0, fd, buff, memory_size);
+	SAFE_CLOSE(fd);
+
+	for (int i = 0; i < memory_size; i++) {
+		if (buff[i] != (char)i) {
+			tst_res(TFAIL, "Mapped file has not been updated at byte %d", i);
+			goto exit;
+		}
+	}
+
+	tst_res(TPASS, "Mapped file has been updated");
+
+exit:
+	if (buff)
+		free(buff);
+
+	SAFE_MUNMAP(memory_data, memory_size);
+	SAFE_UNLINK(filename);
+}
+
+static void setup(void)
+{
+	if (tst_parse_filesize(str_pages, &pages, 1, LLONG_MAX))
+		tst_brk(TBROK, "Invalid number of pages: %s", str_pages);
+
+	memory_size = pages * getpagesize();
+
+	snprintf(filename, 1024, "testfile.%d", getpid());
+}
+
+static void cleanup(void)
+{
+	if (memory_data)
+		SAFE_MUNMAP(memory_data, memory_size);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{"m:", &str_pages, "Number of pages (default 1000)"},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
