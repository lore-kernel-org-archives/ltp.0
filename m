Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42A2D68B2C
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 14:41:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D8413D6F4A
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 15:41:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B36383D6F3E
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:37 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C35C01432422
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E51351F443;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRuDJscJqxBjidntgTE0NHmGZdjp8e6xsjKhX13I9tk=;
 b=f9G/YNKsKa1JLuG0EHgK/FNBLOhNlJVXRnEq9pLCP4MOQ/AlI6ircR4xSUEcWL5dejhhd9
 gZ7T64o47CwDkgQSCk/Lg7XQbNGYFeR6Zd1zx1bkjx0cOCxrx1y9M/C6M3bqUL5AJc5A3w
 6hqLE3QJz/Xs/FADyRWWaEv/7dFVpw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRuDJscJqxBjidntgTE0NHmGZdjp8e6xsjKhX13I9tk=;
 b=bZqBIz0uHXItNq8leT9C1emtrZIdTWlUu78Z/eDUpkpXR5qkBAaBpDScBkdnB0ykOostp1
 owyMB8cTKNZp1vAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="rVh+/dxN";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mMd58s2q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRuDJscJqxBjidntgTE0NHmGZdjp8e6xsjKhX13I9tk=;
 b=rVh+/dxNiLo9iFWsrdhyXVMBF8a3Qm7rJKspnl/CM2IlsFQcW2/8OmO71S9k8ReoGO67Jd
 Lq08Slqrnkk63XddYdhDV9q8HeaHD3jTiuVBumkpdhiGkXrI8b2p9CdwrAj3rwVeOUYoHr
 vyx6PJ/npQsPJp+eNRmj+PT+iCLWzWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRuDJscJqxBjidntgTE0NHmGZdjp8e6xsjKhX13I9tk=;
 b=mMd58s2q9xCZgy24kvRip24VFJsVelEfoFAvjtplHndLqEAtBOE7044t39LB6AlEeC7p36
 LfsgSSQhyFFYZECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8A3913ACF;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mOnAK+MLNmeSdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 14:40:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Nov 2024 15:40:28 +0100
Message-ID: <20241114144029.349559-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114144029.349559-1-pvorel@suse.cz>
References: <20241114144029.349559-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E51351F443
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] libs/sigwait: Workaround segfault on libc variant
 on 32 bit
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

test_bad_address3() test which tests EFAULT segfaults on newer kernels
(e.g. 6.4) on libc variant on 32bit.  Similarly to 1d4d5a0750 use
typical LTP workaround to test by forked child + checking the
terminating signal.

This got broken on sigtimedwait01.c (but not on rt_sigtimedwait01.c).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 libs/sigwait/sigwait.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/libs/sigwait/sigwait.c b/libs/sigwait/sigwait.c
index 86899954d7..cf3c445b4a 100644
--- a/libs/sigwait/sigwait.c
+++ b/libs/sigwait/sigwait.c
@@ -359,17 +359,27 @@ void test_bad_address3(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 		       enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs;
+	pid_t pid;
+	int status;
 
-	SAFE_SIGEMPTYSET(&sigs);
-	TEST(sigwaitinfo(&sigs, NULL, (void *)1));
-	if (TST_RET == -1) {
-		if (TST_ERR == EFAULT)
-			tst_res(TPASS, "Fault occurred while accessing the buffers");
-		else
-			tst_res(TFAIL | TTERRNO, "Expected error number EFAULT, got");
-	} else {
-		tst_res(TFAIL, "Expected return value -1, got: %ld", TST_RET);
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		SAFE_SIGEMPTYSET(&sigs);
+		TST_EXP_FAIL(sigwaitinfo(&sigs, NULL, (void *)1), EFAULT);
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
 	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
 }
 
 static void empty_handler(int sig LTP_ATTRIBUTE_UNUSED)
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
