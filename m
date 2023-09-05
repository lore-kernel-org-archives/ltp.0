Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79547C83F2C
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 09:54:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A6563CB798
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 11:54:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EBB43CB798
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:54:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 25327140012E
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:54:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DE8021855
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693907654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n79fKKxTJBU4vMZN9HvWgbAssC+5qyaL0HWADpXvVC4=;
 b=D7/bLOyWkinhd7RiKrzxSJ3MEk15pC2SQjR752WR0oDjEy3sQ3x9nyRE9xaR6PKNzKthHy
 3/YTERrZq4pIVnLObx1XdU9x/Dcw81V3X8zHt1Igfy+wzucb2231GBc7QA9RuxNhhsEpu7
 0sD8VcKf0KixaBxdKuvlVtbyVlnpOS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693907654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n79fKKxTJBU4vMZN9HvWgbAssC+5qyaL0HWADpXvVC4=;
 b=hGhTHArZeb09FLumGdWjlFxX8UJ6oYC9hIeco+uam7Clhv+EoE2RnHIDXW7lr0yoxIYWsP
 IUv6oshMpRIWlkDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDE4B13911
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 09:54:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gUspI8X69mSrPQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 05 Sep 2023 09:54:13 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 15:24:10 +0530
Message-ID: <20230905095411.6704-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZPHY1CtYogkqUHzQ@yuki>
References: <ZPHY1CtYogkqUHzQ@yuki>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mmap04: Validate mapping perms in
 /proc/self/maps
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

Validating the various combinations of prot+flags arguments in mmap()
call and parsing the /proc/self/maps file to verifying resulting mapping
has the permission bits as requested in mmap() call.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap04.c | 274 ++++++++----------------
 1 file changed, 89 insertions(+), 185 deletions(-)
 rewrite testcases/kernel/syscalls/mmap/mmap04.c (97%)

diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
dissimilarity index 97%
index 43f7b7525..a15dfedbe 100644
--- a/testcases/kernel/syscalls/mmap/mmap04.c
+++ b/testcases/kernel/syscalls/mmap/mmap04.c
@@ -1,185 +1,89 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Description:
- *  Call mmap() to map a file creating a mapped region with read/exec access
- *  under the following conditions -
- *	- The prot parameter is set to PROT_READ|PROT_EXEC
- *	- The file descriptor is open for read
- *	- The file being mapped has read and execute permission bit set.
- *	- The minimum file permissions should be 0555.
- *
- *  The call should succeed to map the file creating mapped memory with the
- *  required attributes.
- *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and the mapped region should contain the contents of the mapped file.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-
-#include "test.h"
-
-#define TEMPFILE	"mmapfile"
-
-char *TCID = "mmap04";
-int TST_TOTAL = 1;
-
-static size_t page_sz;
-static char *addr;
-static char *dummy;
-static int fildes;
-
-static void setup(void);
-static void cleanup(void);
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
-		/*
-		 * Call mmap to map the temporary file 'TEMPFILE'
-		 * with read and execute access.
-		 */
-		errno = 0;
-		addr = mmap(0, page_sz, PROT_READ | PROT_EXEC,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-
-		/* Check for the return value of mmap() */
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
-			continue;
-		}
-
-		/*
-		 * Read the file contents into the dummy
-		 * variable.
-		 */
-		if (read(fildes, dummy, page_sz) < 0) {
-			tst_brkm(TFAIL, cleanup, "reading %s failed",
-				 TEMPFILE);
-		}
-
-		/*
-		 * Check whether the mapped memory region
-		 * has the file contents.
-		 */
-		if (memcmp(dummy, addr, page_sz)) {
-			tst_resm(TFAIL,
-				 "mapped memory region contains invalid "
-				 "data");
-		} else {
-			tst_resm(TPASS,
-				 "Functionality of mmap() successful");
-		}
-
-		/* Clean up things in case we are looping. */
-		/* Unmap the mapped memory */
-		if (munmap(addr, page_sz) != 0) {
-			tst_brkm(TFAIL, cleanup, "munmapping failed");
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	char *tst_buff;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	page_sz = getpagesize();
-
-	if ((tst_buff = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, NULL, "calloc failed (tst_buff)");
-	}
-
-	/* Fill the test buffer with the known data */
-	memset(tst_buff, 'A', page_sz);
-
-	tst_tmpdir();
-
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_WRONLY | O_CREAT, 0666)) < 0) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
-	}
-
-	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, page_sz) < (ssize_t)page_sz) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "writing to %s failed", TEMPFILE);
-	}
-
-	/* Free the memory allocated for test buffer */
-	free(tst_buff);
-
-	/* Make sure proper permissions set on file */
-	if (fchmod(fildes, 0555) < 0) {
-		tst_brkm(TFAIL, cleanup, "fchmod of %s failed", TEMPFILE);
-	}
-
-	/* Close the temporary file opened for write */
-	if (close(fildes) < 0) {
-		tst_brkm(TFAIL, cleanup, "closing %s failed", TEMPFILE);
-	}
-
-	/* Allocate and initialize dummy string of system page size bytes */
-	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
-	}
-
-	/* Open the temporary file again for reading */
-	if ((fildes = open(TEMPFILE, O_RDONLY)) < 0) {
-		tst_brkm(TFAIL, cleanup,
-			 "opening %s read-only failed", TEMPFILE);
-	}
-}
-
-static void cleanup(void)
-{
-	close(fildes);
-	free(dummy);
-	tst_rmdir();
-}
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that, after a successful mmap() call, permission bits of the new
+ * mapping in /proc/pid/maps file matches the prot and flags arguments in
+ * mmap() call.
+ */
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#define MMAPSIZE 1024
+static char *addr;
+
+static struct tcase {
+	int prot;
+	int flags;
+	char *exp_perms;
+} tcases[] = {
+	{PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, "---p"},
+	{PROT_NONE, MAP_ANONYMOUS | MAP_SHARED, "---s"},
+	{PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, "r--p"},
+	{PROT_READ, MAP_ANONYMOUS | MAP_SHARED, "r--s"},
+	{PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "-w-p"},
+	{PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "-w-s"},
+	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "rw-p"},
+	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "rw-s"},
+	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "r-xp"},
+	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "r-xs"},
+	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "-wxp"},
+	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "-wxs"},
+	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "rwxp"},
+	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "rwxs"}
+};
+
+static void get_map_perms(char *addr_str, char *perms)
+{
+	FILE *file;
+	char line[BUFSIZ];
+
+	file = SAFE_FOPEN("/proc/self/maps", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, addr_str) != NULL) {
+			if (sscanf(line, "%*x-%*x %s", perms) != 1)
+				tst_brk(TBROK, "failed to find permission string in %s", line);
+			break;
+		}
+	}
+
+	SAFE_FCLOSE(file);
+	file = NULL;
+}
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+	char addr_str[20];
+	char perms[8];
+
+	addr = SAFE_MMAP(NULL, MMAPSIZE, tc->prot, tc->flags, -1, 0);
+
+	sprintf(addr_str, "%p", addr);
+	if (sscanf(addr_str, "0x%s", addr_str) != 1)
+		tst_brk(TBROK, "failed to find address string");
+
+	get_map_perms(addr_str, perms);
+
+	if (!strcmp(perms, tc->exp_perms))
+		tst_res(TPASS, "mapping permissions in /proc matched: %s", perms);
+	else
+		tst_res(TFAIL, "mapping permissions in /proc mismatched,"
+						" expected: %s, found: %s",
+						tc->exp_perms, perms);
+
+	SAFE_MUNMAP(addr, MMAPSIZE);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
