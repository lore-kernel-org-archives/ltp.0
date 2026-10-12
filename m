Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48400CA9ED0
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 09:34:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A947B3E6A9E
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 11:34:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E99BC3E6A91
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 11:34:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 225916003BE
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 11:34:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B40011F76C;
 Mon, 12 Oct 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791797643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D6BSXGhEeCaTeDzFR+33O5MGGjrqbe+m0U8AFpaP3gw=;
 b=HEdcBUsz3yd1+aL/hclbTHJdXKRdPhN2TmMjyWYG9n5pH2y/ZDovkzOJp5kgGVvxLT2Kgn
 +ROx2S3TXaToYJ4po/LWET5zZ4L0OW1jbrxWDdq4f31qOEuy5bDTG+62yICkqJfSdHCMpx
 ylFbmqe/y17g2EzsWxtS9t2u//IhPrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791797643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D6BSXGhEeCaTeDzFR+33O5MGGjrqbe+m0U8AFpaP3gw=;
 b=1dTp7hWzmETTxc5W1KBzIv/j4P5TgeQy3li5yGYLV70nZTtdz/j7lB86wy6qXyuQoZfG2G
 eTu6DCageyHh7FBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791797643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D6BSXGhEeCaTeDzFR+33O5MGGjrqbe+m0U8AFpaP3gw=;
 b=HEdcBUsz3yd1+aL/hclbTHJdXKRdPhN2TmMjyWYG9n5pH2y/ZDovkzOJp5kgGVvxLT2Kgn
 +ROx2S3TXaToYJ4po/LWET5zZ4L0OW1jbrxWDdq4f31qOEuy5bDTG+62yICkqJfSdHCMpx
 ylFbmqe/y17g2EzsWxtS9t2u//IhPrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791797643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D6BSXGhEeCaTeDzFR+33O5MGGjrqbe+m0U8AFpaP3gw=;
 b=1dTp7hWzmETTxc5W1KBzIv/j4P5TgeQy3li5yGYLV70nZTtdz/j7lB86wy6qXyuQoZfG2G
 eTu6DCageyHh7FBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B50413314;
 Mon, 12 Oct 2026 09:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6gzrEoupzGpGbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 12 Oct 2026 09:34:03 +0000
Date: Mon, 12 Oct 2026 11:33:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20261012093357.GA191096@pevik>
References: <d462c7ccea7e45f489e9f8d5a04ec786de2014b6.1791780763.git.jstancek@redhat.com>
 <b6d98d03422ec30d0bf5284cd094d2ecf688efe3.1791792065.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6d98d03422ec30d0bf5284cd094d2ecf688efe3.1791792065.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] openposix: timers/twoevtimers: Wait for both
 timer signals
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

Hi Jan,

thanks, LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> -#define EXPIREDELTA 3
> -#define LONGTIME 5
> +#define EXPIREDELTA_NS 50000000

very nit: having EXPIREDELTA_MS 50 and then use EXPIREDELTA_MS * 1000000
might be slightly more readable.

> +#define LONGTIME 3
> +
> +#define POLL_MS 50
> +#define POLL_COUNT (LONGTIME * 1000 / POLL_MS)

>  #define CHILDPASS 1

> -static int caughtabort = 0;
> -static int caughtalarm = 0;
> +static volatile sig_atomic_t caughtabort = 0;
> +static volatile sig_atomic_t caughtalarm = 0;
nit: static is 0 already (maybe drop "= 0"?)

> -static void handler_abrt(int signo)
> +static void handler_abrt(int signo PTS_ATTRIBUTE_UNUSED)
Thanks for silence some of the warnings.

>  {
> -	printf("Caught abort signal\n");
+1

>  	caughtabort++;
>  }

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
