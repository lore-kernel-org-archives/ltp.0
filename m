Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEAAC001DB
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 11:57:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6241E3CDA8C
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 13:57:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58D303CD0C4
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A2D01A00691
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B9ADF21857
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691754950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wC3ZUdZh0vVGXLdWguBL5fCPThnlVJF06DZ1YqPjWX4=;
 b=IyWhZHCx0yO22pTQCyKkGAMNSUebdASN2n+Q8yYpSCsACxH2RomUwlGo3zDRVUuLJNCDfr
 c10IRjuJxITZaJeTuR92Mgqo9mDukfUGqfwDjeszi1R2jxPdaVpzXb1s43p6HRko2obZx9
 kEv6EjHTBc0QFhNkGjdHbQgQ0ZtOj48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691754950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wC3ZUdZh0vVGXLdWguBL5fCPThnlVJF06DZ1YqPjWX4=;
 b=Uax4m9MLgpBobzLR3k4vfV8vMAcXDMHPDTKwUk9rh5IilkfftEufNXzecAGfFgk+IxCuys
 Kmc+0EFGhcut3AAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55024138E2
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NoNjCcYh1mQRWwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:50 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Aug 2023 13:56:47 +0200
Message-ID: <20230811115647.32387-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811115647.32387-1-chrubis@suse.cz>
References: <20230811115647.32387-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] syscalls/chroot03: Make use of guarded buffers
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/chroot/chroot03.c | 46 ++++++++++++---------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/chroot/chroot03.c b/testcases/kernel/syscalls/chroot/chroot03.c
index ba8c1e9ac..87faec316 100644
--- a/testcases/kernel/syscalls/chroot/chroot03.c
+++ b/testcases/kernel/syscalls/chroot/chroot03.c
@@ -25,41 +25,42 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-static char fname[255];
-static char nonexistent_dir[100] = "testdir";
-static char bad_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
-static char symbolic_dir[] = "sym_dir1";
+#define FILE_NAME "test_file"
+#define LOOP_DIR "sym_dir1"
+#define NONEXISTENT_DIR "does_not_exist"
+
+static char *longname_dir;
+static char *file_name;
+static char *nonexistent_dir;
+static char *bad_ptr;
+static char *loop_dir;
 
 static struct tcase {
-	char *dir;
+	char **dir;
 	int error;
 	char *desc;
 } tcases[] = {
-	{bad_dir, ENAMETOOLONG, "chroot(longer than VFS_MAXNAMELEN)"},
-	{fname, ENOTDIR, "chroot(not a directory)"},
-	{nonexistent_dir, ENOENT, "chroot(does not exists)"},
-	{(char *)-1, EFAULT, "chroot(an invalid address)"},
-	{symbolic_dir, ELOOP, "chroot(symlink loop)"}
+	{&longname_dir, ENAMETOOLONG, "chroot(longer than VFS_MAXNAMELEN)"},
+	{&file_name, ENOTDIR, "chroot(not a directory)"},
+	{&nonexistent_dir, ENOENT, "chroot(does not exists)"},
+	{&bad_ptr, EFAULT, "chroot(an invalid address)"},
+	{&loop_dir, ELOOP, "chroot(symlink loop)"}
 };
 
 static void verify_chroot(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TST_EXP_FAIL(chroot(tc->dir), tc->error, "%s", tc->desc);
+	TST_EXP_FAIL(chroot(*tc->dir), tc->error, "%s", tc->desc);
 }
 
 static void setup(void)
 {
-	unsigned int i;
-
-	(void)sprintf(fname, "tfile_%d", getpid());
-	SAFE_TOUCH(fname, 0666, NULL);
+	SAFE_TOUCH(FILE_NAME, 0666, NULL);
+	bad_ptr = tst_get_bad_addr(NULL);
 
-	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
-		if (tcases[i].error == EFAULT)
-			tcases[3].dir = tst_get_bad_addr(NULL);
-	}
+	memset(longname_dir, 'a', PATH_MAX + 1);
+	longname_dir[PATH_MAX+1] = 0;
 
 	SAFE_SYMLINK("sym_dir1/", "sym_dir2");
 	SAFE_SYMLINK("sym_dir2/", "sym_dir1");
@@ -70,4 +71,11 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_chroot,
 	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&file_name, .str = FILE_NAME},
+		{&nonexistent_dir, .str = NONEXISTENT_DIR},
+		{&loop_dir, .str = LOOP_DIR},
+		{&longname_dir, .size = PATH_MAX+2},
+		{}
+	}
 };
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
