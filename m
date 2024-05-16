Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F08FC25B75
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 01:34:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD98A3CF939
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 03:34:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 935F93CF095
 for <ltp@lists.linux.it>; Thu, 16 May 2024 03:34:35 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D2CAE63CA7B
 for <ltp@lists.linux.it>; Thu, 16 May 2024 03:34:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA67320EC7;
 Thu, 16 May 2024 01:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715823274;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+Bc2OxSm0htFUiWS+k3hCTeKUgWDY8Jro0/GrVoMe8=;
 b=WSah7o96g+qf75pcZ27kVNHmui8qBOjDeHWIF+AQeR1WRjzJcPQIdlo9EWM6wHA2gbfLyl
 x1c8SgMhsJ0NF67ecPcIW34AyEhMT858isyu6UZ+Dzy2fJCl/7i0eKIYc2kvbbtwQYdiZF
 qCIK6hTr7CqCGOdEOzRqMo/nXMwmvu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715823274;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+Bc2OxSm0htFUiWS+k3hCTeKUgWDY8Jro0/GrVoMe8=;
 b=SWBBy0hRfrUvW6KP+XHf/Ftbtbe8vjWlBUkZD67304gOuGiWu2rrRFnFH8KeCTEaWi7LEF
 RpY/Br6mlQB8PnAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h4Uc5q+r;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RszVj9Lf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715823272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+Bc2OxSm0htFUiWS+k3hCTeKUgWDY8Jro0/GrVoMe8=;
 b=h4Uc5q+rY5krgHdtUm33u31KnUodDR8uX0fmrPTQVoGYiy/oZfTomGcsVf70bUK8UDPwM7
 r2NdjorsQbFQB/fVaGwE895iai/i7eceZqGbSSbdp71GijWwxllqNUZ0CLw3aQuu5IeMYl
 TuW5plY401ikAamLTMKIT64QoEVkkVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715823272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+Bc2OxSm0htFUiWS+k3hCTeKUgWDY8Jro0/GrVoMe8=;
 b=RszVj9LfWeUxIBMg7gd7bE+8DtcG6iCbTd2TDbEaiBQIC7E7aMF7ScV02bIw1inQMK4ONG
 EdkXpqFRP8DsvICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C52CE13A5D;
 Thu, 16 May 2024 01:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kv8KL6hiRWYvdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 01:34:32 +0000
Date: Thu, 16 May 2024 03:34:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240516013427.GC260285@pevik>
References: <20240422083657.28363-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240422083657.28363-1-xuyang2018.jy@fujitsu.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DA67320EC7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getsockopt01: Add case for errno EINVAL
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

Hi Xu,

...
> +++ b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
> @@ -15,6 +15,7 @@
>   * - ENOTSOCK on a file descriptor not linked to a socket
>   * - EFAULT on invalid address of value or length
>   * - EOPNOTSUPP on invalid option name or protocol
> + * - EINVAL on an invalid optlen
>   */

>  #include "tst_test.h"
> @@ -24,6 +25,7 @@ static struct sockaddr_in sin0;
>  static int sinlen;
>  static int optval;
>  static socklen_t optlen;
> +static socklen_t optleninval;

Again, -1 should be added here (can be fixed before merge):

static socklen_t optleninval = -1;

>  static struct test_case {
>  	int *sockfd;
> @@ -56,7 +58,10 @@ static struct test_case {
>  	.optlen = &optlen, .experrno = ENOPROTOOPT, .desc =  "invalid option name (IP)"},

>  	{.sockfd = &sock_bind, .level = IPPROTO_TCP, .optname = -1, .optval = &optval,
> -	.optlen = &optlen, .experrno = ENOPROTOOPT, .desc = "invalid option name (TCP)"}
> +	.optlen = &optlen, .experrno = ENOPROTOOPT, .desc = "invalid option name (TCP)"},
> +
> +	{.sockfd = &sock_bind, .level = SOL_SOCKET, .optname = SO_OOBINLINE, .optval = &optval,
> +	.optlen = &optleninval, .experrno = EINVAL, .desc = "invalid optlen"},
>  };


> @@ -79,6 +84,7 @@ static void setup(void)
>  	SAFE_BIND(sock_bind, (struct sockaddr *)&sin0, sizeof(sin0));
>  	sinlen = sizeof(sin0);
>  	optlen = sizeof(optval);
> +	optleninval = -1;
And this can be removed.

With that:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
