Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DAFC83F1A
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:00:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A0AD3CCD18
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:00:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EC493CCCE0
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D97660091B
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 819861F7D7;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WztjYL8p7nTGgEAUzqwtqSw7kaOKpFzo+r1Pn+/SOQI=;
 b=x+ewhZtz2/d41pGFyC/vzdqg/lsZWiAvJfpmAp3v4RceGlaMLIEzYRO43rtWeyJ5q/4EXN
 2amWBXL7FtTTcAq/VwXp62HzsI7zZJnX+p7JoENyVKU8soTlIGkY/n/4Br5GtHjlwfbm65
 VgYdEvhYXgAhQDtwXJQ8e4SEgtWEXFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WztjYL8p7nTGgEAUzqwtqSw7kaOKpFzo+r1Pn+/SOQI=;
 b=tGipaMqOrkvcwAC1U8nxTTWlPGzMJ8wKLU/j06AmtUJxWRa8uKByaQ8AX3ShwNcxeV8M9H
 6gLkQFco3AlaQPAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WztjYL8p7nTGgEAUzqwtqSw7kaOKpFzo+r1Pn+/SOQI=;
 b=x+ewhZtz2/d41pGFyC/vzdqg/lsZWiAvJfpmAp3v4RceGlaMLIEzYRO43rtWeyJ5q/4EXN
 2amWBXL7FtTTcAq/VwXp62HzsI7zZJnX+p7JoENyVKU8soTlIGkY/n/4Br5GtHjlwfbm65
 VgYdEvhYXgAhQDtwXJQ8e4SEgtWEXFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WztjYL8p7nTGgEAUzqwtqSw7kaOKpFzo+r1Pn+/SOQI=;
 b=tGipaMqOrkvcwAC1U8nxTTWlPGzMJ8wKLU/j06AmtUJxWRa8uKByaQ8AX3ShwNcxeV8M9H
 6gLkQFco3AlaQPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 584D1132EA;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AAuVFDCLf2igZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 12:59:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Jul 2025 14:59:13 +0200
Message-ID: <20250722125916.74967-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722125916.74967-1-pvorel@suse.cz>
References: <20250722125916.74967-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/6] tst_res_: Add support for TWARN
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

TWARN is standard flag in LTP API, it should be supported, otherwise we
get:

Usage: tst_{res,brk} filename lineno [TPASS|TBROK|TFAIL|TCONF|TINFO|TDEBUG] 'A short description'

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
* New in v4

 testcases/lib/tst_res_.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_res_.c b/testcases/lib/tst_res_.c
index fd9b8e8414..c09d689ee5 100644
--- a/testcases/lib/tst_res_.c
+++ b/testcases/lib/tst_res_.c
@@ -8,7 +8,7 @@
 
 static void print_help(void)
 {
-	printf("Usage: tst_{res,brk} filename lineno [TPASS|TBROK|TFAIL|TCONF|TINFO|TDEBUG] 'A short description'\n");
+	printf("Usage: tst_{res,brk} filename lineno [TPASS|TBROK|TFAIL|TWARN|TCONF|TINFO|TDEBUG] 'A short description'\n");
 }
 
 int main(int argc, char *argv[])
@@ -28,6 +28,8 @@ int main(int argc, char *argv[])
 		type = TCONF;
 	} else if (!strcmp(argv[3], "TINFO")) {
 		type = TINFO;
+	} else if (!strcmp(argv[3], "TWARN")) {
+		type = TWARN;
 	} else if (!strcmp(argv[3], "TDEBUG")) {
 		type = TDEBUG;
 	} else if (!strcmp(argv[3], "TBROK")) {
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
