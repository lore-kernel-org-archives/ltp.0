Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB054C021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 13:26:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B9FA3CA037
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 14:26:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6CED3C1B4B
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:26:10 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E21D560085E
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:26:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67D2D2117C;
 Tue,  4 Mar 2025 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741094768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c717W6EeN4rTcCXXOnew4N6Dds4wq4qtW/4e3MC+Ggw=;
 b=2L8pb5SmUNy9kXNeNU5iha9QNbHmljHFaAGHior7Ek0DMdNnqbsXQBYEornqhdbKMDjQFI
 v35Gd80KqqjEJl5EyzlbI6QPlcF2CT+SOkeed9mCjsg7D/2hcU56x+EhCZTaf/Vca95D4W
 sZHkon+Uifv3mwQvJiXoE+3+vHo1IDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741094768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c717W6EeN4rTcCXXOnew4N6Dds4wq4qtW/4e3MC+Ggw=;
 b=bPTchU6h+mShqwFA9VMthEX2+slDTeLCurZSkh7DNvCWOXaB7D+3Mit0ayWbTn1+eXqnTj
 AIdNjV26Et7gIkBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741094768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c717W6EeN4rTcCXXOnew4N6Dds4wq4qtW/4e3MC+Ggw=;
 b=2L8pb5SmUNy9kXNeNU5iha9QNbHmljHFaAGHior7Ek0DMdNnqbsXQBYEornqhdbKMDjQFI
 v35Gd80KqqjEJl5EyzlbI6QPlcF2CT+SOkeed9mCjsg7D/2hcU56x+EhCZTaf/Vca95D4W
 sZHkon+Uifv3mwQvJiXoE+3+vHo1IDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741094768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c717W6EeN4rTcCXXOnew4N6Dds4wq4qtW/4e3MC+Ggw=;
 b=bPTchU6h+mShqwFA9VMthEX2+slDTeLCurZSkh7DNvCWOXaB7D+3Mit0ayWbTn1+eXqnTj
 AIdNjV26Et7gIkBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5962A13967;
 Tue,  4 Mar 2025 13:26:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j69LFXD/xmdaHQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 04 Mar 2025 13:26:08 +0000
Date: Tue, 4 Mar 2025 14:26:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z8b_e1F1gX5avllJ@yuki.lan>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
 <20250110-lsm-v2-7-bd38035f86bc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250110-lsm-v2-7-bd38035f86bc@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/7] Add lsm_set_self_attr01 test
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
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	/* just in case lsm_set_self_attr() pass , we won't change
> +	 * LSM configuration for the following process
> +	 */
> +	memcpy(ctx, ctx_orig, sizeof(struct lsm_ctx));
> +
> +	ctx_size = page_size;
> +	ctx_size_small = 1;
> +	ctx_size_big = ctx_size + 1;
> +
> +	TST_EXP_FAIL(lsm_set_self_attr(tc->attr, *tc->ctx, *tc->size, tc->flags),
> +	      tc->exp_errno,
> +	      "%s", tc->msg);
> +}
> +
> +static void setup(void)
> +{
> +	int ret;
> +	uint32_t size;
> +
> +	verify_supported_attr_current();
> +
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +	size = page_size;
> +
> +	ret = lsm_get_self_attr(LSM_ATTR_CURRENT, ctx_orig, &size, 0);

Here as well, the handling of the size is wrong.

> +	if (ret < 0)
> +		tst_brk(TBROK, "Can't read LSM current attribute");
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.min_kver = "6.8",
> +	.bufs = (struct tst_buffers[]) {
> +		{&ctx, .size = sizeof(struct lsm_ctx)},
> +		{&ctx_orig, .size = sizeof(struct lsm_ctx)},
> +		{}
> +	},
> +};
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
