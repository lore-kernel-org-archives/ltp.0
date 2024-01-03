Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528DEC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 15:30:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48EDA3CE7CC
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 16:30:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 493D63CC301
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 16:30:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 661CB1400428
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 16:30:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F5D81FD26;
 Wed,  3 Jan 2024 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704295818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAQVW6lN9nqXjT2FDstfWomxCfgXeLaWJLxpnYzeH3A=;
 b=sdRHN7kAzSiYM06rJ3Hv3sMtSZClwLUbREUEK0l7CYcZzo1hUa94Lxobq6mAmCbEa2+O7j
 CHq7saVYg6emzoIAaJgNZsLAZlPVdFLyXa04msb8pUA4jHyHMuo23Q+Q/OGlGDLbnT/Jkw
 pnpaZPPCrhNG/CY5IuOZcB8tjlJ/on8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704295818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAQVW6lN9nqXjT2FDstfWomxCfgXeLaWJLxpnYzeH3A=;
 b=hWLzMFF7RIG67cl0Q8rWXejpuHDX+P4z5hkCi8euhfcUxA+X2oifpW8FXFhFBTzHkJdNTe
 wO0dqH383SeYotBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704295818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAQVW6lN9nqXjT2FDstfWomxCfgXeLaWJLxpnYzeH3A=;
 b=sdRHN7kAzSiYM06rJ3Hv3sMtSZClwLUbREUEK0l7CYcZzo1hUa94Lxobq6mAmCbEa2+O7j
 CHq7saVYg6emzoIAaJgNZsLAZlPVdFLyXa04msb8pUA4jHyHMuo23Q+Q/OGlGDLbnT/Jkw
 pnpaZPPCrhNG/CY5IuOZcB8tjlJ/on8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704295818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAQVW6lN9nqXjT2FDstfWomxCfgXeLaWJLxpnYzeH3A=;
 b=hWLzMFF7RIG67cl0Q8rWXejpuHDX+P4z5hkCi8euhfcUxA+X2oifpW8FXFhFBTzHkJdNTe
 wO0dqH383SeYotBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BCE91398A;
 Wed,  3 Jan 2024 15:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sHWqGIp9lWVtWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 15:30:18 +0000
Date: Wed, 3 Jan 2024 16:30:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZZV9m0C1dn72aKUY@yuki>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-2-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231222050006.148845-2-xuyang2018.jy@fujitsu.com>
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sdRHN7kA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hWLzMFF7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_SPAM_LONG(3.50)[1.000]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[18.21%]
X-Rspamd-Queue-Id: 7F5D81FD26
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/7] libltpswap: alter get_used_swapfiles api
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
> +/*
> + * Get the used swapfiles number
> + */
> +int get_used_swapfiles(const char *file, const int lineno);
> +#define GET_USED_SWAPFILES() \
> +	get_used_swapfiles(__FILE__, __LINE__)

This has to be prefixed with tst_

Also I wouldn't bother withg the macro and passing down FILE and LINE,
it's going to be called just once in the test setup anyways.

So I would just add:

	int tst_count_swaps(void);

>  #endif /* __LIBSWAP_H__ */
> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index 658ecede7..e10a6f5b2 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -14,6 +14,8 @@
>  #include "tst_kconfig.h"
>  #include "tst_safe_stdio.h"
>  
> +#define BUFSIZE 1024
> +
>  /*
>   * Make a swap file
>   */
> @@ -109,3 +111,27 @@ unsigned int get_maxswapfiles(void)
>  
>  	return max_swapfile - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
>  }
> +
> +/*
> + * Get the used swapfiles number
> + */
> +int get_used_swapfiles(const char *file, const int lineno)
> +{
> +	FILE *fp;
> +	int used = -1;
> +	char buf[BUFSIZE];
> +
> +	fp = safe_fopen(file, lineno, NULL, "/proc/swaps", "r");

I suppose that that we may want to check if the file exists and return 0
if it does not, otherwise we will possibly TBROK here if CONFIG_SWAP is
not set. Or do all the tests that call this function have CONFIG_SWAP in
.needs_kconfig?

> +	while (fgets(buf, BUFSIZE, fp) != NULL)
> +		used++;

We can do this even simpler:

	int c;

	while ((c = fgetc(f)) != EOF) {
		if (c == '\n')
			used++;
	}

> +	fclose(fp);
> +
> +	if (used < 0) {
> +		tst_brk(TBROK, "can't read /proc/swaps to get used swapfiles resource total "
> +			"at %s:%d", file, lineno);
> +	}
> +
> +	return used;
> +}
> -- 
> 2.27.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
