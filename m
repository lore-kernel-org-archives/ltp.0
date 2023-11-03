Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF8CC4167D
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 18:54:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82BFA3CA488
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 19:54:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 912B43CA488
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 19:54:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 745E81A01988
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 19:54:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 063A22187D;
 Fri,  3 Nov 2023 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699037662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZCFjV3QY0sHf0d9yENrEJXw2egu708H8Xz/13cuvag=;
 b=BGZOe4ePubVeyKrBV1MS80ygaHTW2rZjlp+xvXFzyIJ5pPHHzCxGHjZr9MYaS9X1Pf0anJ
 GdAO0bmY+uHrlcN+X2CV8Z1GOaGBgPpq7mXJ3Hi7pYnHG7vis1NVSliVJb/r0IQkJUBbk+
 ZMu9VeUYkRBITCkPmmjkGcz801W90EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699037662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZCFjV3QY0sHf0d9yENrEJXw2egu708H8Xz/13cuvag=;
 b=mb1ZB3fQ85g5qNedeC8QEmgxQ/uImZAeErVgi5Ccx/2+ycpXvS/EoavFl5GE0aEJHoMsxL
 Zl6oOccqFkqYE6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2DF413907;
 Fri,  3 Nov 2023 18:54:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z44mKt1BRWXvBwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 18:54:21 +0000
Date: Fri, 3 Nov 2023 19:54:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20231103185420.GA1111882@pevik>
References: <20231103160350.1096410-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231103160350.1096410-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib/tst_module.c: Replace "rmmod" with
 "modprobe -r"
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> "modprobe -r" will remove also the dependencies loaded for kernel
> modules.

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/lib/tst_module.c b/lib/tst_module.c
> index 9bd443623..e52bb6e00 100644
> --- a/lib/tst_module.c
> +++ b/lib/tst_module.c
> @@ -105,7 +105,7 @@ void tst_module_unload_(void (cleanup_fn)(void), const char *mod_name)
>  {
>  	int i, rc;

> -	const char *const argv[] = { "rmmod", mod_name, NULL };
> +	const char *const argv[] = { "modprobe", "-r", mod_name, NULL };

I'm sorry, obviously some modules needs rmmod:

# ./delete_module03
...
delete_module03.c:32: TPASS: delete_module() failed as expected: EAGAIN/EWOULDBLOCK (11)
tst_module.c:121: TWARN: could not unload dummy_del_mod_dep.ko module
tst_module.c:121: TWARN: could not unload dummy_del_mod.ko module
...

# ./delete_module03
insmod: ERROR: could not insert module dummy_del_mod.ko: File exists
tst_cmd.c:121: TBROK: 'insmod' exited with a non-zero code 1 at tst_cmd.c:121

It's because these modules cannot be found by modprobe

# modprobe -r dummy_del_mod_dep
modprobe: FATAL: Module dummy_del_mod_dep not found.

# modprobe -r dummy_del_mod
modprobe: FATAL: Module dummy_del_mod not found.

# rmmod dummy_del_mod_dep; echo $?; rmmod dummy_del_mod; echo $?
0
0

I guess for .modprobe_module we should have function which uses 'modprobe -r'.
And we should keep tst_module_unload() for these special cases. I would rename
it to tst_module_rmmod() to be obvious.

Setting this as changes requested, next week there is Hackweek in SUSE, I'll
send v3 following week.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
