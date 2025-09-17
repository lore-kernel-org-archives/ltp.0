Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A72CA0EE8
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 12:22:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93A793CDC3C
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 14:22:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 583FB3C0433
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 14:22:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C23381A000B9
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 14:22:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A58721D0F;
 Wed, 17 Sep 2025 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758111758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NR8ebmj7cF9VVCFcoM1UNhdTpKjDNcG4i5h7tma503Q=;
 b=h8HolKmA/UqfIm5pkIN16YEAX6+TH2ahbncAGlljU3c4xJaDZwZtxFOeN5oAYGMw+qbmB3
 Iz+53qn3QuwsFL0ewpQwovAN+mrYB1ym8f0Dqo+tpXrz842uRs50y4grrHaVJKYpCkSv1T
 nCQU7dRZGONPLwIH7zvVzEIaPX3XN5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758111758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NR8ebmj7cF9VVCFcoM1UNhdTpKjDNcG4i5h7tma503Q=;
 b=VBPulzRRz7mmwyHPvfGCnsMf0QjD0N4lLD7kpWkrYtf47b1kOHM1VCu1VWrEotoGfBJ6Te
 xZfH9QPCAbSAypBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h8HolKmA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VBPulzRR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758111758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NR8ebmj7cF9VVCFcoM1UNhdTpKjDNcG4i5h7tma503Q=;
 b=h8HolKmA/UqfIm5pkIN16YEAX6+TH2ahbncAGlljU3c4xJaDZwZtxFOeN5oAYGMw+qbmB3
 Iz+53qn3QuwsFL0ewpQwovAN+mrYB1ym8f0Dqo+tpXrz842uRs50y4grrHaVJKYpCkSv1T
 nCQU7dRZGONPLwIH7zvVzEIaPX3XN5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758111758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NR8ebmj7cF9VVCFcoM1UNhdTpKjDNcG4i5h7tma503Q=;
 b=VBPulzRRz7mmwyHPvfGCnsMf0QjD0N4lLD7kpWkrYtf47b1kOHM1VCu1VWrEotoGfBJ6Te
 xZfH9QPCAbSAypBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F325C1368D;
 Wed, 17 Sep 2025 12:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b7ynOg2oymjzXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Sep 2025 12:22:37 +0000
Date: Wed, 17 Sep 2025 14:22:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250917122228.GB343943@pevik>
References: <20250902-open_tree_attr-v2-0-b23d2585986d@suse.com>
 <20250902-open_tree_attr-v2-2-b23d2585986d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250902-open_tree_attr-v2-2-b23d2585986d@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 1A58721D0F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] mount_setattr01: add open_tree_attr variant
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

Hi Andrea,

generally LGTM. But it'd be great (can be a separate effort) if you could write
checkers similar to fsopen_supported_by_kernel() for __NR_mount_setattr and
__NR_open_tree_attr. That would save time wasted when looping filesystem on the
variants which aren't supported.

Also while at it, could you fix older typo: 'sucess' => 'success' ?

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
>  static struct tcase {
>  	char *name;
> @@ -66,35 +69,61 @@ static void cleanup(void)
>  static void setup(void)
>  {
>  	fsopen_supported_by_kernel();
> -	struct stat st = {0};

> -	if (stat(OT_MNTPOINT, &st) == -1)
> +	if (access(OT_MNTPOINT, F_OK) != 0)
Out of curiosity why this change? Faster?

>  		SAFE_MKDIR(OT_MNTPOINT, 0777);
>  }

> +static int open_tree_variant1(struct mount_attr *attr)
> +{
> +	tst_res(TINFO, "Variant using open_tree() + mount_setattr()");
nit: I'm not an english speaker, but I would say "Using variant ..."

> +
> +	otfd = TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT,
> +			AT_EMPTY_PATH | OPEN_TREE_CLONE));
> +	if (otfd == -1)
> +		return -1;
> +
> +	TST_EXP_PASS(mount_setattr(otfd, "", AT_EMPTY_PATH,
> +			attr, sizeof(*attr)));
> +	if (TST_RET == -1) {
> +		SAFE_CLOSE(otfd);
> +		return -1;
> +	}
> +
> +	return otfd;
> +}
> +
> +static int open_tree_variant2(struct mount_attr *attr)
> +{
> +	tst_res(TINFO, "Variant using open_tree_attr()");
And here.

The rest LGTM.

Kind regards,
Petr
> +
> +	otfd = TST_EXP_FD(open_tree_attr(AT_FDCWD, MNTPOINT,
> +			AT_EMPTY_PATH | OPEN_TREE_CLONE,
> +			attr, sizeof(*attr)));
> +
> +	return otfd;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
