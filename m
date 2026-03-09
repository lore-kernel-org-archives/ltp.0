Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75789EFCD93
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 10:46:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 327683DD6B7
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 11:46:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 257713DD9C5
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 11:45:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B0E851400960
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 11:45:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFAB04D228;
 Mon,  9 Mar 2026 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773053112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEEy8AgaqQVESYnK5+Ve640RQJgDGtiP3ziuLXIAZAc=;
 b=KBsVn4lMLUVHq2vde144/BXRkEpcsXoAW5IscSJxSabyUT0hUis2UXzKpc9vwLWvTLqpcb
 f1bI8gDtqG5Qb+iiQpr2N8KFp1Fke6XD7P1NqHXAPuhG7ShJtojfOOGeftt3Pe5bt5UO8x
 L0cPIWTCWFbYhuda+rabSPmRlvaIt3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773053112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEEy8AgaqQVESYnK5+Ve640RQJgDGtiP3ziuLXIAZAc=;
 b=lrbNJ8HNcmRqXfs5HxDOWetMXzaixcF+PDaHH5byIJwzKCDaTSEv0TwIMBkYZ77mlh1MS7
 hd18A3TY37CrGICg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nBd4uFtB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wKrWz16H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773053111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEEy8AgaqQVESYnK5+Ve640RQJgDGtiP3ziuLXIAZAc=;
 b=nBd4uFtBzBruLMaOtcuL2fF10uc6E5mB1wmNIIBgX3dzlCHM+IP7lgjmjDWktxKS2Ybv4i
 9RFr8KiScN7HGVuHUEAk6U6ki7xqW6Bcj2mkEUnWwRuuTdK93BfGx7uJ9qR8MPmO628KBV
 H03PyA1kTm+6zwhcV9Q2OGei6XXdZTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773053111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEEy8AgaqQVESYnK5+Ve640RQJgDGtiP3ziuLXIAZAc=;
 b=wKrWz16Hd/motGawcjlYiXe0wFRWHth91DoCQP4cxSaoGxMyjwNn1aO4PsnNL/WU0oKgPg
 KUMd4kveKdWmTjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB0C03EE67;
 Mon,  9 Mar 2026 10:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OHyoL7ekrmlcTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 09 Mar 2026 10:45:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Mar 2026 11:45:10 +0100
MIME-Version: 1.0
Message-Id: <20260309-fork_refactoring-v3-1-8a645d7e00db@suse.com>
References: <20260309-fork_refactoring-v3-0-8a645d7e00db@suse.com>
In-Reply-To: <20260309-fork_refactoring-v3-0-8a645d7e00db@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773053111; l=6964;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=fu1Y57zUWVDjqLbR5xGoedf5XGeHXMYyQwkvwGhXhYA=;
 b=jaAl8K/4zO/cIQTU3r+KRdzo91ReEUElhMMg5cDo0jT8KKXz7Bgms0XMOSoF3qx7Mv3H3y4lp
 wRbE/X8dZ2IBhyUOKDmtgS6rbMyuCNHfgybmUYfKZOe2H27KNNdSiqV
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EFAB04D228
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] syscalls: refactor fork09 using new API
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/fork/fork09.c | 221 +++++++++++---------------------
 1 file changed, 74 insertions(+), 147 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork09.c b/testcases/kernel/syscalls/fork/fork09.c
index c3b9cf45bf947604fed3217dbdda9b3c1657add9..d5c5e116dfcf61065a23de3207740da0e22c66ba 100644
--- a/testcases/kernel/syscalls/fork/fork09.c
+++ b/testcases/kernel/syscalls/fork/fork09.c
@@ -1,172 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
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
- *
- * NAME
- *	fork09.c
- *
- * DESCRIPTION
- *	Check that child has access to a full set of files.
- *
- * ALGORITHM
- *	Parent opens a maximum number of files
- *	Child closes one and attempts to open another, it should be
- *	available
- *
- * USAGE
- *	fork09
- *
- * HISTORY
+ * Copyright (c) International Business Machines  Corp., 2001
  *	07/2001 Ported by Wayne Boyer
- *
  *	10/2008 Suzuki K P <suzuki@in.ibm.com>
- *		Fix maximum number of files open logic.
  *
- * RESTRICTIONS
- *	None
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>		/* for _SC_OPEN_MAX */
-#include "test.h"
-#include "tso_safe_macros.h"
-
-char *TCID = "fork09";
-int TST_TOTAL = 1;
+/*\
+ * Verify that a forked child can close all the files which have been open by
+ * the parent process, after opening and closing one of them.
+ */
 
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
 
-static char filname[40], childfile[40];
-static int first;
-static FILE **fildeses;		/* file streams */
-static int mypid, nfiles;
+#define FILE_PREFIX "ltp_file"
 
-#define OPEN_MAX (sysconf(_SC_OPEN_MAX))
+static FILE **open_files;
+static long file_open_max;
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int pid, status, nf;
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	fildeses = malloc((OPEN_MAX + 10) * sizeof(FILE *));
-	if (fildeses == NULL)
-		tst_brkm(TBROK, cleanup, "malloc failed");
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		mypid = getpid();
-
-		tst_resm(TINFO, "OPEN_MAX is %ld", OPEN_MAX);
-
-		/* establish first free file */
-		sprintf(filname, "fork09.%d", mypid);
-		first = SAFE_CREAT(cleanup, filname, 0660);
-		close(first);
-
-		tst_resm(TINFO, "first file descriptor is %d ", first);
-
-		SAFE_UNLINK(cleanup, filname);
-
-		/*
-		 * now open all the files for the test
-		 */
-		for (nfiles = first; nfiles < OPEN_MAX; nfiles++) {
-			sprintf(filname, "file%d.%d", nfiles, mypid);
-			fildeses[nfiles] = fopen(filname, "a");
-			if (fildeses[nfiles] == NULL) {
-				/* Did we already reach OPEN_MAX ? */
-				if (errno == EMFILE)
-					break;
-				tst_brkm(TBROK, cleanup, "Parent: cannot open "
-					 "file %d %s errno = %d", nfiles,
-					 filname, errno);
-			}
-#ifdef DEBUG
-			tst_resm(TINFO, "filname: %s", filname);
-#endif
-		}
+	FILE *f;
+	long nfiles;
+	long totfiles;
+	int name_len;
+	char name[PATH_MAX];
+	char reopen[PATH_MAX];
 
-		tst_resm(TINFO, "Parent reporting %d files open", nfiles - 1);
-
-		pid = fork();
-		if (pid == -1)
-			tst_brkm(TBROK, cleanup, "Fork failed");
-
-		if (pid == 0) {	/* child */
-			nfiles--;
-			if (fclose(fildeses[nfiles]) == -1) {
-				tst_resm(TINFO, "Child could not close file "
-					 "#%d, errno = %d", nfiles, errno);
-				exit(1);
-			} else {
-				sprintf(childfile, "cfile.%d", getpid());
-				fildeses[nfiles] = fopen(childfile, "a");
-				if (fildeses[nfiles] == NULL) {
-					tst_resm(TINFO, "Child could not open "
-						 "file %s, errno = %d",
-						 childfile, errno);
-					exit(1);
-				} else {
-					tst_resm(TINFO, "Child opened new "
-						 "file #%d", nfiles);
-					unlink(childfile);
-					exit(0);
-				}
-			}
-		} else {	/* parent */
-			wait(&status);
-			if (status >> 8 != 0)
-				tst_resm(TFAIL, "test 1 FAILED");
-			else
-				tst_resm(TPASS, "test 1 PASSED");
-		}
+	memset(reopen, 0, PATH_MAX);
+
+	tst_res(TINFO, "Opening files from parent");
+
+	for (nfiles = 0; nfiles < file_open_max; nfiles++) {
+		name_len = snprintf(name, PATH_MAX, "%s%lu", FILE_PREFIX, nfiles);
+		if (!nfiles)
+			memcpy(reopen, name, name_len);
 
-		/* clean up things in case we are looping */
-		for (nf = first; nf < nfiles; nf++) {
-			fclose(fildeses[nf]);
-			sprintf(filname, "file%d.%d", nf, mypid);
-			unlink(filname);
+		f = fopen(name, "a");
+		if (!f) {
+			/* raised if we reached OPEN_MAX */
+			if (errno == EMFILE)
+				break;
+
+			tst_brk(TBROK | TERRNO, "fopen() error");
 		}
+
+		open_files[nfiles] = f;
 	}
 
-	cleanup();
-	tst_exit();
+	totfiles = nfiles;
+
+	if (!totfiles)
+		tst_brk(TBROK, "Parent couldn't open any file");
+
+	tst_res(TINFO, "Closing %lu files from child", totfiles);
+
+	if (!SAFE_FORK()) {
+		SAFE_FCLOSE(open_files[0]);
+		open_files[0] = SAFE_FOPEN(reopen, "a");
+
+		for (nfiles = nfiles - 1; nfiles >= 0; nfiles--)
+			SAFE_FCLOSE(open_files[nfiles]);
+
+		_exit(0);
+	}
+
+	tst_reap_children();
+
+	tst_res(TPASS, "Child closed all parent's files");
+
+	for (nfiles = 0; nfiles < totfiles; nfiles++) {
+		snprintf(name, PATH_MAX, "%s%lu", FILE_PREFIX, nfiles);
+
+		SAFE_FCLOSE(open_files[nfiles]);
+		SAFE_UNLINK(name);
+	}
 }
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	umask(0);
-
-	TEST_PAUSE;
-	tst_tmpdir();
+	file_open_max = sysconf(_SC_OPEN_MAX);
+	open_files = SAFE_MALLOC(sizeof(FILE *) * file_open_max);
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	free(open_files);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
