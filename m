Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACC8C43334
	for <ltp@archiver.kernel.org>; Wed,  8 Jun 2022 14:37:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3D3E3C8FC8
	for <ltp@archiver.kernel.org>; Wed,  8 Jun 2022 16:37:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21C5B3C207C
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 16:37:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACF601A006F0
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 16:37:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24D171F962;
 Wed,  8 Jun 2022 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654699059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLg7lk1r8UNmseAf/y80yiqKvXAR1cNekHGn1dIn0DY=;
 b=qBZsC6x4oRinDLWatLij/LpWRfSxKB2/tbsS2jTfKx+3mAAHK6FS3LD/DTu7TbMuLKWoMT
 q1+iam72JUHzNk5VwpfME9LIczz8pQfA4rKvyExdkXp3ALxdp6Td3M8BR5X7EWoA90p7iL
 79+OyyPPpJsw39RFQD5UW/cxHn5gDsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654699059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLg7lk1r8UNmseAf/y80yiqKvXAR1cNekHGn1dIn0DY=;
 b=ic0dEIlGXi22awkDGuDzT3+vhLMeDMzdBhh5T8XNHLHA1Xote37LXJvYVgf9PVIkFaNJaa
 Cd/TqZ7j1U/Fm3Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1077613A15;
 Wed,  8 Jun 2022 14:37:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zEubATO0oGLPfAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jun 2022 14:37:39 +0000
Date: Wed, 8 Jun 2022 16:39:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <petr.vorel@gmail.com>
Message-ID: <YqC0sSfMjolMEeKx@yuki>
References: <20220606184320.8210-1-petr.vorel@gmail.com>
 <20220606184320.8210-2-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606184320.8210-2-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] kvm: Fix compilation on x86
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Buildroot Mailing List <buildroot@buildroot.org>,
 Fabrice Fontaine <fontaine.fabrice@gmail.com>,
 "Yann E. MORIN" <yann.morin.1998@free.fr>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Buildroot supports i386 pentium toolchains (br-i386-pentium-mmx-musl,
> br-i386-pentium4-full) which fail to compile because as is run without --32.

So we have a 32bit compiler but 64bit linker?

I guess that passing -m32 to 32bit compiler is harmless, so this can go
in.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  testcases/kernel/kvm/Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
> index adab56952..8d5193d8e 100644
> --- a/testcases/kernel/kvm/Makefile
> +++ b/testcases/kernel/kvm/Makefile
> @@ -17,11 +17,14 @@ FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86
>  ifeq ($(HOST_CPU),x86_64)
>  	ifneq (,$(findstring m32,$(CFLAGS)))
>  		HOST_CPU = x86
> -		GUEST_CFLAGS += -m32
> -		ASFLAGS += --32
>  	endif
>  endif
>  
> +ifeq ($(HOST_CPU),x86)
> +	GUEST_CFLAGS += -m32
> +	ASFLAGS += --32
> +endif
> +
>  # Some distros enable -pie by default. That breaks KVM payload linking.
>  ifdef LTP_CFLAGS_NOPIE
>  	GUEST_CFLAGS += -fno-pie
> -- 
> 2.36.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
