Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2D8CD11DD
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 16:31:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8E2C3C2CDD
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 17:31:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC0383C2153
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 17:29:46 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 606EE609680
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 17:29:46 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 660B120BA1;
 Thu, 28 Mar 2024 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711643385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnV1Nbwb0Cqc53Dq2gD7kVqtlZUQ8ZPg0mx1MGqLLFU=;
 b=E22VjRyHFjkR3FhUGfUT1deMb4bRlS1tVwpO5aw/G2kpdG6oApwqPX0phwmyXEuL2y5ZLB
 s70IxrdGDTLEc2PeekrQlVRem/SvIdHmWlZrVs6f7ppkH8KewWF6eYFM7iDKa0e4XVSf7F
 XbztTSHLqGGzVcYKYSWAm768xUPuqNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711643385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnV1Nbwb0Cqc53Dq2gD7kVqtlZUQ8ZPg0mx1MGqLLFU=;
 b=IZ/r056KkTzHJIC4LpPZwY87FEk7ha9+sHa1tqerMzOTOwhDpecyKJv7zQV+f+DjUnwI0Y
 hNkRSLhDU8G6/NBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 16EAD13A92;
 Thu, 28 Mar 2024 16:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mJIVAfmaBWZoeAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 28 Mar 2024 16:29:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 28 Mar 2024 17:29:39 +0100
Message-ID: <20240328162939.100872-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328162939.100872-1-pvorel@suse.cz>
References: <20240328162939.100872-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +++++
X-Spamd-Result: default: False [5.88 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.01)[50.09%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 660B120BA1
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/4] realpath01: Use TST_EXP_FAIL_PTR_NULL
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

From: Wei Gao <wegao@suse.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
The same as in v5.

 testcases/kernel/syscalls/realpath/realpath01.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/realpath/realpath01.c b/testcases/kernel/syscalls/realpath/realpath01.c
index c0381e9cb..c4c603609 100644
--- a/testcases/kernel/syscalls/realpath/realpath01.c
+++ b/testcases/kernel/syscalls/realpath/realpath01.c
@@ -24,16 +24,7 @@ static void setup(void)
 
 static void run(void)
 {
-	TESTPTR(realpath(".", NULL));
-
-	if (TST_ERR != ENOENT) {
-		tst_res(TFAIL | TTERRNO, "returned unexpected errno");
-	} else	if (TST_RET_PTR != NULL) {
-		tst_res(TFAIL, "syscall didn't return NULL: '%s'",
-				(char *)TST_RET_PTR);
-	} else {
-		tst_res(TPASS, "bug not reproduced");
-	}
+	TST_EXP_FAIL_PTR_NULL(realpath(".", NULL), ENOENT);
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
