Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B5CD59D65
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 15:22:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D5AA3C8529
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 16:22:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 240893C5373
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 16:21:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79371200D11
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 16:21:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9424733788;
 Fri, 12 Dec 2025 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765552916;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVFJpUFXqc9Hvx0wR4wSPjDcIJWHRH02oNCIMXFZwd0=;
 b=aaoBBI3Qu624wtfowL4qzEHyQuf1fsfzyUNgA6EjJGkz9d/Mg+DCo1qEXe6VDshRFkgnWC
 wLsRro5Ja4mtFESU8ykMRzDuGyFRWae7o0VMguGR0MGjk+DLn6d+cXPUCEvshebhv9m7Cy
 zkQRzwijrxh8gqJEgVzOneNjz/6ETpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765552916;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVFJpUFXqc9Hvx0wR4wSPjDcIJWHRH02oNCIMXFZwd0=;
 b=lISmIDZxniZJNE3WFzHJuDDZRy63YT6jtPt4EQLJjEKxQ0sARR4NIFcbx8gh3YT0qd2zwy
 LSWQf6anV7JVgLDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eWk0QlkY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cnwOKD46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765552915;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVFJpUFXqc9Hvx0wR4wSPjDcIJWHRH02oNCIMXFZwd0=;
 b=eWk0QlkYhqayRo1bzuCifK6T7/1X3nHQuus71tW7f2s+5zh05I71cSYQAxrVqT6Z0AX4Et
 NoH6ZpGqaSN0tfPzZOSsrjft4jQqBu9DFuEvTHUtOn9aO71lPo3nkY2qipQjEwMmfMFYtZ
 HZD4jC9XYeMKNLO0oIWxNPeT6Efg4G8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765552915;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVFJpUFXqc9Hvx0wR4wSPjDcIJWHRH02oNCIMXFZwd0=;
 b=cnwOKD46eIWsub0fZvl00nDiPnwrSj/wNXm8b3eKpaZpzSI4EH24bN0rIjCfRWNVw8OnWD
 foGHBLCha2Vaz6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D8D63EA63;
 Fri, 12 Dec 2025 15:21:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7mmCHRMzPGnJcwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Dec 2025 15:21:55 +0000
Date: Fri, 12 Dec 2025 16:21:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: simplemessager@163.com
Message-ID: <20251212152154.GA165966@pevik>
References: <20251209195328.GB24146@pevik>
 <20251211081205.342673-1-simplemessager@163.com>
 <20251211081205.342673-2-simplemessager@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251211081205.342673-2-simplemessager@163.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_TO(0.00)[163.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[163.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,chinatelecom.cn:email];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9424733788
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] safe_keyctl: Skip with TCONF on EOPNOTSUPP
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

> From: Petr Vorel <pvorel@suse.cz>

> errno EOPNOTSUPP is likely a configuration issue, skip testing
> with TCONF.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mingyu Li <limy83@chinatelecom.cn>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  include/lapi/keyctl.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
> index e08b8f132..eac9e2609 100644
> --- a/include/lapi/keyctl.h
> +++ b/include/lapi/keyctl.h
> @@ -212,7 +212,8 @@ static inline long safe_keyctl(const char *file, const int lineno,

>  	rval = keyctl(cmd, arg2, arg3, arg4, arg5);
>  	if (rval == -1) {
> -		tst_brk_(file, lineno, TBROK | TERRNO,
> +		tst_brk_(file, lineno,
> +			errno == EOPNOTSUPP ? TCONF : TBROK | TERRNO,

In the end, thinking about it twice I merged version which always prints TERRNO,
because we don't have any special explanation for TCONF, therefore the only
explanation is the errno itself:

(errno == EOPNOTSUPP ? TCONF : TBROK) | TERRNO,

Merged, with your Reviewed-by: and Co-developed-by:. Thanks!

Kind regards,
Petr

>  			"keyctl(%d, %lu, %lu, %lu, %lu)",
>  			cmd, arg2, arg3, arg4, arg5);
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
