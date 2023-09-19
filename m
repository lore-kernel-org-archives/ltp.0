Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11E2CD5BB2
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 12:52:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E15BF3CE46C
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 14:52:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D5883C997A
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 14:51:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8ADCF100185C
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 14:51:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA95321A5D;
 Tue, 19 Sep 2023 12:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695127911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ogj0DAEXedWLD7Q/8PERFhHszQPfmEJmK6wzIVaATyY=;
 b=e6FwIypxghEW8EkdW46YnmgDYr59Ycph4tksk26V65OdEkulUXjrEfb6Lp980o22LMP0YE
 joiqX+H/FgQUI6pKfEJa6uyM4lqT68y/tGxK/vAMHdPDBq40XBMqjntQhdOnTcH4UkGkjI
 B6qhuRQbqz4/jPwaJAs2+YXl3az+rxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695127911;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ogj0DAEXedWLD7Q/8PERFhHszQPfmEJmK6wzIVaATyY=;
 b=FZN56uvD3O8hxrCb1kH0TGMOtVX+bcKRwgsTbvyOJK87bvmgPTwx+3OXI+DPmdccJLCNi5
 ZQ65QBDVsb/eIPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B494313458;
 Tue, 19 Sep 2023 12:51:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jhArK2eZCWUXIAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 19 Sep 2023 12:51:51 +0000
Message-ID: <a2aa6bf8-2299-daad-2291-750c7db6e143@suse.cz>
Date: Tue, 19 Sep 2023 14:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
References: <20230919083827.8423-1-rpalethorpe@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230919083827.8423-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kvm: Fix Nix build failure by moving
 -fno-stack-protector to CFLAGS
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
pvorel should have a look whether it doesn't break the other systems 
where -fno-stack-protector is needed, but otherwise:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 19. 09. 23 10:38, Richard Palethorpe wrote:
> Nix (and by extension NixOS) uses a binutils wrapper of some sort to
> allow switching between toolchains. This seems to be causing a problem
> for the KVM tests although it may not be unique to Nix.
> 
> gcc -I/home/rich/kernel/ltp/testcases/kernel/kvm/include -DCOMPILE_PAYLOAD -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx\
>   -mno-sse -fno-pie -c -o lib_guest.o lib_guest.c
> as  -c -o bootstrap_x86_64.o bootstrap_x86_64.S
> gcc -I/home/rich/kernel/ltp/testcases/kernel/kvm/include -DCOMPILE_PAYLOAD -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx\
>   -mno-sse -fno-pie -c -o lib_x86.o lib_x86.c
> gcc -I/home/rich/kernel/ltp/testcases/kernel/kvm/include -I../../../include -I../../../include -I../../../include/old/ -DCOMPILE_PAYLOAD -ff\
> reestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse -fno-pie -nostdlib -Wl,--build-id=none -fno-stack-protector -z noexe\
> cstack -no-pie -Wl,-T/home/rich/kernel/ltp/testcases/kernel/kvm/linker/x86_64.lds -o kvm_pagefault01-payload.elf kvm_pagefault01.c lib_guest\
> .o bootstrap_x86_64.o lib_x86.o
> /nix/store/inq79dwl8sz1ygmfbgsmg77i5cwmdjpz-binutils-2.40/bin/ld: lib_x86.o: in function `kvm_init_guest_vmcb':
> lib_x86.c:(.text+0x7b3): undefined reference to `__stack_chk_fail'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:58: kvm_pagefault01-payload.o] Error 1
> 
> __stack_chk_fail is added to lib_x86.o which means that
> -fstack-protector somehow gets added to the compilation of lib_x86.o.
> 
> Swapping -fno-stack-protector from the LD flags to the C flags ensures
> it is disabled when compiling lib_x86.o.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>   testcases/kernel/kvm/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
> index d9eb10728..ce4a5ede2 100644
> --- a/testcases/kernel/kvm/Makefile
> +++ b/testcases/kernel/kvm/Makefile
> @@ -8,8 +8,8 @@ include $(top_srcdir)/include/mk/testcases.mk
>   ASFLAGS =
>   CPPFLAGS += -I$(abs_srcdir)/include
>   GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
> -GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
> -GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fno-stack-protector -z noexecstack
> +GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -fno-stack-protector -mno-mmx -mno-sse
> +GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -z noexecstack
>   GUEST_LDLIBS =
>   KVM_LD ?= $(LD)
>   

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
