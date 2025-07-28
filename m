Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A1AC87FC9
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 13:38:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B9EB3C8C2C
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 15:38:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A0BE3C0980
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 15:38:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AD1BF1A00886
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 15:38:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15B0B1F789;
 Mon, 28 Jul 2025 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753709908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOSpwKYCT+BWXyEjqt+ZemeynvJfzY9GT/Q9YfqfQDw=;
 b=J/RXSqRXFah0q8F2PrD6a+k3k5bGCUM448QBpyqpHWxoB/6+u1ZHXaUCeH/y+MvyGEc1Xo
 SoXV4xmiQy80EoFUjMomGXP7T0oJHCBWTydnZLovc0iSmOaxLhKD3yGqS+3WpvkhnmwlaJ
 Rkqh3AZrsX7jqZ8BLQMGQt7enq9opqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753709908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOSpwKYCT+BWXyEjqt+ZemeynvJfzY9GT/Q9YfqfQDw=;
 b=UG/9dCpaxyr+rSziD9PespuEnNkSIUDTH47E5FEecjpdYwgVt6jkyuUdsTupVyHONmXjoA
 BqMbcxpb0oQGmQBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753709908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOSpwKYCT+BWXyEjqt+ZemeynvJfzY9GT/Q9YfqfQDw=;
 b=J/RXSqRXFah0q8F2PrD6a+k3k5bGCUM448QBpyqpHWxoB/6+u1ZHXaUCeH/y+MvyGEc1Xo
 SoXV4xmiQy80EoFUjMomGXP7T0oJHCBWTydnZLovc0iSmOaxLhKD3yGqS+3WpvkhnmwlaJ
 Rkqh3AZrsX7jqZ8BLQMGQt7enq9opqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753709908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOSpwKYCT+BWXyEjqt+ZemeynvJfzY9GT/Q9YfqfQDw=;
 b=UG/9dCpaxyr+rSziD9PespuEnNkSIUDTH47E5FEecjpdYwgVt6jkyuUdsTupVyHONmXjoA
 BqMbcxpb0oQGmQBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06C311368A;
 Mon, 28 Jul 2025 13:38:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IMSLAFR9h2g8AwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 28 Jul 2025 13:38:28 +0000
Date: Mon, 28 Jul 2025 15:39:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <aId9ge006B4Z8RDY@yuki.lan>
References: <20250728-fixes-munmap04-v1-1-e32ef11d594a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250728-fixes-munmap04-v1-1-e32ef11d594a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/munmap04: Stop using MAP_FIXED_NOREPLACE
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> On some machines, mmap() call might return MAP_FAILED when passed the
> MAP_FIXED_NOREPLACE flag for reasons other than what the test expect: vma
> limit reached. While at it, add a sanity check if no regions were mapped.
> =

> Signed-off-by: Ricardo B. Marli=E8re <rbm@suse.com>
> ---
>  testcases/kernel/syscalls/munmap/munmap04.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/testcases/kernel/syscalls/munmap/munmap04.c b/testcases/kern=
el/syscalls/munmap/munmap04.c
> index e046d17a75f8f75c5b11d569c33da41d7adc7d09..f55aa770a99d2facb53234fa5=
93fa3f41a16cb00 100644
> --- a/testcases/kernel/syscalls/munmap/munmap04.c
> +++ b/testcases/kernel/syscalls/munmap/munmap04.c
> @@ -37,8 +37,7 @@ static void setup(void)
>  =

>  	while (1) {
>  		void *p =3D mmap((void *)(base + PAD * vma_size * map_count),
> -			     vma_size, PROT_NONE,
> -			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE,
> +			     vma_size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS,

How do we avoid the adjacent mapping merges without the
MAP_FIXED_NOREPLACE flag? With the flag we force particular addresses
that have padding between then. Without the flag kernel is free to place
the mappings anywhere it wants, e.g. create a big continous mapping in
which case we would effectively have a signle vma in the kernel.



>  			     -1, 0);
>  		if (p =3D=3D MAP_FAILED)
>  			break;

Sholdn't it be easier to continue; here if errno =3D=3D EEXIST? that would
mean that we would not map over any mappings that exists in the process
address space and continue retrying with increasing addresses:

	if (p =3D=3D MAP_FAILED && errno =3D=3D EEXIST)
		continue;

	if (p =3D=3D MAP_FAILED)
		break;

	maps[map_count++] =3D p;

> @@ -46,8 +45,9 @@ static void setup(void)
>  	}
>  =

>  	if (map_count =3D=3D MAP_MAX_COUNT)
> -		tst_brk(TBROK, "Mapped all %d regions, expected less",
> -			map_count);
> +		tst_brk(TBROK, "Mapped all %d regions, expected less", map_count);
> +	if (map_count =3D=3D 0)
> +		tst_brk(TBROK, "Mapped 0 regions");
>  =

>  	tst_res(TINFO, "Mapped %d regions", map_count);
>  }
> =

> ---
> base-commit: 6af619552ce7676171e47b88964ffb5b08499b36
> change-id: 20250728-fixes-munmap04-02083c550c6b
> =

> Best regards,
> -- =

> Ricardo B. Marli=E8re <rbm@suse.com>
> =

> =

> -- =

> Mailing list info: https://lists.linux.it/listinfo/ltp

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
