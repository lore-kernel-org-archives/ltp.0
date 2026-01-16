Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFFDD4A607
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 07:07:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAB7B3CA79A
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 08:07:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51D663C4C09
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 08:07:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C67531A00EFB
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 08:07:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A66815BCC6;
 Fri, 16 Jan 2026 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768547229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vp35xP5k+CLutrZacLfw9+wqFD++UQ7SjDix2Rl3CPU=;
 b=PGpgRfa35JJkTIPLiTi7VyvBCQ1sn1jqb0rZhWyJrRfU76chVckIMlYIfkXdxE8qx+jYfG
 siBOapxuD+zK+keJ4TA4TQrMJhgr2GmVPbddNWk58y23x+IDtoRG9+Om2MjUjjlWpydo0C
 nj7SpLc8c48qoT2Un09dupZDMXGni3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768547229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vp35xP5k+CLutrZacLfw9+wqFD++UQ7SjDix2Rl3CPU=;
 b=//iCjGhtD1/ke5t5BuUdQKOtLat6klEATvDkmT98t8mSjSVIKLDS+uQ/5TKfdMShpD35KH
 7wG3Ko3oK+vnkxCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PGpgRfa3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="//iCjGht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768547229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vp35xP5k+CLutrZacLfw9+wqFD++UQ7SjDix2Rl3CPU=;
 b=PGpgRfa35JJkTIPLiTi7VyvBCQ1sn1jqb0rZhWyJrRfU76chVckIMlYIfkXdxE8qx+jYfG
 siBOapxuD+zK+keJ4TA4TQrMJhgr2GmVPbddNWk58y23x+IDtoRG9+Om2MjUjjlWpydo0C
 nj7SpLc8c48qoT2Un09dupZDMXGni3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768547229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vp35xP5k+CLutrZacLfw9+wqFD++UQ7SjDix2Rl3CPU=;
 b=//iCjGhtD1/ke5t5BuUdQKOtLat6klEATvDkmT98t8mSjSVIKLDS+uQ/5TKfdMShpD35KH
 7wG3Ko3oK+vnkxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 829C83EA63;
 Fri, 16 Jan 2026 07:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BZlSHp3jaWl1NgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 16 Jan 2026 07:07:09 +0000
Date: Fri, 16 Jan 2026 08:07:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260116070708.GA556902@pevik>
References: <aWmqFAzdtsR0t5aJ@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aWmqFAzdtsR0t5aJ@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: A66815BCC6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clone10.c failed on 32bit compilation
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

FYI the patch is invalid. It should have been:

diff --git include/lapi/tls.h include/lapi/tls.h
index a067872e0f..eee77899e8 100644
--- include/lapi/tls.h
+++ include/lapi/tls.h
@@ -64,7 +64,7 @@ static inline void init_tls(void)
 	tls_ptr = allocate_tls_area();
 	tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
 	memset(tls_desc, 0, sizeof(*tls_desc));
-	tls_desc->entry_number = -1;
+	tls_desc->entry_number = 13;
 	tls_desc->base_addr = (unsigned long)tls_ptr;
 	tls_desc->limit = TLS_SIZE;
 	tls_desc->seg_32bit = 1;
@@ -72,7 +72,7 @@ static inline void init_tls(void)
 	tls_desc->read_exec_only = 0;
 	tls_desc->limit_in_pages = 0;
 	tls_desc->seg_not_present = 0;
-	tls_desc->useable = 1;
+	tls_ptr = tls_desc;
 
 #else
 	tst_brk(TCONF, "Unsupported architecture for TLS");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
