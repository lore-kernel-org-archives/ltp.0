Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D61C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 13:24:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FAAE3C8A4B
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 14:24:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 067473C8AFF
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 14:23:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 03FED600292
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 14:23:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F297D1F3BE;
 Mon, 13 Dec 2021 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639401830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2D/01UJbk+D3t2qjZApB6fOpbUQBZ8bzaTyBVahbNQc=;
 b=w46mr8EZou74yLvhCKMYstugwDqDoFeL5mzYor20Jg6Ce7hb1BQ6OCP4SIX+2gtd7gVw9p
 1TG9upgMHzGzPwXEJXaWJozU9rUIDO3uGqkAHjqHDaJACwnzZLYIrbzQzBj2ZU3zOQ8/T5
 iZrjEO6v3U/kfhAHzW9CvgCAxoap78Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639401830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2D/01UJbk+D3t2qjZApB6fOpbUQBZ8bzaTyBVahbNQc=;
 b=UgNnuSVHCUg1EUclKXnscXrusbn6IJUk601RavhTLU7NejN4rObgim+8x3ph141TTJO2io
 M3jCT9t7ZryiYEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6A5613AFF;
 Mon, 13 Dec 2021 13:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hbNGKmZJt2GLDQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Dec 2021 13:23:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 13 Dec 2021 14:23:38 +0100
Message-Id: <20211213132339.22770-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] chdir01.c: Fix on enabled FIPS
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

which causes 0 permission for user and group.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/chdir/chdir01.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index aa25adf6aa..5819998484 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -27,7 +27,7 @@
 #define LINK_NAME2 "symloop2"
 
 static char *workdir;
-static int skip_symlinks, skip_blocked;
+static int skip_symlinks, blocked_perm;
 static struct passwd *ltpuser;
 
 static struct test_case {
@@ -61,9 +61,9 @@ static void setup(void)
 	SAFE_MKDIR(BLOCKED_NAME, 0644);
 	umask(sys_umask);
 
-	/* FAT and NTFS override file and directory permissions */
 	SAFE_STAT(BLOCKED_NAME, &statbuf);
-	skip_blocked = statbuf.st_mode & 0111;
+	blocked_perm = statbuf.st_mode;
+
 	skip_symlinks = 0;
 	TEST(symlink(LINK_NAME1, LINK_NAME2));
 
@@ -117,7 +117,15 @@ static void run(unsigned int n)
 	TEST(chdir(tc->name));
 	check_result("root", tc->name, tc->root_ret, tc->root_err);
 
-	if (tc->nobody_err == EACCES && skip_blocked) {
+	/* FIPS mode disables umask efect for group or other */
+	if (!(blocked_perm & S_IRGRP) && strcmp(tc->name, "/") != 0) {
+		tst_res(TCONF, "Skipping unprivileged permission test, "
+			"no read permission for \"%s\"", tc->name);
+		return;
+	}
+
+	/* FAT and NTFS override file and directory permissions */
+	if (blocked_perm & 0111 && tc->nobody_err == EACCES) {
 		tst_res(TCONF, "Skipping unprivileged permission test, "
 			"FS mangles dir mode");
 		return;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
