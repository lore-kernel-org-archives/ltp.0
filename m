Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB00CA0EE4
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 07:55:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91B1F3CC7DC
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 09:55:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C976E3C0639
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 09:54:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7AA8D600731
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 09:54:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D6411F749;
 Mon, 18 Aug 2025 07:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755503682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=33Q2gPacfSDasS5Hx8ffEWoqwHBBZ4oTHWuJL/npu8Q=;
 b=Ejl7pGUVBEnJhWBmaK7J/8z3GOoVWm5zyTNJQHQ1MwSbpcBDbaB14x2ZjU+i1DhP/KEEqI
 bja0M/kmCifP+x23W/jUy89qlDR97HB6GdbNor/SOirOtm9uoG8ZNxQu16leardKcxF833
 jUthEijBuAfE8YRQ/CQvh9Mmfv971Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755503682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=33Q2gPacfSDasS5Hx8ffEWoqwHBBZ4oTHWuJL/npu8Q=;
 b=nUhda3B6d9us0ukkdCrVo4rLwFtYPy6sqhbS8JuFGHPET/ztZRwxGNX8Dx2bcRY/w2DY8C
 Nx5zkmhsbuQJ0uDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ejl7pGUV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nUhda3B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755503682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=33Q2gPacfSDasS5Hx8ffEWoqwHBBZ4oTHWuJL/npu8Q=;
 b=Ejl7pGUVBEnJhWBmaK7J/8z3GOoVWm5zyTNJQHQ1MwSbpcBDbaB14x2ZjU+i1DhP/KEEqI
 bja0M/kmCifP+x23W/jUy89qlDR97HB6GdbNor/SOirOtm9uoG8ZNxQu16leardKcxF833
 jUthEijBuAfE8YRQ/CQvh9Mmfv971Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755503682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=33Q2gPacfSDasS5Hx8ffEWoqwHBBZ4oTHWuJL/npu8Q=;
 b=nUhda3B6d9us0ukkdCrVo4rLwFtYPy6sqhbS8JuFGHPET/ztZRwxGNX8Dx2bcRY/w2DY8C
 Nx5zkmhsbuQJ0uDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04F1613A55;
 Mon, 18 Aug 2025 07:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vNcbOkHcomh4HAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Aug 2025 07:54:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Aug 2025 09:54:38 +0200
Message-ID: <20250818075438.151407-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2D6411F749
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/1] tst_res_: Print error to stderr,
 with filename and lineno
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

Print not only tst_res_.c filename and lineno but also script which
invoked tst_res_.c (if available). That helps find wrong tst_res_.c
invocation:

    tst_res_.c:42: Wrong type 'TPASS_EE' (invoked by shell_loader.sh:-1)
    Usage: tst_{res,brk} filename lineno [TPASS|TBROK|TFAIL|TWARN|TCONF|TINFO|TDEBUG] 'A short description'

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v4->v5:
* Use argv[1] and argv[2] (Cyril)
https://lore.kernel.org/ltp/aIC1A9yNXKX6QN2N@yuki.lan/
https://lore.kernel.org/ltp/aIIHh2CYcraAJHqG@yuki.lan/

Link to v4:
https://patchwork.ozlabs.org/project/ltp/patch/20250722125916.74967-5-pvorel@suse.cz/
https://lore.kernel.org/ltp/20250722125916.74967-5-pvorel@suse.cz/

 testcases/lib/tst_res_.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_res_.c b/testcases/lib/tst_res_.c
index c09d689ee5..2cc31e740f 100644
--- a/testcases/lib/tst_res_.c
+++ b/testcases/lib/tst_res_.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2025
  */
 
 #define TST_NO_DEFAULT_MAIN
@@ -13,13 +14,15 @@ static void print_help(void)
 
 int main(int argc, char *argv[])
 {
-	int type, i;
+	int i, lineno, type;
 
 	if (argc < 5) {
-		printf("argc = %i expected 5\n", argc);
+		fprintf(stderr, "%s:%d: argc = %i expected 5\n", __FILE__, __LINE__, argc);
 		goto help;
 	}
 
+	lineno = atoi(argv[2]);
+
 	if (!strcmp(argv[3], "TPASS")) {
 		type = TPASS;
 	} else if (!strcmp(argv[3], "TFAIL")) {
@@ -35,7 +38,8 @@ int main(int argc, char *argv[])
 	} else if (!strcmp(argv[3], "TBROK")) {
 		type = TBROK;
 	} else {
-		printf("Wrong type '%s'\n", argv[3]);
+		fprintf(stderr, "%s:%d: Wrong type '%s' (invoked by %s:%d)\n", __FILE__,
+				__LINE__, argv[3], argv[1], lineno);
 		goto help;
 	}
 
@@ -57,7 +61,7 @@ int main(int argc, char *argv[])
 
 	tst_reinit();
 
-	tst_res_(argv[1], atoi(argv[2]), type, "%s", msg);
+	tst_res_(argv[1], lineno, type, "%s", msg);
 
 	return 0;
 help:
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
