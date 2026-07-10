Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436A3C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 05:57:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9D0C3E274F
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:57:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE69A3E2769
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 767F91400DEE
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4913F76600;
 Fri, 10 Jul 2026 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UA5ITTvsINx/kVbbB5AS13jbN85D3Vw2MpEK2XFeLc=;
 b=nAk9BxoAEfTiW5VQ0UtRnjpQxR3eKerca1KuO2xJMs6sZALVE1kUwMAh/MrTLmhNfmCSOh
 d2h2YRdk9g7a6nSanPHTkGcUyKFPaZdPkE4Dle4529GiOi9gHvH7Gx0CPqC+2l3P2CiN6k
 Cuj7HQ0SnS3u50ahh04PfZwqW0hPgrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UA5ITTvsINx/kVbbB5AS13jbN85D3Vw2MpEK2XFeLc=;
 b=83COmpqxv4koNrUBGc0okPrbhbPctO+m3MVT7muurrNFDq6lNR5SfFr9geV6DMW6EMR1V8
 G0hUyGqNjtN42+AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UA5ITTvsINx/kVbbB5AS13jbN85D3Vw2MpEK2XFeLc=;
 b=nAk9BxoAEfTiW5VQ0UtRnjpQxR3eKerca1KuO2xJMs6sZALVE1kUwMAh/MrTLmhNfmCSOh
 d2h2YRdk9g7a6nSanPHTkGcUyKFPaZdPkE4Dle4529GiOi9gHvH7Gx0CPqC+2l3P2CiN6k
 Cuj7HQ0SnS3u50ahh04PfZwqW0hPgrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UA5ITTvsINx/kVbbB5AS13jbN85D3Vw2MpEK2XFeLc=;
 b=83COmpqxv4koNrUBGc0okPrbhbPctO+m3MVT7muurrNFDq6lNR5SfFr9geV6DMW6EMR1V8
 G0hUyGqNjtN42+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D20C779BD;
 Fri, 10 Jul 2026 05:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id II0QBnCJUGp7TwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 05:56:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 07:55:51 +0200
Message-ID: <20260710055556.1109220-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710055556.1109220-1-pvorel@suse.cz>
References: <20260710055556.1109220-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/8] metadata: Fix dependency for tests
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

'tests' target needs to have metadata binaries being built.

Fixes: af905936db ("docparse: Split into metadata and docparse")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
* New in v2

 metadata/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/metadata/Makefile b/metadata/Makefile
index 6939b9f76c..7e4ee38d2e 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -15,7 +15,7 @@ INSTALL_DIR		= metadata
 ltp.json: metaparse metaparse-sh
 	$(abs_srcdir)/parse.sh > ltp.json
 
-test:
+test: metaparse metaparse-sh
 	$(MAKE) -C $(abs_srcdir)/tests/ test
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
