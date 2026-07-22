Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F20C4451C
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 06:33:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B98E23E1FD0
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 08:33:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BE653C6FBE
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 08:33:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95E7C1400DD3
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 08:33:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E21D03E1F;
 Wed, 22 Jul 2026 06:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784701984;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnEBuZYvWT1yK+jRgWuye5zbF0XParM1rCOwQ9WA020=;
 b=AIEeaNWWn0cQPG/BXalUQApknSRJN9sLaSZ2OhVY694Erz3UypOabsz7RMDJQCdLxoaQPG
 KS397Rli8oIuYWT+J+tlcZ/EszHI6ScV0O4ssp/3L3o09umlxJhhN0P478N3cjLdaEyQAR
 bJYBeMDs/Z6DP1E2BnfBx+CkXhfrlug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784701984;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnEBuZYvWT1yK+jRgWuye5zbF0XParM1rCOwQ9WA020=;
 b=zspk9yu3xHXnPa/OZA8kGm2sQ5qcTmL8kfvsWKvhc0nidCAB+4IBDlm2szPP7b7duiDWfO
 ZI+zU/yJ4dcChqCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784701984;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnEBuZYvWT1yK+jRgWuye5zbF0XParM1rCOwQ9WA020=;
 b=AIEeaNWWn0cQPG/BXalUQApknSRJN9sLaSZ2OhVY694Erz3UypOabsz7RMDJQCdLxoaQPG
 KS397Rli8oIuYWT+J+tlcZ/EszHI6ScV0O4ssp/3L3o09umlxJhhN0P478N3cjLdaEyQAR
 bJYBeMDs/Z6DP1E2BnfBx+CkXhfrlug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784701984;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnEBuZYvWT1yK+jRgWuye5zbF0XParM1rCOwQ9WA020=;
 b=zspk9yu3xHXnPa/OZA8kGm2sQ5qcTmL8kfvsWKvhc0nidCAB+4IBDlm2szPP7b7duiDWfO
 ZI+zU/yJ4dcChqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB681779AA;
 Wed, 22 Jul 2026 06:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jdcGLCBkYGoqYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Jul 2026 06:33:04 +0000
Date: Wed, 22 Jul 2026 08:32:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260722063259.GA821485@pevik>
References: <20260714-checkpatch_remove_rules-v1-1-b5c561f2dc16@suse.com>
 <alX4Rqs6_uByyjfS@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alX4Rqs6_uByyjfS@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] checkpatch: relax parenthesis style checks
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Cyril,

I found both rules useful (more readable and more consistent code). Can we put
it back? Over the years you will recognise on the code of single test that it
was written/modified by several people with a different styles. And that makes
it less readable.

* PARENTHESIS_ALIGNMENT check enforces space behind 'while' or 'if'.
i.e. instead of:
	while(tst_fzsync_run_b(&fzsync_pair)) {
have:
	while (tst_fzsync_run_b(&fzsync_pair)) {

cve-2014-0196.c mixes 'while()' and 'while ()'. Is it that hard to be
consistent on it?

* OPEN_ENDED_LINE asks for not ending line with '(' or '['.
i.e. instead of this:
	ruleset_fd = TST_EXP_FD_SILENT(
								   tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
have this:
	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));

It's just my personal preference but I agree with the author of the rule that
enforced style is more readable.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
