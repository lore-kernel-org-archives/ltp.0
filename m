Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA85C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:30:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF1DB3CF800
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:30:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D2263C0333
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 99FA26068E6
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29E0C5CD2B;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZ06TyagYBauLO777RetuCbP201c2cYIi2zETO8SaNM=;
 b=yacCJDWYeQ2uZXn1JIFHoUKklO+s3qO8o6jGWDErDIGOxpefbGyiFXy9/VOXcP0kuDgI3w
 l/PVBodM+0aU4InNXCB+uUWclWr3GQnOntcpyOnqIyw68L62VhHKM52a8kC0zkwnLR4fLG
 UvMF867ViTJVxdCBikVuTD6LalKADMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZ06TyagYBauLO777RetuCbP201c2cYIi2zETO8SaNM=;
 b=EKGeRmzNwtZlQW29lIe4Fdii3Tf5p2pdzFUkoFDuskH26VHDFD+H5rNNE0bAf0y1310j+5
 waWEMKfyjn6IshCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZ06TyagYBauLO777RetuCbP201c2cYIi2zETO8SaNM=;
 b=yacCJDWYeQ2uZXn1JIFHoUKklO+s3qO8o6jGWDErDIGOxpefbGyiFXy9/VOXcP0kuDgI3w
 l/PVBodM+0aU4InNXCB+uUWclWr3GQnOntcpyOnqIyw68L62VhHKM52a8kC0zkwnLR4fLG
 UvMF867ViTJVxdCBikVuTD6LalKADMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZ06TyagYBauLO777RetuCbP201c2cYIi2zETO8SaNM=;
 b=EKGeRmzNwtZlQW29lIe4Fdii3Tf5p2pdzFUkoFDuskH26VHDFD+H5rNNE0bAf0y1310j+5
 waWEMKfyjn6IshCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0695D13888;
 Thu, 11 Apr 2024 14:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KAfwOgb0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:03 +0200
Message-ID: <20240411143025.352507-10-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.75 / 50.00]; BAYES_HAM(-2.95)[99.77%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 09/31] connect01: Remove UCLINUX
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
 testcases/kernel/syscalls/connect/connect01.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index d901427ff..660c4f7a9 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -83,13 +83,10 @@ struct test_case_t {		/* test case structure */
 	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
 		    sizeof(struct sockaddr_in), -1, EBADF, setup0,
 		    cleanup0, "bad file descriptor"},
-#ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
 	{
 	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)-1,
 		    sizeof(struct sockaddr_in), -1, EFAULT, setup1,
 		    cleanup1, "invalid socket buffer"},
-#endif
 	{
 	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
 		    3, -1, EINVAL, setup1, cleanup1, "invalid salen"}, {
@@ -112,10 +109,6 @@ struct test_case_t {		/* test case structure */
 
 int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
 
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
 /**
  * bionic's connect() implementation calls netdClientInitConnect() before
  * sending the request to the kernel.  We need to bypass this, or the test will
@@ -139,10 +132,6 @@ int main(int argc, char *argv[])
 	int lc;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
-#ifdef UCLINUX
-	argv0 = argv[0];
-	maybe_run_child(&do_child, "d", &sfd);
-#endif
 
 	setup();
 
@@ -263,11 +252,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 
 	switch ((pid = tst_fork())) {
 	case 0:		/* child */
-#ifdef UCLINUX
-		self_exec(argv0, "d", sfd);
-#else
 		do_child();
-#endif
 		break;
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "server fork failed");
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
