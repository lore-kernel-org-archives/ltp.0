Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1890DCCF9F8
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:32:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3B563CEFAD
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:31:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 975823CEFA6
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 49295601AFB
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA2C4211E5;
 Fri,  7 Nov 2025 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+TY7fzr+mZhdlhJ2VT9G8hshFsQQLjn/l87ITFyInE=;
 b=ZQfk0wc110sVCUd8dpAWPihHb+kdOXlVPaqpmTSS+QIM0bQEOCUPcOpKKHX14DEuHjkr07
 lOyFnjtUxOg/gjtogGGnSpIujVqqXb7vJPQD90mcADBxheqDtsPO+KLrxIwusa5gn+l+Cw
 cQr0HUCLlCc9992Y7H9hh3xPsTzR9ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+TY7fzr+mZhdlhJ2VT9G8hshFsQQLjn/l87ITFyInE=;
 b=E8/zFJDPteEKP8FJtQ1ohG+TxM5RmWi0P9ZAPf2td7fge3bDu1c6wz8Y4WdoWyCloXvNrn
 dn1NQMKdp0n36BDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+TY7fzr+mZhdlhJ2VT9G8hshFsQQLjn/l87ITFyInE=;
 b=nx8ZGDA/phSmS7vTAo7OS9BWTlVow4srYw8Ke/yebREvxxkILtVUQoz401zz1zxGkLQmxY
 eI/ariFzImx8kTVV8IidH3z5XlPIzMrsbnI+XAyS4YCTGcsZrrIIBOZFGH6C2D+vDivIv8
 cxTOMBNBXdUmqfPtKyjF9FPxgf8amUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+TY7fzr+mZhdlhJ2VT9G8hshFsQQLjn/l87ITFyInE=;
 b=6j5jOusdBS2g4fD/MuQ66Guvf7zoIbn1Ojm+ffCBlsOYGXXyE7qE77cJjbVDEg3lH8Dsuz
 mmyF6gtDtgSQWbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB7B8132DD;
 Fri,  7 Nov 2025 10:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CMAnLhjKDWlKQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 10:29:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 11:29:37 +0100
Message-ID: <20251107102939.1111074-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102939.1111074-1-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.986]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/8] tst_test.c: Change run_tcases_per_fs() return
 type to void
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

Return code is not used any more.

Fixes: a1f82704c2 ("lib/tst_test.c: Fix tst_brk() handling")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 05d8e59894..c1a1abf7fb 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1988,9 +1988,8 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	return ret;
 }
 
-static int run_tcases_per_fs(void)
+static void run_tcases_per_fs(void)
 {
-	int ret = 0;
 	unsigned int i;
 	bool found_valid_fs = false;
 	const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);
@@ -2013,8 +2012,6 @@ static int run_tcases_per_fs(void)
 
 	if (!found_valid_fs)
 		tst_brk(TCONF, "No required filesystems are available");
-
-	return ret;
 }
 
 unsigned int tst_variant;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
