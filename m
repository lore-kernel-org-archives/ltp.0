Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECCAEE20AA
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 14:40:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09AE43CC921
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 15:40:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD6F33CC816
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 15:39:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 49D64200DB1
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 15:39:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BDF853E6D4;
 Fri,  6 Feb 2026 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770388796;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDXLgiWjXpQ6Kq402rYqS0b4YNAtvG7va1JhY25U5ZM=;
 b=YSDJVosQPZC/q2dHZhpf34Qe9Ts7Kh+icZ4s6kInmGJbVpXXk/ETOzpSm2cjTDvHB1thdA
 9pI07gCBFVGvq0aC6ADaBCwtK84fK+PzAFBdReshZPP7iQFqnftXlmf1DmwaBM3mGY9oei
 UW88b+cjsK0bIPAftClrGraBwsErkKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770388796;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDXLgiWjXpQ6Kq402rYqS0b4YNAtvG7va1JhY25U5ZM=;
 b=UcCWajIFmvrGCVES3CZbKjU73YFQQDE+G3WAbxz627a5l5XJ8VPWSjHZWhtb6hn00+GuCr
 9ibbAyDtVn0+YxDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YSDJVosQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UcCWajIF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770388796;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDXLgiWjXpQ6Kq402rYqS0b4YNAtvG7va1JhY25U5ZM=;
 b=YSDJVosQPZC/q2dHZhpf34Qe9Ts7Kh+icZ4s6kInmGJbVpXXk/ETOzpSm2cjTDvHB1thdA
 9pI07gCBFVGvq0aC6ADaBCwtK84fK+PzAFBdReshZPP7iQFqnftXlmf1DmwaBM3mGY9oei
 UW88b+cjsK0bIPAftClrGraBwsErkKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770388796;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDXLgiWjXpQ6Kq402rYqS0b4YNAtvG7va1JhY25U5ZM=;
 b=UcCWajIFmvrGCVES3CZbKjU73YFQQDE+G3WAbxz627a5l5XJ8VPWSjHZWhtb6hn00+GuCr
 9ibbAyDtVn0+YxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E0973EA63;
 Fri,  6 Feb 2026 14:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 00ZxITz9hWm3BgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Feb 2026 14:39:56 +0000
Date: Fri, 6 Feb 2026 15:39:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Message-ID: <20260206143955.GC402479@pevik>
References: <20260206125818.319190-1-vasileios.almpanis@virtuozzo.com>
 <20260206125818.319190-3-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260206125818.319190-3-vasileios.almpanis@virtuozzo.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BDF853E6D4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] pty04: use the correct protocol per line
 discipline to avoid extra packets
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Vasileios,

> Use specific protocol filter (ETH_P_IP for N_SLIP, ETH_P_CAN for N_SLCAN)
> instead of ETH_P_ALL to avoid catching unrelated packets like IPv6
> multicast (MLD) which cause false test failures.

LGTM.
@Martin: could you please double check?

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
> ---
>  testcases/kernel/pty/pty04.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
> index 204703253..770c053c4 100644
> --- a/testcases/kernel/pty/pty04.c
> +++ b/testcases/kernel/pty/pty04.c
> @@ -258,6 +258,19 @@ static void open_netdev(const struct ldisc_info *ldisc)
>  {
>  	struct ifreq ifreq = { 0 };
>  	struct sockaddr_ll lla = { 0 };
> +	int protocol;
> +
> +	switch (ldisc->n) {
> +		case N_SLIP:
> +			protocol = ETH_P_IP;
> +			break;
> +		case N_SLCAN:
> +			protocol = ETH_P_CAN;
> +			break;
> +		default:
> +			protocol = ETH_P_ALL;
> +			break;
> +	}

>  	SAFE_IOCTL(pts, SIOCGIFNAME, ifreq.ifr_name);
>  	tst_res(TINFO, "Netdev is %s", ifreq.ifr_name);
> @@ -282,7 +295,7 @@ static void open_netdev(const struct ldisc_info *ldisc)
>  	SAFE_IOCTL(sk, SIOCGIFINDEX, &ifreq);

>  	lla.sll_family = PF_PACKET;
> -	lla.sll_protocol = htons(ETH_P_ALL);
> +	lla.sll_protocol = htons(protocol);
>  	lla.sll_ifindex = ifreq.ifr_ifindex;
>  	SAFE_BIND(sk, (struct sockaddr *)&lla, sizeof(struct sockaddr_ll));

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
