Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01552C433EF
	for <ltp@archiver.kernel.org>; Wed,  8 Jun 2022 14:34:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3196D3C917C
	for <ltp@archiver.kernel.org>; Wed,  8 Jun 2022 16:34:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB1973C207C
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 16:34:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 258656008E1
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 16:34:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 288541F926;
 Wed,  8 Jun 2022 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654698851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JP4yqWx7eyTbKRU02SnGE+87TyAXqKyrUjihd+H9NHk=;
 b=V8/iovZ6tJCgowzgT1wqDvY8Mm3QNR862Q2vamy9h+fLX6EBOxrEvTd7XRZdOeLTEpE3Qe
 83KsEYGtn4MbvyKPMhf+ehiJyS7uaU2CHafbAQ5gNHa6hVON8K9DGK2Esnp0W0eu8bwxzh
 hlljD6d9/GyCdSfOFR3h3sPNunkkij0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654698851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JP4yqWx7eyTbKRU02SnGE+87TyAXqKyrUjihd+H9NHk=;
 b=AJp9jmxQIFVS9GPZ8VgY0sn/vw0iP0lSd8r6cb5yQQjAZz+/Pf+CONb8qxx8HAr2/loq0G
 3DXnPxN7zw6Z0MCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1233213A15;
 Wed,  8 Jun 2022 14:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qD8HA2OzoGJCewAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jun 2022 14:34:11 +0000
Date: Wed, 8 Jun 2022 16:36:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <petr.vorel@gmail.com>
Message-ID: <YqCz4TeYnZH8XsOj@yuki>
References: <20220606184320.8210-1-petr.vorel@gmail.com>
 <20220606184320.8210-3-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606184320.8210-3-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] kvm: Fix undefined reference to
 __stack_chk_fail()
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
> Some x86_64 buildroot toolchains (bootlin-x86-64-glibc,
> bootlin-x86-64-musl) try to link to __stack_chk_fail().
> -nostdlib is not enough, it requires also -fstack-protector.
>
> x86_64-buildroot-linux-gnu/bin/ld: /tmp/ccgBXEoR.o: in function `handle_page_fault':
> kvm_pagefault01.c:(.text+0x5d): undefined reference to `__stack_chk_fail'
> collect2: error: ld returned 1 exit status

I'm still puzzled on why does it try to link it. Why is stack protection
turned on for the code. Does buildroot pass -fstack-protector to the
CFLAGS?

I guess that -nostdlib causes the libssp (which implements
__stack_chk_fail() not to be linked by default, but the
__stack_chk_fail() shouldn't be called unless unless the feature is
enabled in the first place.

Also does -fno-stack-protector passed in GUEST_CFLAGS make it disappear?

> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  testcases/kernel/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
> index 8d5193d8e..bce1a4eb5 100644
> --- a/testcases/kernel/kvm/Makefile
> +++ b/testcases/kernel/kvm/Makefile
> @@ -9,7 +9,7 @@ ASFLAGS =
>  CPPFLAGS += -I$(abs_srcdir)/include
>  GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
>  GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
> -GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none
> +GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fstack-protector
>  GUEST_LDLIBS =
>  
>  FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86
> -- 
> 2.36.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
