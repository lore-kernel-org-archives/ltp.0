Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F669CCD18B
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 08:13:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EE1C3C2E50
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 10:13:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83F443C0EF7
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 10:13:38 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D8FA2602BAD
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 10:13:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5C4A2290E;
 Wed, 18 Sep 2024 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726647216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uTKDXZsla249y3s0rXLGORGct+BRdoGa9fimklli92w=;
 b=KPpdmR7vcFrtFG7Zugsg+/dEQCZQj6hemZjslSAi35qdKa0lf4Wx/vGxma0pdtP3GYXweL
 18P/WlAYSMyjxRgdRYbrKBmDtvS5+W9LCexke+AtB6ut+tBx1hrfrDMzYbhSADGCrS6cnV
 uursT/vhO/eRfV9zLnvrEQTdEVGytGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726647216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uTKDXZsla249y3s0rXLGORGct+BRdoGa9fimklli92w=;
 b=tSzN2rhL3oF6U5PwAaMo4Ko/0UxB4wGZRtj3KAv0fy1dRhFTOV82P3jUYxWxcylbf6rTyG
 RqN/yyZiqZMqWOAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X1Q0Shne;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4oQcoJ2Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726647215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uTKDXZsla249y3s0rXLGORGct+BRdoGa9fimklli92w=;
 b=X1Q0ShneIwYBHXpfNyjrgNgO1HOZFeXXnsxY2eLbgNsTJn+uEx4XHzNlHVzRn+8VMF+4Eu
 HaAvQ1jxt1kuion0JwtE/Dw2jNIO0+uwZjUe67UUu92Kf+CFcCXh8qP2Z0jMHvmnJIkrz5
 2tob3Py+W3elSUCXLVhBocypHb+UBPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726647215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uTKDXZsla249y3s0rXLGORGct+BRdoGa9fimklli92w=;
 b=4oQcoJ2Z+O3sYCBp26Rvih4Laj8PnTt4rAoRXhW9Ssk9kxPWup4mcqPVPUP4WeoiITVIKS
 L8PDbS+5SA0PW0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B572C13A57;
 Wed, 18 Sep 2024 08:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /aYtK6+L6mY0WAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Sep 2024 08:13:35 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Sep 2024 10:12:55 +0200
Message-ID: <20240918081255.13686-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: C5C4A2290E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 suse.com:email, imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Disable failure hints before we actually run the
 test
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

This is patch based on a suggestion from Peter Vorel:

http://patchwork.ozlabs.org/project/ltp/patch/20240527202858.350200-2-pvorel@suse.cz/

Peter proposed not to print failure hints (the tags) if we fail to
acquire the device. This patch extends it for the whole test library
intialization and enables the failure hints right before we jump into
the test function.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>
---

v2: Move the show_failure_hints = 1 deeper into the library as requested
    by Martin.

 lib/tst_test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 918bee2a1..d226157e0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -899,6 +899,8 @@ static void print_failure_hint(const char *tag, const char *hint,
 	}
 }
 
+static int show_failure_hints;
+
 /* update also docparse/testinfo.pl */
 static void print_failure_hints(void)
 {
@@ -919,7 +921,8 @@ static void do_exit(int ret)
 
 		if (results->failed) {
 			ret |= TFAIL;
-			print_failure_hints();
+			if (show_failure_hints)
+				print_failure_hints();
 		}
 
 		if (results->skipped && !results->passed)
@@ -930,7 +933,8 @@ static void do_exit(int ret)
 
 		if (results->broken) {
 			ret |= TBROK;
-			print_failure_hints();
+			if (show_failure_hints)
+				print_failure_hints();
 		}
 
 		fprintf(stderr, "\nSummary:\n");
@@ -1723,6 +1727,8 @@ static int fork_testrun(void)
 
 	alarm(results->timeout);
 
+	show_failure_hints = 1;
+
 	test_pid = fork();
 	if (test_pid < 0)
 		tst_brk(TBROK | TERRNO, "fork()");
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
