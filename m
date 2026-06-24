Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F28CDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:21:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 823DE3E533C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:21:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FB083E5377
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 250B0600069
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3497576172
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7U/eCjo7m7+bnV2s8uyeWrSTWxxBY7JHXK1NZ2TL4pA=;
 b=riOCzaBUVpZEA8Lkt1wf/2cS6U1/WsyaI8U9jicVs5GxJcy5fqwrYDO0DbTRCVg8a7HEhS
 /DL7WOFG0mLAzkKLCOIJ2E3cDFbiQA0Dm5Oedbqi/YGHQBNT1fyge49+r+Z7tCq2PNyV5Z
 Io0s183wbd/CjGfG3bP8+mg2qECxJIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7U/eCjo7m7+bnV2s8uyeWrSTWxxBY7JHXK1NZ2TL4pA=;
 b=KqmH4M056mb4kgStjW/Hr7Q96+sT3vKnxuSCfxEKw+BgYn6EKaVIH7h2RF8B0E3bGggCco
 Sk5/z4UXZDzDJPAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7U/eCjo7m7+bnV2s8uyeWrSTWxxBY7JHXK1NZ2TL4pA=;
 b=riOCzaBUVpZEA8Lkt1wf/2cS6U1/WsyaI8U9jicVs5GxJcy5fqwrYDO0DbTRCVg8a7HEhS
 /DL7WOFG0mLAzkKLCOIJ2E3cDFbiQA0Dm5Oedbqi/YGHQBNT1fyge49+r+Z7tCq2PNyV5Z
 Io0s183wbd/CjGfG3bP8+mg2qECxJIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7U/eCjo7m7+bnV2s8uyeWrSTWxxBY7JHXK1NZ2TL4pA=;
 b=KqmH4M056mb4kgStjW/Hr7Q96+sT3vKnxuSCfxEKw+BgYn6EKaVIH7h2RF8B0E3bGggCco
 Sk5/z4UXZDzDJPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25620779A8
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RoNQCA2hO2pkAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:58 +0200
Message-ID: <20260624091900.4107041-12-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 11/13] build: rules.mk: Fix HOST_MAKE_TARGET rule
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

The rule was written with $< which means that the additional C files
were not picked for compilation. Correct it to $^ instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/mk/rules.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/mk/rules.mk b/include/mk/rules.mk
index c7da6d37f..2c15c4af1 100644
--- a/include/mk/rules.mk
+++ b/include/mk/rules.mk
@@ -35,9 +35,9 @@ endif
 
 $(HOST_MAKE_TARGETS): %: %.c
 ifdef VERBOSE
-	$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $< $(HOST_LDLIBS) -o $@
+	$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $^ $(HOST_LDLIBS) -o $@
 else
-	@$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $< $(HOST_LDLIBS) -o $@
+	@$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $^ $(HOST_LDLIBS) -o $@
 	@echo HOSTCC $(target_rel_dir)$@
 endif
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
