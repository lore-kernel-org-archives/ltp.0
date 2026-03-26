Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1320D10A88E7
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 17:05:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A17E23CFAE8
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 18:05:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E430F3D0E54
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 18:04:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A99C1000D3B
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 18:04:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7A5B5BF56;
 Thu, 26 Mar 2026 17:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774544678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CF/zgaJUlyoQ8W/q1m5xM6P7OH/3+/oG3YsQ/+Uyo6U=;
 b=uJ7/b7ZchnNpWu0MzhNfDXxng/dijCnxxJXILW4CbAsX9ZIbqheJZhmUHzg7N0ozpMYhoV
 ADY9RXwVhmfVvjO8YiTptx8tN+6DU2tcVbA8F2b5zidMb6DHCibFYBqf/V9s5/O/tO38OO
 ufMukH30xFVH9FF6TyDMHYCnIVkSUW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774544678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CF/zgaJUlyoQ8W/q1m5xM6P7OH/3+/oG3YsQ/+Uyo6U=;
 b=jwJJpPE5OKxTOL5imYjU7Vl1mrJ+s0ZYOuKlfw0m+udaAaWtmfeD84meS9Q4ra07LhDTif
 xLslSoJ3dij+HAAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bIAPcAUR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VWoauKHi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774544677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CF/zgaJUlyoQ8W/q1m5xM6P7OH/3+/oG3YsQ/+Uyo6U=;
 b=bIAPcAURIO0y45zJWAn5PoNZDGOH9a8wSD9HK4DvNtEJnsvsJxg7G+lsabK1M9zmjuYyHU
 nqI1Zqp+NvB+zKbIFf3VfYjnU7R185CkfinxZKk5MRSjL2n0uJiKCE/PYg1keNUwfMT4bd
 GqgS1NWLniE5tSyLD7ExQi7Tid8TvTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774544677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CF/zgaJUlyoQ8W/q1m5xM6P7OH/3+/oG3YsQ/+Uyo6U=;
 b=VWoauKHimhyhG81hXviMS7LIUroOZ8JsNklVqZzC84eRr7XRg9GeHZfhK5c5ugWN+HewHF
 u2e4nVGQp/ufV7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 851D54A0A6;
 Thu, 26 Mar 2026 17:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8N+sHiVnxWnqTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 17:04:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Mar 2026 18:04:33 +0100
Message-ID: <20260326170435.22566-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326170435.22566-1-pvorel@suse.cz>
References: <20260326170435.22566-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A7A5B5BF56
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] lib: Ignore empty LTP_ENABLE_DEBUG
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

Fixes: e434de62b4 ("lib: Extend LTP_ENABLE_DEBUG to support verbosity levels")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2d62ab164d..4a22f2e477 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1445,13 +1445,13 @@ static void do_setup(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (tdebug_env && !context->tdebug) {
+	if (tdebug_env && tdebug_env[0] != '\0' && !context->tdebug) {
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
