Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5962D597B7
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 23:36:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88DCC3D634F
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 00:36:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20D593D6338
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 00:35:58 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8A72C62949D
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 00:35:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B36B41F365;
 Tue, 12 Nov 2024 23:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731454557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GaHNNe3f/rXXQ65jVHuma+fGeXucOFZMCSn3suDb4AQ=;
 b=uvSgYdyB4o+qHZq8AK2EUwyvP80UBPS0y3+IlOjwnfBziBxnu2zWqnq7NZw7YUDfzf5okP
 F+g/SiNn3C2g7+HNw5n0qg4joxt43XxK+Lu/wznlaJI1XUb4Rtuo3kc/t1jWxnOGH1boDO
 gVoAwz3fS2DvF3f6bYRUKeiCWxAncQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731454557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GaHNNe3f/rXXQ65jVHuma+fGeXucOFZMCSn3suDb4AQ=;
 b=Nrjh+5mOOiIAWUr1iQAxLAL3HGP6gminBq7/vjEodaYYN/n3YHlqU/xyN0NeLw3bUmUvQi
 fUya5vpalrpS8vCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uvSgYdyB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Nrjh+5mO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731454557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GaHNNe3f/rXXQ65jVHuma+fGeXucOFZMCSn3suDb4AQ=;
 b=uvSgYdyB4o+qHZq8AK2EUwyvP80UBPS0y3+IlOjwnfBziBxnu2zWqnq7NZw7YUDfzf5okP
 F+g/SiNn3C2g7+HNw5n0qg4joxt43XxK+Lu/wznlaJI1XUb4Rtuo3kc/t1jWxnOGH1boDO
 gVoAwz3fS2DvF3f6bYRUKeiCWxAncQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731454557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GaHNNe3f/rXXQ65jVHuma+fGeXucOFZMCSn3suDb4AQ=;
 b=Nrjh+5mOOiIAWUr1iQAxLAL3HGP6gminBq7/vjEodaYYN/n3YHlqU/xyN0NeLw3bUmUvQi
 fUya5vpalrpS8vCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9934713721;
 Tue, 12 Nov 2024 23:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z7iXI13mM2fSFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Nov 2024 23:35:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 13 Nov 2024 00:35:52 +0100
Message-ID: <20241112233554.280518-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: B36B41F365
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] kcmp03: Use TST_EXP_PASS()
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/kcmp/kcmp03.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index 4ae6e02953..37d5118d55 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -30,14 +30,16 @@ static int pid1;
 static int pid2;
 static void *stack;
 
+#define ARGS(x, y) .clone_type = x, .kcmp_type = y, .desc = #x ", " #y
 static struct tcase {
 	int clone_type;
 	int kcmp_type;
+	char *desc;
 } tcases[] = {
-	{CLONE_VM, KCMP_VM},
-	{CLONE_FS, KCMP_FS},
-	{CLONE_IO, KCMP_IO},
-	{CLONE_SYSVSEM, KCMP_SYSVSEM}
+	{ARGS(CLONE_VM, KCMP_VM)},
+	{ARGS(CLONE_FS, KCMP_FS)},
+	{ARGS(CLONE_IO, KCMP_IO)},
+	{ARGS(CLONE_SYSVSEM, KCMP_SYSVSEM)}
 };
 
 static void setup(void)
@@ -53,28 +55,17 @@ static void cleanup(void)
 static int do_child(void *arg)
 {
 	pid2 = getpid();
-
-	TEST(kcmp(pid1, pid2, *(int *)arg, 0, 0));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
-		return 0;
-	}
-
-	if (TST_RET == 0)
-		tst_res(TPASS, "kcmp() returned the expected value");
-	else
-		tst_res(TFAIL, "kcmp() returned the unexpected value");
-
+	TST_EXP_PASS(kcmp(pid1, pid2, *(int *)arg, 0, 0));
 	return 0;
 }
 
 static void verify_kcmp(unsigned int n)
 {
 	int res;
-
 	struct tcase *tc = &tcases[n];
 
 	pid1 = getpid();
+	tst_res(TINFO, "Testing %s", tc->desc);
 
 	res = ltp_clone(tc->clone_type | SIGCHLD, do_child, &tc->kcmp_type,
 			STACK_SIZE, stack);
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
