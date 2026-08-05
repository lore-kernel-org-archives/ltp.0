Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D719C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:16:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CCD03E7152
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:16:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E6643E718A
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 685D920099A
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CDFD7F20D;
 Wed,  5 Aug 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AF2A779EE;
 Wed,  5 Aug 2026 15:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MPNKBXZTc2qsGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:15:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 17:14:46 +0200
Message-ID: <20260805151451.648990-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805151451.648990-1-pvorel@suse.cz>
References: <20260805151451.648990-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 0CDFD7F20D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/9] creat07: execve04: Remove version check,
 add linux-git
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

Kernel commit 2a010c412853 ("fs: don't block i_writecount during exec")
from 6.11-rc1 was reverted in 3b832035387f ("Revert "fs: don't block
i_writecount during exec"") in v6.13-rc1 and backported into v6.11.11
and v6.12.2. Due LTP "no hide kernel bugs" policy remove kernel version
limitation and add missing linux-git tag.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reported-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4 (replaced adding max_kver in previous versions).

 testcases/kernel/syscalls/creat/creat07.c   | 20 ++++++++---------
 testcases/kernel/syscalls/execve/execve04.c | 24 ++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index c7b85ee694..4a1282bb2f 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -6,6 +6,12 @@
 
 /*\
  * Check that :manpage:`creat(2)` sets ETXTBSY correctly.
+ *
+ * NOTE: write to executed file was allowed in 6.11-rc1:
+ * 2a010c412853 ("fs: don't block i_writecount during exec")
+ * but then reverted in v6.13-rc1:
+ * 3b832035387f ("Revert "fs: don't block i_writecount during exec""),
+ * backported into v6.11.11 and v6.12.2.
  */
 
 #include <sys/types.h>
@@ -47,20 +53,14 @@ static void verify_creat(void)
 	SAFE_WAITPID(pid, NULL, 0);
 }
 
-static void setup(void)
-{
-	if ((tst_kvercmp(6, 11, 0)) >= 0) {
-		tst_brk(TCONF, "Skipping test, write to executed file is "
-			"allowed since 6.11-rc1.\n"
-			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
-	}
-}
-
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = verify_creat,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "3b832035387ff508fdcf0fba66701afc78f79e3d"},
+		{}
+	},
 	.resource_files = (const char *const []) {
 		TEST_APP,
 		NULL
diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index 35ec882a07..314710a32d 100644
--- a/testcases/kernel/syscalls/execve/execve04.c
+++ b/testcases/kernel/syscalls/execve/execve04.c
@@ -9,8 +9,14 @@
  */
 
 /*\
- * Attempt to :manpage:`execve(2)` a file which is being opened by another process for
- * writing fails with ETXTBSY.
+ * Attempt to :manpage:`execve(2)` a file which is being opened by another
+ * process for writing fails with ETXTBSY.
+ *
+ * NOTE: write to executed file was allowed in 6.11-rc1:
+ * 2a010c412853 ("fs: don't block i_writecount during exec")
+ * but then reverted in v6.13-rc1:
+ * 3b832035387f ("Revert "fs: don't block i_writecount during exec""),
+ * backported into v6.11.11 and v6.12.2.
  */
 
 #define _GNU_SOURCE
@@ -62,21 +68,15 @@ static void do_child(void)
 	exit(0);
 }
 
-static void setup(void)
-{
-	if ((tst_kvercmp(6, 11, 0)) >= 0) {
-		tst_brk(TCONF, "Skipping test, write to executed file is "
-			"allowed since 6.11-rc1.\n"
-			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
-	}
-}
-
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = verify_execve,
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.needs_checkpoints = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "3b832035387ff508fdcf0fba66701afc78f79e3d"},
+		{}
+	},
 	.resource_files = (const char *const []) {
 		TEST_APP,
 		NULL
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
