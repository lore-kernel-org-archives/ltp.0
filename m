Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C01D2F000
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 12:51:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46B713CABE9
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 13:51:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7BED3CA152
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 13:50:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2FFE3600824
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 13:50:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC91B5BCFD;
 Tue, 27 Jan 2026 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769518210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJb5ugxX2f9GUxMgh7zNbSUkCEOTeRFUyFWZkp3SI/8=;
 b=u+yMx5Oflr8NHHTkFyaxz7z0F1NNe1ez0wuRSCanhBtQmy5zYwi6UT5Q03r8phnq/LDO61
 s3urz1VsWymKuOs9/27u6xL8MQUHoNNtiplEo5t4yFki0uGRXG6+cZXW6QirMaiq26PCBS
 o9WC18DwMJVg+478E5SVFXvhSiuxpuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769518210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJb5ugxX2f9GUxMgh7zNbSUkCEOTeRFUyFWZkp3SI/8=;
 b=ldHi7xzQBrhjUmYv/o/Tf3emi5pr2uNVIZ6CazSj0LwD7LDR+HwQFj4bWEb7FBJAjWi1QZ
 skmTCPOfxK1207Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u+yMx5Of;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ldHi7xzQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769518210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJb5ugxX2f9GUxMgh7zNbSUkCEOTeRFUyFWZkp3SI/8=;
 b=u+yMx5Oflr8NHHTkFyaxz7z0F1NNe1ez0wuRSCanhBtQmy5zYwi6UT5Q03r8phnq/LDO61
 s3urz1VsWymKuOs9/27u6xL8MQUHoNNtiplEo5t4yFki0uGRXG6+cZXW6QirMaiq26PCBS
 o9WC18DwMJVg+478E5SVFXvhSiuxpuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769518210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJb5ugxX2f9GUxMgh7zNbSUkCEOTeRFUyFWZkp3SI/8=;
 b=ldHi7xzQBrhjUmYv/o/Tf3emi5pr2uNVIZ6CazSj0LwD7LDR+HwQFj4bWEb7FBJAjWi1QZ
 skmTCPOfxK1207Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A77D83EA61;
 Tue, 27 Jan 2026 12:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4NJIJ4K0eGmaYwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 27 Jan 2026 12:50:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 27 Jan 2026 13:50:10 +0100
MIME-Version: 1.0
Message-Id: <20260127-fork_refactoring-v1-2-e3e21ff1a4f7@suse.com>
References: <20260127-fork_refactoring-v1-0-e3e21ff1a4f7@suse.com>
In-Reply-To: <20260127-fork_refactoring-v1-0-e3e21ff1a4f7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769518210; l=12050;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pdQlt3ZIBFC3mH72zFg6YUMPMGJlNy6xlMOVEF0EFu4=;
 b=dLEi16itIeZ3Gbc45fh9DiXCnVXUfc9XNnD9p7sgUhuVH2teTGNpqs8uub5FsxghManYSchEY
 c8Pb6YdTlJNB7B1SJc7lZv7u+sGgjC6vc9jwC4ZPrX/yLr0plFNBfYk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CC91B5BCFD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] syscalls: refactor vfork01 using new API
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
 testcases/kernel/syscalls/vfork/vfork01.c | 374 ++++--------------------------
 1 file changed, 45 insertions(+), 329 deletions(-)

diff --git a/testcases/kernel/syscalls/vfork/vfork01.c b/testcases/kernel/syscalls/vfork/vfork01.c
index b050776b7982e568f59b31547a6ebf72a1dba880..a681abe37b8cac7b6fdee4e2387db12cd548c698 100644
--- a/testcases/kernel/syscalls/vfork/vfork01.c
+++ b/testcases/kernel/syscalls/vfork/vfork01.c
@@ -1,352 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Name: vfork01
- *
- * Test Description:
- *  Fork a process using vfork() and verify that, the attribute values like
- *  euid, ruid, suid, egid, rgid, sgid, umask, inode and device number of
- *  root and current working directories are same as that of the parent
- *  process.
- * $
- * Expected Result:
- *  The attribute values like euid, ruid, suid, egid, rgid, sgid, umask, inode
- *  and device number of root and current working directory of the parent and
- *  child processes should be equal.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  vfork01 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,	-c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *  None.
- *
+/*\
+ * Fork a process using `vfork()` and verify that the attribute values like
+ * euid, ruid, suid, egid, rgid, sgid, umask, inode and device number of
+ * root and current working directories are the same of the parent
+ * process ones.
  */
 
-#define _GNU_SOURCE 1
-#include <stdio.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <unistd.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-
-#include "test.h"
-
-char *TCID = "vfork01";
-int TST_TOTAL = 1;
-
-/* Variables to hold parent/child eff/real/saved uid/gid values */
-uid_t Peuid, Ceuid, Csuid, Psuid, Pruid, Cruid;
-gid_t Pegid, Cegid, Psgid, Csgid, Prgid, Crgid;
-mode_t Pumask, Cumask;
-
-char *Pcwd, *Ccwd;		/*
-				 * pathname of working directory of
-				 * child/parent process.
-				 */
-/* stat structure to hold directory/inode information for parent/child */
-struct stat StatPbuf;
-struct stat StatCbuf;
-struct stat Stat_cwd_Pbuf;
-struct stat Stat_cwd_Cbuf;
+#include "tst_test.h"
+#include "tst_uid.h"
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-	pid_t cpid;		/* process id of the child process */
-	int exit_status;	/* exit status of child process */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	char *p_cwd, *c_cwd;
+	mode_t p_mask, c_mask;
+	static uid_t p_ruid, p_euid, p_suid;
+	static gid_t p_rgid, p_egid, p_sgid;
+	struct stat p_cwd_stat, c_cwd_stat;
+	struct stat p_root_stat, c_root_stat;
 
-		tst_count = 0;
+	p_mask = umask(0);
+	umask(p_mask);
 
-		/*
-		 * Call vfork(2) to create a child process without
-		 * fully copying the address space of parent.
-		 */
-		TEST(vfork());
+	p_cwd = getcwd(NULL, BUFSIZ);
 
-		if ((cpid = TEST_RETURN) == -1) {
-			tst_resm(TFAIL, "vfork() Failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else if (cpid == 0) {	/* Child process */
-			/*
-			 * Get the euid, ruid, egid, rgid, umask value
-			 * and the current working directory of the
-			 * child process
-			 */
-			if (getresuid(&Cruid, &Ceuid, &Csuid) < 0) {
-				tst_resm(TFAIL, "getresuid() fails to "
-					 "get real/eff./saved uid of "
-					 "child process");
-				_exit(1);
-			}
+	SAFE_GETRESUID(&p_ruid, &p_euid, &p_suid);
+	SAFE_GETRESGID(&p_rgid, &p_egid, &p_sgid);
 
-			if (getresgid(&Crgid, &Cegid, &Csgid) < 0) {
-				tst_resm(TFAIL, "getresgid() fails to "
-					 "get real/eff./saved gid of "
-					 "child process");
-				_exit(1);
-			}
+	SAFE_STAT(p_cwd, &p_cwd_stat);
+	SAFE_STAT("/", &p_root_stat);
 
-			/*
-			 * Get the file mode creation mask value of
-			 * child process by setting value zero and
-			 * restore the previous mask value.
-			 */
-			Cumask = umask(0);
+	if (!vfork()) {
+		c_mask = umask(0);
+		umask(c_mask);
 
-			/*
-			 * Restore the process mask of child to
-			 * previous value.
-			 */
-			umask(Cumask);
+		TST_EXP_EQ_LI(p_mask, c_mask);
 
-			/*
-			 * Get the pathname of current working
-			 * directory for the child process.
-			 */
-			if ((Ccwd = (char *)getcwd(NULL,
-						   BUFSIZ)) == NULL) {
-				tst_resm(TFAIL, "getcwd failed for the "
-					 "child process");
-				_exit(1);
-			}
+		c_cwd = getcwd(NULL, BUFSIZ);
+		SAFE_STAT(c_cwd, &c_cwd_stat);
 
-			/*
-			 * Get the device number and the inode
-			 * number of "/" directory for the child
-			 * process.
-			 */
-			if (stat("/", &StatCbuf) < 0) {
-				tst_resm(TFAIL, "stat(2) failed to get "
-					 "info. of'/' in the child "
-					 "process");
-				_exit(1);
-			}
+		TST_EXP_EQ_STR(p_cwd, c_cwd);
+		TST_EXP_EQ_LI(p_cwd_stat.st_ino, c_cwd_stat.st_ino);
+		TST_EXP_EQ_LI(p_cwd_stat.st_dev, c_cwd_stat.st_dev);
 
-			/*
-			 * Get the device/inode number of "."
-			 * (working directory) for the child process.
-			 */
-			if (stat(Ccwd, &Stat_cwd_Cbuf) < 0) {
-				tst_resm(TFAIL, "stat(2) failed to get "
-					 "info. of working irectory in "
-					 "the child");
-				_exit(1);
-			}
+		SAFE_STAT("/", &c_root_stat);
 
-			/* Now, do the actual comparision */
-			if (Peuid != Ceuid || Pegid != Cegid ||
-			    Psuid != Csuid || Psgid != Csgid ||
-			    Pruid != Cruid || Prgid != Crgid ||
-			    Pumask != Cumask) {
-				tst_resm(TFAIL, "Attribute values of "
-					 "parent and child don't match");
-				_exit(1);
-			} else {
-				tst_resm(TINFO, "Attribute values of "
-					 "parent and child match");
-			}
+		TST_EXP_EQ_LI(p_root_stat.st_ino, c_root_stat.st_ino);
+		TST_EXP_EQ_LI(p_root_stat.st_dev, c_root_stat.st_dev);
 
-			/* Check for the same working directories */
-			if (strcmp(Pcwd, Ccwd) != 0) {
-				tst_resm(TFAIL, "Working directories "
-					 "of parent and child don't "
-					 "match");
-				_exit(1);
-			} else {
-				tst_resm(TINFO, "Working directories "
-					 "of parent and child match");
-			}
+		if (tst_check_resuid("resuid()", p_ruid, p_euid, p_suid))
+			tst_res(TPASS, "Parent and child UID are matching");
 
-			/*
-			 * Check for the same device/inode number of
-			 * '/' directory.
-			 */
-			if ((StatPbuf.st_ino != StatCbuf.st_ino) ||
-			    (StatPbuf.st_dev != StatCbuf.st_dev)) {
-				tst_resm(TFAIL, "Device/inode number "
-					 "of parent and childs '/' "
-					 " don't match");
-				_exit(1);
-			} else {
-				tst_resm(TINFO, "Device/inode number "
-					 "of parent and childs '/' "
-					 "match");
-			}
+		if (tst_check_resgid("resgid()", p_rgid, p_egid, p_sgid))
+			tst_res(TPASS, "Parent and child GID are matching");
 
-			/*
-			 * Check for the same device and inode number
-			 *  of "." (current working directory.
-			 */
-			if ((Stat_cwd_Pbuf.st_ino !=
-			     Stat_cwd_Cbuf.st_ino) ||
-			    (Stat_cwd_Pbuf.st_dev !=
-			     Stat_cwd_Cbuf.st_dev)) {
-				tst_resm(TFAIL, "Device/inode number "
-					 "of parent and childs '.' "
-					 "don't match");
-				_exit(1);
-			} else {
-				tst_resm(TINFO, "Device/inode number "
-					 "of parent and childs '.' "
-					 "don't match");
-			}
-
-			/*
-			 * Exit with normal exit code if everything
-			 * fine
-			 */
-			_exit(0);
-
-		} else {	/* parent process */
-			/*
-			 * Let the parent process wait till child completes
-			 * its execution.
-			 */
-			wait(&exit_status);
-
-			/* Check for the exit status of child process */
-			if (WEXITSTATUS(exit_status) == 0) {
-				tst_resm(TPASS, "Call of vfork() successful");
-			} else if (WEXITSTATUS(exit_status) == 1) {
-				tst_resm(TFAIL,
-					 "Child process exited abnormally");
-			}
-		}
-		tst_count++;	/* incr. TEST_LOOP counter */
+		exit(0);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  This function gets real/effective/saved uid/gid, umask, the device/inode
- *  number of '/' and current working directory for the parent process.
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Get the euid, ruid, egid, rgid, umask value
-	 * and the current working directory of the parent process.
-	 */
-	if (getresuid(&Pruid, &Peuid, &Psuid) < 0) {
-		tst_brkm(TFAIL, cleanup, "getresuid() fails to get "
-			 "real/eff./saved uid of parent");
-	}
-
-	if (getresgid(&Prgid, &Pegid, &Psgid) < 0) {
-		tst_brkm(TFAIL, cleanup, "getresgid() fails to get "
-			 "real/eff./saved gid of parent");
-	}
-
-	/* Get the process file mode creation mask by setting value 0 */
-	Pumask = umask(0);
-	umask(Pumask);		/*
-				 * Restore the mask value of the
-				 * process.
-				 */
-	/*
-	 * Get the pathname of current working directory of the parent
-	 * process.
-	 */
-	if ((Pcwd = (char *)getcwd(NULL, BUFSIZ)) == NULL) {
-		tst_brkm(TFAIL, cleanup,
-			 "getcwd failed for the parent process");
-	}
-
-	/*
-	 * Get the device and inode number of root directory for the
-	 * parent process.
-	 */
-	if (stat("/", &StatPbuf) == -1) {
-		tst_brkm(TFAIL, cleanup, "stat(2) failed to get info. of '/' "
-			 "in parent process");
-	}
-
-	/*
-	 * Get the device number and the inode number of "." (current-
-	 * working directory) for the parent process.
-	 */
-	if (stat(Pcwd, &Stat_cwd_Pbuf) < 0) {
-		tst_brkm(TFAIL, cleanup, "stat(2) failed to get info. of "
-			 "working directory in parent process");
-	}
-}
-
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
