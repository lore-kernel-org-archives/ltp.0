Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA91C88E53
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 10:54:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 102353E6950
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 12:54:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 464523E1868
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 12:53:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 77DE91400048
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 12:53:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1712B1FD86;
 Tue, 15 Sep 2026 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789469624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6Zi5pj3NDtXmghFGfsaGrCz3IULEjm6lDIVJWSX8xw=;
 b=0ZWUrO7KAvkGU+eZwVmNGJiFngq82wyz9UfdOErF8AaEARYEjRxH041eyN086WwVXxFNWf
 iH5EQw38UWRWWx+MkbQ/sV9lGQSKUQ5cUIOZ9owOYoDkPtFYYHO6+xhYIQEP9pNVJCYbZF
 XOmGtk6/nvzApQw4rVmO+h9wRGaLl9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789469624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6Zi5pj3NDtXmghFGfsaGrCz3IULEjm6lDIVJWSX8xw=;
 b=1ASqkyl12W6l3mdzVUHQxKNZmry02uPAXmGKXfJovbxpFt9LnpQ+AmH4ZORAlocAKcbHzE
 ftGLaNi7N4YKU5DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789469620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6Zi5pj3NDtXmghFGfsaGrCz3IULEjm6lDIVJWSX8xw=;
 b=oE5RSmp+NSF4M3HJqTEifu816VSJcNF2EYSl8lzRw+aB+rmbEbv0NCLOqH63Oyd5t2sbI7
 khe9cfhiKMERG6puqIvcPnqr0Rp0ODncpspy1rCRQbyEw4l29iqmitm881GlCrr3Y3AtTj
 /OjMkXvyCDSvUSyPhiwPmlG7e5zubNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789469620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6Zi5pj3NDtXmghFGfsaGrCz3IULEjm6lDIVJWSX8xw=;
 b=+h9+GdFVRL30QilBBd1capbaB9hBszf4D+9Ty42QHjMAaghPlCxNiV4Dk2y9c4lrPoMVWa
 Jq6HW5ANF8FOpmBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFCC813693;
 Tue, 15 Sep 2026 10:53:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zsWQLrMjqWq4RwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Sep 2026 10:53:39 +0000
Date: Tue, 15 Sep 2026 12:53:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <aqkjv-oIgNgHYROA@yuki.lan>
References: <apmHTcCUhxRMdcVg@yuki.lan>
 <20260907194422.414746-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260907194422.414746-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] uevent02: Make wait_for_uevents()
 order-independent
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
>  static inline void wait_for_uevents(int fd, const struct uevent_desc *const uevents[])
>  {
> -	int i = 0;
> +	int i, cnt = 0, remaining;
> +
> +	while (uevents[cnt])
> +		cnt++;
> +
> +	uint8_t matched[cnt];
> +
> +	memset(matched, 0, sizeof(matched));
>  
> -	while (1) {
> +	remaining = cnt;
> +
> +	while (remaining) {
>  		int len;
>  		char buf[4096];
>  
> @@ -136,11 +155,15 @@ static inline void wait_for_uevents(int fd, const struct uevent_desc *const ueve
>  
>  		print_uevent(buf, len);
>  
> -		if (uevent_match(buf, len, uevents[i])) {
> -			tst_res(TPASS, "Got expected UEVENT");
> -			if (!uevents[++i]) {
> -				close(fd);
> -				return;
> +		for (i = 0; i < cnt; i++) {
> +			if (matched[i])
> +				continue;
> +
> +			if (uevent_match(buf, len, uevents[i])) {
> +				tst_res(TPASS, "Got expected UEVENT");
> +				matched[i] = 1;
> +				remaining--;
> +				break;
>  			}
>  		}
>  	}

Unfortunately this is not yet ready either. The problem is that this
relaxes the conditions for uevent01.c and uevent03.c too, since these
two tests does not inforce any order after this change.

Well techically for uevent01.c the order does not matter, since the two
events for attach/detach are the same, as the event only reports
"change".

But uevent03.c is exactly the same patter, sequence of add and remove
events. Hence we have to enforce at least partial order. I would however
enforce the full order unless we are told otherwise. So maybe we need
two different wait_for_uevents() helpers one that would keep the order
and one that would match events in any order. And we should use the
order enforcing one in the uevent01 and uevent03.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
