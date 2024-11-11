Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E16DD2E9F0
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 14:36:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05E9F3D555B
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 15:36:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 319213D5554
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 15:36:15 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B365D631991
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 15:36:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E35521991;
 Mon, 11 Nov 2024 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731335773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VZefIJISxNpXYb3LaMRc8i1syc5uuKDZt1sQR4U8Fb4=;
 b=p9JzGq3ovgP803la/8Xs8A71enLxDbAtkBOTDeMC/sYSejTlxRgkPFf7lLIBEFmQfcjZBT
 KqsV+ikm1xYZbNzNZv0Me/V9zKgrxGA/TBpplRw0XupkRphRf6etWyMTMUUJ4lGwjEKZib
 kjM33nXV6GEaL8K1HSmBYw/G3r0Dxmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731335773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VZefIJISxNpXYb3LaMRc8i1syc5uuKDZt1sQR4U8Fb4=;
 b=ZhLEABwg1W3qba1Kj/op7i9Rb2eSkvv2H4nsD/S5S3lVSwhg8H0x1rBeFZ7Q6Hd1Is9Ld1
 1iPLlOM5O1sugyBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p9JzGq3o;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZhLEABwg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731335773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VZefIJISxNpXYb3LaMRc8i1syc5uuKDZt1sQR4U8Fb4=;
 b=p9JzGq3ovgP803la/8Xs8A71enLxDbAtkBOTDeMC/sYSejTlxRgkPFf7lLIBEFmQfcjZBT
 KqsV+ikm1xYZbNzNZv0Me/V9zKgrxGA/TBpplRw0XupkRphRf6etWyMTMUUJ4lGwjEKZib
 kjM33nXV6GEaL8K1HSmBYw/G3r0Dxmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731335773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VZefIJISxNpXYb3LaMRc8i1syc5uuKDZt1sQR4U8Fb4=;
 b=ZhLEABwg1W3qba1Kj/op7i9Rb2eSkvv2H4nsD/S5S3lVSwhg8H0x1rBeFZ7Q6Hd1Is9Ld1
 1iPLlOM5O1sugyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DACA13301;
 Mon, 11 Nov 2024 14:36:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HKMaEV0WMmdTagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 11 Nov 2024 14:36:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 11 Nov 2024 15:36:09 +0100
Message-ID: <20241111143609.185692-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8E35521991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] syscalls: Add missing WEXITSTATUS() check
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
I haven't found any other test which would need it.
 testcases/kernel/syscalls/madvise/madvise08.c | 2 +-
 testcases/kernel/syscalls/select/select03.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index 96bcaf159a..cd5ce722a5 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -173,7 +173,7 @@ static pid_t run_child(int advice)
 	SAFE_WAITPID(pid, &status, 0);
 	if (WIFSIGNALED(status) && WCOREDUMP(status))
 		return pid;
-	if (WIFEXITED(status))
+	if (WIFEXITED(status) && !WEXITSTATUS(status))
 		return 0;
 
 	tst_res(TCONF, "No coredump produced after signal (%d)",
diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index 1cec3a4c76..216b22104f 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -77,7 +77,7 @@ static void run(unsigned int n)
 
 	SAFE_WAITPID(pid, &status, 0);
 
-	if (WIFEXITED(status))
+	if (WIFEXITED(status) && !WEXITSTATUS(status))
 		return;
 
 	if (tst_variant == GLIBC_SELECT_VARIANT &&
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
