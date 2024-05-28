Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36907C25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 12:17:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A08AB3D052D
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 14:17:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A631C3C67E5
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:17:19 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CC5301000D11
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:17:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 042E022818;
 Tue, 28 May 2024 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716898638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3j5WtoDZGMjpOXYQuTm8tEbeqJuRL86cFX8wNZFRDDc=;
 b=lU0fUFPBtGRv3NiN4tZvoa3lFTWQtxf0Aw5iwcj8H0YXkE9vNV+28nFkkMu4jgPhjwrpWz
 ZTCRi9q3wpirA+f0kTOfQ7pW4iQQMDqdecDmdVLy1U8REu5uPncZJfIaz3f0l9q7ATc1Qu
 0eVCMY+muU0hHxVS4PG+FksQr/bQ0oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716898638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3j5WtoDZGMjpOXYQuTm8tEbeqJuRL86cFX8wNZFRDDc=;
 b=7fog8RNK2cTwEvmyNaByiX2x6fc1HRdJ9C+7KW/5GtsUuNVBQbCH7EsBUkAXva8ztD+n3A
 monviDzHRMF8vDBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716898638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3j5WtoDZGMjpOXYQuTm8tEbeqJuRL86cFX8wNZFRDDc=;
 b=lU0fUFPBtGRv3NiN4tZvoa3lFTWQtxf0Aw5iwcj8H0YXkE9vNV+28nFkkMu4jgPhjwrpWz
 ZTCRi9q3wpirA+f0kTOfQ7pW4iQQMDqdecDmdVLy1U8REu5uPncZJfIaz3f0l9q7ATc1Qu
 0eVCMY+muU0hHxVS4PG+FksQr/bQ0oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716898638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3j5WtoDZGMjpOXYQuTm8tEbeqJuRL86cFX8wNZFRDDc=;
 b=7fog8RNK2cTwEvmyNaByiX2x6fc1HRdJ9C+7KW/5GtsUuNVBQbCH7EsBUkAXva8ztD+n3A
 monviDzHRMF8vDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D270613A5D;
 Tue, 28 May 2024 12:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NtK2MU3LVWb0IQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 May 2024 12:17:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 May 2024 14:17:15 +0200
Message-ID: <20240528121715.436013-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] sparse-ltp: Fix bogus warning
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

tst_tmpdir.c:347:6: warning: Symbol 'tst_purge_dir' has no prototype or
library ('tst_') prefix. Should it be static?

Fixes: abe9b1792 ("tools/sparse: Add static check")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/sparse/sparse-ltp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index d649ee7b7..fff4bd4e6 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -148,9 +148,11 @@ static void check_symbol_visibility(const struct symbol *const sym)
 	if (sym->ident == &main_ident)
 		return;
 
-	warning(sym->pos,
-		"Symbol '%s' has no prototype or library ('tst_') prefix. Should it be static?",
-		name);
+	if (!has_lib_prefix) {
+		warning(sym->pos,
+			"Symbol '%s' has no prototype or library ('tst_') prefix. Should it be static?",
+			name);
+	}
 }
 
 /* See base_type() in dissect.c */
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
