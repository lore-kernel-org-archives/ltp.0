Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD5E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 16:19:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB2603C26F5
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 17:19:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 438463C2509
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 17:19:02 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1A4C22E816
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 17:19:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A0C5221109;
 Thu,  9 Jan 2025 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736439537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rhnUW4+IgnkOpcPCVUNrEw595dLhroGbi3N9tDjNoA=;
 b=Byupb1Xb8uLdZgYmSJUL/pptMi9crIBsddR0NsBfrbLIolUrDQYnxU/4Tg9R05lj37S4G4
 YOb4C4ZznvDhusrIOD4Kpcu6tL5yUTx0YIVm0LC2jgg/jnSGtISK8Ep4u0CPhUxycJ69ar
 MQ4WCioGjvzzwUkSeo+e/hJZDfxSzFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736439537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rhnUW4+IgnkOpcPCVUNrEw595dLhroGbi3N9tDjNoA=;
 b=f+fS4u36poZ3LgIyIUDMNtADHdNwuiNrTBjDuBQi+nrCXSYeIqCAlsSnYPGUzmp/MaY3VR
 LkDjXIR0Yg3v+6Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736439537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rhnUW4+IgnkOpcPCVUNrEw595dLhroGbi3N9tDjNoA=;
 b=Byupb1Xb8uLdZgYmSJUL/pptMi9crIBsddR0NsBfrbLIolUrDQYnxU/4Tg9R05lj37S4G4
 YOb4C4ZznvDhusrIOD4Kpcu6tL5yUTx0YIVm0LC2jgg/jnSGtISK8Ep4u0CPhUxycJ69ar
 MQ4WCioGjvzzwUkSeo+e/hJZDfxSzFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736439537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rhnUW4+IgnkOpcPCVUNrEw595dLhroGbi3N9tDjNoA=;
 b=f+fS4u36poZ3LgIyIUDMNtADHdNwuiNrTBjDuBQi+nrCXSYeIqCAlsSnYPGUzmp/MaY3VR
 LkDjXIR0Yg3v+6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B17B13876;
 Thu,  9 Jan 2025 16:18:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CKriG/H2f2eWBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jan 2025 16:18:57 +0000
Date: Thu, 9 Jan 2025 17:18:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250109161851.GB355678@pevik>
References: <20250109150336.25235-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250109150336.25235-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] safe_macros: Fix confusing safe_read() failure
 output
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

Hi Cyril, Andrea
> In the case that we read() less bytes than expected in the strict mode
> we used the same tst_brk() as for the case when read() fails. However
> for short reads the errno is in an udefined state and we possibly end up
> with confusing TBROK message. Andrea reported EACESS ernno in the TBROK
nit: s/ernno/errno/

> message on a short read() while developing tests.

Good catch!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

FYI safe_write() also has TERRNO in len_strict.

Kind regards,
Petr

+++ lib/safe_macros.c
@@ -554,7 +554,7 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 
 		if (len_strict == SAFE_WRITE_ALL) {
 			if ((size_t)rval != nbyte)
-				tst_brkm_(file, lineno, TBROK | TERRNO,
+				tst_brkm_(file, lineno, TBROK,
 					cleanup_fn, "short write(%d,%p,%zu) "
 					"return value %zd",
 					fildes, buf, nbyte, rval);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
