Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA22C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 09:32:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9057C3C98E2
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 11:32:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 426C33C05C3
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:32:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 226D81000351
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:32:23 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8B0BF1FABD
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658827943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kl3lriSAQHCdfft+RPb6AfSoJpEf0wYU3Urpt094XKo=;
 b=Y2HX5nM5XyG7Cl8TttQogGG4FJSqu7wyNs4M2I9ygLlwYH6N1aj1DyaBR2MIjCeWbgXha0
 xLR9K546XoIzVlKWbmxJZjNBI6j+kYavC2o2etNsnYmHD0YiZnxZoaLr85AIvLDApcUvb5
 oU3ph1l13Z+sG9HIaIsyeZjw/EI5g4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658827943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kl3lriSAQHCdfft+RPb6AfSoJpEf0wYU3Urpt094XKo=;
 b=8bjIloJtTU0GXtFUlPdH3SO3m9mi5uKjWFIYN8VTxgT8jSSmu6fs1lT1y4a3Qm9Sc0zKMt
 NKsLzjjokHEQn9DA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5AD442C15D;
 Tue, 26 Jul 2022 09:32:23 +0000 (UTC)
References: <20220725153727.30418-1-mdoucha@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 26 Jul 2022 10:30:50 +0100
In-reply-to: <20220725153727.30418-1-mdoucha@suse.cz>
Message-ID: <87h73443tl.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add KVM_LD Makefile variable for building KVM
 payload binaries
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Martin Doucha <mdoucha@suse.cz> writes:

> KVM linker needs to be configurable for cross-compiling but some
> linkers don't support the linker script for wrapping arbitrary files
> into linkable resource files. Allow KVM linker to be changed
> independently of $LD via $KVM_LD.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>
> This should solve the issues with
> https://github.com/linux-test-project/ltp/pull/948
>
>  doc/build-system-guide.txt    | 5 +++++
>  testcases/kernel/kvm/Makefile | 5 +++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/doc/build-system-guide.txt b/doc/build-system-guide.txt
> index 166f7fb92..b8d267b4b 100644
> --- a/doc/build-system-guide.txt
> +++ b/doc/build-system-guide.txt
> @@ -145,6 +145,11 @@ $(CPPFLAGS)		: Preprocessor flags, e.g. -I arguments.
>  
>  $(DEBUG_CFLAGS)		: Debug flags to pass to $(CC), -g, etc.
>  
> +$(KVM_LD)		: Special linker for wrapping KVM payload binaries
> +			  into linkable object files. Defaults to $(LD).
> +			  Change this variable if the KVM Makefile fails
> +			  to build files named *-payload.o.
> +
>  $(LD)			: The system linker (typically $(CC), but not
>  			  necessarily).
>  
> diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
> index 22a840da6..6986844be 100644
> --- a/testcases/kernel/kvm/Makefile
> +++ b/testcases/kernel/kvm/Makefile
> @@ -11,6 +11,7 @@ GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
>  GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
>  GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fno-stack-protector
>  GUEST_LDLIBS =
> +KVM_LD ?= $(LD)
>  
>  FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86
>  
> @@ -53,11 +54,11 @@ include $(top_srcdir)/include/mk/generic_leaf_target.mk
>  ifdef VERBOSE
>  	$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
>  	objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
> -	$(LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
> +	$(KVM_LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
>  else
>  	@$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
>  	@objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
> -	@$(LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
> +	@$(KVM_LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
>  	@echo KVM_CC $(target_rel_dir)$@
>  endif
>  	@rm $*-payload.elf $*-payload.bin
> -- 
> 2.36.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
