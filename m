Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63C410F285E
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 17:33:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21BD83DD114
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 18:33:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67BD03CFB7B
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:33:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CCE981A010E9
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:33:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C1DF4D2B9;
 Fri, 27 Mar 2026 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774632807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcnjnRnolWBiiXPt1hlQMvtLPLPvvT15RCi88AWo0EE=;
 b=sQwkCH6LPjJMFw73k881FBj4jK2D9gQPXQYS2Pd/4JMIL3nKSgY8dSKGLVub7mBS7ETg+3
 jZleowZa4mRwsIlG58i+D7T5CxDempaLf4Xvj0TCsnF7n/cTC6zftyG1OVqfQmfL5LEou1
 TgDcqhDetPWJtw8ctfNd9lBztQ3/Qis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774632807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcnjnRnolWBiiXPt1hlQMvtLPLPvvT15RCi88AWo0EE=;
 b=tGfyPTCylOPmipoYYEXECROa1VX+0mD0s1Y6YvsIiCchJn9cS/wd2qfuV4ApPex3VBby/W
 4/zRYIifOHu/qhAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774632807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcnjnRnolWBiiXPt1hlQMvtLPLPvvT15RCi88AWo0EE=;
 b=sQwkCH6LPjJMFw73k881FBj4jK2D9gQPXQYS2Pd/4JMIL3nKSgY8dSKGLVub7mBS7ETg+3
 jZleowZa4mRwsIlG58i+D7T5CxDempaLf4Xvj0TCsnF7n/cTC6zftyG1OVqfQmfL5LEou1
 TgDcqhDetPWJtw8ctfNd9lBztQ3/Qis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774632807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcnjnRnolWBiiXPt1hlQMvtLPLPvvT15RCi88AWo0EE=;
 b=tGfyPTCylOPmipoYYEXECROa1VX+0mD0s1Y6YvsIiCchJn9cS/wd2qfuV4ApPex3VBby/W
 4/zRYIifOHu/qhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE92E4A0B1;
 Fri, 27 Mar 2026 17:33:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IBwGMWa/xmm0DgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 17:33:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Mar 2026 18:32:49 +0100
Message-ID: <20260327173252.1112192-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327173252.1112192-1-pvorel@suse.cz>
References: <20260327173252.1112192-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] lib: Ignore empty LTP_ENABLE_DEBUG
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

Empty LTP_ENABLE_DEBUG environment variable should be just ignored.

This fixes warning:
LTP_ENABLE_DEBUG= ./test05
tst_test.c:1454: TWARN: Invalid LTP_ENABLE_DEBUG value:

Reviewed-by: Li Wang <liwang@redhat.com>
Fixes: e434de62b4 ("lib: Extend LTP_ENABLE_DEBUG to support verbosity levels")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* C cleanup (tdebug_env[0] != '\0' => *tdebug_env, thanks Li)

 lib/tst_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2d62ab164d..6cd5546c0f 100644
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
