Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1404DC25B74
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:34:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 701DC3D038C
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:34:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78F963D029D
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:57 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F17A6600F9A
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7198621CB5;
 Mon, 27 May 2024 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNqTtCVLw2TXzjcJ40qbtw9jU1cptdD7JNr0umKqP38=;
 b=p+3QSM5oph8qOT3D2ZynCPE7fKlIbLOZqnO7cD54E7K2xrLHOxf0E9lm0YW5GWfwYQyfKx
 57CmmY0nha8LA2uiSH6+4q4dm2DVkdPz0WpjRR0zhOdgjXR6cBImY6sWeAvdH1siAqjfdW
 l0lQJFxNhFYzXif1HdJeTgUMZbFeiTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNqTtCVLw2TXzjcJ40qbtw9jU1cptdD7JNr0umKqP38=;
 b=ug8kOB24ludMVy9wmJwmZ/LXCvD58c5FdFXCh7oXCE/EqTZacl4RAPe6b937AFe9jYMtn/
 /sVapFkhus9SBBDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p+3QSM5o;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ug8kOB24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNqTtCVLw2TXzjcJ40qbtw9jU1cptdD7JNr0umKqP38=;
 b=p+3QSM5oph8qOT3D2ZynCPE7fKlIbLOZqnO7cD54E7K2xrLHOxf0E9lm0YW5GWfwYQyfKx
 57CmmY0nha8LA2uiSH6+4q4dm2DVkdPz0WpjRR0zhOdgjXR6cBImY6sWeAvdH1siAqjfdW
 l0lQJFxNhFYzXif1HdJeTgUMZbFeiTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNqTtCVLw2TXzjcJ40qbtw9jU1cptdD7JNr0umKqP38=;
 b=ug8kOB24ludMVy9wmJwmZ/LXCvD58c5FdFXCh7oXCE/EqTZacl4RAPe6b937AFe9jYMtn/
 /sVapFkhus9SBBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A7D213A87;
 Mon, 27 May 2024 06:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id INATFVQpVGZAFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 06:33:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 08:33:33 +0200
Message-ID: <20240527063346.289771-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527063346.289771-1-pvorel@suse.cz>
References: <20240527063346.289771-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7198621CB5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/15] recv{, from, msg}01: Remove kernel >= 3.17 check
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

Since 9e9654cf2 LTP supports kernel >= 4.4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/recv/recv01.c         | 8 --------
 testcases/kernel/syscalls/recvfrom/recvfrom01.c | 8 --------
 testcases/kernel/syscalls/recvmsg/recvmsg01.c   | 7 -------
 3 files changed, 23 deletions(-)

diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index d71243c30..bb2578355 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -113,14 +113,6 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if ((tst_kvercmp(3, 17, 0) < 0)
-			    && (tdat[testno].flags & MSG_ERRQUEUE)
-			    && (tdat[testno].type & SOCK_STREAM)) {
-				tst_resm(TCONF, "skip MSG_ERRQUEUE test, "
-						"it's supported from 3.17");
-				continue;
-			}
-
 			tdat[testno].setup();
 			TEST(recv(s, tdat[testno].buf, tdat[testno].buflen,
 				  tdat[testno].flags));
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index f26f85688..6ce9f1bde 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -137,14 +137,6 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if ((tst_kvercmp(3, 17, 0) < 0)
-			    && (tdat[testno].flags & MSG_ERRQUEUE)
-			    && (tdat[testno].type & SOCK_STREAM)) {
-				tst_resm(TCONF, "skip MSG_ERRQUEUE test, "
-						"it's supported from 3.17");
-				continue;
-			}
-
 			tdat[testno].setup();
 			TEST(recvfrom(s, tdat[testno].buf, tdat[testno].buflen,
 				      tdat[testno].flags, tdat[testno].from,
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 80c1b3aa9..a265bc3bd 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -220,13 +220,6 @@ static void run(unsigned int n)
 	struct tcase *tc = &tcases[n];
 	int ret = tc->exp_errno ? -1 : 0;
 
-	if ((tst_kvercmp(3, 17, 0) < 0)
-			&& (tc->flags & MSG_ERRQUEUE)
-			&& (tc->type & SOCK_STREAM)) {
-		tst_res(TCONF, "MSG_ERRQUEUE requires kernel >= 3.17");
-		return;
-	}
-
 	setup_all();
 	tc->setup(n);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
