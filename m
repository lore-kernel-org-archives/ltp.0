Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93390D4415B
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 10:30:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F65E3C6D10
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 11:30:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE8673C5794
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 11:30:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1EAA01000D56
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 11:29:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 27DB15BCFC;
 Fri, 12 Dec 2025 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765535397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msmT4TqnmHr3s/AalR8W+2RyrbSKHLzCd9UyqqjWnB4=;
 b=PHoCgivwP9OsL1hI6nERyL9iShBhtb24h2al4VIV2kT18fpnXhcbkBMGq72oODAsD+1MYE
 Af89KcM2Syftl3v6zRS9E/Zfb81iHeQt2yJ4OpXmTfBw/kuLU8S+dvl2fkxMjQrau1W6nf
 /ESHJv5XYfF+rzGnEkNRSIt2ZbyDjds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765535397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msmT4TqnmHr3s/AalR8W+2RyrbSKHLzCd9UyqqjWnB4=;
 b=rEftrhTveS1ywnoEjTUIqR5lSBQi48QKh/5pejBM6xPSLHmMwqCIatReOibRvW3L+eMkTE
 wNf1MN63JRM7wRBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qLNQxM64;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="E9bRbXL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765535396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msmT4TqnmHr3s/AalR8W+2RyrbSKHLzCd9UyqqjWnB4=;
 b=qLNQxM64CItSruKDmLHo/+luqQB9Nq1EopnWCAhY0+9fIXKt3V4dqlITIkO4teeF/AdJBM
 nBNBysAONiyonoOBkmzlOhhpaElMFYmBS7Oo96XtKmpxXh4kAkSAzm6xBD1njAzbYVL1y1
 /VPhE8C6rhvoaHd8FIAvusmOJQLfbkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765535396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msmT4TqnmHr3s/AalR8W+2RyrbSKHLzCd9UyqqjWnB4=;
 b=E9bRbXL/BhyBObulVVuJcYPYtARb61wZzNlVUGqh1/4G7N1ViJzuP5kwuOVC2CnO2clmMm
 JrY75DGfnwlLywAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16A733EA63;
 Fri, 12 Dec 2025 10:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MkwNBaTuO2mSZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Dec 2025 10:29:56 +0000
Date: Fri, 12 Dec 2025 11:30:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aTvu4GJBC_G5kSNi@yuki.lan>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251110024805.31070-2-wegao@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid,suse.cz:dkim,suse.cz:email];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 27DB15BCFC
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: Add support option for .needs_cmds
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
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index da5314c50..67553f65d 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1365,6 +1365,19 @@ static const char *default_fs_type(void)
>  	return tst_dev_fs_type();
>  }
>  
> +bool tst_cmd_present(const char *cmd)
> +{
> +	struct tst_cmd *pcmd = tst_test->needs_cmds;
> +
> +	while (pcmd->cmd) {
> +		if (!strcmp(pcmd->cmd, cmd))
> +			return pcmd->present;
> +
> +		pcmd++;
> +	}
> +	return false;

Once again, we should tst_brk(TBROK, "Unexpected command '%s'", cmd) here since we asked for
something that we haven't checked for!

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
