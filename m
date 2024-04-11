Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEFCC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:37:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 963AD3CF862
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:37:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C31533CF822
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2547C6067B8
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFFA55CD1B;
 Thu, 11 Apr 2024 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCKNaH/yJOfgleyVHojsqMOUmXcOxTDx/Nf8YFFEQWk=;
 b=Q6aRP3O2C24dmOmCqWYdq4lJgg+FYHynbboxf6qOaczDQKMKXorVTBMAwFdDl2DnDXvKZZ
 N3UPDQU947TmG313Bk2iGCJ6Vt4S3Bs8W2ykdFxpvwOWYNU8grAdrldvCnlysqRM25nFIx
 3wRUWRGafIBSwRpePT/cnNp0ZroY63E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCKNaH/yJOfgleyVHojsqMOUmXcOxTDx/Nf8YFFEQWk=;
 b=NY207598gGmaFpsFhOufGA9qbEgn7WWMU96I++/wxhIAYsLQQ8XZeJBGDr4hicVLQ8boe5
 A3lms4wo7T8DHnAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q6aRP3O2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NY207598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCKNaH/yJOfgleyVHojsqMOUmXcOxTDx/Nf8YFFEQWk=;
 b=Q6aRP3O2C24dmOmCqWYdq4lJgg+FYHynbboxf6qOaczDQKMKXorVTBMAwFdDl2DnDXvKZZ
 N3UPDQU947TmG313Bk2iGCJ6Vt4S3Bs8W2ykdFxpvwOWYNU8grAdrldvCnlysqRM25nFIx
 3wRUWRGafIBSwRpePT/cnNp0ZroY63E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCKNaH/yJOfgleyVHojsqMOUmXcOxTDx/Nf8YFFEQWk=;
 b=NY207598gGmaFpsFhOufGA9qbEgn7WWMU96I++/wxhIAYsLQQ8XZeJBGDr4hicVLQ8boe5
 A3lms4wo7T8DHnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 921A31386D;
 Thu, 11 Apr 2024 14:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJBIIgn0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:20 +0200
Message-ID: <20240411143025.352507-27-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.98 / 50.00]; BAYES_HAM(-2.97)[99.87%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AFFA55CD1B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 26/31] sigrelse01: Remove UCLINUX
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
 .../kernel/syscalls/sigrelse/sigrelse01.c     | 20 +++----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index a9d509cba..957542120 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -192,9 +192,6 @@ int main(int argc, char **argv)
 	 * parse standard options
 	 */
 	tst_parse_opts(argc, argv, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&child, "dd", &pipe_fd[1], &pipe_fd2[0]);
-#endif
 
 	/*
 	 * perform global setup for test
@@ -208,23 +205,12 @@ int main(int argc, char **argv)
 		/*
 		 * fork off a child process
 		 */
-		if ((pid = tst_fork()) < 0) {
+		if ((pid = tst_fork()) < 0)
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-
-		} else if (pid > 0) {
+		else if (pid > 0)
 			parent();
-
-		} else {
-#ifdef UCLINUX
-			if (self_exec(argv[0], "dd", pipe_fd[1], pipe_fd2[0]) <
-			    0) {
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "self_exec() failed");
-			}
-#else
+		else
 			child();
-#endif
-		}
 
 	}
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
