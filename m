Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1415EF8FF4
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:03:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 409D83DC86E
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 16:03:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CCB93DC6D0
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:02:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1B58A200A0F
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:02:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD87E3F980;
 Wed,  4 Mar 2026 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772636548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kii7VOeRH0rgfOrmvAxqsl9L8KjokoiGtqTedjqJN5E=;
 b=LHplfzH5Pp4V7yW8f9HxB6OVeq1qN2lHy0TQO4IU9lXQmtXwLh07BdNNR9ipTY6Szi6qyi
 UGR4fH1V9+Zy4Z/kuzPoMLTEH7MqC4C1Xpf/xQCjeTWmLf2TGlsg1SZqOsh34Gng6GxTnb
 cNGxZR23Cw4ymkaqR9lWbcDnRSU5S+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772636548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kii7VOeRH0rgfOrmvAxqsl9L8KjokoiGtqTedjqJN5E=;
 b=YtSQzPOFe6X1hjBKfIO/kcy55FgJqRKZciNruOf4hgLdfCsANAhjAGzvI2dES8YKfSTjZ/
 bdWZPIz9KrnmZACQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s390Zyws;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=st3lbA4Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772636547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kii7VOeRH0rgfOrmvAxqsl9L8KjokoiGtqTedjqJN5E=;
 b=s390ZywsKoBf/fOKfKjx0C/Jm7wn7ISOHp0q0kgofBtWxKBgBHlvYxL5M1K1Bld4uTFMe1
 rpmieI67ff3pBTA7Gsb45FM3p3vykN5KdHsUro8PI4QiLSJJ1FEU4qs49ogHGlTprClAID
 eP68x5EAVzLF9zFPZtbuThqVWducPA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772636547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kii7VOeRH0rgfOrmvAxqsl9L8KjokoiGtqTedjqJN5E=;
 b=st3lbA4ZbVLzLfuTzxcXbn3fgSlgK1Xpp5HNfe4FHuKpaN/+21IjMSZ9sxOrqIz4ogUaX6
 B9PigC7AWqQ5uOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93A853EA6D;
 Wed,  4 Mar 2026 15:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QM78IYNJqGkJNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 04 Mar 2026 15:02:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 04 Mar 2026 16:02:27 +0100
MIME-Version: 1.0
Message-Id: <20260304-fork_refactoring-v2-2-016c47c90bc1@suse.com>
References: <20260304-fork_refactoring-v2-0-016c47c90bc1@suse.com>
In-Reply-To: <20260304-fork_refactoring-v2-0-016c47c90bc1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772636547; l=12123;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=GdDurEzjseAvTjmP0zpDAiLdVdiqHCOWyq4QkfBwg48=;
 b=IjAL+a0sB+qUSPhWBYnZvJxt+zV2XqvBzNeR/tt9TwlUj+sJF9fg3172zMvgsVqJkvgvOLRYg
 s4ukb1vfVnFDf9QMU4hE2kPl1xg1laQO6DEu+PpYPBJhZSJD+6pKGxg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BD87E3F980
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] syscalls: refactor vfork01 using new API
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
 testcases/kernel/syscalls/vfork/vfork01.c | 375 ++++--------------------------
 1 file changed, 49 insertions(+), 326 deletions(-)

diff --git a/testcases/kernel/syscalls/vfork/vfork01.c b/testcases/kernel/syscalls/vfork/vfork01.c
index b050776b7982e568f59b31547a6ebf72a1dba880..b36d48e586a2954bc022dd46c843f19d74b50a80 100644
--- a/testcases/kernel/syscalls/vfork/vfork01.c
+++ b/testcases/kernel/syscalls/vfork/vfork01.c
@@ -1,352 +1,75 @@
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
+#include "tst_test.h"
+#include "tst_uid.h"
 
-char *Pcwd, *Ccwd;		/*
-				 * pathname of working directory of
-				 * child/parent process.
-				 */
-/* stat structure to hold directory/inode information for parent/child */
-struct stat StatPbuf;
-struct stat StatCbuf;
-struct stat Stat_cwd_Pbuf;
-struct stat Stat_cwd_Cbuf;
-
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
-
-		tst_count = 0;
-
-		/*
-		 * Call vfork(2) to create a child process without
-		 * fully copying the address space of parent.
-		 */
-		TEST(vfork());
-
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
-
-			if (getresgid(&Crgid, &Cegid, &Csgid) < 0) {
-				tst_resm(TFAIL, "getresgid() fails to "
-					 "get real/eff./saved gid of "
-					 "child process");
-				_exit(1);
-			}
-
-			/*
-			 * Get the file mode creation mask value of
-			 * child process by setting value zero and
-			 * restore the previous mask value.
-			 */
-			Cumask = umask(0);
-
-			/*
-			 * Restore the process mask of child to
-			 * previous value.
-			 */
-			umask(Cumask);
-
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
+	char *p_cwd, *c_cwd;
+	mode_t p_mask, c_mask;
+	static uid_t p_ruid, p_euid, p_suid;
+	static gid_t p_rgid, p_egid, p_sgid;
+	struct stat p_cwd_stat, c_cwd_stat;
+	struct stat p_root_stat, c_root_stat;
 
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
+	p_mask = umask(0);
+	umask(p_mask);
 
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
+	p_cwd = getcwd(NULL, BUFSIZ);
 
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
+	SAFE_GETRESUID(&p_ruid, &p_euid, &p_suid);
+	SAFE_GETRESGID(&p_rgid, &p_egid, &p_sgid);
 
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
+	SAFE_STAT(p_cwd, &p_cwd_stat);
+	SAFE_STAT("/", &p_root_stat);
 
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
+	if (!vfork()) {
+		c_mask = umask(0);
+		umask(c_mask);
 
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
+		TST_EXP_EQ_LI(p_mask, c_mask);
 
-			/*
-			 * Exit with normal exit code if everything
-			 * fine
-			 */
-			_exit(0);
+		c_cwd = getcwd(NULL, BUFSIZ);
+		SAFE_STAT(c_cwd, &c_cwd_stat);
 
-		} else {	/* parent process */
-			/*
-			 * Let the parent process wait till child completes
-			 * its execution.
-			 */
-			wait(&exit_status);
+		TST_EXP_EQ_STR(p_cwd, c_cwd);
+		free(c_cwd);
 
-			/* Check for the exit status of child process */
-			if (WEXITSTATUS(exit_status) == 0) {
-				tst_resm(TPASS, "Call of vfork() successful");
-			} else if (WEXITSTATUS(exit_status) == 1) {
-				tst_resm(TFAIL,
-					 "Child process exited abnormally");
-			}
-		}
-		tst_count++;	/* incr. TEST_LOOP counter */
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  This function gets real/effective/saved uid/gid, umask, the device/inode
- *  number of '/' and current working directory for the parent process.
- */
-void setup(void)
-{
+		TST_EXP_EQ_LI(p_cwd_stat.st_ino, c_cwd_stat.st_ino);
+		TST_EXP_EQ_LI(p_cwd_stat.st_dev, c_cwd_stat.st_dev);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+		SAFE_STAT("/", &c_root_stat);
 
-	TEST_PAUSE;
+		TST_EXP_EQ_LI(p_root_stat.st_ino, c_root_stat.st_ino);
+		TST_EXP_EQ_LI(p_root_stat.st_dev, c_root_stat.st_dev);
 
-	/*
-	 * Get the euid, ruid, egid, rgid, umask value
-	 * and the current working directory of the parent process.
-	 */
-	if (getresuid(&Pruid, &Peuid, &Psuid) < 0) {
-		tst_brkm(TFAIL, cleanup, "getresuid() fails to get "
-			 "real/eff./saved uid of parent");
-	}
+		if (tst_check_resuid("resuid()", p_ruid, p_euid, p_suid))
+			tst_res(TPASS, "Parent and child UID are matching");
 
-	if (getresgid(&Prgid, &Pegid, &Psgid) < 0) {
-		tst_brkm(TFAIL, cleanup, "getresgid() fails to get "
-			 "real/eff./saved gid of parent");
-	}
+		if (tst_check_resgid("resgid()", p_rgid, p_egid, p_sgid))
+			tst_res(TPASS, "Parent and child GID are matching");
 
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
+		_exit(0);
 	}
 
-	/*
-	 * Get the device and inode number of root directory for the
-	 * parent process.
-	 */
-	if (stat("/", &StatPbuf) == -1) {
-		tst_brkm(TFAIL, cleanup, "stat(2) failed to get info. of '/' "
-			 "in parent process");
-	}
+	tst_reap_children();
 
-	/*
-	 * Get the device number and the inode number of "." (current-
-	 * working directory) for the parent process.
-	 */
-	if (stat(Pcwd, &Stat_cwd_Pbuf) < 0) {
-		tst_brkm(TFAIL, cleanup, "stat(2) failed to get info. of "
-			 "working directory in parent process");
-	}
+	if (p_cwd)
+		free(p_cwd);
 }
 
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
