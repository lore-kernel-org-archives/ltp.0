Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79271C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 08:27:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 071ED3C9207
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 10:27:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211F33C06E0
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 10:26:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 314921A00E32
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 10:26:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF40B21DE6;
 Thu,  9 Jun 2022 08:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654763215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfURaI2Jg4CFdxz54jkCHhfZs/Ryz2Gjr5WE33ou6vU=;
 b=bYlpgAX7cCQ58QbR11NqmIM3yZmcvX2wQGB1StTr8nDn1TCdtp1toZPkZJ6SDXtgjA1Prg
 TmfuE8OF+9mVe164tQurnmSyor7sChNbkxogpmclXAdB+t4UA2rff/UtI5SBgR/cXx7iRu
 SRNNUNc7cmW8We2eX23mhqjjv/WexI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654763215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfURaI2Jg4CFdxz54jkCHhfZs/Ryz2Gjr5WE33ou6vU=;
 b=bxeWYkU4saYy6BUSuPL1dIRc0A4+3cXOSiGybRFnfGdi9lugEty/BjvcXRSsfI6JrTcQLS
 5CBei+dZG5sZlNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7118413A8C;
 Thu,  9 Jun 2022 08:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nScPGs+uoWKRTAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 09 Jun 2022 08:26:55 +0000
Message-ID: <5d4a4e2b-4d1d-88d6-4905-67083c154775@suse.cz>
Date: Thu, 9 Jun 2022 10:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Petr Vorel <petr.vorel@gmail.com>, ltp@lists.linux.it
References: <20220606184320.8210-1-petr.vorel@gmail.com>
 <20220606184320.8210-3-petr.vorel@gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220606184320.8210-3-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
 "Yann E. MORIN" <yann.morin.1998@free.fr>,
 Buildroot Mailing List <buildroot@buildroot.org>,
 Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 06. 06. 22 20:43, Petr Vorel wrote:
> Some x86_64 buildroot toolchains (bootlin-x86-64-glibc,
> bootlin-x86-64-musl) try to link to __stack_chk_fail().
> -nostdlib is not enough, it requires also -fstack-protector.
> 
> x86_64-buildroot-linux-gnu/bin/ld: /tmp/ccgBXEoR.o: in function `handle_page_fault':
> kvm_pagefault01.c:(.text+0x5d): undefined reference to `__stack_chk_fail'
> collect2: error: ld returned 1 exit status
> 
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

We should use -fno-stack-protector here instead. Your patch probably
enables linking of libssp despite -nostdlib which we don't want. The GCC
stack protector may also break tests because bootstrap initializes stack
manually instead of letting GCC handle it.

>  GUEST_LDLIBS =
>  
>  FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
