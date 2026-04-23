Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A000F99352
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:41:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C176F3E2D7A
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:41:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73BEC3E1AA2
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2FBA92009E3
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81DC45BD52;
 Thu, 23 Apr 2026 08:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AL757g80cD8wt2DY+NfZvyTarGgZnLAKWpq7WQ7d1Mg=;
 b=sa0s7MHoOUuv53o6EZTuKhVMe2tdx+GvtRyRgwkbXt9Xn9lo3KFFnygfStIJCeooq1K8Cr
 jAaGlQ7yGk9uQxPPhkPQboNE0/PRuYNDJhTJPqpATFX95EFABeKjFEMQWSk9gStaptrUYY
 a4pm9t/yfmY0YtwOlQ0hDlUxAlAuPCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AL757g80cD8wt2DY+NfZvyTarGgZnLAKWpq7WQ7d1Mg=;
 b=3++k/Dho6zckF8IEwopdgiKIS4CTErhZB9Ao+y0Ikm/iK2GoZotjVz0Tnu1iFgemQPYdQV
 1cr+ULQBmHR5uKDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AL757g80cD8wt2DY+NfZvyTarGgZnLAKWpq7WQ7d1Mg=;
 b=sa0s7MHoOUuv53o6EZTuKhVMe2tdx+GvtRyRgwkbXt9Xn9lo3KFFnygfStIJCeooq1K8Cr
 jAaGlQ7yGk9uQxPPhkPQboNE0/PRuYNDJhTJPqpATFX95EFABeKjFEMQWSk9gStaptrUYY
 a4pm9t/yfmY0YtwOlQ0hDlUxAlAuPCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AL757g80cD8wt2DY+NfZvyTarGgZnLAKWpq7WQ7d1Mg=;
 b=3++k/Dho6zckF8IEwopdgiKIS4CTErhZB9Ao+y0Ikm/iK2GoZotjVz0Tnu1iFgemQPYdQV
 1cr+ULQBmHR5uKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28518593B0;
 Thu, 23 Apr 2026 08:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iLJxCD7b6Wl6fgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 08:41:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 10:41:17 +0200
Message-ID: <20260423084123.657690-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423084123.657690-1-pvorel@suse.cz>
References: <20260423084123.657690-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com,redhat.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/6] lib: Ignore empty LTP_ENABLE_DEBUG
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
Cc: Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Empty LTP_ENABLE_DEBUG environment variable should be just ignored.

This fixes warning:
LTP_ENABLE_DEBUG= ./test05
tst_test.c:1454: TWARN: Invalid LTP_ENABLE_DEBUG value:

Fixes: e434de62b4 ("lib: Extend LTP_ENABLE_DEBUG to support verbosity levels")
Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 26f6510a0a..229da669fa 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1445,13 +1445,13 @@ static void do_setup(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (tdebug_env && !context->tdebug) {
+	if (tdebug_env && *tdebug_env && !context->tdebug) {
 		if (!strcmp(tdebug_env, "2"))
 			context->tdebug = 2;
 		else if (!strcmp(tdebug_env, "1") || !strcmp(tdebug_env, "y"))
 			context->tdebug = 1;
 		else
-			tst_res(TWARN, "Invalid LTP_ENABLE_DEBUG value: %s", tdebug_env);
+			tst_res(TWARN, "Invalid LTP_ENABLE_DEBUG value: '%s'", tdebug_env);
 
 		if (context->tdebug)
 			tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
