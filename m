Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D7CC54E67
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 07:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAC673CE6A4
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 08:31:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49AA33CD808
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:31:20 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B82ED140514C
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:31:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A8C6209C6;
 Wed, 20 Mar 2024 07:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710919878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wI3jUSbPZA4wRMMjHMZWWsejHiwrObP1wx+cv9lebDE=;
 b=khLbiePib6GHdjF2vYI/XS9b5uuI+ZAwK1ONoKMCWKMuWk/pLpOuzz3QV2kEGGOqfw8QTC
 UYghC2NVu2L3bgyU+tbvcu6IWMsnv9JVKWlvbU4ckDAm+iUR49YpPxibFyPiO2cNpTok8G
 n0fLm95gyVE+nQ/Td4S0Fm4TRNs5Vbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710919878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wI3jUSbPZA4wRMMjHMZWWsejHiwrObP1wx+cv9lebDE=;
 b=vd3V4Dzery6iSsRR+4JZwAaIfNXVignNC8rCeP1AXhBOoAJcguTeQukUlOllPzHgZuLLE1
 G/r1DKfZZc7EzhCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710919877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wI3jUSbPZA4wRMMjHMZWWsejHiwrObP1wx+cv9lebDE=;
 b=jbgupZ+3L4WwgLvARtLnEH2bxx3WX83IUjr8pZv4/0y9KIpGj+4fB4nXi7q94KMNNGlaQa
 qi/enIOotAp9m8eWpf6cJG+cDUwdKd3AIe5t5YKRImRh00UZVGD8Y7FJ/nLdn8VDRug78L
 Bv0seEzfPvrgyxW4dx7HeP2Elwepcxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710919877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wI3jUSbPZA4wRMMjHMZWWsejHiwrObP1wx+cv9lebDE=;
 b=wlYMv5Kl3SJHffb+XCQ5/36YFjXmALQ7BBzSQANyKwUBGAdMGiNRN0Xf0Z5eXmucd8XCEo
 tpDcRz6X2rAbUnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 587B5136CD;
 Wed, 20 Mar 2024 07:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hDYtFMWQ+mVJLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 07:31:17 +0000
Date: Wed, 20 Mar 2024 08:31:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240320073116.GA452876@pevik>
References: <20240319100822.3243785-1-liwang@redhat.com>
 <20240319100822.3243785-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240319100822.3243785-2-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] libswap: add two methods to create swapfile
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

Hi Li,

Generally LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
>  /*
> - * Make a swap file
> + * Create a swapfile of a specified size or number of blocks.
>   */
> -int make_swapfile(const char *swapfile, int blocks, int safe);
> +int make_swapfile(const char *swapfile, unsigned int num,
> +			int safe, enum swapfile_method method);
I wonder if it would help to add const char *file, const int lineno here.

> +
> +#define MAKE_SWAPFILE_SIZE(swapfile, size, safe) \
> +    make_swapfile(swapfile, size, safe, SWAPFILE_BY_SIZE)
nit: I like the name but one have to search which units (kB vs. MB vs. GB) are used.

> +
> +#define MAKE_SWAPFILE_BLKS(swapfile, blocks, safe) \
> +    make_swapfile(swapfile, blocks, safe, SWAPFILE_BY_BLKS)

And we could also have SAFE_ variants.

Therefore maybe rename make_swapfile() to make_swapfile_()
(approach in LTP for functions to be wrapped) and define macros:

int make_swapfile_(const char *file, const int lineno,
	const char *swapfile, unsigned int num,
	int safe, enum swapfile_method method);

#define MAKE_SWAPFILE_SIZE(swapfile, size, safe) \
    make_swapfile_(__FILE__, __LINE__, swapfile, size, 0, SWAPFILE_BY_SIZE)

#define MAKE_SWAPFILE_BLKS(swapfile, blocks, safe) \
    make_swapfile_(__FILE__, __LINE__, swapfile, blocks, 0, SWAPFILE_BY_BLKS)

#define SAFE_MAKE_SWAPFILE_SIZE(swapfile, size, safe) \
    make_swapfile_(__FILE__, __LINE__, swapfile, size, 1, SWAPFILE_BY_SIZE)

#define SAFE_MAKE_SWAPFILE_BLKS(swapfile, blocks, safe) \
    make_swapfile_(__FILE__, __LINE__, swapfile, blocks, 1, SWAPFILE_BY_BLKS)


>  /*
>   * Check swapon/swapoff support status of filesystems or files
> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index a26ea25e4..0e2476ec2 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -133,18 +133,26 @@ out:
>  	return contiguous;
>  }

> -int make_swapfile(const char *swapfile, int blocks, int safe)
> +int make_swapfile(const char *swapfile, unsigned int num, int safe, enum swapfile_method method)
>  {
>  	struct statvfs fs_info;
>  	unsigned long blk_size, bs;
>  	size_t pg_size = sysconf(_SC_PAGESIZE);
>  	char mnt_path[100];
> +	unsigned int blocks = 0;

>  	if (statvfs(".", &fs_info) == -1)
>  		return -1;

>  	blk_size = fs_info.f_bsize;

> +	if (method == SWAPFILE_BY_SIZE)
> +		blocks = num * 1024 * 1024 / blk_size;
> +	else if (method == SWAPFILE_BY_BLKS)
> +		blocks = num;
> +	else
> +		tst_brk(TBROK, "Invalid method, please see include/libswap.h");

nit: I would print the method.

Using const char *file, const int lineno and tst_brk_() would help
later to point out which file actually contains wrong method.

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
