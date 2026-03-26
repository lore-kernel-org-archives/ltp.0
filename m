Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48AE10A62C0
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 12:52:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AE6D3CB2AA
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 13:52:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 480AB3C98E7
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:52:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A7962140098F
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:52:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A2DB75BD0C;
 Thu, 26 Mar 2026 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774529546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pkUGuFCXutWR5mI4sh320DA3qSomnBk60gt8821BQqA=;
 b=xofKaGkQVwr2WSRnIrO7ki4vBOqPQbQnIxZAhQpEu2G40DRfbuXlWBJVdA8zki5oL2QXof
 +HfKQ+kyduMuQKxwPPpg1hmJzyHLmGei5Amo+opzGH28cgD3rgAebnArYr9Xp7m3tlMBue
 tfp6kn+5rsFY2ulVm1Ym03nxfYpv7oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774529546;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pkUGuFCXutWR5mI4sh320DA3qSomnBk60gt8821BQqA=;
 b=GR3mSRIKXYL4BntJGEKqdBngZs69YiuY0PwEbqwMzLT8b2IavvnIi/owCDwwjCQ1AiAmkJ
 FYjL8MgR+2oPT/DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xofKaGkQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GR3mSRIK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774529546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pkUGuFCXutWR5mI4sh320DA3qSomnBk60gt8821BQqA=;
 b=xofKaGkQVwr2WSRnIrO7ki4vBOqPQbQnIxZAhQpEu2G40DRfbuXlWBJVdA8zki5oL2QXof
 +HfKQ+kyduMuQKxwPPpg1hmJzyHLmGei5Amo+opzGH28cgD3rgAebnArYr9Xp7m3tlMBue
 tfp6kn+5rsFY2ulVm1Ym03nxfYpv7oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774529546;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pkUGuFCXutWR5mI4sh320DA3qSomnBk60gt8821BQqA=;
 b=GR3mSRIKXYL4BntJGEKqdBngZs69YiuY0PwEbqwMzLT8b2IavvnIi/owCDwwjCQ1AiAmkJ
 FYjL8MgR+2oPT/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 808EB4A0A3;
 Thu, 26 Mar 2026 12:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gMWEHgosxWnWQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 12:52:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Mar 2026 13:52:15 +0100
Message-ID: <20260326125216.159239-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A2DB75BD0C
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] userfaultfd03.c: Require kernel 6.1
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

Required kernel functionality was added in kernel 6.1 (not 6.11)
2d5de004e009 ("userfaultfd: add /dev/userfaultfd for fine grained access control")

Because it's a new kernel functionality which has not been backported to
enterprise kernels we can simplify check with just .min_kver.

Fixes: b63ab54aee ("userfaultfd: Do not use min_kver as gate for test")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

@Li I suppose RHEL kernel haven't backport this.

Kind regards,
Petr

 testcases/kernel/syscalls/userfaultfd/userfaultfd03.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
index b65f39ecab..dd4354be6f 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
@@ -24,15 +24,6 @@ static char *page;
 static void *copy_page;
 static int uffd;
 
-static void setup(void)
-{
-	if (access("/dev/userfaultfd", F_OK) != 0) {
-		int res = (tst_kvercmp(6, 1, 0) < 0) ? TCONF : TBROK;
-
-		tst_brk(res, "/dev/userfaultfd not found");
-	}
-}
-
 static int open_userfaultfd(int flags)
 {
 	int fd, fd2;
@@ -127,8 +118,8 @@ static void run(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.setup = setup,
 	.test_all = run,
+	.min_kver = "6.1",
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USERFAULTFD=y",
 		NULL
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
