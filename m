Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C95CD4F32
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 08:34:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA0723CA115
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 10:34:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4CA13CA0FF
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 10:34:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CC8714052E4
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 10:34:15 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5283F1F38A;
 Fri, 22 Sep 2023 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695371655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l5CX+WdeDbRDJV/PSmupfcMH+hXAPXbV1wRxbbFyqTk=;
 b=LEjOEl+1C0RURvkQUnQS8+mTW8mhdGG1Fon2XmJL3t0qy/4MF1nNVCHql/qbE4LWUUKJEB
 YlCB9ZnXL4yADtYIP7tQCwHdT3XFX3k2fS14KSqUexTl/ckCe2Pbj5vEauhWPtDVwx7QIw
 gkBTuh55fFJtyJh0QJEkNCkBt+hLOcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695371655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l5CX+WdeDbRDJV/PSmupfcMH+hXAPXbV1wRxbbFyqTk=;
 b=q8MnYehiGw/tUHmL5SmsojdfCjObCu9WbaCjHxzqJBmvtygSYBab2Li6u9ijDIEcd3Uu2b
 ohtdebwnqXfT5XCA==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id ED4232C142;
 Fri, 22 Sep 2023 08:34:14 +0000 (UTC)
References: <20230919083827.8423-1-rpalethorpe@suse.com>
 <a2aa6bf8-2299-daad-2291-750c7db6e143@suse.cz>
 <CAB1t1Cz8f5gy4vq1z7Ts3kHX1kmuMo2zcW7qNk548NJZuTASmQ@mail.gmail.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <petr.vorel@gmail.com>
Date: Fri, 22 Sep 2023 09:20:32 +0100
Organization: Linux Private Site
In-reply-to: <CAB1t1Cz8f5gy4vq1z7Ts3kHX1kmuMo2zcW7qNk548NJZuTASmQ@mail.gmail.com>
Message-ID: <8734z6fvy1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <petr.vorel@gmail.com> writes:

> Hi all,
>
> [I Cc Fabrice and Buildroot ML]
>
> On Tue, 19 Sept 2023 at 14:51, Martin Doucha <mdoucha@suse.cz> wrote:
>>
>> Hi,
>> pvorel should have a look whether it doesn't break the other systems
>> where -fno-stack-protector is needed, but otherwise:
>
> Yesterday night I tested the current LTP master with ./utils/test-pkg. Some
> Bootlin toolchains keep failing (bootlin-x86-64-musl, bootlin-x86-64-glibc):
>
> CC testcases/kernel/kvm/lib_x86.o
> gbr-test-pkg/bootlin-x86-64-musl/host/opt/ext-toolchain/bin/../lib/gcc/x86_64-buildroot-linux-musl/11.3.0/../../../../x86_64-buildroot-linux-musl/bin/ld:
> lib_x86.o: in function `kvm_init_guest_vmcb':
> lib_x86.c:(.text+0x7c8): undefined reference to `__stack_chk_fail'
> collect2: error: ld returned 1 exit status
>
> Problems are only on x86_64, other archs (aarch64, riscv64, mipsel, amv7r)
> are OK.

I think only x86_64 is supported.

>
> NOTE: In Buildroot LTP is currently disabled when musl is used due  5.11
> headers requirement for musl toolchain [1], but I temporarily remove this
> requirement to get more testing. That's why there are also musl results.
>
> It looks like this patch actually fixes it, thus:
> Acked-by: Petr Vorel <pvorel@suse.cz>

Right, it's not just Nix then. I will merge it.

>
> There are even more kvm test related results [2], but I suspect they are more
> related to the Buildroot toolchain than LTP itself:
>
> CC testcases/kernel/kvm/lib_guest.o
> bootstrap_x86_64.S: Assembler messages:
> bootstrap_x86_64.S:16: Error: unknown pseudo-op: `.code16'
> bootstrap_x86_64.S:19: Error: unknown mnemonic `cli' -- `cli'
> bootstrap_x86_64.S:21: Error: unknown mnemonic `lgdt' -- `lgdt kvm_gdt32_desc'
> bootstrap_x86_64.S:23: Error: operand 1 must be an integer register --
> `mov $0x11,%eax'
> bootstrap_x86_64.S:24: Error: operand 1 must be an integer register --
> `mov %eax,%cr0'
> bootstrap_x86_64.S:26: Error: unknown mnemonic `jmp' -- `jmp
> $3*8,$protected_mode_entry'
> bootstrap_x86_64.S:28: Error: unknown pseudo-op: `.code32'

For me I would at the least we need V=1 enabled or the names and
versions of the tools being used to guess what is wrong here.

mov $0x11,%eax looks like a really simple op to put 11 in EAX using
AT&T/GAS syntax. If that goes wrong then possibly the wrong syntax is
expected by the assembler or else a previous line is confusing it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
