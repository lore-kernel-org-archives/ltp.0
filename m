Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC3C1099B2D
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 17:27:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D0B3E6106
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 18:27:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AA493E180B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 18:27:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B41A06006F1
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 18:27:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E33E5BCFA;
 Fri, 20 Mar 2026 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774027646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8x2zOA13DNdOagxfpTo4QEaWFWhxhbll0cibzbvklS8=;
 b=gAee0MAw7z9YnyrlQWR8qH0sLx9g8WD6mqil2QyVsz+1CTr6gW8KzPzsqpkT30H3v1g6KO
 75xQ38h4lNNMK2DDF3slBwelNzur2PVshrJdet7nmXf58W1EwbpYtYoSpWECsTC0nNg3wv
 3WYRI5I1ud/ei5SNIYfAK5eE770DIXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774027646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8x2zOA13DNdOagxfpTo4QEaWFWhxhbll0cibzbvklS8=;
 b=jHDRpBRwu9awPUUU4Q4N8A0MIBSCeMnwIbF5dS0U2nV4N7h1u+iaF/fen4jgjsABWebFv1
 yIcdLmBLA9J2P4CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gAee0MAw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jHDRpBRw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774027646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8x2zOA13DNdOagxfpTo4QEaWFWhxhbll0cibzbvklS8=;
 b=gAee0MAw7z9YnyrlQWR8qH0sLx9g8WD6mqil2QyVsz+1CTr6gW8KzPzsqpkT30H3v1g6KO
 75xQ38h4lNNMK2DDF3slBwelNzur2PVshrJdet7nmXf58W1EwbpYtYoSpWECsTC0nNg3wv
 3WYRI5I1ud/ei5SNIYfAK5eE770DIXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774027646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8x2zOA13DNdOagxfpTo4QEaWFWhxhbll0cibzbvklS8=;
 b=jHDRpBRwu9awPUUU4Q4N8A0MIBSCeMnwIbF5dS0U2nV4N7h1u+iaF/fen4jgjsABWebFv1
 yIcdLmBLA9J2P4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD6D0428F8;
 Fri, 20 Mar 2026 17:27:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NHlmMnyDvWnucwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 20 Mar 2026 17:27:24 +0000
Date: Fri, 20 Mar 2026 18:27:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260320172718.GA163304@pevik>
References: <20260128002828.424-1-wegao@suse.com>
 <20260226022536.20175-1-wegao@suse.com>
 <20260320150945.GA160532@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260320150945.GA160532@pevik>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0E33E5BCFA
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mseal02: Handle multiple errnos for 32-bit
 compat mode
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei, all,

> Hi all,

> > In 32-bit compat mode, the overflow_size (calculated using a 32-bit ULONG_MAX)
> > does not cause a 64-bit integer wrap-around when added to the start address.
> > Consequently, the kernel see valid range that points to unmapped space, returning
> > ENOMEM instead of the expected EINVAL.

> Also LGTM.

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +	if (tst_is_compat_mode())
> +		tcases[2].exp_err = ENOMEM;

I was about to merge, but thinking about it twice, it'd make sense instead
hardcoding index 2 (we talked about it in the past, that hardcoding indexes can
cause problems the future) to add attribute .check_kver, similar way Jan Polensky
did in dcf0c145d9 ("setxattr02: Adapt test for kernel 7.1.0+ socket xattr support").

Could you please modify it in v3?

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/dcf0c145d90531b919e633bb3f481f59a867aa06

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
