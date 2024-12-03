Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6C5E64AB9
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 15:16:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32BFD3DE337
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 16:16:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C42493DE30D
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:30 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15E5A638412
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77DF41F44F
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59SpLZuQhiwpV8SUv+3HjtkkT0Vm4hQnvX4hTZMwp3Y=;
 b=hppoWouTwT7cI5aRZqLTBJQG6wa2NIz9OfZzmMaVpDyCWJRVLHyN3A6WgdWV7lj7U6WU8i
 ttDPLyzwGlic1plesDEu4huWtQhcRxa8MU5VcRliEx4F+gn4qmH01AypaAuymHbvVCpqfi
 hh6xsqXQG5v4e4XPEYdpMm3FQZjDGeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59SpLZuQhiwpV8SUv+3HjtkkT0Vm4hQnvX4hTZMwp3Y=;
 b=U1mldj4naubUv/bYtubUVr7hU2FqGJZaW/QxLl4J/5BlHpyXyvurGLVLKv7HRifOkkgqA+
 AMyzaExuxQxRG7Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hppoWouT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U1mldj4n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59SpLZuQhiwpV8SUv+3HjtkkT0Vm4hQnvX4hTZMwp3Y=;
 b=hppoWouTwT7cI5aRZqLTBJQG6wa2NIz9OfZzmMaVpDyCWJRVLHyN3A6WgdWV7lj7U6WU8i
 ttDPLyzwGlic1plesDEu4huWtQhcRxa8MU5VcRliEx4F+gn4qmH01AypaAuymHbvVCpqfi
 hh6xsqXQG5v4e4XPEYdpMm3FQZjDGeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59SpLZuQhiwpV8SUv+3HjtkkT0Vm4hQnvX4hTZMwp3Y=;
 b=U1mldj4naubUv/bYtubUVr7hU2FqGJZaW/QxLl4J/5BlHpyXyvurGLVLKv7HRifOkkgqA+
 AMyzaExuxQxRG7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C8FC139C2
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BNpoFZEgT2evQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 15:15:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Dec 2024 16:15:29 +0100
Message-ID: <20241203151530.16882-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203151530.16882-1-chrubis@suse.cz>
References: <20241203151530.16882-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 77DF41F44F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] lib/tst_res_.c: Add TBROK handler + more verbose
 errors
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

We use the tst_res_ helper for tst_brk_ as well so we need to be able to
handle TBROK type as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_res_.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/testcases/lib/tst_res_.c b/testcases/lib/tst_res_.c
index a43920f36..fd9b8e841 100644
--- a/testcases/lib/tst_res_.c
+++ b/testcases/lib/tst_res_.c
@@ -8,28 +8,34 @@
 
 static void print_help(void)
 {
-	printf("Usage: tst_res_ filename lineno [TPASS|TFAIL|TCONF|TINFO|TDEBUG] 'A short description'\n");
+	printf("Usage: tst_{res,brk} filename lineno [TPASS|TBROK|TFAIL|TCONF|TINFO|TDEBUG] 'A short description'\n");
 }
 
 int main(int argc, char *argv[])
 {
 	int type, i;
 
-	if (argc < 5)
+	if (argc < 5) {
+		printf("argc = %i expected 5\n", argc);
 		goto help;
+	}
 
-	if (!strcmp(argv[3], "TPASS"))
+	if (!strcmp(argv[3], "TPASS")) {
 		type = TPASS;
-	else if (!strcmp(argv[3], "TFAIL"))
+	} else if (!strcmp(argv[3], "TFAIL")) {
 		type = TFAIL;
-	else if (!strcmp(argv[3], "TCONF"))
+	} else if (!strcmp(argv[3], "TCONF")) {
 		type = TCONF;
-	else if (!strcmp(argv[3], "TINFO"))
+	} else if (!strcmp(argv[3], "TINFO")) {
 		type = TINFO;
-	else if (!strcmp(argv[3], "TDEBUG"))
+	} else if (!strcmp(argv[3], "TDEBUG")) {
 		type = TDEBUG;
-	else
+	} else if (!strcmp(argv[3], "TBROK")) {
+		type = TBROK;
+	} else {
+		printf("Wrong type '%s'\n", argv[3]);
 		goto help;
+	}
 
 	size_t len = 0;
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
