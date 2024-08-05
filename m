Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BB8C3DA4A
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 13:59:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2E0D3D1FD6
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 15:59:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8F9C3D1B17
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 15:59:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 491431400523
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 15:59:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CF2A21B9B;
 Mon,  5 Aug 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 884DC13254;
 Mon,  5 Aug 2024 13:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Uay1F7nasGbfQwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Aug 2024 13:59:21 +0000
Date: Mon, 5 Aug 2024 15:59:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240805135919.GB45426@pevik>
References: <20240805065247.13791-1-liwang@redhat.com>
 <20240805065247.13791-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240805065247.13791-2-liwang@redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0CF2A21B9B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] mseal01: handle more possible errnos when
 pkey_alloc gets fail
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

...
>  static void test_pkey_mprotect(void)
>  {
> -	int ret;
>  	int pkey;

> -	pkey = tst_syscall(__NR_pkey_alloc, 0, 0);
> -	if (pkey == -1) {
> -		if (errno == EINVAL)
> -			tst_brk(TCONF, "pku is not supported on this CPU");
> +	check_pkey_support();

> -		tst_brk(TBROK | TERRNO, "pkey_alloc() error");
> -	}
> +	pkey = ltp_pkey_alloc(0, 0);
> +	if (pkey == -1)
> +		tst_brk(TBROK | TERRNO, "pkey_alloc failed");

> -	TST_EXP_FAIL(tst_syscall(__NR_pkey_mprotect,
> +	TST_EXP_FAIL(ltp_pkey_mprotect(
>  		mem_addr, mem_size,
>  		PROT_NONE,
>  		pkey),
>  		EPERM);

Reviewed-by: Petr Vorel <pvorel@suse.cz>

But as I wrote in first patch, I would consider better to rewrite test to use
.test_variants = 2 to test both raw syscall and libc wrapper. That would require
to rewrite the lapi header. And it'd be then safer if pkey01.c would use always
raw syscall variant, no need for not standard "ltp_pkey_mprotect()" name.

> -	ret = tst_syscall(__NR_pkey_free, pkey);
> -	if (ret == -1)
> +	if (ltp_pkey_free(pkey) == -1)
>  		tst_brk(TBROK | TERRNO, "pkey_free() error");
>  }

> @@ -150,7 +147,6 @@ static struct tst_test test = {
>  	.test = run,
>  	.tcnt = ARRAY_SIZE(tcases),
>  	.setup = setup,
> -	.min_kver = "6.10",
This change would be worth to mention in the changelog.

Kind regards,
Petr

>  	.forks_child = 1,
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
