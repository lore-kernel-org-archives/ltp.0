Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B823C83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 14:14:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA93B3CB228
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 16:14:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1333C218B
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 16:14:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D5F01140013E
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 16:14:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E56571F385;
 Fri, 11 Jul 2025 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752243278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4ukT3m+uK0IdpRb7Z0VbhMgD22TzMN+vuI65a0y85c=;
 b=mVE1FotIj+wEot/L9Emv6OUP8pVKabiR33/5bhWo0x1mnUiR8P88h4BkAhPRu2va7ddh9g
 ydasjL5guq/qbQ+nMvSZ0a+2lgD+X+LxEl+Fjx/eEI8qX/qx+bYwE02IOvsqxcd3dWjrOT
 yK3TpsLBeaJImXCLChdSezl4cnGyw30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752243278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4ukT3m+uK0IdpRb7Z0VbhMgD22TzMN+vuI65a0y85c=;
 b=ohUmXieb0kpFZYALFIcM3cfxJew8hiwTLmTwWoh6geMQbWVuSyyYK8ejuuJ5ReSKBR2l7I
 oiS3YwSMYFV9afDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752243276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4ukT3m+uK0IdpRb7Z0VbhMgD22TzMN+vuI65a0y85c=;
 b=lgu/hWjI5rCE6U1kQv1vw9vVquzoCzHD3ClbkzfLVgnCpQzs9+rzNFTQiXvBAIGViEZJcS
 f37dYi+kSoAv38eT7eKGzQ3nonbTwC9uZ3u8ujcgHrqnAC3BeuK4Qu/jZfARTrWQ/VF3bM
 yg4sK8ZhJW6gfaM2cFGKNN960ZCtkUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752243276;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4ukT3m+uK0IdpRb7Z0VbhMgD22TzMN+vuI65a0y85c=;
 b=uvcPneBP48ghYEvpEH8A9KYY8zanqcwtEgnXssKTV3DlFg3cUCmmfsSuJL3+e4g94UOltM
 uQaOMCT2i8XvbGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4D401388B;
 Fri, 11 Jul 2025 14:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FoMAM0wccWiHTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Jul 2025 14:14:36 +0000
Date: Fri, 11 Jul 2025 16:15:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aHEccDO8lJiTzbEs@yuki.lan>
References: <20250326142259.50981-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250326142259.50981-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 linux.it:url, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl_ficlone03.c: Support test on more
 filesystems
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +	/* ext[234] and tmpfs does not support immutable destination */
> +	if (errno_exp == EPERM &&
> +		(fs_type == TST_EXT234_MAGIC || fs_type == TST_TMPFS_MAGIC)) {

Maybe a bit better if (tc->dst_fd == immut_fd && ...)

> +		errno_exp = EOPNOTSUPP;
> +	}
>  
>  	TST_EXP_FAIL(ioctl(*tc->dst_fd, FICLONE, *tc->src_fd),
> -		tc->errno_exp,
> -		"%s", tc->msg);
> +		errno_exp, "%s", tc->msg);
>  
>  	clone_range->src_fd = *tc->src_fd;
>  
>  	TST_EXP_FAIL(ioctl(*tc->dst_fd, FICLONERANGE, clone_range),
> -		tc->errno_exp,
> -		"%s", tc->msg);
> +		errno_exp, "%s", tc->msg);
>  }
>  
>  static void setup(void)

I find it strange that we manage to set the FS_IMMUTABLE_FL in the setup
with the FS_IOC_SETFLAGS without any error. Maybe it would make sense to
check with ext devs what is going on here.

> @@ -117,6 +123,10 @@ static struct tst_test test = {
>  			.mkfs_ver = "mkfs.xfs >= 1.5.0",
>  			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
>  		},
> +		{.type = "ext2"},
> +		{.type = "ext3"},
> +		{.type = "ext4"},
> +		{.type = "tmpfs"},
>  		{}
>  	},
>  	.bufs = (struct tst_buffers []) {
> -- 
> 2.49.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
