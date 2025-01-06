Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440E2E77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 13:28:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64C7A3C4C15
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:28:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3393E3C4C0B
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:29 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 519D91BCD0E7
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B268D21162;
 Mon,  6 Jan 2025 13:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ru5CXbgyJGgZ8RLmRhxVoG03/z3KhJI1v0UxWH58LDA=;
 b=okrbsq0AMcsBoH35obMP8OdVymqXwSABmISg5YYvpAOl1Q+kBUk60/FRZzUsAJ3VdjdfcQ
 S2JpiuPNcCbDXgOQsbqx8Z9BUvcP38Fyp1FsIwET+aZ9bYDNbUYw60bhKjeUkv0JHLeIg1
 quoiHXKAsAJ8qjxu6pChpGpg3wBjaY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ru5CXbgyJGgZ8RLmRhxVoG03/z3KhJI1v0UxWH58LDA=;
 b=fuHzhAMTjb9GlQA6FIwwW7MxcHBXU4wq4F+R7p/mC5zRVzXlUG34mEN1EPndaTkpnnQQ8q
 8jmpUTnon59bQ+DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ru5CXbgyJGgZ8RLmRhxVoG03/z3KhJI1v0UxWH58LDA=;
 b=okrbsq0AMcsBoH35obMP8OdVymqXwSABmISg5YYvpAOl1Q+kBUk60/FRZzUsAJ3VdjdfcQ
 S2JpiuPNcCbDXgOQsbqx8Z9BUvcP38Fyp1FsIwET+aZ9bYDNbUYw60bhKjeUkv0JHLeIg1
 quoiHXKAsAJ8qjxu6pChpGpg3wBjaY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ru5CXbgyJGgZ8RLmRhxVoG03/z3KhJI1v0UxWH58LDA=;
 b=fuHzhAMTjb9GlQA6FIwwW7MxcHBXU4wq4F+R7p/mC5zRVzXlUG34mEN1EPndaTkpnnQQ8q
 8jmpUTnon59bQ+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A25BB139AB;
 Mon,  6 Jan 2025 13:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id crp4JgPae2fUKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jan 2025 13:26:27 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Jan 2025 14:26:06 +0100
Message-ID: <20250106132607.25627-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106132607.25627-1-chrubis@suse.cz>
References: <20250106132607.25627-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/6] lib/tst_res_.c: Add TBROK handler + more
 verbose errors
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

Note that we pass TBROK to the tst_res() here deliberately here because
we want to return back to the shell library, which is the process that
reports the TBROK to the test library by doing 'exit 2'. This works
because we pass the value by a variable as compiler cannot evaluate it's
value at a compile time.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
