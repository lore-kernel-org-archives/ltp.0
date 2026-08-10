Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432EFC5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:03:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 897A43D03B0
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:03:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16B5B3D04D2
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 758C760071F
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E8E63E1E;
 Mon, 10 Aug 2026 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJaD9S2Fp3wXTPqx1k4HsaUvGAv335+BsFYFtRKi3Ds=;
 b=fn7I3CkVlSSGas746MMtqhi4crtXi2nisumeNEIxvELoaYLcYRhdBFvHCfvXKFR+EJNdqs
 5UHTzE12+hv2FN1t9DBwS2WF2SdrYRcb9PaqDUrs/HPnE8xumH9cd+8LkkzPwzd7tJcWLR
 H2YC2gERp0+zTYa8rNPVecneEz0uF1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJaD9S2Fp3wXTPqx1k4HsaUvGAv335+BsFYFtRKi3Ds=;
 b=5/FkhYHN+JW/vbnBYmLMLFNA84X2S1ORNIKfHJrbwLSIrkXEiY3Abed9Cmfl9papRVnpsG
 BNCQEZuqkrCNPvBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X7jfjndO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0ThAIOwH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJaD9S2Fp3wXTPqx1k4HsaUvGAv335+BsFYFtRKi3Ds=;
 b=X7jfjndOeXKK6Ok0twEMcRWnipJhiCCrOQ7vKUPTyL+/GdDQUyYpg5T6W2Rck0Gh+w+hn8
 WH6P4EG9gpTB6q1Mw17Q1wXUOWnqGmdZCro4e4/uSfHOuET9mLvoxEy5PuNbgnJrMumh59
 zCP5IrNQ7F+AiC/BoYpKB5F9r5mSiw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJaD9S2Fp3wXTPqx1k4HsaUvGAv335+BsFYFtRKi3Ds=;
 b=0ThAIOwHG9biiLsTLDuCrL+/J89WhRe49z1r6rNtUBd4D0wcd5rV02sVuqUzA6C0O8S8Sj
 NvNUN4BFqgvAP1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82750779C3;
 Mon, 10 Aug 2026 16:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KNTkHrP1eWquLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 16:00:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Aug 2026 18:00:46 +0200
Message-ID: <20260810160048.1040517-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810160048.1040517-1-pvorel@suse.cz>
References: <20260810160048.1040517-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 1E8E63E1E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/7] creat07: execve04: Remove version check,
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
The same as in v4.

 testcases/kernel/syscalls/creat/creat07.c   | 20 ++++++++---------
 testcases/kernel/syscalls/execve/execve04.c | 24 ++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index 1de1b46621..92ff7d2682 100644
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
@@ -48,20 +54,14 @@ kill:
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
