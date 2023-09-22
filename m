Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA06CD4F2B
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 07:57:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DCD93CA3A6
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 09:57:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27E233CA154
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:56:58 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 373B2600F43
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:56:58 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso214666266b.1
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695369417; x=1695974217; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FkXD5yB0zBNtWGIrCtR7gbNYht1OdtexhSJehq/ByuI=;
 b=nqW8PP4xVSLikooEk0vAxvRwB6Amt9lbqbp4hdRCtOfwiJN9WQNTq/UwHGTW3ZqQcW
 NSom1JSfrkKXzi2zBwmnNGVTGG1bkI+vJdariDza7ieLX8WX1cYahgQydOg5Uyjt5hMv
 VA9h1pGBdow2DWvMLs4sFVQxGWZ2pBJVd6/lA9PAQIh41wbtbpnOo2x9BLdEWoJ9jq8T
 8M333koJ7TFrUWmZbBKGyUKaBea7M8FQlOYj+E45XZopNqtWMhaMfpGadcXME6CvlZ6W
 DDxyelpjCr8H22estKpHThWroWk/n5kC7KIUaNaeVkoSxK2OprYA07YfbEH0C8Mh/64n
 AJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695369417; x=1695974217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FkXD5yB0zBNtWGIrCtR7gbNYht1OdtexhSJehq/ByuI=;
 b=phWcWW6NCwwHLytV88ZZOvhkRb3t96D9awC42An1IZADDunXQot+vzm26DICJUtpZV
 rstNWqFZh1r3ZcPHaF1fzaQO5gbNsdjAu+E0dNqnLIJ/sKXeWK3kMyot0ZM//VZ1/Y1e
 5nzZV3TBCfXwwqFYwXYII0uvspqPMjK+SAF0aw9hJfi6oKkCwcrXZmQSi/fK/Dyq64WT
 tedPMfMJOJRQT8XgDYYff2LMGs8HH/y0rBklhPO36PicRl6sG88upUjL/z4l9woZ+KjO
 0XSpSV4smD2P84Qml79vAQfVycM450nf3sLAju3e5PXbvSRBDpL7FHGYBCemIACDRc7F
 SmCw==
X-Gm-Message-State: AOJu0YxvWlFVfyjkdmkc9g/+xRoe4lPDwrTHIl/DivC/etNdG6rwhHz5
 v2+sQTv4nIW2W1wGivaE4JZObXaXynn/RQL20YE=
X-Google-Smtp-Source: AGHT+IF1dkjm0DwwXLdWuzWJuXOFV5gUyN9AXHw2viY7Bsw/WyWwCgKAHNbkshNdDlsQMNXCye5meeUMZsnRfjSyZdE=
X-Received: by 2002:a17:906:535e:b0:9ae:4f9e:7813 with SMTP id
 j30-20020a170906535e00b009ae4f9e7813mr5569740ejo.73.1695369417448; Fri, 22
 Sep 2023 00:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230919083827.8423-1-rpalethorpe@suse.com>
 <a2aa6bf8-2299-daad-2291-750c7db6e143@suse.cz>
In-Reply-To: <a2aa6bf8-2299-daad-2291-750c7db6e143@suse.cz>
From: Petr Vorel <petr.vorel@gmail.com>
Date: Fri, 22 Sep 2023 09:56:45 +0200
Message-ID: <CAB1t1Cz8f5gy4vq1z7Ts3kHX1kmuMo2zcW7qNk548NJZuTASmQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[I Cc Fabrice and Buildroot ML]

On Tue, 19 Sept 2023 at 14:51, Martin Doucha <mdoucha@suse.cz> wrote:
>
> Hi,
> pvorel should have a look whether it doesn't break the other systems
> where -fno-stack-protector is needed, but otherwise:

Yesterday night I tested the current LTP master with ./utils/test-pkg. Some
Bootlin toolchains keep failing (bootlin-x86-64-musl, bootlin-x86-64-glibc):

CC testcases/kernel/kvm/lib_x86.o
gbr-test-pkg/bootlin-x86-64-musl/host/opt/ext-toolchain/bin/../lib/gcc/x86_64-buildroot-linux-musl/11.3.0/../../../../x86_64-buildroot-linux-musl/bin/ld:
lib_x86.o: in function `kvm_init_guest_vmcb':
lib_x86.c:(.text+0x7c8): undefined reference to `__stack_chk_fail'
collect2: error: ld returned 1 exit status

Problems are only on x86_64, other archs (aarch64, riscv64, mipsel, amv7r)
are OK.

NOTE: In Buildroot LTP is currently disabled when musl is used due  5.11
headers requirement for musl toolchain [1], but I temporarily remove this
requirement to get more testing. That's why there are also musl results.

It looks like this patch actually fixes it, thus:
Acked-by: Petr Vorel <pvorel@suse.cz>

There are even more kvm test related results [2], but I suspect they are more
related to the Buildroot toolchain than LTP itself:

CC testcases/kernel/kvm/lib_guest.o
bootstrap_x86_64.S: Assembler messages:
bootstrap_x86_64.S:16: Error: unknown pseudo-op: `.code16'
bootstrap_x86_64.S:19: Error: unknown mnemonic `cli' -- `cli'
bootstrap_x86_64.S:21: Error: unknown mnemonic `lgdt' -- `lgdt kvm_gdt32_desc'
bootstrap_x86_64.S:23: Error: operand 1 must be an integer register --
`mov $0x11,%eax'
bootstrap_x86_64.S:24: Error: operand 1 must be an integer register --
`mov %eax,%cr0'
bootstrap_x86_64.S:26: Error: unknown mnemonic `jmp' -- `jmp
$3*8,$protected_mode_entry'
bootstrap_x86_64.S:28: Error: unknown pseudo-op: `.code32'

Kind regards,
Petr

[1] https://git.busybox.net/buildroot/commit/?id=5e1c238b7202c3b04d9eab94e429c5580c77444b
[2] http://autobuild.buildroot.net/results/6fe953a989a83da67e7ec228ab1668998928ad11/build-end.log
>
> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
>
> On 19. 09. 23 10:38, Richard Palethorpe wrote:
> > Nix (and by extension NixOS) uses a binutils wrapper of some sort to
> > allow switching between toolchains. This seems to be causing a problem
> > for the KVM tests although it may not be unique to Nix.
> >
> > gcc -I/home/rich/kernel/ltp/testcases/kernel/kvm/include -DCOMPILE_PAYLOAD -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx\
> >   -mno-sse -fno-pie -c -o lib_guest.o lib_guest.c
> > as  -c -o bootstrap_x86_64.o bootstrap_x86_64.S
> > gcc -I/home/rich/kernel/ltp/testcases/kernel/kvm/include -DCOMPILE_PAYLOAD -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx\
> >   -mno-sse -fno-pie -c -o lib_x86.o lib_x86.c
> > gcc -I/home/rich/kernel/ltp/testcases/kernel/kvm/include -I../../../include -I../../../include -I../../../include/old/ -DCOMPILE_PAYLOAD -ff\
> > reestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse -fno-pie -nostdlib -Wl,--build-id=none -fno-stack-protector -z noexe\
> > cstack -no-pie -Wl,-T/home/rich/kernel/ltp/testcases/kernel/kvm/linker/x86_64.lds -o kvm_pagefault01-payload.elf kvm_pagefault01.c lib_guest\
> > .o bootstrap_x86_64.o lib_x86.o
> > /nix/store/inq79dwl8sz1ygmfbgsmg77i5cwmdjpz-binutils-2.40/bin/ld: lib_x86.o: in function `kvm_init_guest_vmcb':
> > lib_x86.c:(.text+0x7b3): undefined reference to `__stack_chk_fail'
> > collect2: error: ld returned 1 exit status
> > make: *** [Makefile:58: kvm_pagefault01-payload.o] Error 1
> >
> > __stack_chk_fail is added to lib_x86.o which means that
> > -fstack-protector somehow gets added to the compilation of lib_x86.o.
> >
> > Swapping -fno-stack-protector from the LD flags to the C flags ensures
> > it is disabled when compiling lib_x86.o.
> >
> > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > ---
> >   testcases/kernel/kvm/Makefile | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
> > index d9eb10728..ce4a5ede2 100644
> > --- a/testcases/kernel/kvm/Makefile
> > +++ b/testcases/kernel/kvm/Makefile
> > @@ -8,8 +8,8 @@ include $(top_srcdir)/include/mk/testcases.mk
> >   ASFLAGS =
> >   CPPFLAGS += -I$(abs_srcdir)/include
> >   GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
> > -GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
> > -GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fno-stack-protector -z noexecstack
> > +GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -fno-stack-protector -mno-mmx -mno-sse
> > +GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -z noexecstack
> >   GUEST_LDLIBS =
> >   KVM_LD ?= $(LD)
> >
>
> --
> Martin Doucha   mdoucha@suse.cz
> SW Quality Engineer
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
