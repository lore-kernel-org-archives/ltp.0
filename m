Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09328C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 20:48:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E6CE3CE743
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:48:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 871AB3CC020
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 720091000743
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D582821E1A;
 Thu,  4 Jan 2024 20:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WltCfivNAY7HX74Y00KT+GoKpGOCiZ14dXfssg8VzA0=;
 b=hQEzwBxSRg25vRfksaYsqTjuMetJbqpFmVQZ+snRNP8bmO7RP26W5nvuhCqZyZVuUuusGC
 laSapq91zeZ6VKpLxiu31WFzuGLpvK3Rg5Kyf7GFTZYyq5f6kNDPPnapXXYjhoHAbg8BWW
 MgTfJNV3YRSwgPgRv+ylswPGI9IH4bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WltCfivNAY7HX74Y00KT+GoKpGOCiZ14dXfssg8VzA0=;
 b=FtEyo10Jo7PdgIzEx4pNL2z+r8JvztMUVP/YWmlZFgk+0TQOw4JTXSYnGMMzNDS/EbmayK
 qOgYxfZPcc8fBKCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WltCfivNAY7HX74Y00KT+GoKpGOCiZ14dXfssg8VzA0=;
 b=IuJkAK24dQFR07dSLc3HQvmiTvdz7UiiBmnlSonNyXSZHKKYj5TMc6uaBLJUK9xALyr0GV
 P2rrqohBBPuouSOTUJAzW+qyUoSYuPWol+y6BH1uEyegwL9i9v0MaVm+0adTmGi7lY6yqS
 2kZ0SuMR4Sd78zni02PPDeo32rC7TfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WltCfivNAY7HX74Y00KT+GoKpGOCiZ14dXfssg8VzA0=;
 b=lh37ZX/kecF509EvOJyGHLoWyjzc5gvB/Lx1Q/gUo3pbLXA4iZZkUAWvdoqC/f0GF6lw3O
 zre4EcTit0oesXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6490137E8;
 Thu,  4 Jan 2024 20:46:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wJypKx0Zl2WsIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 20:46:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 21:46:10 +0100
Message-ID: <20240104204614.1426027-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104204614.1426027-1-pvorel@suse.cz>
References: <20240104204614.1426027-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D582821E1A
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IuJkAK24;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="lh37ZX/k"
X-Spamd-Bar: ++++
X-Spamd-Result: default: False [4.48 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[test.sh:url,parse.sh:url,suse.cz:email,suse.cz:dkim];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[49.96%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/9] metaparse: Verbose output on V=1
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

Pass VERBOSE variable to:
* parse.sh (=> pass -v to metaparse.c if VERBOSE=1)
* make test target (=> pass VERBOSE variable to test.sh)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 metadata/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/metadata/Makefile b/metadata/Makefile
index 522af4270..750804175 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -13,7 +13,7 @@ INSTALL_DIR		= metadata
 .PHONY: ltp.json
 
 ltp.json: metaparse
-	$(abs_srcdir)/parse.sh > ltp.json
+	VERBOSE=$(VERBOSE) $(abs_srcdir)/parse.sh > ltp.json
 ifeq ($(WITH_METADATA),yes)
 	mkdir -p $(abs_top_builddir)/docparse
 	$(MAKE) -C $(abs_top_builddir)/docparse/ -f $(abs_top_srcdir)/docparse/Makefile
@@ -25,6 +25,6 @@ install:
 endif
 
 test:
-	$(MAKE) -C $(abs_srcdir)/tests/ test
+	$(MAKE) -C $(abs_srcdir)/tests/ VERBOSE=$(VERBOSE) test
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
