Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CECC07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 23:14:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C6E63CECCE
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 01:14:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E31033CB7F4
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 01:14:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1E997602AEA
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 01:14:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2BD121CB1;
 Tue, 24 Oct 2023 23:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698189270;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jR7JLd1iw0z+RsvN5CrpPHiO+UQmL29wpxffkrr0ykw=;
 b=W4SEYaf3GdHvzOU3fXJ+2cQeJWDYzFMMU6lVMWh4FbUL0sYctagx60SiS6ACASmcIdlp5O
 CfvSI5R0iNEjByigLtvQLd0dcB2WPRsw6YyGRMwVZpsyRa5x+987ZcbEkg3CHA2gW/C2t2
 Ns2EvNLPfwAF5KkJ4bHzrzgDCyXxVmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698189270;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jR7JLd1iw0z+RsvN5CrpPHiO+UQmL29wpxffkrr0ykw=;
 b=sfGYdWMy7r4WUjWzR147vG3juiahCsUYWdCEQUVIk0RUX/wAu4DRM52n/6y0MJLKAgGsm5
 mO7fOm3pMfvpcKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8908C1391C;
 Tue, 24 Oct 2023 23:14:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mSlrH9ZPOGV9GQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Oct 2023 23:14:30 +0000
Date: Wed, 25 Oct 2023 01:14:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20231024231429.GA282313@pevik>
References: <20231018015016.1897021-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231018015016.1897021-1-edliaw@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.64 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.34)[76.28%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kvercmp: Handle larger kernel version numbers
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> Current implementation can only handle revision numbers up to 256.  Bump
> this up to 1024 as some revision numbers are in the 300s.

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  lib/tst_kvercmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> index 552920fac..9e1a511af 100644
> --- a/lib/tst_kvercmp.c
> +++ b/lib/tst_kvercmp.c
> @@ -92,8 +92,8 @@ int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3)
>  		         cur_kver);
>  	}

> -	testver = (r1 << 16) + (r2 << 8) + r3;
> -	currver = (a1 << 16) + (a2 << 8) + a3;
> +	testver = (r1 << 20) + (r2 << 10) + r3;
> +	currver = (a1 << 20) + (a2 << 10) + a3;

I wonder why you need this change. Number > 256 is actually only the third
number, but we haven't checked that so far. Do you plan to use it actually?

We try to detect functional changes to avoid problems to compare about mainline
and *also* with stable/LTS kernels.

NOTE: checking for 3rd number actually does not work for Debian, which reports
`uname -r` as: 5.10.0-8-amd64 (the real version is only as an comment in
/boot/config-*). If something specific in stable would be needed, it would have
to use tst_kvercmp2() (e.g. utimensat01.c for Ubuntu). Maybe you have a similar
problem in AOSP kernel.

Kind regards,
Petr

>  	return currver - testver;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
