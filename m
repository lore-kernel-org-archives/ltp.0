Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0D4FEA835
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 09:23:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A7403E2ACC
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:23:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9B3B3CC6A9
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:23:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2A698600117
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:23:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74E414D2C6;
 Wed, 25 Mar 2026 09:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774430602;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/p4BBguNeysbwEHr6hDwxiEwh/d3SgVQCPM8TgESNck=;
 b=wGPHm1dEErMZDCSk6BslITo/jRwtdZV77+M+H+daAiI1+eEiZLvN7qZ5yWQgtcpzzg+JhP
 F8Rmua7AfQqXyd6WzevGxHmGvXAEe28QyQ9Q7TSS+Ut6mTt5r80K85VH4gDbTLRl2i/Kym
 Oe4xf6yCgQ/MFMosPBNB7HDQq2Un+eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774430602;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/p4BBguNeysbwEHr6hDwxiEwh/d3SgVQCPM8TgESNck=;
 b=XS8ADHyqi3t3apJSJ6aymJDom4rQj5y7B69gq6Rfs6V/Z+Gf7rm7nKc/6LDnCQ66OVYSwn
 8DtL8thwCoffFkDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wGPHm1dE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XS8ADHyq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774430602;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/p4BBguNeysbwEHr6hDwxiEwh/d3SgVQCPM8TgESNck=;
 b=wGPHm1dEErMZDCSk6BslITo/jRwtdZV77+M+H+daAiI1+eEiZLvN7qZ5yWQgtcpzzg+JhP
 F8Rmua7AfQqXyd6WzevGxHmGvXAEe28QyQ9Q7TSS+Ut6mTt5r80K85VH4gDbTLRl2i/Kym
 Oe4xf6yCgQ/MFMosPBNB7HDQq2Un+eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774430602;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/p4BBguNeysbwEHr6hDwxiEwh/d3SgVQCPM8TgESNck=;
 b=XS8ADHyqi3t3apJSJ6aymJDom4rQj5y7B69gq6Rfs6V/Z+Gf7rm7nKc/6LDnCQ66OVYSwn
 8DtL8thwCoffFkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FFFC44316;
 Wed, 25 Mar 2026 09:23:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kPSjFoqpw2nKCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 25 Mar 2026 09:23:22 +0000
Date: Wed, 25 Mar 2026 10:23:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <20260325092313.GA97750@pevik>
References: <20260320170058.433730-1-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260320170058.433730-1-rbranco@suse.de>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 74E414D2C6
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd: Minor fixes
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

Hi Ricardo,

...
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> @@ -53,11 +53,14 @@ static void set_pages(void)

>  static void reset_pages(void)
>  {
> -	SAFE_MUNMAP(page, page_size);
> -	SAFE_MUNMAP(copy_page, page_size);
> +	if (page) {
> +		SAFE_MUNMAP(page, page_size);
> +		SAFE_MUNMAP(copy_page, page_size);
> +		page = NULL;
> +	}
>  }

> -static void *handle_thread(void)
> +static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
>  	static struct uffd_msg msg;
>  	struct uffdio_copy uffdio_copy = {};
> @@ -129,4 +132,5 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.test = run,
>  	.tcnt = ARRAY_SIZE(tcases),
> +	.cleanup = reset_pages,
>  };
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
> index 2fd5ba5d8..db9ce4da4 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
> @@ -32,11 +32,13 @@ static void set_pages(void)

>  static void reset_pages(void)
>  {
> -	SAFE_MUNMAP(page, page_size);
> -	SAFE_MUNMAP(move_page, page_size);
> +	if (page) {
> +		SAFE_MUNMAP(page, page_size);
> +		SAFE_MUNMAP(move_page, page_size);
Here should be also page = NULL; right?

With that (can be added before merge)
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	}
>  }
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
