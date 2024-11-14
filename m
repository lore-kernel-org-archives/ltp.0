Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4ABD6A220
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 17:29:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CE8F3D708A
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 18:29:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE7393C6389
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 18:29:18 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D40D1011779
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 18:29:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 019B72111F;
 Thu, 14 Nov 2024 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731605355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+EC96O7l6T5s0dexJewpTWlQcDuJJeY4SeO+eGpZES0=;
 b=L/FplQtGSo6c6xR6/zu2QwSQV6Zwq8DlWnB4LYRsSrErJuQYINCCaoNXKfZXVCRJb+xw3N
 q8a1JjLXLPtaYpvp2+vGNPUnU9e3A5zEAYaGT1q0mmfm2BhALNqO+Q5BNpPcvyUpzi17Ii
 QbTE8+yK4WYmmlfR6woFWuTOuBz5BOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731605355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+EC96O7l6T5s0dexJewpTWlQcDuJJeY4SeO+eGpZES0=;
 b=QIHp9dtVzvrTWvTeNpAV7LK6xmw1caRMOCYkc0qiI8QJmX2osj5QVgkNICldFKTsm6kBRj
 MOWpjbv+TZbNZaCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="L/FplQtG";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QIHp9dtV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731605355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+EC96O7l6T5s0dexJewpTWlQcDuJJeY4SeO+eGpZES0=;
 b=L/FplQtGSo6c6xR6/zu2QwSQV6Zwq8DlWnB4LYRsSrErJuQYINCCaoNXKfZXVCRJb+xw3N
 q8a1JjLXLPtaYpvp2+vGNPUnU9e3A5zEAYaGT1q0mmfm2BhALNqO+Q5BNpPcvyUpzi17Ii
 QbTE8+yK4WYmmlfR6woFWuTOuBz5BOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731605355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+EC96O7l6T5s0dexJewpTWlQcDuJJeY4SeO+eGpZES0=;
 b=QIHp9dtVzvrTWvTeNpAV7LK6xmw1caRMOCYkc0qiI8QJmX2osj5QVgkNICldFKTsm6kBRj
 MOWpjbv+TZbNZaCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B71FE13794;
 Thu, 14 Nov 2024 17:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oIx1KmozNmf7MQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 17:29:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Nov 2024 18:29:11 +0100
Message-ID: <20241114172911.362197-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 019B72111F
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ioctl01: Workaround segfault on ppc64le
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

Testing termio/termios invalid/NULL address for EFAULT fails on ppc64le.
Use typical LTP workaround to test by forked child + checking the
terminating signal (on all archs).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 45 ++++++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index c84a72b9a2..e4f32330d0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2020 Petr Vorel <petr.vorel@gmail.com>
- * Copyright (c) Linux Test Project, 2002-2023
+ * Copyright (c) Linux Test Project, 2002-2024
  * 07/2001 Ported by Wayne Boyer
  * 04/2002 Fixes by wjhuie
  */
@@ -59,8 +59,42 @@ static struct tcase {
 
 static void verify_ioctl(unsigned int i)
 {
-	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
-		     tcases[i].error, "%s", tcases[i].desc);
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(ioctl(*(tc->fd), tc->request, tc->s_tio), tc->error, "%s",
+		     tc->desc);
+}
+
+static void test_bad_addr(unsigned int i)
+{
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		verify_ioctl(i);
+		_exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status) && !WEXITSTATUS(status))
+		return;
+
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "Child killed by expected signal");
+		return;
+	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
+}
+
+static void do_test(unsigned int i)
+{
+	if (tcases[i].error == EFAULT)
+		test_bad_addr(i);
+	else
+		verify_ioctl(i);
 }
 
 static void setup(void)
@@ -86,6 +120,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test = verify_ioctl,
-	.tcnt = ARRAY_SIZE(tcases)
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
 };
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
