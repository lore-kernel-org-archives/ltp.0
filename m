Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4FEC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 15:15:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 881EA3C9EDB
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:15:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D55C73C9E0D
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:14:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D4C511401269
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:14:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 211B121100;
 Thu, 10 Feb 2022 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644506090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pALMK8Z/Vw/vyiyuBW+fdFAYz9h+wB0efX+TXViHr0w=;
 b=RGgu9bvk2CzrjG+Hawf8vAvHq+ZMPJyp6MvUv6Xs3+QFVVZEzm83p9lEFTvjIi78UQ7lYe
 rcPBHJRpmjlb5IYcspALmmrE4m7ODgz9VhdqM5iTe3ROKbOr94oTr70yWKuMYIfbOuYWBA
 1iNEhS6o6agUqXseMPP9U47bcqJVW3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644506090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pALMK8Z/Vw/vyiyuBW+fdFAYz9h+wB0efX+TXViHr0w=;
 b=0Oq8DztDPTLQ/00t98w9Z/qiFJgNGRP5ilbYgDMlkTVDK4Qkpn6UczP12GZ3ytC8lip1wq
 wFHg9w+VjfiIebDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC29F13BD6;
 Thu, 10 Feb 2022 15:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HLWuN+krBWKACwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Feb 2022 15:14:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 16:14:48 +0100
Message-Id: <20220210151448.18394-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Refactoring mmap16.c test using new LTP API
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

Removed TST_CHECKPOINT_INIT and replaced it with the .needs_checkpoints
LTP test feature. Simplified source code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap16.c | 328 ++++++++++--------------
 1 file changed, 134 insertions(+), 194 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index 0d1fc3e96..a892051ac 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -1,196 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) 2015 Fujitsu Ltd.
- *   Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
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
+ * Copyright (c) 2015 Fujitsu Ltd. Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * This is a regression test for commit:
- * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
- * commit/?id=90a8020
- * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
- * commit/?id=d6320cb
+/*\
+ * [Description]
+ *
+ * This is a regression test for commits:
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0572639ff66dcffe62d37adfe4c4576f9fc398f4
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6320cbfc92910a3e5f10c42d98c231c98db4f60
  */
 
 #define _GNU_SOURCE
 
-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <unistd.h>
-#include <sys/mount.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <time.h>
 #include <sys/mman.h>
+#include <sys/wait.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-#define MNTPOINT	"mntpoint"
-#define FS_BLOCKSIZE	1024
-#define SUB_LOOPCOUNT	10
-
-static void setup(void);
-static void cleanup(void);
-static void do_child(void);
-static void do_test(void);
-
-static const char *device;
-static const char *fs_type = "ext4";
-static int mount_flag;
-static int chdir_flag;
-static int parentfd = -1;
+#define MNTPOINT "mntpoint"
+#define FILE_PARENT "mntpoint/testfilep"
+#define FILE_CHILD "mntpoint/testfilec"
+#define FS_BLOCKSIZE 1024
 
 static int page_size;
-static int bug_reproduced;
-
-char *TCID = "mmap16";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/*
-	 * If child process was killed by SIGBUS, indeed that can not guarantee
-	 * this bug must have been fixed, If we're luckily enough, virtual
-	 * memory subsystem happen to decide that it is time to write dirty
-	 * pages, it will make mapped pages write-protect, so ->page_mkwrite()
-	 * still will be called, child process will be killed by SIGBUS, but
-	 * it's not because of above fixing patches. So here we run this test
-	 * 10 times, if once, child process exits normally, we can sure that
-	 * this bug is not fixed.
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < SUB_LOOPCOUNT; i++)
-			do_test();
-	}
-
-	if (bug_reproduced)
-		tst_resm(TFAIL, "Bug is reproduced!");
-	else
-		tst_resm(TPASS, "Bug is not reproduced!");
-
-	cleanup();
-	tst_exit();
-}
-
-static void do_test(void)
-{
-	int ret, status;
-	pid_t child;
-	char buf[FS_BLOCKSIZE];
-
-	SAFE_TOUCH(cleanup, "testfilep", 0644, NULL);
-	SAFE_TOUCH(cleanup, "testfilec", 0644, NULL);
-
-	child = tst_fork();
-	switch (child) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
-	case 0:
-		do_child();
-	default:
-		parentfd = SAFE_OPEN(cleanup, "testfilep", O_RDWR);
-		memset(buf, 'a', FS_BLOCKSIZE);
-
-		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
-		while (1) {
-			ret = write(parentfd, buf, FS_BLOCKSIZE);
-			if (ret < 0) {
-				if (errno == ENOSPC) {
-					break;
-				} else {
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "write failed unexpectedly");
-				}
-			}
-		}
-		SAFE_CLOSE(cleanup, parentfd);
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-	}
-
-	wait(&status);
-	if (WIFEXITED(status) && WEXITSTATUS(status) == 1) {
-		bug_reproduced = 1;
-	} else {
-		/*
-		 * If child process was killed by SIGBUS, bug is not reproduced.
-		 */
-		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGBUS) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "child process terminate unexpectedly");
-		}
-	}
-
-	SAFE_UNLINK(cleanup, "testfilep");
-	SAFE_UNLINK(cleanup, "testfilec");
-}
-
-static void setup(void)
-{
-	const char *fs_opts[3] = {"-b", "1024", NULL};
-	const char *extra_opts[] = {"10240", NULL};
-
-	tst_sig(FORK, DEF_HANDLER, NULL);
-	tst_require_root();
-
-	TEST_PAUSE;
-	tst_tmpdir();
-
-	TST_CHECKPOINT_INIT(tst_rmdir);
-
-	page_size = getpagesize();
-
-	device = tst_acquire_device(cleanup);
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-	tst_mkfs(cleanup, device, fs_type, fs_opts, extra_opts);
-
-	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
-	/*
-	 * Disable ext4 delalloc feature, so block will be allocated
-	 * as soon as possible
-	 */
-	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, "nodelalloc");
-	mount_flag = 1;
-
-	SAFE_CHDIR(cleanup, MNTPOINT);
-	chdir_flag = 1;
-
-}
+static int parentfd = -1;
+static int childfd = -1;
 
 static void do_child(void)
 {
-	int fd, offset;
+	int offset;
+	int page_size;
 	char buf[FS_BLOCKSIZE];
 	char *addr = NULL;
 
-	/*
-	 * We have changed SIGBUS' handler in parent process by calling
-	 * tst_sig(FORK, DEF_HANDLER, NULL), so here just restore it.
-	 */
-	if (signal(SIGBUS, SIG_DFL) == SIG_ERR)
-		tst_brkm(TBROK | TERRNO, NULL, "signal(SIGBUS) failed");
+	page_size = getpagesize();
+
+	childfd = SAFE_OPEN(FILE_CHILD, O_RDWR | O_CREAT, 0666);
 
 	memset(buf, 'a', FS_BLOCKSIZE);
-	fd = SAFE_OPEN(NULL, "testfilec", O_RDWR);
-	SAFE_WRITE(NULL, 1, fd, buf, FS_BLOCKSIZE);
+	SAFE_WRITE(1, childfd, buf, FS_BLOCKSIZE);
 
 	/*
 	 * In case mremap() may fail because that memory area can not be
@@ -198,19 +50,19 @@ static void do_child(void)
 	 * we first do a mmap(page_size * 2) operation to reserve some
 	 * free address space.
 	 */
-	addr = SAFE_MMAP(NULL, NULL, page_size * 2, PROT_WRITE | PROT_READ,
-			 MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, -1, 0);
-	SAFE_MUNMAP(NULL, addr, page_size * 2);
+	addr = SAFE_MMAP(NULL, page_size * 2, PROT_WRITE | PROT_READ,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(addr, page_size * 2);
 
-	addr = SAFE_MMAP(NULL, addr, FS_BLOCKSIZE, PROT_WRITE | PROT_READ,
-			 MAP_SHARED, fd, 0);
+	addr = SAFE_MMAP(addr, FS_BLOCKSIZE, PROT_WRITE | PROT_READ, MAP_SHARED, childfd, 0);
 
 	addr[0] = 'a';
 
-	SAFE_FTRUNCATE(NULL, fd, page_size * 2);
+	SAFE_FTRUNCATE(childfd, page_size * 2);
+
 	addr = mremap(addr, FS_BLOCKSIZE, 2 * page_size, 0);
 	if (addr == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, NULL, "mremap failed unexpectedly");
+		tst_brk(TBROK | TERRNO, "mremap failed unexpectedly");
 
 	/*
 	 * Let parent process consume FS free blocks as many as possible, then
@@ -220,26 +72,114 @@ static void do_child(void)
 	 * if not, the data 'A', 'B', 'C' will be silently discarded later when
 	 * kernel writepage is called, that means data corruption.
 	 */
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
-	TST_SAFE_CHECKPOINT_WAIT2(NULL, 0, 60*1000);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	for (offset = FS_BLOCKSIZE; offset < page_size; offset += FS_BLOCKSIZE)
 		addr[offset] = 'a';
 
-	SAFE_MUNMAP(NULL, addr, 2 * page_size);
-	SAFE_CLOSE(NULL, fd);
-	exit(TFAIL);
+	SAFE_MUNMAP(addr, 2 * page_size);
+	SAFE_CLOSE(childfd);
+
+	exit(1);
+}
+
+static void run(void)
+{
+	int ret, status;
+	pid_t child;
+	char buf[FS_BLOCKSIZE];
+	int bug_reproduced = 0;
+
+	child = SAFE_FORK();
+	if (!child) {
+		do_child();
+		return;
+	}
+
+	parentfd = SAFE_OPEN(FILE_PARENT, O_RDWR | O_CREAT, 0666);
+
+	memset(buf, 'a', FS_BLOCKSIZE);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	while (1) {
+		ret = write(parentfd, buf, FS_BLOCKSIZE);
+		if (ret < 0) {
+			if (errno == ENOSPC)
+				break;
+
+			tst_brk(TBROK | TERRNO, "write failed unexpectedly");
+		}
+	}
+
+	SAFE_CLOSE(parentfd);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	SAFE_WAITPID(child, &status, 0);
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 1) {
+		bug_reproduced = 1;
+	} else {
+		/*
+		 * If child process was killed by SIGBUS, bug is not reproduced.
+		 */
+		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGBUS) {
+			tst_brk(TBROK | TERRNO, "child process terminate unexpectedly with status %s",
+				tst_strstatus(status));
+		}
+	}
+
+	SAFE_UNLINK(FILE_PARENT);
+	SAFE_UNLINK(FILE_CHILD);
+
+	if (bug_reproduced)
+		tst_res(TFAIL, "bug is reproduced");
+	else
+		tst_res(TPASS, "bug is not reproduced");
 }
 
 static void cleanup(void)
 {
+	if (childfd >= 0)
+		SAFE_CLOSE(childfd);
+
 	if (parentfd >= 0)
-		close(parentfd);
-	if (chdir_flag && chdir(".."))
-		tst_resm(TWARN | TERRNO, "chdir('..') failed");
-	if (mount_flag && tst_umount(MNTPOINT) < 0)
-		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
-	if (device)
-		tst_release_device(device);
-	tst_rmdir();
+		SAFE_CLOSE(parentfd);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_device = 1,
+	.needs_checkpoints = 1,
+	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.dev_fs_type = "ext4",
+	.dev_fs_opts =
+		(const char *const[]){
+			"-b",
+			"1024",
+			NULL,
+		},
+	.dev_extra_opts =
+		(const char *const[]){
+			"10240",
+			NULL,
+		},
+	.needs_cmds =
+		(const char *const[]){
+			"mkfs.ext4",
+			NULL,
+		},
+	.tags =
+		(const struct tst_tag[]){
+			{ "linux-git",
+			  "d6320cbfc92910a3e5f10c42d98c231c98db4f60" },
+			{ "linux-git",
+			  "0572639ff66dcffe62d37adfe4c4576f9fc398f4" },
+			{},
+		},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
