Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948F3C5B552
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 06:35:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E45983CA0FD
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 08:35:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 151FB3CA06A
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 08:35:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 06ECA14002C2
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 08:35:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 274CD1F44F;
 Wed,  4 Jun 2025 06:35:23 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 027D713A63;
 Wed,  4 Jun 2025 06:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4Qq5OirpP2iCVgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Jun 2025 06:35:22 +0000
Date: Wed, 4 Jun 2025 08:35:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250604063521.GA1094733@pevik>
References: <20250603152253.214656-1-mdoucha@suse.cz>
 <20250603152253.214656-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250603152253.214656-2-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 274CD1F44F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] epoll_pwait: Refactor timeout to struct
 timespec
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

Hi Martin,

> Support higher precision timeout in do_epoll_pwait() by passing struct
> timespec instead of int value in milliseconds. Only one test actually
> uses the parameter.

Ah, you mean epoll_pwait03.c.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
> @@ -14,22 +14,22 @@
>  #define NSEC_PER_MSEC (1000000L)

>  static int do_epoll_pwait(int epfd, struct epoll_event *events, int
> -	maxevents, int timeout, const sigset_t *sigmask)
> +	maxevents, struct timespec *timeout, const sigset_t *sigmask)
>  {
> -	if (tst_variant == 0)
> -		return epoll_pwait(epfd, events, maxevents, timeout, sigmask);
> +	if (tst_variant == 0) {
> +		int timeout_ms = -1;

very nit: I would reverse the condition to save indent for tst_variant == 0:

	if (tst_variant != 0)
		return epoll_pwait2(epfd, events, maxevents, timeout, sigmask);
...

Kind regards,
Petr

> -	struct timespec ts;
> +		if (timeout) {
> +			timeout_ms = timeout->tv_sec * MSEC_PER_SEC;
> +			timeout_ms += (timeout->tv_nsec + NSEC_PER_MSEC - 1) /
> +				NSEC_PER_MSEC;
> +		}

> -	if (timeout < 0) {
> -		return epoll_pwait2(epfd, events, maxevents, NULL, sigmask);
> -	} else {
> -		ts.tv_sec = timeout / MSEC_PER_SEC;
> -		ts.tv_nsec = NSEC_PER_MSEC * (timeout % MSEC_PER_SEC);
> +		return epoll_pwait(epfd, events, maxevents, timeout_ms,
> +			sigmask);
>  	}

> -	return epoll_pwait2(epfd, events, maxevents, &ts, sigmask);
> -
> +	return epoll_pwait2(epfd, events, maxevents, timeout, sigmask);
>  }

>  static void epoll_pwait_init(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
